import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/task/display_task_controller.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/pages/components/rating_start.dart';
import 'package:housekeeper/pages/components/status_widget.dart';

class TaskDisplayPage extends StatefulWidget {
  const TaskDisplayPage({super.key});

  @override
  State<TaskDisplayPage> createState() => _TaskDisplayPageState();
}

class _TaskDisplayPageState extends State<TaskDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<TaskDisplayController>(
            init: TaskDisplayController(),
            builder: (controller) {
              return Obx(
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
                              controller.currentUser.ref == controller.client.value.ref
                                  ? 'Worker Information'.toUpperCase()
                                  : 'Client Information'.toUpperCase(),
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
                                      image: NetworkImage(controller.printableUser.value.avatar ?? ''),
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
                                        '${controller.printableUser.value.firstname?.toUpperCase()} ${controller.printableUser.value.lastname}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: AppDimension.mediumText,
                                        ),
                                      ),
                                      Text(
                                        '${controller.printableUser.value.username}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: AppDimension.mediumText,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${MyUtilities.getAge(controller.printableUser.value.birthdate)} years',
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
                                              controller.printableUser.value.keeper?.nationality ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: AppDimension.mediumText,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              controller.printableUser.value.keeper?.religion ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: AppDimension.mediumText,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            controller.printableUser.value.keeper == null
                                                ? const SizedBox()
                                                : RatingStars(
                                                    rating: controller.printableUser.value.keeper?.rating ?? 0),
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
                            Row(
                              children: [
                                Text(
                                  'Task Information'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.circle,
                                  size: AppDimension.smallIcon,
                                  color: controller.getColorForState(),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Start Date : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                                Text(
                                  MyUtilities.parseDate(controller.task.value.start),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'End Date : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                                Text(
                                  MyUtilities.parseDate(controller.task.value.end),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Price/H : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: AppDimension.mediumText,
                                      ),
                                    ),
                                    Text(
                                      '${controller.task.value.currency} ${controller.task.value.pricePerHour}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimension.mediumText,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Reduction : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: AppDimension.mediumText,
                                      ),
                                    ),
                                    Text(
                                      '${controller.task.value.reduction} %',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimension.mediumText,
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
                                  'Description ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                                Text(
                                  '${controller.task.value.description}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
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
                            Row(
                              children: [
                                Text(
                                  'Actions'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimension.mediumText,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                StatusShow(status: '${controller.task.value.status}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TaskActionButton(
                                  label: 'Reject',
                                  color: Colors.red,
                                  show: controller.task.value.status == 'PENDING',
                                  action: controller.rejectTask,
                                ),
                                TaskActionButton(
                                  label: 'Accept',
                                  color: Colors.green,
                                  show: controller.task.value.status == 'PENDING',
                                  action: controller.acceptTask,
                                ),
                                TaskActionButton(
                                  label: 'Start',
                                  color: Colors.green,
                                  show: controller.task.value.status == 'ACCEPTED',
                                  action: controller.startTask,
                                ),
                                TaskActionButton(
                                  label: 'Stop',
                                  color: Colors.red,
                                  show: controller.task.value.status == 'ONGOING' ||
                                      controller.task.value.status == 'ACCEPTED',
                                  action: controller.stopTask,
                                ),
                                TaskActionButton(
                                  label: 'Finish',
                                  color: Colors.blue,
                                  show: controller.task.value.status == 'ONGOING',
                                  action: controller.finishTask,
                                ),
                                TaskActionButton(
                                  label: 'Add Appreciation',
                                  color: Colors.blue,
                                  show: controller.task.value.status == 'COMPLETED' &&
                                      controller.client.value.ref == controller.currentUser.ref,
                                  action: () => controller.addAppreciation(context),
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
                              'Appreciations'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimension.mediumText,
                              ),
                            ),
                            controller.task.value.status == 'COMPLETED' || controller.task.value.start == 'PAID'
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Rating : ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: AppDimension.mediumText,
                                            ),
                                          ),
                                          RatingStars(rating: controller.task.value.rating ?? 0),
                                        ],
                                      ),
                                      Text(
                                        controller.task.value.appreciation ?? 'Nothing was said...',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: AppDimension.mediumText,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class TaskActionButton extends StatelessWidget {
  const TaskActionButton({
    super.key,
    required this.label,
    required this.action,
    required this.color,
    required this.show,
  });
  final String label;
  final Color color;
  final Function action;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return show
        ? InkWell(
            onTap: () => action(),
            child: Card(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  label,
                  style: const TextStyle(fontSize: AppDimension.mediumText, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        : const SizedBox(width: 0, height: 0);
  }
}
