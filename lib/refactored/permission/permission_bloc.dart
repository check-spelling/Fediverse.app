import 'package:fedi/refactored/disposable/disposable.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionBloc implements Disposable {
  PermissionStatus get permissionStatus;

  Stream<PermissionStatus> get permissionStatusStream;

  Future<PermissionStatus> checkPermissionStatus();

  Future<PermissionStatus> requestPermission();

  Stream<bool> get permissionGrantedStream;

  bool get permissionGranted;

  static bool mapPermissionStatusToBool(status) =>
      status != null ? status == PermissionStatus.granted : null;
}