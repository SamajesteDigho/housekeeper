import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/pages/components/animate_text.dart';
import 'package:housekeeper/pages/components/clickable_text.dart';
import 'package:housekeeper/pages/components/testimony.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppDimension.appHeight,
        width: AppDimension.appWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue.withOpacity(0.5),
              Colors.red,
              Colors.orangeAccent,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppDimension.logoSize,
                        height: AppDimension.logoSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimension.logoSize),
                          image: const DecorationImage(image: AssetImage(AppStrings.logoLight)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(2, 2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      ClickableText(text: 'Login', onclick: onclick)
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      AnimatedText(
                        text: "HOUSEKEEPER",
                        animationType: AnimationType.wavyAnimation,
                        bold: true,
                      ),
                      AnimatedText(
                        text: 'FINDER APP',
                        animationType: AnimationType.typerAnimation,
                        bold: true,
                      ),
                      AnimatedText(
                        text: 'Assist you, our objective !',
                        animationType: AnimationType.typerAnimation,
                        bold: false,
                        textSize: 14,
                        repeat: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const <Widget>[
                      Testimony(
                          text: 'This is really interesting and usefull app. Thanks...',
                          name: 'Armanda Carmila',
                          ratings: 5),
                      Testimony(
                          text: 'This is really interesting and usefull app. Thanks...',
                          name: 'Armanda Carmila',
                          ratings: 5),
                      Testimony(
                          text: 'This is really interesting and usefull app. Thanks...',
                          name: 'Armanda Carmila',
                          ratings: 5),
                      Testimony(
                        text: 'This is really interesting and usefull app. Thanks...',
                        name: 'Armanda Carmila',
                        ratings: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't yet have an account : ",
                        style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                      ),
                      ClickableText(text: 'Register', onclick: onclick)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onclick() {
    print('Login...');
  }
}
