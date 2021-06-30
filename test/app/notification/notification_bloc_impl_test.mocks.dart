// Mocks generated by Mockito 5.0.9 from annotations
// in fedi/test/app/notification/notification_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:fedi/disposable/disposable.dart' as _i9;
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_model.dart'
    as _i3;
import 'package:fedi/pleroma/api/notification/pleroma_api_notification_service_impl.dart'
    as _i4;
import 'package:fedi/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i7;
import 'package:fedi/pleroma/api/pleroma_api_service.dart' as _i6;
import 'package:fedi/pleroma/api/rest/auth/pleroma_api_auth_rest_service.dart'
    as _i2;
import 'package:fedi/pleroma/api/visibility/pleroma_api_visibility_model.dart'
    as _i8;
import 'package:flutter/src/widgets/editable_text.dart' as _i10;
import 'package:flutter/src/widgets/focus_manager.dart' as _i12;
import 'package:flutter/src/widgets/scroll_controller.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/src/subjects/subject.dart' as _i13;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIPleromaApiAuthRestService extends _i1.Fake
    implements _i2.IPleromaApiAuthRestService {}

class _FakeIPleromaApiNotification extends _i1.Fake
    implements _i3.IPleromaApiNotification {}

/// A class which mocks [PleromaApiNotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPleromaApiNotificationService extends _i1.Mock
    implements _i4.PleromaApiNotificationService {
  MockPleromaApiNotificationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get notificationRelativeUrlPath =>
      (super.noSuchMethod(Invocation.getter(#notificationRelativeUrlPath),
          returnValue: '') as String);
  @override
  String get pleromaNotificationRelativeUrlPath => (super.noSuchMethod(
      Invocation.getter(#pleromaNotificationRelativeUrlPath),
      returnValue: '') as String);
  @override
  _i2.IPleromaApiAuthRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
              returnValue: _FakeIPleromaApiAuthRestService())
          as _i2.IPleromaApiAuthRestService);
  @override
  _i2.IPleromaApiAuthRestService get restApiAuthService =>
      (super.noSuchMethod(Invocation.getter(#restApiAuthService),
              returnValue: _FakeIPleromaApiAuthRestService())
          as _i2.IPleromaApiAuthRestService);
  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  _i5.Stream<_i6.PleromaApiState> get pleromaApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiStateStream),
              returnValue: Stream<_i6.PleromaApiState>.empty())
          as _i5.Stream<_i6.PleromaApiState>);
  @override
  _i6.PleromaApiState get pleromaApiState =>
      (super.noSuchMethod(Invocation.getter(#pleromaApiState),
          returnValue: _i6.PleromaApiState.validAuth) as _i6.PleromaApiState);
  @override
  _i5.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i5.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i5.Future<_i3.IPleromaApiNotification> getNotification(
          {String? notificationRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#getNotification, [],
                  {#notificationRemoteId: notificationRemoteId}),
              returnValue: Future<_i3.IPleromaApiNotification>.value(
                  _FakeIPleromaApiNotification()))
          as _i5.Future<_i3.IPleromaApiNotification>);
  @override
  _i5.Future<_i3.IPleromaApiNotification> markAsReadSingle(
          {String? notificationRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#markAsReadSingle, [],
                  {#notificationRemoteId: notificationRemoteId}),
              returnValue: Future<_i3.IPleromaApiNotification>.value(
                  _FakeIPleromaApiNotification()))
          as _i5.Future<_i3.IPleromaApiNotification>);
  @override
  _i5.Future<List<_i3.IPleromaApiNotification>> markAsReadList(
          {String? maxNotificationRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(#markAsReadList, [],
                  {#maxNotificationRemoteId: maxNotificationRemoteId}),
              returnValue: Future<List<_i3.IPleromaApiNotification>>.value(
                  <_i3.IPleromaApiNotification>[]))
          as _i5.Future<List<_i3.IPleromaApiNotification>>);
  @override
  _i5.Future<List<_i3.IPleromaApiNotification>> getNotifications(
          {_i7.IPleromaApiPaginationRequest? pagination,
          List<_i3.PleromaApiNotificationType>? excludeTypes,
          String? onlyFromAccountRemoteId,
          List<_i3.PleromaApiNotificationType>? includeTypes,
          List<_i8.PleromaApiVisibility>? excludeVisibilities}) =>
      (super.noSuchMethod(
              Invocation.method(#getNotifications, [], {
                #pagination: pagination,
                #excludeTypes: excludeTypes,
                #onlyFromAccountRemoteId: onlyFromAccountRemoteId,
                #includeTypes: includeTypes,
                #excludeVisibilities: excludeVisibilities
              }),
              returnValue: Future<List<_i3.IPleromaApiNotification>>.value(
                  <_i3.IPleromaApiNotification>[]))
          as _i5.Future<List<_i3.IPleromaApiNotification>>);
  @override
  _i5.Future<dynamic> dismissNotification({String? notificationRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(#dismissNotification, [],
              {#notificationRemoteId: notificationRemoteId}),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<dynamic> dismissAll() =>
      (super.noSuchMethod(Invocation.method(#dismissAll, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  void addDisposable(
          {_i9.IDisposable? disposable,
          _i5.StreamSubscription<dynamic>? streamSubscription,
          _i10.TextEditingController? textEditingController,
          _i11.ScrollController? scrollController,
          _i12.FocusNode? focusNode,
          _i13.Subject<dynamic>? subject,
          _i5.StreamController<dynamic>? streamController,
          _i5.Timer? timer,
          _i5.FutureOr<dynamic>? Function()? custom}) =>
      super.noSuchMethod(
          Invocation.method(#addDisposable, [], {
            #disposable: disposable,
            #streamSubscription: streamSubscription,
            #textEditingController: textEditingController,
            #scrollController: scrollController,
            #focusNode: focusNode,
            #subject: subject,
            #streamController: streamController,
            #timer: timer,
            #custom: custom
          }),
          returnValueForMissingStub: null);
}