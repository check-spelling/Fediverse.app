import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:flutter/cupertino.dart';

class FediBigHorizontalSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox(
        width: FediSizes.bigPadding,
      );

  const FediBigHorizontalSpacer();
}
