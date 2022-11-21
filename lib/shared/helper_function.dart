import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

customError() {
  return ErrorWidget.builder = ((details) {
      return Scaffold(
        body: Container(
          color: Colors.black87,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 40.0),
              SvgPicture.asset("assets/images/error.svg"),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Found Error In Some Thing",
                  // if you want to show main message error cancel comment below
                  // details.exception.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  });
}
