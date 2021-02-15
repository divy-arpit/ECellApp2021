import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/screens/about_us/text_about_us.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(
            elementId: 0,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                screenBody(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget screenBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(D.horizontalPadding, 30, D.horizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(width, height, bottom, heightFactor),
              aboutUsText(width, height, bottom, heightFactor),
              aimTextSection(width, height, bottom, heightFactor),
              visionTextSection(width, height, bottom, heightFactor),
            ],
          ),
        ),
        bottomNavBar(width, height, bottom, heightFactor),
      ],
    );
  }

  Widget backButton(double width, double height, double bottom, double heightFactor) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
      onPressed: () {
        // to be implemented during screen integration.
      },
    );
  }

  Widget aboutUsText(double width, double height, double bottom, double heightFactor) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: width / 50, top: heightFactor * 30),
      child: Text(
        "About Us",
        style: TextStyle(
          fontSize: 50 * heightFactor,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget aimTextSection(double width, double height, double bottom, double heightFactor) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: width / 50, top: heightFactor * 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aim",
            style: TextStyle(
              fontSize: 40 * heightFactor,
              fontWeight: FontWeight.w600,
              color: C.primaryHighlightedColor,
            ),
          ),
          Text(
            TextAboutUs.getAim(),
            style: TextStyle(
              letterSpacing: 1.5 * heightFactor,
              wordSpacing: 2 * heightFactor,
              fontSize: 20 * heightFactor,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget visionTextSection(double width, double height, double bottom, double heightFactor) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: width / 50, top: heightFactor * 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vision",
            style: TextStyle(
              fontSize: 40 * heightFactor,
              fontWeight: FontWeight.w600,
              color: C.primaryHighlightedColor,
            ),
          ),
          Text(
            TextAboutUs.getVision(),
            style: TextStyle(
              letterSpacing: 1.5 * heightFactor,
              wordSpacing: 2 * heightFactor,
              fontSize: 20 * heightFactor,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavBar(double width, double height, double bottom, double heightFactor) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: heightFactor * 45),
      padding: EdgeInsets.only(left: width / 50, top: heightFactor * 10, bottom: heightFactor * 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: heightFactor * 30,
            icon: Icon(
              Icons.adjust_rounded,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: heightFactor * 30,
            icon: Icon(
              Icons.people,
              color: Colors.grey,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}