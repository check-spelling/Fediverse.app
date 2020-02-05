import 'dart:io';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/Pleroma/Foundation/Client.dart';
import 'package:fedi/Pleroma/Foundation/CurrentInstance.dart';
import 'package:fedi/Pleroma/Models/Account.dart';
import 'package:fedi/Pleroma/Models/Status.dart';
import 'package:fedi/Transitions/SlideBottomRoute.dart';
import 'package:fedi/Views/Alert.dart';
import 'package:fedi/Views/LocalVideoPlayer.dart';
import 'package:fedi/Views/MentionPage.dart';
import 'package:fedi/Views/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:fedi/Pleroma/Foundation/Requests/Media.dart' as MediaRequest;
import 'package:fedi/Pleroma/Foundation/Requests/Status.dart' as StatusRequest;
import 'AddAdditionalMedia.dart';
import 'Photo/PhotoFile.dart';
import 'Video/VideoFIle.dart';

class QuickPostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuickPostPageState();
  }
}

class _QuickPostPageState extends State<QuickPostPage> {
  String statusVisability = "Public";
  List<String> attachments = [];
  ProgressDialog _pr;
  String oldText = "";
  TextEditingController statusController = TextEditingController();
  List<dynamic> assets = [];
  Widget status;

  accountMentioned(Account acct) {
    if (statusController.text.length > 0) {
      print("$acct");
      String lastChar =
          statusController.text.substring(statusController.text.length - 1);
      if (lastChar == "@") {
        statusController.text = statusController.text
            .substring(0, statusController.text.length - 1);
      }
    }
    statusController.text = "${statusController.text} @${acct.acct}";
  }

  @override
  Widget build(BuildContext context) {
    status = Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        onChanged: (value) {
          String lastChar = value.substring(value.length - 1);
          if (lastChar == "@" && oldText.length < value.length) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MentionPage(accountMentioned)));
          }

          oldText = value;
        },
        autofocus: true,
        controller: statusController,
        maxLines: null,
        minLines: null,
        expands: true,
      ),
    );

    Widget body = Column(
      children: <Widget>[
        Expanded(child: status),
        getMediaGrid(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Text(
                "@",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MentionPage(accountMentioned)));
              },
            ),
            IconButton(
              icon: getVisibilityIcon(statusVisability),
              onPressed: () {
                showModalBottomSheet(
                    builder: (BuildContext context) {
                      return Container(
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // public button
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: OutlineButton(
                                      child: Row(
                                        children: <Widget>[
                                          getVisibilityIcon("Public"),
                                          Text(AppLocalizations.of(context)
                                              .tr("post.quick_post.visibility"
                                              ".public"))
                                        ],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          statusVisability = "Public";
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Unlisted
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: OutlineButton(
                                      child: Row(
                                        children: <Widget>[
                                          getVisibilityIcon("Unlisted"),
                                          Text(
                                              AppLocalizations.of(context)
                                                  .tr("post.quick_post.visibility"
                                                  ".unlisted"))
                                        ],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          statusVisability = "Unlisted";
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Private
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: OutlineButton(
                                      child: Row(
                                        children: <Widget>[
                                          getVisibilityIcon("Private"),
                                          Text(AppLocalizations.of(context)
                                              .tr("post.quick_post.visibility"
                                              ".private"))
                                        ],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          statusVisability = "Private";
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                            ),
                            // Cancel
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: OutlineButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(AppLocalizations.of(context)
                                              .tr("post.quick_post.action"
                                              ".cancel"),
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    context: context);
              },
            ),
            Spacer(),
            OutlineButton(
              child: Text(
                AppLocalizations.of(context)
                    .tr("post.quick_post.action.post"),
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                postStatus();
              },
            ),
            Container(
              width: 10,
            )
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)
                .tr("post.quick_post.title")),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              AppLocalizations.of(context)
                  .tr("post.quick_post.action.post"),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              postStatus();
            },
          )
        ],
      ),
      body: body,
    );
  }

  Widget getMediaGrid() {
    var count = assets.length < 4 ? assets.length + 1 : assets.length;
    print("COUNT: $count");
    return Container(
      height: 100,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          print("$count == $index");
          if (count == index + 1 && assets.length != 4) {
            return getAddButton();
          }

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  FutureBuilder(
                      future: getMediaPreview(assets[index]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return snapshot.data;
                        } else {
                          return Container();
                        }
                      }),
                  Positioned(
                    top: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 20.0,
                      onPressed: () {
                        askToRemoveAsset(index);
                      },
                    ),
                  ),
                ],
              ),
              width: 100,
              height: 100,
            ),
          );
        },
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      ),
    );
  }

  askToRemoveAsset(int index) {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(
              AppLocalizations.of(context)
                  .tr("post.quick_post.attachment.remove.alert.content")
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                  AppLocalizations.of(context)
                      .tr("post.quick_post.attachment.remove.alert.action"
                      ".cancel")
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(AppLocalizations.of(context)
                  .tr("post.quick_post.attachment.remove.alert.action"
                  ".remove")),
              onPressed: () {
                assets.removeAt(index);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  videoTaken(String uri) {
    VideoFile video = VideoFile(uri);
    assets.add(video);
    if (mounted) setState(() {});
  }

  photoTaken(String uri) {
    PhotoFile photo = PhotoFile(uri);
    assets.add(photo);
    if (mounted) setState(() {});
  }

  gallerySelected(AssetEntity asset) {
    AssetEntity newAsset = asset;
    assets.add(newAsset);
    if (mounted) setState(() {});
  }

  Future<Widget> getMediaPreview(dynamic asset) async {
    if (asset is PhotoFile) {
      return _cameraPreviewWidget(asset.url);
    } else if (asset is VideoFile) {
      return LocalVideoPlayer(url: asset.url);
    } else if (asset is AssetEntity) {
      AssetEntity item = asset;
      File file = await item.file;
      if (item.type == AssetType.video) {
        return LocalVideoPlayer(
          file: file,
        );
      } else {
        return Image.file(file);
      }
    }
    return Container();
  }

  Icon getVisibilityIcon(String visibility) {
    if (visibility == "Public") {
      return Icon(
        Icons.public,
        color: Colors.blue,
      );
    } else if (visibility == "Unlisted") {
      return Icon(Icons.lock_open, color: Colors.blue);
    } else {
      return Icon(Icons.lock, color: Colors.blue);
    }
  }

  Widget _cameraPreviewWidget(String url) {
    return Image.file(File(url));
  }

  Widget getAddButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          SlideBottomRoute(
              page: AddAddtionalMedia(
                  videoTaken: videoTaken,
                  photoTaken: photoTaken,
                  gallerySelected: gallerySelected)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        color: Colors.blue,
        child: Center(
          child: IconButton(
            iconSize: 30,
            icon: Icon(
              Icons.add_photo_alternate,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                SlideBottomRoute(
                    page: AddAddtionalMedia(
                        videoTaken: videoTaken,
                        photoTaken: photoTaken,
                        gallerySelected: gallerySelected)),
              );
            },
          ),
        ),
        width: 100,
        height: 100,
      ),
    );
  }

  postStatus() {

    if (assets.length == 0 && statusController.text == "" ){
      var alert = Alert(
            context,
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.error.alert.title"),
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.error.alert.content"),
            () => {});
        alert.showAlert();
        return;
    }

    if (assets.length == 0 ) {
      postTextStatus();
      return;
    }

    _pr = ProgressDialog(context, ProgressDialogType.Normal);
    _pr.setMessage(AppLocalizations.of(context)
        .tr("post.quick_post.posting.progress"),);
    _pr.show();

    getFileForUpload(0);
  }

  getFileForUpload(int index) async {
    print("getting index $index");
    dynamic asset = assets[index];
    if (asset is PhotoFile) {
      uploadFile(index, File(asset.url));
    } else if (asset is VideoFile) {
      uploadFile(index, File(asset.url));
    } else if (asset is AssetEntity) {
      AssetEntity item = asset;
      item.file.then((file) {
        uploadFile(index, file);
      });
    }
  }

  uploadFile(int index, File file) {
    var path = MediaRequest.Media.postNewStatus;
    CurrentInstance.instance.currentClient
        .runUpload(path: path, files: [file]).then((response) {
      response.stream.bytesToString().then((respStr) {
        MediaAttachment attachment =
            MediaAttachment.fromJson(json.decode(respStr));
        attachments.add(attachment.id);
        int nextIndex = index + 1;
        print("whats next?");
        if (nextIndex != assets.length) {
          getFileForUpload(nextIndex);
        } else {
          postStatusAfterUpload();
        }
      }).catchError((e) {
        print("THIS IS THE ERROR!!!!");
        print(e);
        _pr.hide();
        var alert = Alert(
            context,
            AppLocalizations.of(context)
                .tr("post.quick_post.posting.error.alert.title"),
            AppLocalizations.of(context)
                .tr("post.quick_post.posting.error.alert.content"),
            () => {});
        alert.showAlert();
      });
    });
  }

  postStatusAfterUpload() {
    print("my visability!!!! $statusVisability");
    var statusPath = StatusRequest.Status.postNewStatus;
    Map<String, dynamic> params = {
      "status": statusController.text,
      "visibility": statusVisability,
      "media_ids": attachments
    };

    print("Params");
    print(params);

    CurrentInstance.instance.currentClient
        .run(path: statusPath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      _pr.hide();
      var alert = Alert(context, AppLocalizations.of(context)
          .tr("post.quick_post.posting.success.alert.title"),
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.success.alert.content"),
          () => {Navigator.of(context).popUntil((route) => route.isFirst)});
      alert.showAlert();
    }).catchError((e) {
      print("THIS IS THE ERROR!!!!");
      print(e);
      _pr.hide();
      var alert = Alert(
          context,
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.error.alert.title"),
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.error.alert.content"),
          () => {});
      alert.showAlert();
    });
  }

  postTextStatus() {
    _pr = ProgressDialog(context, ProgressDialogType.Normal);
    _pr.setMessage(AppLocalizations.of(context)
        .tr("post.quick_post.posting.progress"));
    _pr.show();

    var statusPath = StatusRequest.Status.postNewStatus;
    print("visibility  $statusVisability");
    Map<String, dynamic> params = {
      "status": statusController.text,
      "visibility": statusVisability,
    };

    print("Params");
    print(params);

    CurrentInstance.instance.currentClient
        .run(path: statusPath, method: HTTPMethod.POST, params: params)
        .then((statusResponse) {
      print(statusResponse.body);
      _pr.hide();
      var alert = Alert(context,
          AppLocalizations.of(context)
          .tr("post.quick_post.posting.success.alert.title"),
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.success.alert.content"),
          () => {Navigator.of(context).popUntil((route) => route.isFirst)});
      alert.showAlert();
    }).catchError((e) {
      print(e);
      _pr.hide();
      var alert = Alert(
          context,
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.error.alert.title"),
          AppLocalizations.of(context)
              .tr("post.quick_post.posting.error.alert.content"),
          () => {});
      alert.showAlert();
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }
}