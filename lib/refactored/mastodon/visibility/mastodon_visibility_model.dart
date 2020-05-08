import 'package:fedi/refactored/enum/enum_values.dart';
import 'package:json_annotation/json_annotation.dart';

enum MastodonVisibility { PUBLIC, UNLISTED, DIRECT }

final mastodonVisibilityValues = EnumValues({
  "public": MastodonVisibility.PUBLIC,
  "unlisted": MastodonVisibility.UNLISTED,
  "direct": MastodonVisibility.DIRECT
});

class MastodonVisibilityTypeConverter
    implements JsonConverter<MastodonVisibility, String> {
  const MastodonVisibilityTypeConverter();

  @override
  MastodonVisibility fromJson(String value) =>
      mastodonVisibilityValues.map[value];
  @override
  String toJson(MastodonVisibility value) =>
      mastodonVisibilityValues.reverse[value];
}