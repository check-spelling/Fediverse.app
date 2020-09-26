import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/timeline/timeline_local_preferences_bloc.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc.dart';
import 'package:fedi/app/timeline/timeline_model.dart';

abstract class ITimelineTabBloc extends Disposable {
  ICachedPaginationListWithNewItemsBloc<CachedPaginationPage<IStatus>, IStatus>
      paginationListWithNewItemsBloc;

  Timeline get timeline;
  ITimelineLocalPreferencesBloc get timelineLocalPreferencesBloc;
}
