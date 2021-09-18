// Mocks generated by Mockito 5.0.10 from annotations
// in fedi/test/app/account/my/my_account_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:base_fediverse_api/src/rest/rest_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pleroma_fediverse_api/src/pleroma/api/account/my/pleroma_api_my_account_model.dart'
    as _i3;
import 'package:pleroma_fediverse_api/src/pleroma/api/account/my/pleroma_api_my_account_service.dart'
    as _i5;
import 'package:pleroma_fediverse_api/src/pleroma/api/account/pleroma_api_account_model.dart'
    as _i4;
import 'package:pleroma_fediverse_api/src/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i8;
import 'package:pleroma_fediverse_api/src/pleroma/api/pleroma_api_service.dart'
    as _i7;
import 'package:pleroma_fediverse_api/src/pleroma/api/status/pleroma_api_status_model.dart'
    as _i9;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIRestService extends _i1.Fake implements _i2.IRestService {}

class _FakeIUnifediApiMyAccount extends _i1.Fake
    implements _i3.IUnifediApiMyAccount {}

class _FakeIUnifediApiAccountRelationship extends _i1.Fake
    implements _i4.IUnifediApiAccountRelationship {}

/// A class which mocks [IUnifediApiMyAccountService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUnifediApiMyAccountService extends _i1.Mock
    implements _i5.IUnifediApiMyAccountService {
  MockIUnifediApiMyAccountService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i6.Stream<_i7.UnifediApiState> get unifediApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#unifediApiStateStream),
              returnValue: Stream<_i7.UnifediApiState>.empty())
          as _i6.Stream<_i7.UnifediApiState>);
  @override
  _i7.UnifediApiState get unifediApiState =>
      (super.noSuchMethod(Invocation.getter(#unifediApiState),
          returnValue: _i7.UnifediApiState.validAuth) as _i7.UnifediApiState);
  @override
  _i6.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i6.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i6.Future<_i3.IUnifediApiMyAccount> updateCredentials(
          _i3.IUnifediApiEditMyAccount? accountEditData) =>
      (super.noSuchMethod(
              Invocation.method(#updateCredentials, [accountEditData]),
              returnValue: Future<_i3.IUnifediApiMyAccount>.value(
                  _FakeIUnifediApiMyAccount()))
          as _i6.Future<_i3.IUnifediApiMyAccount>);
  @override
  _i6.Future<_i3.IUnifediApiMyAccount> updateFiles(
          _i3.UnifediApiMyAccountFilesRequest? accountFilesRequest) =>
      (super.noSuchMethod(
              Invocation.method(#updateFiles, [accountFilesRequest]),
              returnValue: Future<_i3.IUnifediApiMyAccount>.value(
                  _FakeIUnifediApiMyAccount()))
          as _i6.Future<_i3.IUnifediApiMyAccount>);
  @override
  _i6.Future<_i3.IUnifediApiMyAccount> verifyCredentials() =>
      (super.noSuchMethod(Invocation.method(#verifyCredentials, []),
              returnValue: Future<_i3.IUnifediApiMyAccount>.value(
                  _FakeIUnifediApiMyAccount()))
          as _i6.Future<_i3.IUnifediApiMyAccount>);
  @override
  _i6.Future<List<String>> getDomainBlocks(
          {_i8.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
          Invocation.method(#getDomainBlocks, [], {#pagination: pagination}),
          returnValue:
              Future<List<String>>.value(<String>[])) as _i6
          .Future<List<String>>);
  @override
  _i6.Future<List<_i4.IUnifediApiAccount>> getAccountBlocks(
          {_i8.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
          Invocation.method(#getAccountBlocks, [], {#pagination: pagination}),
          returnValue: Future<List<_i4.IUnifediApiAccount>>.value(
              <_i4.IUnifediApiAccount>[])) as _i6
          .Future<List<_i4.IUnifediApiAccount>>);
  @override
  _i6.Future<List<_i4.IUnifediApiAccount>> getAccountMutes(
          {_i8.IUnifediApiPagination? pagination,
          bool? withRelationship}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountMutes, [], {
                #pagination: pagination,
                #withRelationship: withRelationship
              }),
              returnValue: Future<List<_i4.IUnifediApiAccount>>.value(
                  <_i4.IUnifediApiAccount>[]))
          as _i6.Future<List<_i4.IUnifediApiAccount>>);
  @override
  _i6.Future<List<_i9.IUnifediApiStatus>> getBookmarks(
          {_i8.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getBookmarks, [], {#pagination: pagination}),
              returnValue: Future<List<_i9.IUnifediApiStatus>>.value(
                  <_i9.IUnifediApiStatus>[]))
          as _i6.Future<List<_i9.IUnifediApiStatus>>);
  @override
  _i6.Future<List<_i9.IUnifediApiStatus>> getFavourites(
          {_i8.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getFavourites, [], {#pagination: pagination}),
              returnValue: Future<List<_i9.IUnifediApiStatus>>.value(
                  <_i9.IUnifediApiStatus>[]))
          as _i6.Future<List<_i9.IUnifediApiStatus>>);
  @override
  _i6.Future<List<_i4.IUnifediApiAccount>> getFollowRequests(
          {_i8.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
          Invocation.method(#getFollowRequests, [], {#pagination: pagination}),
          returnValue: Future<List<_i4.IUnifediApiAccount>>.value(
              <_i4.IUnifediApiAccount>[])) as _i6
          .Future<List<_i4.IUnifediApiAccount>>);
  @override
  _i6.Future<_i4.IUnifediApiAccountRelationship> acceptFollowRequest(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #acceptFollowRequest, [], {#accountRemoteId: accountRemoteId}),
          returnValue: Future<_i4.IUnifediApiAccountRelationship>.value(
              _FakeIUnifediApiAccountRelationship())) as _i6
          .Future<_i4.IUnifediApiAccountRelationship>);
  @override
  _i6.Future<_i4.IUnifediApiAccountRelationship> rejectFollowRequest(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #rejectFollowRequest, [], {#accountRemoteId: accountRemoteId}),
          returnValue: Future<_i4.IUnifediApiAccountRelationship>.value(
              _FakeIUnifediApiAccountRelationship())) as _i6
          .Future<_i4.IUnifediApiAccountRelationship>);
  @override
  _i6.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i6.Future<dynamic>);
}
