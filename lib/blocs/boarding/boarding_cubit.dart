import 'package:bloctest/constants/colors.dart';
import 'package:bloctest/helper/routes.dart';
import 'package:bloctest/model/boarding_model.dart';
import 'package:bloctest/ui/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloctest/blocs/boarding/boarding_state.dart';

class BoardingBloc extends Cubit<BoardingState>{
  BoardingBloc() : super(BoardingInitialState());
  int currentIndex=0;
  PageController pageController=PageController();

  void changePage(int index){
    currentIndex=index;
    emit(BoardingUpdateIndexState());
  }

  void nextPage(){
    if(currentIndex==onBoardingList.length-1){
      AppRoute.pushReplacement(const LandingScreen());
    }
    else{
      pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
    }
    emit(BoardingUpdatePageState());
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 25,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex==index?ColorsApp.secondary:Colors.grey.withOpacity(.3),
      ),
    );
  }
}