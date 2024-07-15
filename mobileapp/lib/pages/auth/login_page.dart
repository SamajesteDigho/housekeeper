import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/LoginController.dart';
import 'package:housekeeper/pages/components/clickable_text.dart';
import 'package:housekeeper/pages/components/my_button.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<LoginController>(
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimension.defaultPadding),
                width: AppDimension.appWidth,
                height: AppDimension.appHeight,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(-2, 2),
                            ),
                          ],
                          image: const DecorationImage(image: AssetImage(AppStrings.logoDark)),
                        ),
                      ),
                      const SizedBox(height: AppDimension.inputSpacing * 3),
                      const MyInputTextField(label: 'Username / Email'),
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(label: 'Password'),
                      const SizedBox(height: AppDimension.inputSpacing * 3),
                      MyButton(text: 'Login', textColor: Colors.white, onClick: controller.login, btnWidth: 150),
                      const SizedBox(height: AppDimension.inputSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't yet have an account : ",
                            style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                          ),
                          ClickableText(text: 'Register', onclick: controller.register),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
