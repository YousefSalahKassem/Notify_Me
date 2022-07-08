import '../../../constants/Strings.dart';

class BoardingModel{
  String title,subtitle,image;

  BoardingModel(this.title,this.subtitle,this.image);
}
List<BoardingModel> onBoardingList=[
  BoardingModel('Welcome To Notify Me','Notify you for what you need to do during day',StringsApp.boarding1),
  BoardingModel('Welcome To Notify Me','put you\'r tasks to groups !',StringsApp.boarding2),
  BoardingModel('Explore Notify Me','Create you\'r tasks now !',StringsApp.boarding3)
];