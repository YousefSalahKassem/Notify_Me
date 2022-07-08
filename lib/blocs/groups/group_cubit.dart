import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../../constants/colors.dart';
import 'group_state.dart';

class GroupBloc extends Cubit<GroupState> {
  GroupBloc() : super(GroupInitialState());

  static GroupBloc get(context) => BlocProvider.of<GroupBloc>(context);

  late Database database;
  TextEditingController groupName = TextEditingController();
  List<Emoji> emList = Emoji.all(); // list of all Emojis
  List<Map> groups = [];
  int emojiIndex=0;

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'groups.db');

    debugPrint('AppDatabaseInitialized');

    openGroupDatabase(
      path: path,
    );

    emit(GroupDatabaseInitialized());
  }

  void openGroupDatabase({required String path,}) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE groups (id INTEGER PRIMARY KEY, name TEXT, logo TEXT)',
        );

        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;
        getGroupsData();

      },
    );
  }

  void insertGroupData() {
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO groups(name, logo) VALUES("${groupName.text}", "${emList[emojiIndex]}")');
    }).then((value) {
      debugPrint('User Data Inserted');

      groupName.clear();
      getGroupsData();

      emit(GroupDatabaseUserCreated());
    });
  }

  void getGroupsData() async {
    database.rawQuery('SELECT * FROM groups').then((value) {
      debugPrint('Users Data Fetched');
      groups = value;
      debugPrint(groups.toString());
      emit(GroupDatabaseUsers());
    });
  }

  void deleteGroupData(String name) async {
    await database.rawDelete('DELETE FROM groups WHERE name = ?',[name]);
    emit(DeleteGroupDatabase());
    getGroupsData();
  }

  void selectLogo(int index){
    emojiIndex=index;
    emit(LogoSelectedIndex());
  }

}