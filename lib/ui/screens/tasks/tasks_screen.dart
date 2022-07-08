import 'package:bloctest/blocs/tasks/task_cubit.dart';
import 'package:bloctest/blocs/tasks/task_state.dart';
import 'package:bloctest/helper/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/button_app.dart';
import '../../../components/text_field.dart';
import '../../../constants/colors.dart';

class TasksScreen extends StatelessWidget {
  String? category;
  TasksScreen({Key? key,this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc,TaskStates>(builder: (context,state){
      BlocProvider.of<TaskBloc>(context).category=category!;
      return Scaffold(
        backgroundColor: ColorsApp.white,
        appBar: AppBar(
          backgroundColor: ColorsApp.primary,
          centerTitle: true,
          title: Text(BlocProvider.of<TaskBloc>(context).category,style: GoogleFonts.oleoScript(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your Tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              Expanded(
                child: ListView.builder(
                    itemCount: BlocProvider.of<TaskBloc>(context).tasks.length,
                    itemBuilder: (context,index){
                      return BlocProvider.of<TaskBloc>(context).tasks[index]['category']==category?Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const[
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(0, 7),
                                blurRadius: 7,
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: BlocProvider.of<TaskBloc>(context).tasks[index]['checked']=="0"?Colors.grey:Colors.green,
                              radius: 20,
                              child: BlocProvider.of<TaskBloc>(context).tasks[index]['checked']=="0"?Container():const Icon(FontAwesomeIcons.check,color: Colors.white,),
                            ),
                            title: Text(BlocProvider.of<TaskBloc>(context).tasks[index]['name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                            subtitle: Text('Due to : ${BlocProvider.of<TaskBloc>(context).tasks[index]['dueDate']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                            trailing: Text(BlocProvider.of<TaskBloc>(context).tasks[index]['logo'],style: const TextStyle(fontSize: 50),),
                            onLongPress: (){BlocProvider.of<TaskBloc>(context).checkedData(BlocProvider.of<TaskBloc>(context).tasks[index]['checked'],BlocProvider.of<TaskBloc>(context).tasks[index]['name']);},
                            onTap: (){
                              BlocProvider.of<TaskBloc>(context).taskName.text=BlocProvider.of<TaskBloc>(context).tasks[index]['name'];
                              BlocProvider.of<TaskBloc>(context).description.text=BlocProvider.of<TaskBloc>(context).tasks[index]['description'];
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  builder: (context){
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
                                      child: Wrap(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children:  [
                                                  Text(BlocProvider.of<TaskBloc>(context).tasks[index]['name'], style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                  Text(BlocProvider.of<TaskBloc>(context).tasks[index]['logo'],style: const TextStyle(fontSize: 50),),

                                                ],
                                              ),
                                              const Text("Title", style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              const SizedBox(height: 5,),
                                              TextFieldApp(controller: BlocProvider.of<TaskBloc>(context).taskName,hint: 'Title..',),
                                              const SizedBox(height: 15,),
                                              const Text("Description", style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              const SizedBox(height: 5,),
                                              TextFieldApp(controller: BlocProvider.of<TaskBloc>(context).description,hint: 'Description..',),
                                              const SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ButtonApp(text: 'Update', color: ColorsApp.secondary, function: (){
                                                      BlocProvider.of<TaskBloc>(context).updateUserData(BlocProvider.of<TaskBloc>(context).taskName.text,BlocProvider.of<TaskBloc>(context).description.text,BlocProvider.of<TaskBloc>(context).tasks[index]["logo"]);
                                                      AppRoute.pop();

                                                    }),
                                                  ),
                                                  const SizedBox(width: 20,),
                                                  Expanded(
                                                    child: ButtonApp(text: 'Delete', color: ColorsApp.primary, function: (){
                                                      BlocProvider.of<TaskBloc>(context).deleteGroupData(BlocProvider.of<TaskBloc>(context).tasks[index]['name']);
                                                      AppRoute.pop();
                                                    }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )

                                        ],
                                      ),
                                    );
                                  });                        },
                          )
                      ):Container();
                    }),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(onPressed: (){
          showModalBottomSheet(
              isScrollControlled:true,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              builder: (context){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create New Task",
                            style: TextStyle(
                                fontSize: 30,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(height: 15,),
                          const Text("Title", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 5,),
                          TextFieldApp(controller: BlocProvider.of<TaskBloc>(context).taskName,hint: 'Title..',),
                          const SizedBox(height: 15,),
                          const Text("Description", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 5,),
                          TextFieldApp(controller: BlocProvider.of<TaskBloc>(context).description,hint: 'Description..',),
                          const SizedBox(height: 5,),
                          const Text("Due Date", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 5,),
                          StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async{
                                      final TimeOfDay? timeOfDay = await showTimePicker(
                                        context: context,
                                        initialTime: BlocProvider.of<TaskBloc>(context).selectedTime,
                                        initialEntryMode: TimePickerEntryMode.dial,
                                      );
                                      if(timeOfDay != null && timeOfDay != BlocProvider.of<TaskBloc>(context).selectedTime)
                                      {
                                        setState((){
                                          BlocProvider.of<TaskBloc>(context).changeTime(timeOfDay);
                                        });
                                      }
                                      },
                                    child: const Text("Choose Time"),
                                  ),
                                  Text("${BlocProvider.of<TaskBloc>(context).selectedTime.hour}:${BlocProvider.of<TaskBloc>(context).selectedTime.minute}", style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ],
                              );
                            }),
                          const SizedBox(height: 5,),
                          const Text("Logo", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),),
                          const SizedBox(height: 5,),
                          SizedBox(
                            height: 70,
                            width: double.maxFinite,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:BlocProvider.of<TaskBloc>(context).emList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return  InkWell(
                                    onTap: (){BlocProvider.of<TaskBloc>(context).selectLogo(index);},
                                    child: Text(BlocProvider.of<TaskBloc>(context).emList[index].toString(),style: const TextStyle(fontSize: 25),));
                              }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5),),
                          ),
                          ButtonApp(text: 'Create', color: ColorsApp.primary, function: (){
                            BlocProvider.of<TaskBloc>(context).insertUserData();
                            AppRoute.pop();
                          })
                        ],
                      )

                    ],
                  ),
                );
              });
        },backgroundColor: ColorsApp.secondary,child: const Icon(Icons.add),),
      );
    }, listener: (context,state){
      if (state is TaskInitialState) {
        debugPrint('CounterInitialState');
      }
    });

  }
}
