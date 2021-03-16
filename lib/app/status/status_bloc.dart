import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/emoji/text/emoji_text_model.dart';
import 'package:fedi/app/hashtag/hashtag_model.dart';
import 'package:fedi/app/instance/location/instance_location_bloc.dart';
import 'package:fedi/app/poll/poll_bloc.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/pleroma/card/pleroma_card_model.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:fedi/pleroma/mention/pleroma_mention_model.dart';
import 'package:fedi/pleroma/poll/pleroma_poll_model.dart';
import 'package:fedi/pleroma/status/pleroma_status_model.dart';
import 'package:fedi/pleroma/tag/pleroma_tag_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IStatusBloc implements IDisposable, IInstanceLocationBloc {
  static IStatusBloc of(BuildContext context, {bool listen = true}) =>
      Provider.of<IStatusBloc>(context, listen: listen);

  bool get isPleroma;

  IStatus get status;

  Stream<IStatus> get statusStream;

  IStatus? get reblog;

  Stream<IStatus?> get reblogStream;

  IStatus get reblogOrOriginal;

  Stream<IStatus> get reblogOrOriginalStream;

  String? get content;

  Stream<String?> get contentStream;

  String? get contentRawText;

  Stream<String?> get contentRawTextStream;

  EmojiText? get contentWithEmojis;

  Stream<EmojiText?> get contentWithEmojisStream;

  IPleromaCard? get card;

  Stream<IPleromaCard?> get cardStream;

  IPleromaCard? get reblogOrOriginalCard;

  Stream<IPleromaCard?> get reblogOrOriginalCardStream;

  IAccount get account;

  Stream<IAccount> get accountStream;

  IAccount get reblogOrOriginalAccount;

  Stream<IAccount> get reblogOrOriginalAccountStream;

  DateTime get createdAt;

  Stream<DateTime> get createdAtStream;

  String get remoteId;

  List<IPleromaMediaAttachment>? get mediaAttachments;

  Stream<List<IPleromaMediaAttachment>?> get mediaAttachmentsStream;

  List<IPleromaMediaAttachment>? get reblogOrOriginalMediaAttachments;

  Stream<List<IPleromaMediaAttachment>?>
      get reblogOrOriginalMediaAttachmentsStream;

  IPleromaPoll? get poll;

  Stream<IPleromaPoll?> get pollStream;

  IPollBloc get pollBloc;

  List<IPleromaStatusEmojiReaction>? get pleromaEmojiReactions;

  Stream<List<IPleromaStatusEmojiReaction>?> get pleromaEmojiReactionsStream;

  int? get pleromaEmojiReactionsCount;

  Stream<int?> get pleromaEmojiReactionsCountStream;

  List<IPleromaStatusEmojiReaction>?
      get reblogPlusOriginalPleromaEmojiReactions;

  Stream<List<IPleromaStatusEmojiReaction>?>
      get reblogPlusOriginalEmojiReactionsStream;

  int? get reblogPlusOriginalEmojiReactionsCount;

  Stream<int?> get reblogPlusOriginalEmojiReactionsCountStream;

  String get accountAvatar;

  Stream<String> get accountAvatarStream;

  bool get favourited;

  Stream<bool> get favouritedStream;

  List<IPleromaMention>? get mentions;

  Stream<List<IPleromaMention>?> get mentionsStream;

  List<IPleromaMention>? get reblogOrOriginalMentions;

  List<IPleromaTag>? get tags;

  List<IPleromaTag>? get reblogOrOriginalTags;

  bool get reblogged;

  Stream<bool> get rebloggedStream;

  bool? get bookmarked;

  Stream<bool?> get bookmarkedStream;

  bool get muted;

  Stream<bool> get mutedStream;

  bool get pinned;

  Stream<bool> get pinnedStream;

  int get favouritesCount;

  Stream<int> get favouritesCountStream;

  int get reblogPlusOriginalFavouritesCount;

  Stream<int> get reblogPlusOriginalFavouritesCountStream;

  int get reblogsCount;

  Stream<int> get reblogsCountStream;

  int get reblogPlusOriginalReblogsCount;

  Stream<int> get reblogPlusOriginalReblogsCountStream;

  int get repliesCount;

  Stream<int> get repliesCountStream;

  String? get reblogOrOriginalSpoilerText;

  Stream<String?> get reblogOrOriginalSpoilerTextStream;

  EmojiText? get spoilerTextWithEmojis;

  Stream<EmojiText?> get spoilerTextWithEmojisStream;

  bool get nsfwSensitive;

  Stream<bool> get nsfwSensitiveStream;

  bool get containsSpoiler;

  Stream<bool> get containsSpoilerStream;

  Future refreshFromNetwork();

  Future<IAccount?> loadAccountByMentionUrl({
    required String url,
  });

  Future<IHashtag?> loadHashtagByUrl({
    required String url,
  });

  Future<IAccount?> getInReplyToAccount();

  Stream<IAccount?> watchInReplyToAccount();

  Future<IStatus?> getInReplyToStatus();

  Stream<IStatus?> watchInReplyToStatus();

  Future<IStatus> toggleReblog();

  Future<IStatus> toggleFavourite();

  Future<IStatus> mute({
    required Duration? duration,
  });

  Future<IStatus> toggleMute({
    required Duration? duration,
  });

  Future<IStatus> toggleBookmark();

  Future<IStatus> togglePin();

  Future delete();

  Future<IPleromaStatus> toggleEmojiReaction({
    required String emoji,
  });

  Future<IStatus> onPollUpdated(
    IPleromaPoll poll,
  );

  bool get deleted;

  Stream<bool> get deletedStream;
}

extension IStatusBlocExtension on IStatusBloc {
  bool get isHaveTextContent => content?.isNotEmpty == true;

  bool get isReply => status.isReply;

  bool get isHaveReblog => status.isHaveReblog;
}
