import 'package:fedi/app/account/my/my_account_bloc.dart';
import 'package:fedi/app/chat/message/chat_message_bloc.dart';
import 'package:fedi/app/html/html_text_widget.dart';
import 'package:fedi/app/media/attachment/media_attachments_widget.dart';
import 'package:fedi/app/ui/fedi_colors.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _borderRadius = Radius.circular(16.0);

class ChatMessageListItemWidget extends StatelessWidget {
  final bool isFirstInGroup;

  ChatMessageListItemWidget({@required this.isFirstInGroup});

  @override
  Widget build(BuildContext context) {
    IChatMessageBloc messageBloc = IChatMessageBloc.of(context, listen: true);

    var myAccountBloc = IMyAccountBloc.of(context, listen: true);

    var deviceWidth = MediaQuery.of(context).size.width;

    var isChatMessageFromMe =
        myAccountBloc.checkIsChatMessageFromMe(messageBloc.chatMessage);

    return Align(
      alignment:
          isChatMessageFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isChatMessageFromMe
                ? FediColors.primaryColorDark
                : FediColors.ultraLightGrey,
            borderRadius: isChatMessageFromMe
                ? BorderRadius.only(
                    topLeft: _borderRadius,
                    topRight: isFirstInGroup ? Radius.zero : _borderRadius,
                    bottomLeft: _borderRadius)
                : BorderRadius.only(
                    topLeft: isFirstInGroup ? Radius.zero : _borderRadius,
                    topRight: _borderRadius,
                    bottomRight: _borderRadius)),
        constraints: BoxConstraints(maxWidth: deviceWidth * 0.80),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: buildContent(context, messageBloc, isChatMessageFromMe),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, IChatMessageBloc messageBloc,
      bool isChatMessageFromMe) {
    return Column(
      children: <Widget>[
        buildTextContent(messageBloc, isChatMessageFromMe),
        buildMediaContent(messageBloc),
      ],
    );
  }

  Widget buildMediaContent(IChatMessageBloc messageBloc) =>
      StreamBuilder<IPleromaMediaAttachment>(
          stream: messageBloc.mediaAttachmentStream,
          initialData: messageBloc.mediaAttachment,
          builder: (context, snapshot) {
            var mediaAttachment = snapshot.data;

            var mediaAttachments = <IPleromaMediaAttachment>[];

            if (mediaAttachment != null) {
              mediaAttachments.add(mediaAttachment);
            }

            return MediaAttachmentsWidget(
              mediaAttachments: mediaAttachments,
            );
          });

  Widget buildTextContent(
          IChatMessageBloc messageBloc, bool isChatMessageFromMe) =>
      StreamBuilder<Object>(
          stream: messageBloc.contentWithEmojisStream,
          initialData: messageBloc.contentWithEmojis,
          builder: (context, snapshot) {
            var contentWithEmojis = snapshot.data;

            if (contentWithEmojis != null) {
              return HtmlTextWidget(
                  shrinkWrap: true,
                  color: isChatMessageFromMe
                      ? FediColors.white
                      : FediColors.darkGrey,
                  fontSize: 16.0,
                  lineHeight: 1.5,
                  data: contentWithEmojis,
                  onLinkTap: (String link) async {
                    if (await canLaunch(link)) {
                      await launch(link);
                    }
                  });
            } else {
              return SizedBox.shrink();
            }
          });
}