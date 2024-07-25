import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/TaskController.dart';
import 'package:housekeeper/pages/components/task_card.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TaskController(),
      builder: (controller) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: const Row(
                      children: [
                        Icon(Icons.list_alt_sharp),
                        Text(
                          'My Tasks',
                          style: TextStyle(
                            fontSize: AppDimension.xLargeText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      isScrollable: false,
                      tabs: controller.isKeeper.value
                          ? <Widget>[
                              Obx(
                                () => Tab(
                                  child: Text(
                                    'Received ${controller.placed_received.isNotEmpty ? '(${controller.placed_received.length})' : ''}',
                                  ),
                                ),
                              ),
                              Obx(
                                () => Tab(
                                  child: Text(
                                    'On Going ${controller.ongoing.isNotEmpty ? '(${controller.ongoing.length})' : ''}',
                                  ),
                                ),
                              ),
                              Obx(
                                () => Tab(
                                  child: Text(
                                    'Completed ${controller.completed.isNotEmpty ? '(${controller.completed.length})' : ''}',
                                  ),
                                ),
                              ),
                            ]
                          : <Widget>[
                              Obx(
                                () => Tab(
                                  child: Text(
                                    'Placed ${controller.placed_received.isNotEmpty ? '(${controller.placed_received.length})' : ''}',
                                  ),
                                ),
                              ),
                              Obx(
                                () => Tab(
                                  child: Text(
                                    'On Going ${controller.ongoing.isNotEmpty ? '(${controller.ongoing.length})' : ''}',
                                  ),
                                ),
                              ),
                              Obx(
                                () => Tab(
                                  child: Text(
                                    'Completed ${controller.completed.isNotEmpty ? '(${controller.completed.length})' : ''}',
                                  ),
                                ),
                              ),
                            ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  buildPlacedOrders(),
                  buildOnGoingOrders(),
                  buildCompletedOrders(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPlacedOrders() {
    return SingleChildScrollView(
      child: GetBuilder<TaskController>(builder: (controller) {
        return Obx(
          () => controller.placed_received.isEmpty
              ? const Center(
                  child: Text(
                    'No Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimension.largeText,
                      color: Colors.red,
                    ),
                  ),
                )
              : Column(children: controller.placed_received.map((element) => TaskCard(task: element)).toList()),
        );
      }),
    );
  }

  Widget buildOnGoingOrders() {
    return SingleChildScrollView(
      child: GetBuilder<TaskController>(builder: (controller) {
        return Obx(
          () => controller.ongoing.isEmpty
              ? const Center(
                  child: Text(
                    'No Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimension.largeText,
                      color: Colors.red,
                    ),
                  ),
                )
              : Column(children: controller.ongoing.map((element) => TaskCard(task: element)).toList()),
        );
      }),
    );
  }

  Widget buildCompletedOrders() {
    return SingleChildScrollView(
      child: GetBuilder<TaskController>(builder: (controller) {
        return Obx(
          () => controller.completed.isEmpty
              ? const Center(
                  child: Text(
                    'No Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimension.largeText,
                      color: Colors.red,
                    ),
                  ),
                )
              : Column(children: controller.completed.map((element) => TaskCard(task: element)).toList()),
        );
      }),
    );
  }
}
