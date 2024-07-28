import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/task/create_new_task_controller.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/brain/helpers/validators.dart';
import 'package:housekeeper/pages/components/my_date_picker.dart';
import 'package:housekeeper/pages/components/my_input_text_field.dart';
import 'package:housekeeper/pages/components/my_time_picker.dart';
import 'package:housekeeper/pages/components/rating_start.dart';
import 'package:im_stepper/stepper.dart';

class CreateNewTaskPage extends StatefulWidget {
  const CreateNewTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateNewTaskPage();
}

class _CreateNewTaskPage extends State<CreateNewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Open Task With HouseKeeper',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimension.largeText,
            decoration: TextDecoration.underline,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<CreateNewTaskController>(
          init: CreateNewTaskController(),
          builder: (controller) {
            return Column(
              children: [
                Obx(
                  () => Card(
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
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                  image: DecorationImage(
                                    image: NetworkImage(controller.worker.value.avatar ?? ''),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.worker.value.firstname?.toUpperCase()} ${controller.worker.value.lastname}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        fontSize: AppDimension.mediumText,
                                      ),
                                    ),
                                    Text(
                                      '${controller.worker.value.username}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        fontSize: AppDimension.mediumText,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${MyUtilities.getAge(controller.worker.value.birthdate)} years',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: AppDimension.mediumText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Cameroon',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: AppDimension.mediumText,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Christian',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: AppDimension.mediumText,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          RatingStars(rating: 5),
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
                ),
                Expanded(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconStepper(
                          icons: const [
                            Icon(Icons.description_outlined, color: Colors.white),
                            Icon(Icons.schedule, color: Colors.white),
                            Icon(Icons.domain_verification_rounded, color: Colors.white),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.currentPage.value == 0
                                      ? 'Description'
                                      : controller.currentPage.value == 1
                                          ? 'Scheduling'
                                          : 'Check Validation',
                                  style: const TextStyle(
                                    color: Colors.white,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'In the following field, enter a clair and detailed description of the task.'
                                            ' Please make sure to be explicit and detailed as possible.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppDimension.smallText,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          MyInputTextField(
                                            label: 'Task Description',
                                            hint: 'Describe the task here.',
                                            text: controller.taskDescription,
                                            maxNumberOfLine: 12,
                                            setText: (value) => controller.taskDescription = value,
                                            validator: InputValidator.nameValidator,
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          ),
                                        ],
                                      ),
                                    )
                                  : controller.currentPage.value == 1
                                      ? Form(
                                          key: controller.formKeyStep2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Start Date & Time',
                                                    style: TextStyle(
                                                      fontSize: AppDimension.mediumText,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: MyDatePicker(
                                                          selectedDate: controller.startDate,
                                                          setDateVariable: controller.setStartDate,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      MyTimePicker(
                                                        selectedTime: controller.startTime,
                                                        setTimeVariable: controller.setStartTime,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: AppDimension.defaultPadding),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'End Date & Time',
                                                    style: TextStyle(
                                                      fontSize: AppDimension.mediumText,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: MyDatePicker(
                                                          selectedDate: controller.endDate,
                                                          setDateVariable: controller.setEndDate,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      MyTimePicker(
                                                        selectedTime: controller.endTime,
                                                        setTimeVariable: controller.setEndTime,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: AppDimension.defaultPadding),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Total number of days : ',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: AppDimension.mediumText,
                                                      fontStyle: FontStyle.italic,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${controller.numberOfDaysOfWork()} days',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: AppDimension.mediumText,
                                                      fontStyle: FontStyle.italic,
                                                      color: controller.numberOfDaysOfWork() <= 0
                                                          ? Colors.red
                                                          : Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: AppDimension.defaultPadding),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: MyInputTextField(
                                                      label: 'Price per hour',
                                                      inputType: TextInputType.number,
                                                      validator: InputValidator.numberValidator,
                                                      text: controller.pricePerHour,
                                                      setText: (value) => controller.pricePerHour = value,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Obx(
                                                    () => DropdownButton(
                                                      value: controller.currency.value,
                                                      items: ['USD', 'EURO', 'XAF']
                                                          .map(
                                                            (e) => DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e),
                                                            ),
                                                          )
                                                          .toList(),
                                                      onChanged: (value) => value == null
                                                          ? controller.currency.value = 'USD'
                                                          : controller.currency.value = value,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Task Information',
                                              style: TextStyle(
                                                fontSize: AppDimension.largeText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  '1. Description',
                                                  style: TextStyle(
                                                    fontSize: AppDimension.mediumText,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.taskDescription}',
                                                  style: const TextStyle(
                                                    fontSize: AppDimension.smallText,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  '2. Schedule',
                                                  style: TextStyle(
                                                    fontSize: AppDimension.mediumText,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Start : ',
                                                      style: TextStyle(
                                                        fontSize: AppDimension.mediumText,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${MyUtilities.parseDate(controller.startDate)} | ${MyUtilities.parseTime(controller.startTime)}',
                                                      style: const TextStyle(
                                                        fontSize: AppDimension.smallText,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'End : ',
                                                      style: TextStyle(
                                                        fontSize: AppDimension.mediumText,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${MyUtilities.parseDate(controller.endDate)} | ${MyUtilities.parseTime(controller.endTime)}',
                                                      style: const TextStyle(
                                                        fontSize: AppDimension.smallText,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  '3. Pricing',
                                                  style: TextStyle(
                                                    fontSize: AppDimension.mediumText,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Per Hour : ',
                                                      style: TextStyle(
                                                        fontSize: AppDimension.mediumText,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${controller.currency.value} ${controller.pricePerHour}',
                                                      style: const TextStyle(
                                                        fontSize: AppDimension.smallText,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Total Days : ',
                                                      style: TextStyle(
                                                        fontSize: AppDimension.mediumText,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${controller.numberOfDaysOfWork()} days',
                                                      style: const TextStyle(
                                                        fontSize: AppDimension.smallText,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
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
                              : Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      controller.currentPage.value > 0
                                          ? ElevatedButton(
                                              onPressed: () => controller.back(),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                              ),
                                              child: const Text('Prev'),
                                            )
                                          : const SizedBox(),
                                      ElevatedButton(
                                        onPressed: controller.next,
                                        style: ButtonStyle(
                                          backgroundColor: controller.currentPage.value == controller.maxSteps
                                              ? MaterialStateProperty.all(Colors.greenAccent)
                                              : MaterialStateProperty.all(Colors.white),
                                        ),
                                        child: Text(
                                          controller.currentPage.value == controller.maxSteps ? 'Save' : 'Continue',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
