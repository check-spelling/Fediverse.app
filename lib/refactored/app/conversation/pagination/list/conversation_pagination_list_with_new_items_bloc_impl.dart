import 'package:fedi/refactored/app/conversation/conversation_model.dart';
import 'package:fedi/refactored/app/conversation/list/cached/conversation_cached_list_service.dart';
import 'package:fedi/refactored/pagination/list/with_new_items/pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/refactored/pagination/pagination_bloc.dart';
import 'package:fedi/refactored/pagination/pagination_model.dart';
import 'package:flutter/widgets.dart';

class ConversationPaginationListWithNewItemsBloc<
        TPage extends PaginationPage<IConversation>>
    extends PaginationListWithNewItemsBloc<TPage, IConversation> {
  final IConversationCachedListService cachedListService;

  ConversationPaginationListWithNewItemsBloc(
      {@required bool mergeNewItemsImmediately,
      @required this.cachedListService,
      @required IPaginationBloc<TPage, IConversation> paginationBloc})
      : super(
            mergeNewItemsImmediately: mergeNewItemsImmediately,
            paginationBloc: paginationBloc);

  @override
  Stream<List<IConversation>> watchItemsNewerThanItem(IConversation item) =>
      cachedListService.watchLocalItemsNewerThanItem(item);

  @override
  int compareItems(IConversation a, IConversation b) {
    if (a == null && b == null) {
      return 0;
    }

    if (a != null && b == null) {
      return -1;
    }
    if (a == null && b != null) {
      return 1;
    }
    return a.remoteId.compareTo(b.remoteId);
  }
}
