import 'package:fedi/refactored/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/refactored/pleroma/chat/pleroma_chat_exception.dart';
import 'package:fedi/refactored/pleroma/chat/pleroma_chat_model.dart';
import 'package:fedi/refactored/pleroma/chat/pleroma_chat_service.dart';
import 'package:fedi/refactored/pleroma/rest/auth/pleroma_auth_rest_service.dart';
import 'package:fedi/refactored/rest/rest_request_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;

var urlPath = path.Context(style: path.Style.url);

class PleromaChatService implements IPleromaChatService {
  final chatRelativeUrlPath = "/api/v1/pleroma/chats";
  final IPleromaAuthRestService restService;

  @override
  Stream<PleromaApiState> get pleromaStateStream =>
      restService.pleromaStateStream;

  @override
  PleromaApiState get pleromaState => restService.pleromaState;

  @override
  Stream<bool> get isApiReadyToUseStream => restService.isApiReadyToUseStream;

  @override
  bool get isApiReadyToUse => restService.isApiReadyToUse;

  @override
  bool get isConnected => restService.isConnected;

  @override
  Stream<bool> get isConnectedStream => restService.isConnectedStream;

  PleromaChatService({@required this.restService});

  List<IPleromaChat> parseChatListResponse(Response httpResponse) {
    if (httpResponse.statusCode == 200) {
      return PleromaChat.listFromJsonString(httpResponse.body);
    } else {
      throw PleromaChatException(
          statusCode: httpResponse.statusCode, body: httpResponse.body);
    }
  }

  IPleromaChat parseChatResponse(Response httpResponse) {
    if (httpResponse.statusCode == 200) {
      return PleromaChat.fromJsonString(httpResponse.body);
    } else {
      throw PleromaChatException(
          statusCode: httpResponse.statusCode, body: httpResponse.body);
    }
  }

  List<IPleromaChatMessage> parseChatMessageListResponse(
      Response httpResponse) {
    if (httpResponse.statusCode == 200) {
      return PleromaChatMessage.listFromJsonString(httpResponse.body);
    } else {
      throw PleromaChatException(
          statusCode: httpResponse.statusCode, body: httpResponse.body);
    }
  }

  IPleromaChatMessage parseChatMessageResponse(Response httpResponse) {
    if (httpResponse.statusCode == 200) {
      return PleromaChatMessage.fromJsonString(httpResponse.body);
    } else {
      throw PleromaChatException(
          statusCode: httpResponse.statusCode, body: httpResponse.body);
    }
  }

  @override
  Future<List<IPleromaChat>> getChats({
    String sinceId,
    String minId,
    String maxId,
    int limit = 20,
  }) async {
    var httpResponse = await restService
        .sendHttpRequest(RestRequest.get(relativePath: chatRelativeUrlPath));

    return parseChatListResponse(httpResponse);
  }

  @override
  Future<List<IPleromaChatMessage>> getChatMessages({
    @required String chatId,
    String sinceId,
    String minId,
    String maxId,
    int limit = 20,
  }) async {
    assert(chatId?.isNotEmpty == true);
    var httpResponse = await restService.sendHttpRequest(RestRequest.get(
        relativePath: urlPath.join(chatRelativeUrlPath, chatId, "messages"),
        queryArgs: [
          RestRequestQueryArg("since_id", sinceId),
          RestRequestQueryArg("min_id", minId),
          RestRequestQueryArg("max_id", maxId),
          RestRequestQueryArg("limit", limit?.toString()),
        ]));

    return parseChatMessageListResponse(httpResponse);
  }

  @override
  Future<IPleromaChat> markChatAsRead({@required String chatId}) async {
    assert(chatId?.isNotEmpty == true);
    var httpResponse = await restService.sendHttpRequest(RestRequest.post(
        relativePath: urlPath.join(chatRelativeUrlPath, chatId, "read")));

    return parseChatResponse(httpResponse);
  }

  @override
  Future<IPleromaChat> getOrCreateChatByAccountId(
      {@required String accountId}) async {
    assert(accountId?.isNotEmpty == true);
    var httpResponse = await restService.sendHttpRequest(RestRequest.post(
        relativePath:
            urlPath.join(chatRelativeUrlPath, "by-account-id", accountId)));

    return parseChatResponse(httpResponse);
  }

  @override
  Future<IPleromaChatMessage> sendMessage(
      {@required String chatId,
      @required IPleromaChatMessageSendData data}) async {
    assert(chatId?.isNotEmpty == true);
    var httpResponse = await restService.sendHttpRequest(RestRequest.post(
        relativePath: urlPath.join(chatRelativeUrlPath, chatId, "messages"),
        queryArgs: [
          RestRequestQueryArg("content", data.content)
        ]));

    return parseChatMessageResponse(httpResponse);
  }

  @override
  void dispose() {
    // nothing
  }
}