import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel>boardingItems=[
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'Title one', body: 'body one'),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'Title two', body: 'body two'),
    BoardingModel(image: 'assets/images/onboard_1.jpg', title: 'Title three', body: 'body three'),
  ];
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              text: 'Skip',
              function: () {
                navigate();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildOnBoardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
                onPageChanged: (int index){
                  if(index==boardingItems.length-1){
                      isLast=true;
                  }else{
                      isLast=false;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: boardingItems.length,
                    effect:  WormEffect(
                      activeDotColor: lightGreen,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey.shade300
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    child: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      if(isLast){
                          navigate();
                      }else {
                        pageController.nextPage(
                            duration: const Duration(
                              milliseconds: 700,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      );

  void navigate(){
    CacheHelper.saveData(key: IS_FIRST_TIME, value: true)
        .then((value){
          if(value){
            navigateAndFinish(context: context, screen: LoginScreen());
          }
    });
    
  }
}
