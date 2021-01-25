import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/list/cached/account_cached_list_bloc.dart';
import 'package:fedi/app/account/list/cached/account_cached_list_bloc_proxy_provider.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/account/repository/account_repository_model.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:fedi/pleroma/account/pleroma_account_model.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/pleroma/pagination/pleroma_pagination_model.dart';
import 'package:fedi/pleroma/status/auth/pleroma_auth_status_service.dart';
import 'package:fedi/pleroma/status/pleroma_status_service.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:moor/moor.dart';

var _logger = Logger("status_favourite_account_list_service_impl.dart");

class StatusFavouriteAccountCachedListBloc extends DisposableOwner
    implements IAccountCachedListBloc {
  final IPleromaAuthStatusService pleromaAuthStatusService;
  final IAccountRepository accountRepository;
  final IStatus status;

  StatusFavouriteAccountCachedListBloc({
    @required this.pleromaAuthStatusService,
    @required this.accountRepository,
    @required this.status,
  });

  @override
  IPleromaApi get pleromaApi => pleromaAuthStatusService;

  @override
  Future<bool> refreshItemsFromRemoteForPage(
      {@required int limit,
      @required IAccount newerThan,
      @required IAccount olderThan}) async {
    _logger.fine(() => "start refreshItemsFromRemoteForPage \n"
        "\t newerThanAccount = $newerThan"
        "\t olderThanAccount = $olderThan");

    List<IPleromaAccount> remoteAccounts;

    remoteAccounts = await pleromaAuthStatusService.favouritedBy(
      statusRemoteId: status.remoteId,
      pagination: PleromaPaginationRequest(
        limit: limit,
        sinceId: newerThan?.remoteId,
        maxId: olderThan?.remoteId,
      ),
    );

    if (remoteAccounts != null) {
      await accountRepository.upsertRemoteAccounts(remoteAccounts,
          conversationRemoteId: null, chatRemoteId: null);

      await accountRepository.updateStatusFavouritedBy(
          statusRemoteId: status.remoteId,
          favouritedByAccounts: remoteAccounts);

      return true;
    } else {
      _logger.severe(() => "error during refreshItemsFromRemoteForPage: "
          "accounts is null");
      return false;
    }
  }

  @override
  Future<List<IAccount>> loadLocalItems(
      {@required int limit,
      @required IAccount newerThan,
      @required IAccount olderThan}) async {
    _logger.finest(() => "start loadLocalItems \n"
        "\t newerThanAccount=$newerThan"
        "\t olderThanAccount=$olderThan");

    var accounts = await accountRepository.getAccounts(
        searchQuery: null,
        olderThanAccount: olderThan,
        newerThanAccount: newerThan,
        limit: limit,
        offset: null,
        orderingTermData: AccountOrderingTermData(
            orderingMode: OrderingMode.desc,
            orderByType: AccountOrderByType.remoteId),
        onlyInConversation: null,
        onlyInAccountFollowers: null,
        onlyInStatusFavouritedBy: status,
        onlyInAccountFollowing: null,
        onlyInStatusRebloggedBy: null,
        onlyInChat: null);

    _logger.finer(() => "finish loadLocalItems accounts ${accounts.length}");
    return accounts;
  }

  static StatusFavouriteAccountCachedListBloc createFromContext(
          BuildContext context,
          {@required IStatus status}) =>
      StatusFavouriteAccountCachedListBloc(
          accountRepository: IAccountRepository.of(context, listen: false),
          pleromaAuthStatusService:
              IPleromaStatusService.of(context, listen: false),
          status: status);

  static Widget provideToContext(
    BuildContext context, {
    @required IStatus status,
    @required Widget child,
  }) =>
      DisposableProvider<IAccountCachedListBloc>(
        create: (context) =>
            StatusFavouriteAccountCachedListBloc.createFromContext(
          context,
          status: status,
        ),
        child: AccountCachedListBlocProxyProvider(child: child),
      );

  @override
  InstanceLocation get instanceLocation => InstanceLocation.local;
}
