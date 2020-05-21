import 'package:moor/moor.dart';

// todo: add foreign keys
@DataClassName("DbNotification")
class DbNotifications extends Table {
  // integer ids works much better in SQLite
  IntColumn get id => integer().autoIncrement()();

  TextColumn get remoteId => text().customConstraint("UNIQUE NOT NULL")();
  TextColumn get accountRemoteId => text()();
  TextColumn get statusRemoteId => text().nullable()();
  TextColumn get chatRemoteId => text().nullable()();
  TextColumn get chatMessageRemoteId => text().nullable()();
  BoolColumn get unread => boolean().nullable()();
  TextColumn get type =>
      text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
}