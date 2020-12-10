import 'dart:convert';

import 'package:fedi/mastodon/account/mastodon_account_model.dart';
import 'package:fedi/pleroma/emoji/pleroma_emoji_model.dart';
import 'package:fedi/pleroma/field/pleroma_field_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pleroma_account_model.g.dart';

abstract class IPleromaAccount implements IMastodonAccount {
  @override
  List<IPleromaField> get fields;

  @override
  List<IPleromaEmoji> get emojis;

  IPleromaAccountPleromaPart get pleroma;
}

// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 64)
@JsonSerializable(explicitToJson: true)
class PleromaAccount implements IPleromaAccount {
  @override
  @HiveField(0)
  final String username;
  @override
  @HiveField(1)
  final String url;
  @override
  @HiveField(2)
  @JsonKey(name: "statuses_count")
  final int statusesCount;
  @override
  @HiveField(3)
  final String note;
  @override
  @HiveField(4)
  final bool locked;
  @override
  @HiveField(5)
  final String id;
  @override
  @HiveField(6)
  @JsonKey(name: "header_static")
  final String headerStatic;
  @override
  @HiveField(7)
  final String header;
  @override
  @HiveField(8)
  @JsonKey(name: "following_count")
  final int followingCount;
  @override
  @HiveField(9)
  @JsonKey(name: "followers_count")
  final int followersCount;
  @override
  @HiveField(10)
  final List<PleromaField> fields;
  @override
  @HiveField(11)
  final List<PleromaEmoji> emojis;
  @override
  @HiveField(12)
  @JsonKey(name: "display_name")
  final String displayName;
  @override
  @HiveField(13)
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @override
  @HiveField(14)
  final bool bot;
  @override
  @HiveField(15)
  @JsonKey(name: "avatar_static")
  final String avatarStatic;
  @override
  @HiveField(16)
  final String avatar;
  @override
  @HiveField(17)
  final String acct;
  @override
  @HiveField(19)
  final PleromaAccountPleromaPart pleroma;
  @override
  @HiveField(20)
  @JsonKey(name: "last_status_at")
  final DateTime lastStatusAt;

  PleromaAccount(
      {this.username,
      this.url,
      this.statusesCount,
      this.note,
      this.locked,
      this.id,
      this.headerStatic,
      this.header,
      this.followingCount,
      this.followersCount,
      this.fields,
      this.emojis,
      this.displayName,
      this.createdAt,
      this.bot,
      this.avatarStatic,
      this.avatar,
      this.acct,
      this.pleroma,
      this.lastStatusAt});

  factory PleromaAccount.fromJson(Map<String, dynamic> json) =>
      _$PleromaAccountFromJson(json);

  factory PleromaAccount.fromJsonString(String jsonString) =>
      _$PleromaAccountFromJson(jsonDecode(jsonString));

  static List<PleromaAccount> listFromJsonString(String str) =>
      List<PleromaAccount>.from(
          json.decode(str).map((x) => PleromaAccount.fromJson(x)));

  Map<String, dynamic> toJson() => _$PleromaAccountToJson(this);

  String toJsonString() => jsonEncode(_$PleromaAccountToJson(this));

  @override
  String toString() {
    return 'PleromaAccount{username: $username, url: $url,'
        ' statusesCount: $statusesCount, note: $note, locked: $locked,'
        ' id: $id, headerStatic: $headerStatic, header: $header,'
        ' followingCount: $followingCount, followersCount: $followersCount,'
        ' fields: $fields, emojis: $emojis, displayName: $displayName,'
        ' createdAt: $createdAt, bot: $bot, avatarStatic: $avatarStatic,'
        ' avatar: $avatar, acct: $acct, pleroma: $pleroma,'
        ' lastStatusAt: $lastStatusAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaAccount &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          url == other.url &&
          statusesCount == other.statusesCount &&
          note == other.note &&
          locked == other.locked &&
          id == other.id &&
          headerStatic == other.headerStatic &&
          header == other.header &&
          followingCount == other.followingCount &&
          followersCount == other.followersCount &&
          fields == other.fields &&
          emojis == other.emojis &&
          displayName == other.displayName &&
          createdAt == other.createdAt &&
          bot == other.bot &&
          avatarStatic == other.avatarStatic &&
          avatar == other.avatar &&
          acct == other.acct &&
          pleroma == other.pleroma &&
          lastStatusAt == other.lastStatusAt;

  @override
  int get hashCode =>
      username.hashCode ^
      url.hashCode ^
      statusesCount.hashCode ^
      note.hashCode ^
      locked.hashCode ^
      id.hashCode ^
      headerStatic.hashCode ^
      header.hashCode ^
      followingCount.hashCode ^
      followersCount.hashCode ^
      fields.hashCode ^
      emojis.hashCode ^
      displayName.hashCode ^
      createdAt.hashCode ^
      bot.hashCode ^
      avatarStatic.hashCode ^
      avatar.hashCode ^
      acct.hashCode ^
      pleroma.hashCode ^
      lastStatusAt.hashCode;
}

abstract class IPleromaAccountPleromaPart {
  dynamic get backgroundImage;

//  List<PleromaTag> tags;
  List<dynamic> get tags;

  PleromaAccountRelationship get relationship;

  bool get isAdmin;

  bool get isModerator;

  bool get confirmationPending;

  bool get hideFavorites;

  bool get hideFollowers;

  bool get hideFollows;

  bool get hideFollowersCount;

  bool get hideFollowsCount;

  bool get deactivated;

  bool get allowFollowingMove;

  bool get skipThreadContainment;
}

// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 75)
@JsonSerializable(explicitToJson: true)
class PleromaAccountPleromaPart implements IPleromaAccountPleromaPart {
  // TODO: CHECK, was in previous implementation, but not exist at https://docs-develop.pleroma.social/backend/API/differences_in_mastoapi_responses/
  @override
  @HiveField(1)
  @JsonKey(name: "background_image")
  final dynamic backgroundImage;

  @override
  @HiveField(2)
  // todo: remove hack, Pleroma return List<String> instead of List<PleromaTag>
  // for example at accounts/verify_credentials endpoint
//  List<PleromaTag> tags;
  final List<dynamic> tags;

  @override
  @HiveField(3)
  final PleromaAccountRelationship relationship;
  @override
  @HiveField(4)
  @JsonKey(name: "is_admin")
  final bool isAdmin;
  @override
  @HiveField(5)
  @JsonKey(name: "is_moderator")
  final bool isModerator;

  @override
  @HiveField(7)
  @JsonKey(name: "confirmation_pending")
  final bool confirmationPending;

  @override
  @HiveField(8)
  // TODO: CHECK, was in previous implementation, but not exist at
  @JsonKey(name: "hide_favorites")
  final bool hideFavorites;
  @override
  @HiveField(9)
  @JsonKey(name: "hide_followers")
  final bool hideFollowers;
  @override
  @HiveField(11)
  @JsonKey(name: "hide_follows")
  final bool hideFollows;
  @override
  @HiveField(12)
  @JsonKey(name: "hide_followers_count")
  final bool hideFollowersCount;
  @override
  @HiveField(13)
  @JsonKey(name: "hide_follows_count")
  final bool hideFollowsCount;

  ///  A generic map of settings for frontends.
  ///  Opaque to the backend.
  ///  Only returned in verify_credentials and update_credentials
  @HiveField(14)
  @JsonKey(name: "settings_store")
  final dynamic settingsStore;

  @override
  @HiveField(16)
  final bool deactivated;

  ///  boolean, true when the user allows automatically follow moved
  ///  following accounts
  @override
  @HiveField(17)
  @JsonKey(name: "allow_following_move")
  final bool allowFollowingMove;

  /// TODO: CHECK, was in previous implementation, but not exist at
  /// https://docs-develop.pleroma.social/backend/API/differences_in_mastoapi_responses/
  @override
  @JsonKey(name: "skip_thread_containment")
  final bool skipThreadContainment;

  PleromaAccountPleromaPart({
    this.backgroundImage,
    this.tags,
    this.relationship,
    this.isAdmin,
    this.isModerator,
    this.confirmationPending,
    this.hideFavorites,
    this.hideFollowers,
    this.hideFollows,
    this.hideFollowersCount,
    this.hideFollowsCount,
    this.settingsStore,
    this.deactivated,
    this.allowFollowingMove,
    this.skipThreadContainment,
  });

  factory PleromaAccountPleromaPart.fromJson(Map<String, dynamic> json) =>
      _$PleromaAccountPleromaPartFromJson(json);

  factory PleromaAccountPleromaPart.fromJsonString(String jsonString) =>
      _$PleromaAccountPleromaPartFromJson(jsonDecode(jsonString));

  Map<String, dynamic> toJson() => _$PleromaAccountPleromaPartToJson(this);

  String toJsonString() => jsonEncode(_$PleromaAccountPleromaPartToJson(this));

  @override
  String toString() {
    return 'PleromaAccountPleromaPart{backgroundImage: $backgroundImage,'
        ' tags: $tags, relationship: $relationship, isAdmin: $isAdmin,'
        ' isModerator: $isModerator, confirmationPending: $confirmationPending,'
        ' hideFavorites: $hideFavorites, hideFollowers: $hideFollowers,'
        ' hideFollows: $hideFollows, hideFollowersCount: $hideFollowersCount,'
        ' hideFollowsCount: $hideFollowsCount, settingsStore: $settingsStore,'
        ' deactivated: $deactivated,'
        ' allowFollowingMove: $allowFollowingMove,'
        ' skipThreadContainment: $skipThreadContainment}';
  }
}

abstract class IPleromaAccountRelationship
    implements IMastodonAccountRelationship {
  IPleromaAccountRelationship copyWith({
    int id,
    bool blocking,
    bool domainBlocking,
    bool endorsed,
    bool followedBy,
    bool following,
    bool muting,
    bool mutingNotifications,
    bool requested,
    bool showingReblogs,
    bool subscribing,
    bool blockedBy,
    bool note,
  });
}

// -32 is hack for hive 0.x backward ids compatibility
// see reservedIds in Hive,
// which not exist in Hive 0.x
//@HiveType()
@HiveType(typeId: -32 + 42)
@JsonSerializable()
class PleromaAccountRelationship implements IPleromaAccountRelationship {
  @override
  @HiveField(1)
  final bool blocking;
  @override
  @JsonKey(name: "domain_blocking")
  @HiveField(2)
  final bool domainBlocking;
  @override
  @HiveField(3)
  final bool endorsed;
  @override
  @HiveField(4)
  @JsonKey(name: "followed_by")
  final bool followedBy;
  @override
  @HiveField(5)
  final bool following;
  @override
  @HiveField(6)
  final String id;
  @override
  @HiveField(7)
  final bool muting;
  @override
  @HiveField(8)
  @JsonKey(name: "muting_notifications")
  @HiveField(9)
  final bool mutingNotifications;
  @override
  @HiveField(10)
  final bool requested;
  @override
  @JsonKey(name: "showing_reblogs")
  @HiveField(11)
  final bool showingReblogs;
  @override
  @HiveField(12)
  final bool subscribing;

  @override
  @HiveField(13)
  @JsonKey(name: "blocked_by")
  final bool blockedBy;

  @override
  @HiveField(14)
  final String note;

  PleromaAccountRelationship({
    this.blocking,
    this.domainBlocking,
    this.endorsed,
    this.followedBy,
    this.following,
    this.id,
    this.muting,
    this.mutingNotifications,
    this.requested,
    this.showingReblogs,
    this.subscribing,
    this.blockedBy,
    this.note,
  });

  @override
  PleromaAccountRelationship copyWith({
    int id,
    bool blocking,
    bool domainBlocking,
    bool endorsed,
    bool followedBy,
    bool following,
    bool muting,
    bool mutingNotifications,
    bool requested,
    bool showingReblogs,
    bool subscribing,
    bool blockedBy,
    bool note,
  }) =>
      PleromaAccountRelationship(
        id: id ?? this.id,
        blocking: blocking ?? this.blocking,
        domainBlocking: domainBlocking ?? this.domainBlocking,
        endorsed: endorsed ?? this.endorsed,
        followedBy: followedBy ?? this.followedBy,
        following: following ?? this.following,
        muting: muting ?? this.muting,
        mutingNotifications: mutingNotifications ?? this.mutingNotifications,
        requested: requested ?? this.requested,
        showingReblogs: showingReblogs ?? this.showingReblogs,
        subscribing: subscribing ?? this.subscribing,
        blockedBy: blockedBy ?? this.blockedBy,
        note: note ?? this.note,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaAccountRelationship &&
          runtimeType == other.runtimeType &&
          blocking == other.blocking &&
          domainBlocking == other.domainBlocking &&
          endorsed == other.endorsed &&
          followedBy == other.followedBy &&
          following == other.following &&
          id == other.id &&
          muting == other.muting &&
          mutingNotifications == other.mutingNotifications &&
          requested == other.requested &&
          showingReblogs == other.showingReblogs &&
          blockedBy == other.blockedBy &&
          note == other.note &&
          subscribing == other.subscribing;

  @override
  int get hashCode =>
      blocking.hashCode ^
      domainBlocking.hashCode ^
      endorsed.hashCode ^
      followedBy.hashCode ^
      following.hashCode ^
      id.hashCode ^
      muting.hashCode ^
      mutingNotifications.hashCode ^
      requested.hashCode ^
      showingReblogs.hashCode ^
      blockedBy.hashCode ^
      note.hashCode ^
      subscribing.hashCode;

  @override
  String toString() {
    return 'PleromaAccountRelationship{blocking: $blocking,'
        ' domainBlocking: $domainBlocking, endorsed: $endorsed,'
        ' followedBy: $followedBy, following: $following, id: $id,'
        ' muting: $muting, mutingNotifications: $mutingNotifications,'
        ' requested: $requested, showingReblogs: $showingReblogs,'
        ' subscribing: $subscribing,'
        ' note: $note,'
        ' blockedBy: $blockedBy'
        '}';
  }

  factory PleromaAccountRelationship.fromJson(Map<String, dynamic> json) =>
      _$PleromaAccountRelationshipFromJson(json);

  factory PleromaAccountRelationship.fromJsonString(String jsonString) =>
      _$PleromaAccountRelationshipFromJson(jsonDecode(jsonString));

  static List<PleromaAccountRelationship> listFromJsonString(String str) =>
      List<PleromaAccountRelationship>.from(
          json.decode(str).map((x) => PleromaAccountRelationship.fromJson(x)));

  Map<String, dynamic> toJson() => _$PleromaAccountRelationshipToJson(this);

  String toJsonString() => jsonEncode(_$PleromaAccountRelationshipToJson(this));
}

abstract class IPleromaAccountIdentityProof
    extends IMastodonAccountIdentityProof {}

@JsonSerializable()
class PleromaAccountIdentityProof extends IPleromaAccountIdentityProof {
  @override
  final String profileUrl;

  @override
  final String proofUrl;

  @override
  final String provider;

  @override
  final String providerUsername;

  @override
  final DateTime updatedAt;

  PleromaAccountIdentityProof(
      {this.profileUrl,
      this.proofUrl,
      this.provider,
      this.providerUsername,
      this.updatedAt});

  @override
  String toString() {
    return 'PleromaAccountIdentityProof{profileUrl: $profileUrl, proofUrl: $proofUrl,'
        ' provider: $provider, providerUsername: $providerUsername,'
        ' updatedAt: $updatedAt}';
  }

  factory PleromaAccountIdentityProof.fromJson(Map<String, dynamic> json) =>
      _$PleromaAccountIdentityProofFromJson(json);

  factory PleromaAccountIdentityProof.fromJsonString(String jsonString) =>
      _$PleromaAccountIdentityProofFromJson(jsonDecode(jsonString));

  static List<PleromaAccountIdentityProof> listFromJsonString(String str) =>
      List<PleromaAccountIdentityProof>.from(
          json.decode(str).map((x) => PleromaAccountIdentityProof.fromJson(x)));

  Map<String, dynamic> toJson() => _$PleromaAccountIdentityProofToJson(this);

  String toJsonString() =>
      jsonEncode(_$PleromaAccountIdentityProofToJson(this));
}

abstract class IPleromaAccountReportRequest
    implements IMastodonAccountReportRequest {
  Map<String, dynamic> toJson();
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class PleromaAccountReportRequest implements IPleromaAccountReportRequest {
  @JsonKey(name: "account_id")
  @override
  final String accountId;

  @override
  final String comment;

  @override
  final bool forward;

  @JsonKey(name: "status_ids")
  @override
  final List<String> statusIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PleromaAccountReportRequest &&
          runtimeType == other.runtimeType &&
          accountId == other.accountId &&
          comment == other.comment &&
          forward == other.forward &&
          statusIds == other.statusIds;

  @override
  int get hashCode =>
      accountId.hashCode ^
      comment.hashCode ^
      forward.hashCode ^
      statusIds.hashCode;

  PleromaAccountReportRequest({
    @required this.accountId,
    this.comment,
    this.forward,
    this.statusIds,
  });

  factory PleromaAccountReportRequest.fromJson(Map<String, dynamic> json) =>
      _$PleromaAccountReportRequestFromJson(json);

  factory PleromaAccountReportRequest.fromJsonString(String jsonString) =>
      _$PleromaAccountReportRequestFromJson(jsonDecode(jsonString));

  @override
  Map<String, dynamic> toJson() => _$PleromaAccountReportRequestToJson(this);

  String toJsonString() =>
      jsonEncode(_$PleromaAccountReportRequestToJson(this));
}
