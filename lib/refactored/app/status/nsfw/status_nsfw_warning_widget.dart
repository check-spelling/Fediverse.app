import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/status/status_bloc.dart';
import 'package:fedi/refactored/app/ui/button/text/fedi_filled_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusNsfwWarningWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FediFilledTextButton(
        appLocalizations.tr("app.status.nsfw.action.view"),
        onPressed: () {
          var statusBloc = IStatusBloc.of(context, listen: false);

          statusBloc.changeDisplayNsfwSensitive(true);
        },
      ),
    );
  }

  const StatusNsfwWarningWidget();
}
