import 'package:bloctest/blocs/tasks/task_state.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class TaskBloc extends Cubit<TaskStates> {
  TaskBloc() : super(TaskInitialState());

  static TaskBloc get(context) => BlocProvider.of<TaskBloc>(context);
  late String category;
  late Database database;
  List<Emoji> emList = Emoji.all(); // list of all Emojis
  List<Map> tasks = [];
  TextEditingController taskName = TextEditingController();
  TextEditingController description = TextEditingController();
  String checked="0";
  int emojiIndex=0;
  TimeOfDay selectedTime = TimeOfDay.now();


  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, '$category.db');

    debugPrint('AppDatabaseInitialized');

    openAppDatabase(
      path: path,
    );

    emit(TaskDatabaseInitialized());
  }

  void openAppDatabase({required String path}) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $category( id INTEGER PRIMARY KEY, name TEXT, description TEXT, checked TEXT, logo TEXT, dueDate TEXT)',
        );
        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

        getUsersData();
      },
    );
  }

  void insertUserData() {
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO $category(name, description, checked, logo, dueDate) VALUES("${taskName.text}", "${description.text}", "$checked", "${emList[emojiIndex]}", "${selectedTime.hour}:${selectedTime.minute}")');
    }).then((value) {
      debugPrint('User Data Inserted');

      taskName.clear();
      description.clear();
      getUsersData();

      emit(TaskDatabaseUserCreated());
    });
  }

  void getUsersData() async {
    emit(TaskDatabaseLoading());

    database.rawQuery('SELECT * FROM $category').then((value) {
      debugPrint('Users Data Fetched');
      tasks = value;
      debugPrint(tasks.toString());
      emit(TaskDatabaseUsers());
    });
  }

  void updateUserData(String name,String descriptions,String logo) async {
    database.rawUpdate(
        'UPDATE $category SET name = ? WHERE logo = ?' ,[name,logo],).then((value) {
      taskName.clear();
      debugPrint('User Data Updated');
      getUsersData();
    });

    database.rawUpdate(
        'UPDATE tasks SET description = ? WHERE logo = ? ',[descriptions,logo],
      ).then((value) {
      description.clear();
      debugPrint('User Data Updated');
      getUsersData();
    });
  }

  void deleteGroupData(String name) async {
    await database.rawDelete('DELETE FROM $category WHERE name = ?',[name]);
    emit(DeleteGroupDatabase());
    getUsersData();
  }

  void checkedData(String checked,String name){
    checked="1";
    database.rawUpdate(
      'UPDATE $category SET checked = ? WHERE name = ?' ,[checked,name]);
    emit(TaskChecked());
    getUsersData();
  }

  void changeTime(TimeOfDay timeOfDay){
    selectedTime=timeOfDay;
    emit(TimeSelected());
    getUsersData();
  }

  void selectLogo(int index){
    emojiIndex=index;
    emit(LogoSelectedIndex());
  }
}