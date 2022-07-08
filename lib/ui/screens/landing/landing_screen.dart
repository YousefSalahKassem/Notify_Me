import 'package:bloctest/blocs/groups/group_state.dart';
import 'package:bloctest/blocs/tasks/task_cubit.dart';
import 'package:bloctest/blocs/tasks/task_state.dart';
import 'package:bloctest/components/button_app.dart';
import 'package:bloctest/components/text_field.dart';
import 'package:bloctest/constants/colors.dart';
import 'package:bloctest/helper/routes.dart';
import 'package:bloctest/ui/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../blocs/groups/group_cubit.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBloc, GroupState>(listener: (context, state) {
      if (state is GroupInitialState) {
        debugPrint('CounterInitialState');
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: ColorsApp.white.withOpacity(.90),
          appBar: AppBar(
            backgroundColor: ColorsApp.primary,
            centerTitle: true,
            title: Text(
              'Notify me',
              style: GoogleFonts.oleoScript(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                  itemCount:
                      BlocProvider.of<GroupBloc>(context).groups.length,
                  itemBuilder: (context, index) {

                    return GestureDetector(
                      onTap: () {
                        AppRoute.push(TasksScreen(
                          category: BlocProvider.of<GroupBloc>(context)
                              .groups[index]["name"],
                        ));
                      },
                      onLongPress: (){
                        BlocProvider.of<GroupBloc>(context).deleteGroupData(BlocProvider.of<GroupBloc>(context)
                            .groups[index]["name"]);
                      },
                      child: Card(
                        color: ColorsApp.secondary,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                BlocProvider.of<GroupBloc>(context)
                                    .groups[index]["logo"],
                                style: const TextStyle(fontSize: 60),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                BlocProvider.of<GroupBloc>(context)
                                    .groups[index]["name"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (context) {
                    return BlocConsumer<GroupBloc, GroupState>(
                        listener: (context, state) {
                    }, builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15),
                        child: Wrap(
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Create New Group",
                                  style: TextStyle(
                                      fontSize: 30,
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey[800]),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFieldApp(
                                  controller:
                                      BlocProvider.of<GroupBloc>(
                                              context)
                                          .groupName,
                                  hint: 'Group Name..',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Logo",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 85,
                                  width: double.maxFinite,
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        BlocProvider.of<GroupBloc>(
                                                context)
                                            .emList
                                            .length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<GroupBloc>(context).selectLogo(index);
                                        },
                                        child: Text(
                                          BlocProvider.of<GroupBloc>(
                                                  context)
                                              .emList[index]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 25),
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ButtonApp(
                                    text: 'Create',
                                    color: ColorsApp.primary,
                                    function: () {
                                      BlocProvider.of<GroupBloc>(
                                              context)
                                          .insertGroupData();
                                      AppRoute.pop();
                                    }),
                              ],
                            )
                          ],
                        ),
                      );
                    });
                  });
            },
            backgroundColor: ColorsApp.secondary,
            child: const Icon(Icons.add),
          ));
    });
  }
}
