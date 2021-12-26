import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'Boarding title 1',
      image: 'assets/images/on_boarding_1.jpg',
      body: 'Boarding body 1',
    ),
    BoardingModel(
      title: 'Boarding title 2',
      image: 'assets/images/on_boarding_1.jpg',
      body: 'Boarding body 2',
    ),
    BoardingModel(
      title: 'Boarding title 3',
      image: 'assets/images/on_boarding_1.jpg',
      body: 'Boarding body 3',
    ),
  ];

  bool isLast = false;

  void Submit(){
    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
      if(value){NavigatAndFinish(context, ShopLoginScreen());}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: Submit,
              text: 'skip'.toUpperCase()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    BuildBoardingItems(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: DefaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItems(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
}
