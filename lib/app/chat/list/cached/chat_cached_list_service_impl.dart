import 'package:fedi/app/chat/chat_model.dart';
import 'package:fedi/app/chat/list/cached/chat_cached_list_service.dart';
import 'package:fedi/app/chat/repository/chat_repository.dart';
import 'package:fedi/app/chat/repository/chat_repository_model.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/chat/pleroma_chat_model.dart';
import 'package:fedi/pleroma/chat/pleroma_chat_service.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:moor_flutter/moor_flutter.dart';

var _logger = Logger("chat_cached_list_service_impl.dart");

class ChatCachedListService extends IChatCachedListService {
  final IPleromaChatService pleromaChatService;
  final IChatRepository chatRepository;

  ChatCachedListService(
      {@required this.pleromaChatService,
      @required this.chatRepository});

  @override
  IPleromaApi get pleromaApi => pleromaChatService;

  @override
  Future<bool> refreshItemsFromRemoteForPage(
      {@required int limit,
      @required IChat newerThan,
      @required IChat olderThan}) async {
    _logger.fine(() => "start refreshItemsFromRemoteForPage \n"
        "\t newerThan = $newerThan"
        "\t olderThan = $olderThan");

    try {
      List<IPleromaChat> remoteChats;

      remoteChats = await pleromaChatService.getChats(
          maxId: olderThan?.remoteId,
          sinceId: newerThan?.remoteId,
          limit: limit);

      if (remoteChats != null) {
        await chatRepository
            .upsertRemoteChats(remoteChats);

        return true;
      } else {
        _logger.severe(() => "error during refreshItemsFromRemoteForPage: "
            "chats is null");
        return false;
      }
    } catch (e, stackTrace) {
      _logger.severe(
          () => "error during refreshItemsFromRemoteForPage", e, stackTrace);
      return false;
    }
  }

  @override
  Future<List<IChat>> loadLocalItems(
      {@required int limit,
      @required IChat newerThan,
      @required IChat olderThan}) async {
    _logger.finest(() => "start loadLocalItems \n"
        "\t newerThan=$newerThan"
        "\t olderThan=$olderThan");

    var chats = await chatRepository.getChats(
        olderThan: olderThan,
        newerThan: newerThan,
        limit: limit,
        offset: null,
        orderingTermData: ChatOrderingTermData(
            orderingMode: OrderingMode.desc,
            orderByType: ChatOrderByType.updatedAt));

    _logger.finer(
        () => "finish loadLocalItems chats ${chats.length}");
    return chats;
  }

  @override
  Stream<List<IChat>> watchLocalItemsNewerThanItem(
          IChat item) =>
      chatRepository.watchChats(
          olderThan: null,
          newerThan: item,
          limit: null,
          offset: null,
          orderingTermData: ChatOrderingTermData(
              orderingMode: OrderingMode.desc,
              orderByType: ChatOrderByType.updatedAt));
}