import 'package:fedi/app/chat/pleroma/database/pleroma_chat_accounts_database_model.dart';
import 'package:fedi/app/database/app_database.dart';
import 'package:moor/moor.dart';

part 'pleroma_chat_accounts_database_dao.g.dart';

@UseDao(tables: [
  DbChatAccounts
], queries: {
  "countAll": "SELECT Count(*) FROM db_chat_accounts;",
  "findById": "SELECT * FROM db_chat_accounts WHERE id = :id;",
  "findByChatRemoteId":
      "SELECT * FROM db_chat_accounts WHERE chat_remote_id = :chatRemoteId;",
  "findByChatRemoteIdAndAccountRemoteId":
      "SELECT * FROM db_chat_accounts WHERE chat_remote_id = "
          ":chatRemoteId AND account_remote_id = :accountRemoteId;",
  "findByAccountRemoteId":
      "SELECT * FROM db_chat_accounts WHERE account_remote_id = :accountRemoteId;",
  "countById": "SELECT COUNT(*) FROM db_chat_accounts WHERE id = :id;",
  "deleteById": "DELETE FROM db_chat_accounts WHERE id = :id;",
  "deleteByChatRemoteId": "DELETE FROM db_chat_accounts WHERE "
      "chat_remote_id = :chatRemoteId;",
  "clear": "DELETE FROM db_chat_accounts",
  "getAll": "SELECT * FROM db_chat_accounts"
})
class ChatAccountsDao extends DatabaseAccessor<AppDatabase>
    with _$ChatAccountsDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  ChatAccountsDao(this.db) : super(db);

  Future<int> insert(Insertable<DbChatAccount> entity,
          {InsertMode? mode}) async =>
      into(dbChatAccounts).insert(
        entity,
        mode: mode,
      );

  Future insertAll(List<Insertable<DbChatAccount>> entities,
          InsertMode mode) async =>
      await batch(
        (batch) {
          batch.insertAll(
            dbChatAccounts,
            entities,
          );
        },
      );

  Future<bool> replace(Insertable<DbChatAccount> entity) async =>
      await update(dbChatAccounts).replace(entity);
}
