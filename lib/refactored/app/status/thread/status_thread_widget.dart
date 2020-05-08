import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/async/async_smart_refresher_helper.dart';
import 'package:fedi/refactored/app/list/list_refresh_header_widget.dart';
import 'package:fedi/refactored/app/status/list/status_list_item_timeline_widget.dart';
import 'package:fedi/refactored/app/status/post/thread/thread_post_status_widget.dart';
import 'package:fedi/refactored/app/status/status_bloc.dart';
import 'package:fedi/refactored/app/status/status_bloc_impl.dart';
import 'package:fedi/refactored/app/status/status_model.dart';
import 'package:fedi/refactored/app/status/thread/status_thread_bloc.dart';
import 'package:fedi/refactored/app/status/thread/status_thread_page.dart';
import 'package:fedi/refactored/disposable/disposable_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StatusThreadWidget extends StatefulWidget {
  @override
  _StatusThreadWidgetState createState() => _StatusThreadWidgetState();
}

class _StatusThreadWidgetState extends State<StatusThreadWidget> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionListener =
      ItemPositionsListener.create();

  bool isJumpedToStartState = false;

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var statusThreadBloc = IStatusThreadBloc.of(context, listen: false);

    return Column(
      children: <Widget>[
        Expanded(
          child: buildMessageList(context, statusThreadBloc),
        ),
        ThreadPostStatusWidget()
      ],
    );
  }

  Widget buildMessageList(
      BuildContext context, IStatusThreadBloc statusThreadBloc) {
    return StreamBuilder<List<IStatus>>(
        stream: statusThreadBloc.statusesStream,
        initialData: statusThreadBloc.statuses,
        builder: (context, snapshot) {
          var statuses = snapshot.data;

          return SmartRefresher(
            enablePullUp: false,
            enablePullDown: true,
            header: ListRefreshHeaderWidget(),
            controller: refreshController,
            onRefresh: () => AsyncSmartRefresherHelper.doAsyncRefresh(
                controller: refreshController,
                action: statusThreadBloc.refresh),
            child: buildList(statusThreadBloc, statuses),
          );
        });
  }

  Widget buildList(IStatusThreadBloc statusThreadBloc, List<IStatus> statuses) {
    if (statuses.isEmpty) {
      return Text(AppLocalizations.of(context).tr("app.list.empty"));
    } else {
      // jump only after context messages loading
      if (!isJumpedToStartState && statuses.length > 1) {
        isJumpedToStartState = true;
        Future.delayed(Duration(microseconds: 1), () {
          if (itemScrollController.isAttached) {
            itemScrollController.scrollTo(
                index: statusThreadBloc.startStatusIndex,
                duration: Duration(milliseconds: 500));
          }
        });
      }

      return ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionListener,
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
        itemCount: statuses.length,
        itemBuilder: (BuildContext context, int index) {
          return Provider.value(
            value: statuses[index],
            child: DisposableProxyProvider<IStatus, IStatusBloc>(
                update: (context, status, oldValue) =>
                    StatusBloc.createFromContext(context, status,
                        isNeedWatchLocalRepositoryForUpdates: true),
                child: StatusListItemTimelineWidget(
                  statusCallback: (context, status) {
                    if (status.remoteId !=
                        statusThreadBloc.startStatus.remoteId) {
                      goToStatusThreadPage(context, status);
                    }
                  },
                  collapsible: false,
                )),
          );
        },
      );
    }
  }
}