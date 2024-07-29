import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/housekeeper/request_worker_controller.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/brain/helpers/validators.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';
import 'package:housekeeper/pages/components/rating_start.dart';
import 'package:im_stepper/stepper.dart';

class RequestWorkerPage extends StatefulWidget {
  const RequestWorkerPage({super.key});

  @override
  State<StatefulWidget> createState() => _RequestWorkerPage();
}

class _RequestWorkerPage extends State<RequestWorkerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Worker Account Request'.toUpperCase(),
          style: const TextStyle(
            fontSize: AppDimension.largeText,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<RequestWorkerPageController>(
          init: RequestWorkerPageController(),
          builder: (controller) {
            return Obx(
              () => Column(
                children: [
                  IconStepper(
                    icons: const [
                      Icon(Icons.person_outline, color: Colors.white),
                      Icon(Icons.account_circle_outlined, color: Colors.white),
                      Icon(Icons.document_scanner_outlined, color: Colors.white),
                      Icon(Icons.verified_user_outlined, color: Colors.white),
                    ],

                    activeStep: controller.currentPage.value,

                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) => controller.onStepReached,
                    enableStepTapping: false,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.currentPage.value == 0
                                ? 'Basic Info'.toUpperCase()
                                : controller.currentPage.value == 1
                                    ? 'Origins and Address'.toUpperCase()
                                    : controller.currentPage.value == 2
                                        ? 'Identification Docs'.toUpperCase()
                                        : 'Validation'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: AppDimension.largeText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimension.defaultPadding,
                          vertical: AppDimension.defaultPadding,
                        ),
                        child: controller.currentPage.value == 0
                            ? Form(
                                key: controller.formKeyStep1,
                                child: Column(
                                  children: [
                                    MyInputTextField(
                                      label: 'First Name',
                                      hint: "Enter First Name",
                                      text: controller.firstname,
                                      setText: (value) => controller.firstname = value,
                                      validator: InputValidator.nameValidator,
                                    ),
                                    MyInputTextField(
                                      label: 'Last Name',
                                      hint: "Enter Last Name",
                                      text: controller.lastname,
                                      setText: (value) => controller.lastname = value,
                                      validator: InputValidator.nameValidator,
                                    ),
                                    MyInputTextField(
                                      label: 'Email',
                                      hint: "Enter your email",
                                      text: controller.email,
                                      setText: (value) => controller.email = value,
                                      enabled: false,
                                    ),
                                    MyInputTextField(
                                      label: 'Phone Number',
                                      hint: "Enter Phone Number",
                                      text: controller.phone,
                                      setText: (value) => controller.phone = value,
                                      validator: InputValidator.phoneNumberValidator,
                                    ),
                                    MyInputTextField(
                                      label: 'Birth Date',
                                      hint: "Select Birthdate",
                                      text: controller.birthdate,
                                      setText: (value) => controller.birthdate = value,
                                    ),
                                  ],
                                ),
                              )
                            : controller.currentPage.value == 1
                                ? Form(
                                    key: controller.formKeyStep2,
                                    child: Column(
                                      children: [
                                        MyInputTextField(
                                          label: 'Nationality',
                                          hint: "Select Nationality",
                                          text: controller.nationality,
                                          setText: (value) => controller.nationality = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        MyInputTextField(
                                          label: 'Province',
                                          hint: "Enter your Province",
                                          text: controller.province,
                                          setText: (value) => controller.province = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        MyInputTextField(
                                          label: 'Religion',
                                          hint: "Enter your Religion",
                                          text: controller.religion,
                                          setText: (value) => controller.religion = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        const Divider(),
                                        MyInputTextField(
                                          label: 'Country (Residence)',
                                          hint: "Select Residence Country",
                                          text: controller.countryRes,
                                          setText: (value) => controller.countryRes = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        MyInputTextField(
                                          label: 'Province (Residence)',
                                          hint: "Entre your Province",
                                          text: controller.provinceRes,
                                          setText: (value) => controller.provinceRes = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        MyInputTextField(
                                          label: 'City (Residence)',
                                          hint: "Enter your city of residence",
                                          text: controller.cityRes,
                                          setText: (value) => controller.cityRes = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        MyInputTextField(
                                          label: 'Full Address',
                                          hint: "Enter your full Address",
                                          text: controller.fullAddress,
                                          setText: (value) => controller.fullAddress = value,
                                          validator: InputValidator.nameValidator,
                                        ),
                                        MyInputTextField(
                                          label: 'Fax',
                                          hint: "Enter the fax number",
                                          text: controller.fax,
                                          setText: (value) => controller.fax = value,
                                        ),
                                        MyInputTextField(
                                          label: 'Postal code',
                                          hint: "Enter the Postal Code",
                                          text: controller.postCode,
                                          setText: (value) => controller.postCode = value,
                                        ),
                                      ],
                                    ),
                                  )
                                : controller.currentPage.value == 2
                                    ? Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Obx(
                                                () => Container(
                                                  margin: const EdgeInsets.only(bottom: 20),
                                                  width: AppDimension.appWidth,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.black45, width: 2),
                                                    borderRadius: BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.7),
                                                        blurRadius: 2,
                                                        spreadRadius: 2,
                                                        offset: const Offset(2, 2),
                                                      )
                                                    ],
                                                    image: DecorationImage(
                                                      image: FileImage(controller.idDoc.value),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 8,
                                                left: 8,
                                                child: InkWell(
                                                  onTap: controller.openGallery,
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(25),
                                                      border: Border.all(color: Colors.white, width: 1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.8),
                                                          blurRadius: 2,
                                                          spreadRadius: 2,
                                                          offset: const Offset(2, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 8,
                                                right: 8,
                                                child: InkWell(
                                                  onTap: controller.openCamera,
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(25),
                                                      border: Border.all(color: Colors.white, width: 1),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.8),
                                                          blurRadius: 2,
                                                          spreadRadius: 2,
                                                          offset: const Offset(2, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Text('Here the description of the NB'),
                                        ],
                                      )
                                    : Obx(
                                        () => Column(
                                          children: [
                                            Card(
                                              shape: Border.all(style: BorderStyle.none),
                                              child: Container(
                                                width: AppDimension.appWidth,
                                                margin: const EdgeInsets.all(AppDimension.defaultPadding / 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'User Information'.toUpperCase(),
                                                      style: const TextStyle(
                                                        color: Colors.blueAccent,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: AppDimension.mediumText,
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(60),
                                                            border: Border.all(color: Colors.white, width: 1.5),
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                  controller.validatedUser.value.avatar ?? ''),
                                                              fit: BoxFit.fill,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.4),
                                                                spreadRadius: 2,
                                                                blurRadius: 2,
                                                                offset: const Offset(-2, 2),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                '${controller.validatedUser.value.firstname?.toUpperCase()} ${controller.validatedUser.value.lastname}',
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontStyle: FontStyle.normal,
                                                                  fontSize: AppDimension.mediumText,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${controller.validatedUser.value.username}',
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontStyle: FontStyle.normal,
                                                                  fontSize: AppDimension.mediumText,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${MyUtilities.getAge(controller.validatedUser.value.birthdate)} years',
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      fontStyle: FontStyle.normal,
                                                                      fontSize: AppDimension.mediumText,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      controller.validatedUser.value.keeper
                                                                              ?.nationality ??
                                                                          '',
                                                                      style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontStyle: FontStyle.normal,
                                                                        fontSize: AppDimension.mediumText,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 10),
                                                                    Text(
                                                                      controller.validatedUser.value.keeper?.religion ??
                                                                          '',
                                                                      style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontStyle: FontStyle.normal,
                                                                        fontSize: AppDimension.mediumText,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(width: 10),
                                                                    controller.validatedUser.value.keeper == null
                                                                        ? const SizedBox()
                                                                        : RatingStars(
                                                                            rating: controller.validatedUser.value
                                                                                    .keeper?.rating ??
                                                                                0),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              shape: Border.all(style: BorderStyle.none),
                                              child: Container(
                                                width: AppDimension.appWidth,
                                                margin: const EdgeInsets.all(AppDimension.defaultPadding / 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Worker Information'.toUpperCase(),
                                                      style: const TextStyle(
                                                        color: Colors.blueAccent,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: AppDimension.mediumText,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Matricule : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.keeper?.matricule}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Nationality : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.keeper?.nationality}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Province : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.keeper?.province}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Religion : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.keeper?.religion}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              shape: Border.all(style: BorderStyle.none),
                                              child: Container(
                                                width: AppDimension.appWidth,
                                                margin: const EdgeInsets.all(AppDimension.defaultPadding / 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Address Information'.toUpperCase(),
                                                      style: const TextStyle(
                                                        color: Colors.blueAccent,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: AppDimension.mediumText,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Country : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.address?.country}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Province : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.address?.province}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'City : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.address?.city}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Postal Code : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.address?.postalCode}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Fax : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.address?.fax}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Full Address : ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${controller.validatedUser.value.address?.fullAddress}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppDimension.mediumText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimension.defaultPadding,
                      horizontal: AppDimension.defaultPadding,
                    ),
                    child: controller.currentPage.value == controller.maxSteps
                        ? ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.currentPage.value == 0
                                  ? const SizedBox()
                                  : ElevatedButton(
                                      onPressed: () => controller.back(),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.red.withOpacity(0.5)),
                                      ),
                                      child: const Text(
                                        'Prev',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppDimension.smallText,
                                        ),
                                      ),
                                    ),
                              ElevatedButton(
                                onPressed: controller.next,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                ),
                                child: Text(
                                  controller.currentPage.value == controller.maxSteps - 1 ? 'Save' : 'Continue',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.smallText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
