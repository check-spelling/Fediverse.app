import 'package:fedi/async/loading/init/async_init_loading_bloc.dart';
import 'package:fedi/async/loading/init/async_init_loading_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AsyncInitLoadingWidget extends StatelessWidget {
  final IAsyncInitLoadingBloc asyncInitLoadingBloc;
  final WidgetBuilder loadingFinishedBuilder;
  AsyncInitLoadingWidget(
      {@required this.asyncInitLoadingBloc,
      @required this.loadingFinishedBuilder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AsyncInitLoadingState>(
        stream: asyncInitLoadingBloc.initLoadingStateStream,
        initialData: asyncInitLoadingBloc.initLoadingState,
        builder: (context, snapshot) {
          var loadingState = snapshot.data;

          switch (loadingState) {
            case AsyncInitLoadingState.notStarted:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text("Async loading not started, don't "
                      "forget to call performAsynInit();"),
                ),
              );
              break;
            case AsyncInitLoadingState.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case AsyncInitLoadingState.finished:
              return loadingFinishedBuilder(context);
              break;
            case AsyncInitLoadingState.failed:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                        "Init failed with error: ${asyncInitLoadingBloc.initLoadingException}")),
              );
              break;
          }

          throw "Invalid AsyncInitLoadingState $loadingState";
        });
  }
}
