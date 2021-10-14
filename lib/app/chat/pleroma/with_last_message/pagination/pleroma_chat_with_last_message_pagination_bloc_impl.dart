import 'package:collection/collection.dart';
import 'package:fedi/app/chat/pleroma/with_last_message/list/cached/pleroma_chat_with_last_message_cached_list_bloc.dart';
import 'package:fedi/app/chat/pleroma/with_last_message/pagination/pleroma_chat_with_last_message_pagination_bloc.dart';
import 'package:fedi/app/chat/pleroma/with_last_message/pleroma_chat_with_last_message_model.dart';
import 'package:fedi/app/pagination/cached/cached_pleroma_pagination_bloc_impl.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_bloc.dart';
import 'package:fedi/connection/connection_service.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:unifedi_api/unifedi_api.dart';

class PleromaChatWithLastMessagePaginationBloc
    extends CachedPleromaPaginationBloc<IPleromaChatWithLastMessage>
    implements IPleromaChatWithLastMessagePaginationBloc {
  final IPleromaChatWithLastMessageCachedListBloc cachedListBloc;

  PleromaChatWithLastMessagePaginationBloc({
    required this.cachedListBloc,
    required IPaginationSettingsBloc paginationSettingsBloc,
    required int? maximumCachedPagesCount,
    required IConnectionService connectionService,
  }) : super(
          connectionService: connectionService,
          maximumCachedPagesCount: maximumCachedPagesCount,
          paginationSettingsBloc: paginationSettingsBloc,
        );

  @override
  IUnifediApiService get unifediApi => cachedListBloc.unifediApi;

  @override
  Future<List<IPleromaChatWithLastMessage>> loadLocalItems({
    required int pageIndex,
    required int? itemsCountPerPage,
    required CachedPaginationPage<IPleromaChatWithLastMessage>? olderPage,
    required CachedPaginationPage<IPleromaChatWithLastMessage>? newerPage,
  }) =>
      cachedListBloc.loadLocalItems(
        limit: itemsCountPerPage,
        newerThan: olderPage?.items.firstOrNull,
        olderThan: newerPage?.items.lastOrNull,
      );

  @override
  Future refreshItemsFromRemoteForPage({
    required int pageIndex,
    required int? itemsCountPerPage,
    required CachedPaginationPage<IPleromaChatWithLastMessage>? olderPage,
    required CachedPaginationPage<IPleromaChatWithLastMessage>? newerPage,
  }) async {
    assert(
      !(pageIndex > 0 && olderPage == null && newerPage == null),
      'cant refresh not first page without actual items bounds',
    );

    return cachedListBloc.refreshItemsFromRemoteForPage(
      limit: itemsCountPerPage,
      newerThan: olderPage?.items.firstOrNull,
      olderThan: newerPage?.items.lastOrNull,
    );
  }
}
