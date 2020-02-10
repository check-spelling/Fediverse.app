import 'dart:io';

import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/file/picker/file_picker_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IFilePickerBloc implements Disposable {
  static IFilePickerBloc of(BuildContext context, {listen: true}) =>
      Provider.of<IFilePickerBloc>(context, listen: listen);

  FilePickerTab get selectedTab;

  Stream<FilePickerTab> get selectedTabStream;

  List<FilePickerTab> get availableTabs;

  Stream<List<FilePickerTab>> get availableTabsStream;

  onTabSelected(FilePickerTab tab);
  onFileSelected(FilePickerFile filePickerFile);
}
