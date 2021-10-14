// ignore_for_file: unnecessary_lambdas

import 'package:fedi/app/timeline/timeline_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../hive/hive_test_helper.dart';
import '../../json/json_test_helper.dart';
import '../../obj/obj_test_helper.dart';
import 'timeline_model_test_helper.dart';

void main() {
  test('equal & hashcode & toString', () async {
    ObjMockHelper.testEqualsHashcodeToString(
      ({required String seed}) => TimelineModelMockHelper.createTestTimeline(
        seed: seed,
      ),
    );
  });

  test('toJson & fromJson', () async {
    JsonMockHelper.testFromJsonToJson(
      ({required String seed}) => TimelineModelMockHelper.createTestTimeline(
        seed: seed,
      ),
      (json) => Timeline.fromJson(json),
    );
  });

  test('hive save&load', () async {
    await HiveMockHelper.testHiveSaveAndLoad(
      ({required String seed}) => TimelineModelMockHelper.createTestTimeline(
        seed: seed,
      ),
    );
  });

  test('hive adapter', () async {
    HiveMockHelper.testAdapter(
      () => TimelineAdapter(),
    );
  });
}
