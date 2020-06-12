import 'package:easy_localization/easy_localization.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:fedi/app/account/my/avatar/my_account_avatar_widget.dart';
import 'package:fedi/app/status/post/new/new_post_status_page.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/timeline/tab/timeline_tab_model.dart';
import 'package:fedi/app/timeline/timeline_post_status_header_widget.dart';
import 'package:fedi/app/timeline/timeline_tabs_bloc.dart';
import 'package:fedi/app/timeline/timeline_widget.dart';
import 'package:fedi/app/ui/fedi_colors.dart';
import 'package:fedi/app/ui/fedi_shadows.dart';
import 'package:fedi/app/ui/list/fedi_list_tile.dart';
import 'package:fedi/app/ui/page/fedi_sliver_app_bar_bloc.dart';
import 'package:fedi/app/ui/status_bar/fedi_dark_status_bar_style_area.dart';
import 'package:fedi/app/ui/status_bar/fedi_light_status_bar_style_area.dart';
import 'package:fedi/app/ui/tab/fedi_text_tab.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/list/with_new_items/pagination_list_with_new_items_bloc.dart';
import 'package:fedi/pagination/list/with_new_items/pagination_list_with_new_items_overlay_widget.dart';
import 'package:fedi/pagination/list/with_new_items/pagination_list_with_new_items_unread_badge_widget.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:fedi/ui/nested_scroll_controller_bloc.dart';
import 'package:fedi/ui/scroll_controller_bloc.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter/rendering.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

var _logger = Logger("timeline_tabs_widget.dart");

class TimelineTabsWidget extends StatefulWidget {
  final List<TimelineTab> tabs;
  final TimelineTab startTab;

  final List<Widget> appBarActionWidgets;

  TimelineTabsWidget({
    @required this.tabs,
    @required this.startTab,
    @required this.appBarActionWidgets,
  });

  @override
  _TimelineTabsWidgetState createState() => _TimelineTabsWidgetState();
}

class _TimelineTabsWidgetState extends State<TimelineTabsWidget>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: widget.tabs.length, vsync: this,
//      initialIndex: widget.tabs.indexOf(widget.startTab),
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildScaffoldBody(),
    );
  }

  ClipRRect _buildExpandedAppBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Container(
        color: FediColors.white,
        child: FediListTile(
          isFirstInList: true,
          child: TimelinePostStatusHeaderWidget(),
        ),
      ),
    );
  }

  Widget buildTabBar(BuildContext context, List<TimelineTab> tabs,
          ITimelineTabsBloc timelineTabsBloc) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...tabs
                          .map((tab) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Provider<
                                    IPaginationListWithNewItemsBloc>.value(
                                  value: timelineTabsBloc
                                      .retrieveTimelineTabPaginationListBloc(
                                          tab),
                                  child:
                                      PaginationListWithNewItemsUnreadBadgeWidget(
                                    child: FediTextTab(
                                      mapTabToTitle(context, tab),
                                      index: tabs.indexOf(tab),
                                      isTransparent: true,
                                      tabController: tabController,
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  ),
                ),
                Row(
                  children: [...widget.appBarActionWidgets],
                )
              ],
            ),
          )
        ],
      );

  String mapTabToTitle(BuildContext context, TimelineTab tab) {
    switch (tab) {
      case TimelineTab.public:
        return tr("app.home.tab.timelines.tab.public");
        break;
      case TimelineTab.home:
        return tr("app.home.tab.timelines.tab.home");

        break;
      case TimelineTab.local:
        return tr("app.home.tab.timelines.tab.local");
        break;
    }

    throw "Invalid tab $tab";
  }

  Widget _buildScaffoldBody() {
    var timelinesTabsBloc = ITimelineTabsBloc.of(context, listen: true);

    _logger.finest(() => "build");

    var nestedScrollController =
        INestedScrollControllerBloc.of(context, listen: false)
            .nestedScrollController;
    return NestedScrollView(
      controller: nestedScrollController,
        headerSliverBuilder: (BuildContext c, bool f) {
          return [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16.0 + MediaQuery.of(context).padding.top,
                      bottom: 8.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: FediLightStatusBarStyleArea(
                      child:
                          buildTabBar(context, widget.tabs, timelinesTabsBloc),
                    ),
                  ),
                  FediDarkStatusBarStyleArea(child: _buildExpandedAppBar()),
//              _buildCollapsedAppBarBody(context)
                ],
              ),
            ),
//              buildSliverAppBar(context, tabs, timelinesTabsBloc),
          ];
        },
        //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
        innerScrollPositionKeyBuilder: () {
          String index = 'Tab0';
          index += tabController.index.toString();
          return Key(index);
        },
        body: Column(
          children: <Widget>[
            Expanded(
              child: TimelineTabsNestedScrollViewBodyWidget(
                  'Tab0', tabController, widget.tabs),
            )
          ],
        ));
  }
}

class TimelineTabsNestedScrollViewBodyWidget extends StatefulWidget {
  final List<TimelineTab> tabs;
  const TimelineTabsNestedScrollViewBodyWidget(
    this.tabKey,
    this.tabController,
    this.tabs,
  );

  final String tabKey;
  final TabController tabController;

  @override
  _TimelineTabsNestedScrollViewBodyWidgetState createState() =>
      _TimelineTabsNestedScrollViewBodyWidgetState();
}

class _TimelineTabsNestedScrollViewBodyWidgetState
    extends State<TimelineTabsNestedScrollViewBodyWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var timelineTabsBloc = ITimelineTabsBloc.of(context, listen: true);
    _logger.finest(() => "buildBodyWidget");
    var tabs = timelineTabsBloc.tabs;



    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Builder(
            builder: (context) {
              var scrollControllerBloc =
                  IScrollControllerBloc.of(context, listen: false);
              var fediSliverAppBarBloc =
                  IFediSliverAppBarBloc.of(context, listen: false);

              _logger.finest(() => "Builder");

              return StreamBuilder<bool>(
                  stream: Rx.combineLatest2(
                      scrollControllerBloc.longScrollDirectionStream,
                      fediSliverAppBarBloc.isAtLeastStartExpandStream,
                      (scrollDirection, isAtLeastStartExpand) {
                    _logger.finest(() => "scrollDirection $scrollDirection "
                        "$isAtLeastStartExpand");

                    return scrollDirection == ScrollDirection.forward &&
                        isAtLeastStartExpand == false;
                  }),
//                stream: scrollControllerBloc.longScrollDirectionStream.map(
//                        (scrollDirection) => scrollDirection == ScrollDirection.forward),
                  builder: (context, snapshot) {
                    var show = snapshot.data;
                    _logger.finest(() => "show $show");
                    if (show == true) {
                      return FediDarkStatusBarStyleArea(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: Container(
                            decoration: BoxDecoration(
                                color: FediColors.white,
                                boxShadow: [FediShadows.forTopBar]),
                            child: _buildCollapsedAppBarBody(context),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  });
            },
          ),
          Expanded(
            child: TabBarView(
                controller: widget.tabController,
                children: List<Widget>.generate(
                  tabs.length,
                  (int index) {
                    var tab = tabs[index];

                    return TabViewItem(Key(widget.tabKey + index.toString()), tab);

//              return buildTabBody(context, tab, timelineTabsBloc);
                  },
                )),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TabViewItem extends StatefulWidget {
  final TimelineTab tab;
  const TabViewItem(this.tabKey, this.tab);

  final Key tabKey;

  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
//
//   return NestedScrollViewInnerScrollPositionKeyWidget(
//      widget.tabKey,
//      ListView.builder(
//          physics: const ClampingScrollPhysics(),
//          itemBuilder: (BuildContext c, int i) {
//            return Container(
//              //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
//              alignment: Alignment.center,
//              height: 60.0,
//              width: double.infinity,
//              //color: Colors.blue,
//              child: Text(widget.tabKey.toString() + ': List$i'),
//            );
//          },
//          itemCount: 100,
//          padding: const EdgeInsets.all(0.0)),
//    );

    var timelineTabsBloc = ITimelineTabsBloc.of(context, listen: false);

    Widget child = Provider<
        IPaginationListWithNewItemsBloc<PaginationPage<IStatus>,
            IStatus>>.value(
      value: timelineTabsBloc.retrieveTimelineTabPaginationListBloc(widget.tab),
      child: ProxyProvider<
          IPaginationListWithNewItemsBloc<PaginationPage<IStatus>, IStatus>,
          IPaginationListBloc<PaginationPage<IStatus>, IStatus>>(
        update: (context, value, previous) => value,
        child: ProxyProvider<
                IPaginationListWithNewItemsBloc<PaginationPage<IStatus>,
                    IStatus>,
                IPaginationListWithNewItemsBloc>(
            update: (context, value, previous) => value,
            child: Stack(
              children: <Widget>[
//               NestedScrollViewInnerScrollPositionKeyWidget(
//              widget.tabKey,
//              ListView.builder(
//                  physics: const ClampingScrollPhysics(),
//                  itemBuilder: (BuildContext c, int i) {
//                    return Container(
//                      //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
//                      alignment: Alignment.center,
//                      height: 60.0,
//                      width: double.infinity,
//                      //color: Colors.blue,
//                      child: Text("asd" + ': List$i'),
//                    );
//                  },
//                  itemCount: 100,
//                  padding: const EdgeInsets.all(0.0)),
//            ),
                FediDarkStatusBarStyleArea(child: TimelineWidget(tabKey: widget.tabKey)),

                Builder(
                  builder: (context) {
                    var scrollControllerBloc =
                        IScrollControllerBloc.of(context, listen: false);
                    var fediSliverAppBarBloc =
                        IFediSliverAppBarBloc.of(context, listen: false);
                    return StreamBuilder<bool>(
                        stream: Rx.combineLatest2(
                            scrollControllerBloc.longScrollDirectionStream,
                            fediSliverAppBarBloc.isAtLeastStartExpandStream,
                            (scrollDirection, isAtLeastStartExpand) {
                          _logger
                              .finest(() => "scrollDirection $scrollDirection "
                                  "$isAtLeastStartExpand");

                          return scrollDirection == ScrollDirection.forward &&
                              isAtLeastStartExpand == false;
                        }),
                        builder: (context, snapshot) {
                          var showCollapsedBody = snapshot.data;
                          return Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: showCollapsedBody == true ? 24 : 48),
                                child: PaginationListWithNewItemsOverlayWidget(
                                  textBuilder: (context, updateItemsCount) =>
                                      plural(
                                          "app.status.list.new_items.action.tap_to_load_new",
                                          updateItemsCount),
                                ),
                              ));
                        });
                  },
                ),
              ],
            )),
      ),
    );
//
//     child = ListView.builder(
//        physics: const ClampingScrollPhysics(),
//        itemBuilder: (BuildContext c, int i) {
//          return Container(
//            //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
//            alignment: Alignment.center,
//            height: 60.0,
//            width: double.infinity,
//            //color: Colors.blue,
//            child: Text(widget.tabKey.toString() + ': List$i'),
//          );
//        },
//        itemCount: 100,
//        padding: const EdgeInsets.all(0.0));

//    child = SmartRefresher(
//      controller: RefreshController(),
//      enablePullDown: true,
//      enablePullUp: true,
//      header: const ListRefreshHeaderWidget(),
//      footer: const ListLoadingFooterWidget(),
//      child: child,
//    );

    return child;
  }

  @override
  bool get wantKeepAlive => true;
}

GestureDetector _buildCollapsedAppBarBody(BuildContext context) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      goToNewPostStatusPage(context);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          MyAccountAvatarWidget(
            imageSize: 40,
            progressSize: 24,
          ),
          SizedBox(
            width: 24.0,
          ),
          Text(
            tr("app.status.post.field.message.hint"),
            style: TextStyle(
                fontSize: 18.0,
                color: FediColors.lightGrey,
                height: 1.5,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
  );
}
