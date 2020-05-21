import 'package:fedi/app/chat/message/chat_message_model.dart';
import 'package:fedi/app/chat/message/repository/chat_message_repository_model.dart';
import 'package:fedi/app/chat/chat_model.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/pleroma/chat/pleroma_chat_model.dart';
import 'package:fedi/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IChatMessageRepository
    implements
        IReadIdListRepository<IChatMessage, int>,
        IWriteIdListRepository<DbChatMessage, int>,
        Disposable {
  static IChatMessageRepository of(BuildContext context,
          {bool listen = true}) =>
      Provider.of<IChatMessageRepository>(context, listen: listen);

  Future<IChatMessage> findByRemoteId(String remoteId);

  Future upsertRemoteChatMessages(List<IPleromaChatMessage> remoteChatMessages);

  Stream<IChatMessage> watchByRemoteId(String remoteId);

  Future updateLocalChatMessageByRemoteChatMessage(
      {@required IChatMessage oldLocalChatMessage,
      @required IPleromaChatMessage newRemoteChatMessage});

  Future upsertRemoteChatMessage(IPleromaChatMessage remoteChatMessage);

  Future<List<IChatMessage>> getChatMessages(
      {@required IChat onlyInChat,
      @required IChatMessage olderThanChatMessage,
      @required IChatMessage newerThanChatMessage,
      @required int limit,
      @required int offset,
      @required ChatMessageOrderingTermData orderingTermData});

  Stream<List<IChatMessage>> watchChatMessages(
      {@required IChat onlyInChat,
      @required IChatMessage olderThanChatMessage,
      @required IChatMessage newerThanChatMessage,
      @required int limit,
      @required int offset,
      @required ChatMessageOrderingTermData orderingTermData});

  Future<IChatMessage> getChatMessage(
      {@required IChat onlyInChat,
      @required IChatMessage olderThanChatMessage,
      @required IChatMessage newerThanChatMessage,
      @required ChatMessageOrderingTermData orderingTermData});

  Stream<IChatMessage> watchChatMessage(
      {@required IChat onlyInChat,
      @required IChatMessage olderThanChatMessage,
      @required IChatMessage newerThanChatMessage,
      @required ChatMessageOrderingTermData orderingTermData});

  Stream<IChatMessage> watchChatLastChatMessage(
      {@required IChat chat});

  Future<IChatMessage> getChatLastChatMessage(
      {@required IChat chat});
}