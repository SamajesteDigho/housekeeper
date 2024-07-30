import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/controllers/register_controller.dart';
import 'package:housekeeper/brain/helpers/validators.dart';
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
                            BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2, offset: Offset(-2, 2)),
                          ],
                          image: const DecorationImage(image: AssetImage(AppStrings.logoDark)),
                        ),
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      Obx(() => Center(
                            child: Text(
                              controller.errorString.value,
                              style: const TextStyle(
                                fontSize: AppDimension.mediumText,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          )),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'First Name',
                        icon: Icons.person_outline,
                        text: controller.firstname,
                        hint: 'Enter First Name',
                        maxNumberOfLine: 1,
                        setText: (value) => controller.firstname = value,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'Last Name',
                        icon: Icons.person_outline,
                        text: controller.lastname,
                        hint: 'Enter Last Name',
                        maxNumberOfLine: 1,
                        setText: (value) => controller.lastname = value,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'User Name',
                        icon: Icons.supervised_user_circle_outlined,
                        text: controller.username,
                        hint: 'Enter username',
                        maxNumberOfLine: 1,
                        setText: (value) => controller.username = value,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'Email *',
                        icon: Icons.email_outlined,
                        text: controller.email,
                        hint: 'Enter Email',
                        maxNumberOfLine: 1,
                        setText: (value) => controller.email = value,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'Phone Number',
                        icon: Icons.phone,
                        text: controller.phone,
                        hint: 'Enter Phone',
                        maxNumberOfLine: 1,
                        setText: (value) => controller.phone = value,
                      ),
                      const SizedBox(height: AppDimension.inputSpacing),
                      MyInputTextField(
                        label: 'Password *',
                        icon: Icons.lock_open_sharp,
                        text: controller.password,
                        hint: 'Enter Password',
                        maxNumberOfLine: 1,
                        setText: (value) => controller.password = value,
                        validator: InputValidator.passwordValidator,
                      ),
                      // const SizedBox(height: AppDimension.inputSpacing),
                      // MyInputTextField(
                      //   label: 'Confirm Password',
                      //   icon: Icons.lock_person,
                      //   text: controller.confirmPassword,
                      //   hint: 'Confirm Password',
                      //   maxNumberOfLine: 1,
                      //   setText: (value) => controller.firstname = value,
                      //   required: true,
                      //   validator: (controller) InputValidator.confirmPasswordValidator(pass1, pass2),
                      // ),
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
