import 'package:collection/collection.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/pagination/network_only/account_network_only_pagination_bloc.dart';
import 'package:fedi/app/list/network_only/network_only_list_bloc.dart';
import 'package:fedi/app/pagination/network_only/network_only_pleroma_pagination_bloc_impl.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_bloc.dart';
import 'package:fedi/connection/connection_service.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:unifedi_api/unifedi_api.dart';

class AccountNetworkOnlyPaginationBloc
    extends NetworkOnlyPleromaPaginationBloc<IAccount>
    implements IAccountNetworkOnlyPaginationBloc {
  final INetworkOnlyListBloc<IAccount> listBloc;

  AccountNetworkOnlyPaginationBloc({
    required this.listBloc,
    required IPaginationSettingsBloc paginationSettingsBloc,
    required int? maximumCachedPagesCount,
    required IConnectionService connectionService,
  }) : super(
          connectionService: connectionService,
          maximumCachedPagesCount: maximumCachedPagesCount,
          paginationSettingsBloc: paginationSettingsBloc,
        );

  @override
  IUnifediApiService get unifediApi => listBloc.unifediApi;

  static AccountNetworkOnlyPaginationBloc createFromContext(
    BuildContext context, {
    int? maximumCachedPagesCount,
  }) =>
      AccountNetworkOnlyPaginationBloc(
        connectionService: Provider.of<IConnectionService>(
          context,
          listen: false,
        ),
        maximumCachedPagesCount: maximumCachedPagesCount,
        paginationSettingsBloc: IPaginationSettingsBloc.of(
          context,
          listen: false,
        ),
        listBloc: Provider.of<INetworkOnlyListBloc<IAccount>>(
          context,
          listen: false,
        ),
      );

  @override
  Future<List<IAccount>> loadItemsFromRemoteForPage({
    required int pageIndex,
    required int? itemsCountPerPage,
    required PaginationPage<IAccount>? olderPage,
    required PaginationPage<IAccount>? newerPage,
  }) {
    return listBloc.loadItemsFromRemoteForPage(
      itemsCountPerPage: itemsCountPerPage,
      maxId: newerPage?.items.lastOrNull?.remoteId,
      minId: olderPage?.items.firstOrNull?.remoteId,
      pageIndex: pageIndex,
    );
  }
}
