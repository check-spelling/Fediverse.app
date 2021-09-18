import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/instance/remote/remote_instance_bloc.dart';
import 'package:fedi/app/list/network_only/network_only_list_bloc.dart';
import 'package:fedi/app/status/list/network_only/status_network_only_list_bloc.dart';
import 'package:fedi/app/status/list/network_only/status_network_only_list_bloc_proxy_provider.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/status/status_model_adapter.dart';
import 'package:fedi/app/timeline/local_preferences/timeline_local_preference_bloc.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:unifedi_api/unifedi_api.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InstancePublicTimelineStatusListNetworkOnlyListBloc
    extends IStatusNetworkOnlyListBloc {
  final Uri instanceUri;
  final IUnifediApiTimelineService unifediApiTimelineService;
  final ITimelineLocalPreferenceBloc timelineLocalPreferenceBloc;

  InstancePublicTimelineStatusListNetworkOnlyListBloc({
    required this.instanceUri,
    required this.unifediApiTimelineService,
    required this.timelineLocalPreferenceBloc,
  });

  static InstancePublicTimelineStatusListNetworkOnlyListBloc createFromContext(
    BuildContext context, {
    required ITimelineLocalPreferenceBloc timelineLocalPreferenceBloc,
    required Uri instanceUri,
  }) {
    var remoteInstanceBloc = IRemoteInstanceBloc.of(context, listen: false);
    var unifediApiTimelineService = UnifediApiTimelineService(
      restService: remoteInstanceBloc.unifediApiRestService,
    );

    var bloc = InstancePublicTimelineStatusListNetworkOnlyListBloc(
      timelineLocalPreferenceBloc: timelineLocalPreferenceBloc,
      instanceUri: instanceUri,
      unifediApiTimelineService: unifediApiTimelineService,
    );

    bloc.addDisposable(unifediApiTimelineService);

    return bloc;
  }

  static Widget provideToContext(
    BuildContext context, {
    required ITimelineLocalPreferenceBloc timelineLocalPreferenceBloc,
    required Widget child,
    required Uri instanceUri,
  }) {
    return DisposableProvider<IStatusNetworkOnlyListBloc>(
      create: (context) =>
          InstancePublicTimelineStatusListNetworkOnlyListBloc.createFromContext(
        context,
        timelineLocalPreferenceBloc: timelineLocalPreferenceBloc,
        instanceUri: instanceUri,
      ),
      child: ProxyProvider<IStatusNetworkOnlyListBloc, INetworkOnlyListBloc>(
        update: (context, value, previous) => value,
        child: StatusNetworkOnlyListBlocProxyProvider(
          child: ProxyProvider<IStatusNetworkOnlyListBloc,
              INetworkOnlyListBloc<IStatus>>(
            update: (context, value, previous) => value,
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  InstanceLocation get instanceLocation => InstanceLocation.remote;

  @override
  Uri get remoteInstanceUriOrNull => instanceUri;

  @override
  Future<List<IStatus>> loadItemsFromRemoteForPage({
    required int pageIndex,
    required int? itemsCountPerPage,
    required String? minId,
    required String? maxId,
  }) async {
    var timeline = timelineLocalPreferenceBloc.value!;
    var unifediApiStatuses = await unifediApiTimelineService.getPublicTimeline(
      onlyLocal: timeline.onlyLocal == true,
      onlyRemote: timeline.onlyRemote == true,
      onlyWithMedia: timeline.onlyWithMedia == true,
      withMuted: timeline.withMuted == true,
      onlyFromInstance: timeline.onlyFromInstance,
      excludeVisibilities: timeline.excludeVisibilities,
      replyVisibilityFilter: timeline.replyVisibilityFilter,
      pagination: UnifediApiPagination(
        limit: itemsCountPerPage,
        minId: minId,
        maxId: maxId,
      ),
    );

    return unifediApiStatuses
        .map(
          (unifediApiStatus) => unifediApiStatus.toDbStatusPopulatedWrapper(),
        )
        .toList();
  }

  @override
  IUnifediApiService get unifediApi => unifediApiTimelineService;
}
