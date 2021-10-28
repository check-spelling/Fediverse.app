// Mocks generated by Mockito 5.0.16 from annotations
// in fedi_app/test/app/instance/announcement/instance_announcement_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:fediverse_api/fediverse_api.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:unifedi_api/src/api/announcement/service/unifedi_api_announcement_service.dart'
    as _i5;
import 'package:unifedi_api/src/api/announcement/unifedi_api_announcement_model.dart'
    as _i7;
import 'package:unifedi_api/src/api/feature/unifedi_api_feature_model.dart'
    as _i2;
import 'package:unifedi_api/src/api/rest/unifedi_api_rest_service.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeIUnifediApiFeature_0 extends _i1.Fake
    implements _i2.IUnifediApiFeature {}

class _FakeIUnifediApiRestService_1 extends _i1.Fake
    implements _i3.IUnifediApiRestService {}

class _FakeFediverseApiFeatureRequirementState_2 extends _i1.Fake
    implements _i4.FediverseApiFeatureRequirementState {}

/// A class which mocks [IUnifediApiAnnouncementService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUnifediApiAnnouncementService extends _i1.Mock
    implements _i5.IUnifediApiAnnouncementService {
  MockIUnifediApiAnnouncementService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IUnifediApiFeature get getAnnouncementsFeature =>
      (super.noSuchMethod(Invocation.getter(#getAnnouncementsFeature),
          returnValue: _FakeIUnifediApiFeature_0()) as _i2.IUnifediApiFeature);
  @override
  _i2.IUnifediApiFeature get dismissAnnouncementFeature =>
      (super.noSuchMethod(Invocation.getter(#dismissAnnouncementFeature),
          returnValue: _FakeIUnifediApiFeature_0()) as _i2.IUnifediApiFeature);
  @override
  _i2.IUnifediApiFeature get addAnnouncementReactionFeature =>
      (super.noSuchMethod(Invocation.getter(#addAnnouncementReactionFeature),
          returnValue: _FakeIUnifediApiFeature_0()) as _i2.IUnifediApiFeature);
  @override
  _i2.IUnifediApiFeature get removeAnnouncementReactionFeature =>
      (super.noSuchMethod(Invocation.getter(#removeAnnouncementReactionFeature),
          returnValue: _FakeIUnifediApiFeature_0()) as _i2.IUnifediApiFeature);
  @override
  _i3.IUnifediApiRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
              returnValue: _FakeIUnifediApiRestService_1())
          as _i3.IUnifediApiRestService);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i6.Future<List<_i7.IUnifediApiAnnouncement>> getAnnouncements(
          {bool? withDismissed}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getAnnouncements, [], {#withDismissed: withDismissed}),
              returnValue: Future<List<_i7.IUnifediApiAnnouncement>>.value(
                  <_i7.IUnifediApiAnnouncement>[]))
          as _i6.Future<List<_i7.IUnifediApiAnnouncement>>);
  @override
  _i6.Future<void> dismissAnnouncement({String? announcementId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #dismissAnnouncement, [], {#announcementId: announcementId}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> addAnnouncementReaction(
          {String? announcementId, String? name}) =>
      (super.noSuchMethod(
          Invocation.method(#addAnnouncementReaction, [],
              {#announcementId: announcementId, #name: name}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> removeAnnouncementReaction(
          {String? announcementId, String? name}) =>
      (super.noSuchMethod(
          Invocation.method(#removeAnnouncementReaction, [],
              {#announcementId: announcementId, #name: name}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  String toString() => super.toString();
  @override
  _i4.FediverseApiFeatureRequirementState checkFeatureState(
          _i2.IUnifediApiFeature? feature) =>
      (super.noSuchMethod(Invocation.method(#checkFeatureState, [feature]),
              returnValue: _FakeFediverseApiFeatureRequirementState_2())
          as _i4.FediverseApiFeatureRequirementState);
  @override
  _i6.Future<void> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}