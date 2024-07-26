import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/register_controller.dart';
import 'package:housekeeper/pages/components/clickable_text.dart';
import 'package:housekeeper/pages/components/my_button.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<RegisterController>(
            init: RegisterController(),
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
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
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(label: 'First Name'),
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(label: 'Last Name'),
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(label: 'Email'),
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(label: 'Phone Number'),
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(label: 'Password', icon: Icons.lock_open_sharp),
                      const SizedBox(height: AppDimension.inputSpacing),
                      const MyInputTextField(
                        label: 'Confirm Password',
                        icon: Icons.lock_person,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing * 3),
                      MyButton(text: 'Register', textColor: Colors.white, onClick: controller.register, btnWidth: 150),
                      const SizedBox(height: AppDimension.inputSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account : ",
                            style: TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.normal),
                          ),
                          ClickableText(text: 'Login', onclick: controller.login),
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
