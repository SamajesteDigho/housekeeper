import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/LoginController.dart';
import 'package:housekeeper/brain/helpers/validators.dart';
import 'package:housekeeper/pages/components/animate_text.dart';
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
                            BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2, offset: Offset(-2, 2)),
                          ],
                          image: const DecorationImage(image: AssetImage(AppStrings.logoDark)),
                        ),
                      ),
                      Obx(
                        () => controller.errorString.isEmpty
                            ? const SizedBox()
                            : AnimatedText(
                                text: controller.errorString.value,
                                animationType: AnimationType.typerAnimation,
                                repeat: false,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: AppDimension.mediumText,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                      const SizedBox(height: AppDimension.inputSpacing * 3),
                      MyInputTextField(
                        label: 'Username / Email',
                        icon: Icons.person_outline,
                        maxNumberOfLine: 1,
                        text: controller.pseudo,
                        setText: (value) => controller.pseudo = value,
                        validator: InputValidator.nameValidator,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'Password',
                        icon: Icons.lock_open_sharp,
                        maxNumberOfLine: 1,
                        text: controller.password,
                        setText: (value) => controller.password = value,
                        validator: InputValidator.passwordValidator,
                      ),
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
