// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Relationship.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RelationshipAdapter extends TypeAdapter<Relationship> {
  @override
  Relationship read(BinaryReader reader) {
    var obj = Relationship();
    var numOfFields = reader.readByte();
    for (var i = 0; i < numOfFields; i++) {
      switch (reader.readByte()) {
        case 1:
          obj.blocking = reader.read() as bool;
          break;
        case 2:
          obj.domainBlocking = reader.read() as bool;
          break;
        case 3:
          obj.endorsed = reader.read() as bool;
          break;
        case 4:
          obj.followedBy = reader.read() as bool;
          break;
        case 5:
          obj.following = reader.read() as bool;
          break;
        case 6:
          obj.id = reader.read() as String;
          break;
        case 7:
          obj.muting = reader.read() as bool;
          break;
        case 8:
          obj.mutingNotifications = reader.read() as bool;
          break;
        case 9:
          obj.requested = reader.read() as bool;
          break;
        case 10:
          obj.showingReblogs = reader.read() as bool;
          break;
        case 11:
          obj.subscribing = reader.read() as bool;
          break;
      }
    }
    return obj;
  }

  @override
  void write(BinaryWriter writer, Relationship obj) {
    writer.writeByte(11);
    writer.writeByte(1);
    writer.write(obj.blocking);
    writer.writeByte(2);
    writer.write(obj.domainBlocking);
    writer.writeByte(3);
    writer.write(obj.endorsed);
    writer.writeByte(4);
    writer.write(obj.followedBy);
    writer.writeByte(5);
    writer.write(obj.following);
    writer.writeByte(6);
    writer.write(obj.id);
    writer.writeByte(7);
    writer.write(obj.muting);
    writer.writeByte(8);
    writer.write(obj.mutingNotifications);
    writer.writeByte(9);
    writer.write(obj.requested);
    writer.writeByte(10);
    writer.write(obj.showingReblogs);
    writer.writeByte(11);
    writer.write(obj.subscribing);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relationship _$RelationshipFromJson(Map<String, dynamic> json) {
  return Relationship(
    blocking: json['blocking'] as bool,
    domainBlocking: json['domain_blocking'] as bool,
    endorsed: json['endorsed'] as bool,
    followedBy: json['followed_by'] as bool,
    following: json['following'] as bool,
    id: json['id'] as String,
    muting: json['muting'] as bool,
    mutingNotifications: json['muting_notifications'] as bool,
    requested: json['requested'] as bool,
    showingReblogs: json['showing_reblogs'] as bool,
    subscribing: json['subscribing'] as bool,
  );
}

Map<String, dynamic> _$RelationshipToJson(Relationship instance) =>
    <String, dynamic>{
      'blocking': instance.blocking,
      'domain_blocking': instance.domainBlocking,
      'endorsed': instance.endorsed,
      'followed_by': instance.followedBy,
      'following': instance.following,
      'id': instance.id,
      'muting': instance.muting,
      'muting_notifications': instance.mutingNotifications,
      'requested': instance.requested,
      'showing_reblogs': instance.showingReblogs,
      'subscribing': instance.subscribing,
    };
