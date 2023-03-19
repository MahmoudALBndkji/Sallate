import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Sallate/modules/login/shop_login_screen.dart';
import 'package:Sallate/shared/components/components.dart';
import 'package:Sallate/shared/network/local/cache_helper.dart';
import 'package:Sallate/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    this.image,
    this.title,
    this.body,
  });
}

class OnBoardingPage extends StatefulWidget {
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/images/1.svg",
      title: "Shopping",
      body: "Now you can shop from your phone with easy and simplicity",
    ),
    BoardingModel(
      image: "assets/images/2.svg",
      title: "Search",
      body: "Find the product you want with the right specifications for you",
    ),
    BoardingModel(
      image: "assets/images/3.svg",
      title: "Favorite",
      body: "You can mark the product that you liked, and you can also tag the product later",
    ),
  ];

  bool isLast = false;

  void submit() => CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      ).then((value) {
        if (value) {
          navigateReplacementTo(
            context,
            ShopLoginScreen(),
          );
        }
      }
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) => buildBoardingItem(
                  board: boarding[index],
                  context: context,
                ),
                itemCount: 3,
                onPageChanged: (index) {
                  index == boarding.length - 1
                      ? setState(() => isLast = true)
                      : setState(() => isLast = false);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast)
                      submit();
                    else
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem({BoardingModel? board, context}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              "${board!.image}",
            ),
          ),
          Text(
            "${board.title}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "${board.body}",
            textAlign: TextAlign.center,

            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
}
