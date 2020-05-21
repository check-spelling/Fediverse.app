import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/emoji/emoji_text_model.dart';
import 'package:fedi/app/emoji/emoji_text_widget.dart';
import 'package:fedi/app/ui/fedi_colors.dart';
import 'package:flutter/cupertino.dart';

class AccountDisplayNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context, listen: true);
    return StreamBuilder<EmojiText>(
        stream: accountBloc.displayNameEmojiTextStream,
        initialData: accountBloc.displayNameEmojiText,
        builder: (context, snapshot) {
          var accountDisplayNameEmojiText = snapshot.data;
          var textStyle = TextStyle(

            color: FediColors.darkGrey,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          );
          return EmojiTextWidget(
              emojiText: accountDisplayNameEmojiText, textStyle: textStyle);
        });
  }

  const AccountDisplayNameWidget();
}