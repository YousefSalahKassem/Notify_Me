import 'package:bloctest/blocs/boarding/boarding_cubit.dart';
import 'package:bloctest/blocs/boarding/boarding_state.dart';
import 'package:bloctest/model/boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/button_app.dart';
import '../../../constants/colors.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) {
          return BoardingBloc();
        },
    child: BlocConsumer<BoardingBloc,BoardingState>(
        listener: (context, state) {
          if(state is BoardingInitialState) {
            debugPrint('CounterInitialState');
            debugPrint('${BlocProvider.of<BoardingBloc>(context).currentIndex}');
          }
        },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: screenHeight/1.5,
                    child: PageView.builder(
                        controller: BlocProvider.of<BoardingBloc>(context).pageController,
                        itemCount: onBoardingList.length,
                        onPageChanged: (int index) {
                          BlocProvider.of<BoardingBloc>(context).changePage(index);
                        },
                        itemBuilder: (_, i){
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50,),
                                Image.asset(
                                  onBoardingList[i].image,
                                  width: (screenHeight/3.38)*1.5,
                                  height: screenHeight/3.38,
                                ),
                                const SizedBox(height: 30,),

                                Text(
                                  onBoardingList[i].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Text(
                                  onBoardingList[i].subtitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ),

                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingList.length,
                          (index) => BlocProvider.of<BoardingBloc>(context).buildDot(index, context),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonApp(text: BlocProvider.of<BoardingBloc>(context).currentIndex==2?"Explore":'Get Started', color: ColorsApp.primary,function: (){BlocProvider.of<BoardingBloc>(context).nextPage();},),
                ),
                const SizedBox(height: 30,)

              ],
            ),
          ),
        );
      }
    ),
    );
  }
}
