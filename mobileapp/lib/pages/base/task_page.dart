import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/HomeController.dart';
import 'package:housekeeper/brain/controllers/OrderController.dart';
import 'package:housekeeper/pages/components/bottom_navigation_bar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OrderController(),
      builder: (controller) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScorlled) {
                return <Widget>[
                  const SliverAppBar(
                    title: Row(
                      children: [
                        Icon(Icons.list_alt_sharp),
                        Text(
                          'Orders',
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
                      tabs: [
                        Tab(child: Text('Placed')),
                        Tab(child: Text('On Going')),
                        Tab(child: Text('Completed')),
                      ],
                    ),
                  )
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
    return const Icon(Icons.add, size: 350);
  }

  Widget buildOnGoingOrders() {
    return const Icon(Icons.delete, size: 350);
  }

  Widget buildCompletedOrders() {
    return const Icon(Icons.scale, size: 350);
  }
}
