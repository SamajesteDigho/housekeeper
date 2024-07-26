import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/housekeeper/request_worker_controller.dart';
import 'package:housekeeper/brain/helpers/validators.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';
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
        title: const Text('IconStepper Example'),
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
                      Icon(Icons.verified, color: Colors.white),
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
                                ? 'Basic Info'
                                : controller.currentPage.value == 1
                                    ? 'Origins and More'
                                    : 'Identification Docs',
                            style: const TextStyle(color: Colors.black, fontSize: 20),
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
                                    : const Center(
                                        child: Text('Validation'),
                                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimension.defaultPadding,
                      horizontal: AppDimension.defaultPadding,
                    ),
                    child: controller.currentPage.value > controller.maxSteps
                        ? ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => controller.back(),
                                child: const Text('Prev'),
                              ),
                              ElevatedButton(
                                onPressed: controller.next,
                                child: Text(controller.currentPage.value == controller.maxSteps ? 'Save' : 'Continue'),
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
