import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/list/cached/account_cached_list_service.dart';
import 'package:fedi/app/account/repository/account_repository.dart';
import 'package:fedi/app/account/repository/account_repository_model.dart';
import 'package:fedi/disposable/disposable_owner.dart';
import 'package:fedi/pleroma/account/pleroma_account_model.dart';
import 'package:fedi/pleroma/account/pleroma_account_service.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:moor/moor.dart';

var _logger = Logger("account_follower_account_cached_list_bloc_impl.dart");

class AccountFollowerAccountCachedListBloc extends DisposableOwner
    implements IAccountCachedListBloc {
  final IPleromaAccountService pleromaAccountService;
  final IAccountRepository accountRepository;
  final IAccount account;

  AccountFollowerAccountCachedListBloc({
    @required this.pleromaAccountService,
    @required this.accountRepository,
    @required this.account,
  });

  @override
  IPleromaApi get pleromaApi => pleromaAccountService;

  @override
  Future<bool> refreshItemsFromRemoteForPage(
      {@required int limit,
      @required IAccount newerThan,
      @required IAccount olderThan}) async {
    _logger.fine(() => "start refreshItemsFromRemoteForPage \n"
        "\t newerThanAccount = $newerThan"
        "\t olderThanAccount = $olderThan");

    try {
      List<IPleromaAccount> remoteAccounts;

      remoteAccounts = await pleromaAccountService.getAccountFollowers(
          accountRemoteId: account.remoteId,
          maxId: olderThan?.remoteId,
          sinceId: newerThan?.remoteId,
          limit: limit);

      if (remoteAccounts != null) {
        await accountRepository.upsertRemoteAccounts(remoteAccounts,
            conversationRemoteId: null, chatRemoteId: null);

        await accountRepository.updateAccountFollowers(
            account.remoteId, remoteAccounts);

        return true;
      } else {
        _logger.severe(() => "error during refreshItemsFromRemoteForPage: "
            "accounts is null");
        return false;
      }
    } catch (e, stackTrace) {
      _logger.severe(
          () => "error during refreshItemsFromRemoteForPage", e, stackTrace);
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
      olderThanAccount: olderThan,
      newerThanAccount: newerThan,
      limit: limit,
      offset: null,
      orderingTermData: AccountOrderingTermData(
          orderingMode: OrderingMode.desc,
          orderByType: AccountOrderByType.remoteId),
      onlyInConversation: null,
      onlyInAccountFollowers: account,
      onlyInStatusFavouritedBy: null,
      onlyInAccountFollowing: null,
      searchQuery: null,
      onlyInChat: null,
      onlyInStatusRebloggedBy: null,
    );

    _logger.finer(() => "finish loadLocalItems accounts ${accounts.length}");
    return accounts;
  }

  static AccountFollowerAccountCachedListBloc createFromContext(
          BuildContext context,
          {@required IAccount account}) =>
      AccountFollowerAccountCachedListBloc(
          accountRepository: IAccountRepository.of(context, listen: false),
          pleromaAccountService:
              IPleromaAccountService.of(context, listen: false),
          account: account);
}
