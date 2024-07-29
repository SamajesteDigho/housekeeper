import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/controllers/account_page_controller.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: GetBuilder<AccountPageController>(
          init: AccountPageController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Obx(
                () => Stack(
                  children: [
                    SizedBox(
                      height: AppDimension.appHeight * 0.3,
                      width: double.infinity,
                      child: Image.network('${controller.user.value.avatar}', fit: BoxFit.cover),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: AppDimension.appHeight * 0.25,
                        left: AppDimension.defaultPadding,
                        right: AppDimension.defaultPadding,
                        bottom: AppDimension.defaultPadding,
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppDimension.defaultPadding),
                                margin: const EdgeInsets.only(top: AppDimension.defaultPadding),
                                decoration:
                                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 110.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${controller.user.value.firstname?.toUpperCase()} ${controller.user.value.lastname}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${controller.user.value.role}',
                                                  style: const TextStyle(
                                                    color: Colors.indigo,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: AppDimension.smallText,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 40)
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.8),
                                                  blurRadius: 2,
                                                  spreadRadius: 2,
                                                  offset: const Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blueAccent,
                                              child: IconButton(
                                                onPressed: controller.clickEditUser,
                                                icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 18),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                '${MyUtilities.getAge(controller.user.value.birthdate)} years',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                              ),
                                              const Text("Age"),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                MyUtilities.parseDate(controller.user.value.createdAt),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppDimension.mediumText,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const Text("Registered")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage('${controller.user.value.avatar}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                margin: const EdgeInsets.only(left: 20.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                // const ListTile(
                                //   title: Text("Profile Information"),
                                // ),
                                // const Divider(),
                                controller.user.value.role != 'HOUSEKEEPER'
                                    ? ListTile(
                                        title: const Text(
                                          "Become a Worker",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppDimension.mediumText,
                                          ),
                                        ),
                                        subtitle: const Text(
                                          "Click here to request for a worker account.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic,
                                            fontSize: AppDimension.smallText,
                                          ),
                                        ),
                                        leading: const Icon(Icons.work_outline),
                                        onTap: controller.becomeHouseKeeper,
                                      )
                                    : ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "HouseKeeper Profile",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppDimension.mediumText,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.greenAccent.withOpacity(0.8),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                '${controller.user.value.status}',
                                                style: const TextStyle(
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppDimension.smallText,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        subtitle: const Text(
                                          "Let's have a look on your profile",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontStyle: FontStyle.italic,
                                            fontSize: AppDimension.smallText,
                                          ),
                                        ),
                                        leading: const Icon(Icons.work_outline),
                                        onTap: controller.houseKeeperDetails,
                                      ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    "Statistics",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimension.mediumText,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Have a detailed view on your activity statistics",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      fontSize: AppDimension.smallText,
                                    ),
                                  ),
                                  leading: const Icon(Icons.area_chart),
                                  onTap: controller.activityStatistics,
                                ),
                                const Divider(),
                                ListTile(
                                  title: const Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimension.mediumText,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Logout and clear your login info",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      fontSize: AppDimension.smallText,
                                    ),
                                  ),
                                  leading: const Icon(Icons.logout, color: Colors.red),
                                  onTap: controller.logout,
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

// AFTER
// Container(
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Column(
// children: const [
// ListTile(
// title: Text("Profile Information"),
// ),
// Divider(),
// ListTile(
// title: Text("Date of Birth"),
// subtitle: Text("12 September 2001"),
// leading: Icon(Icons.calendar_view_day),
// ),
// ListTile(
// title: Text("Education"),
// subtitle: Text("Bachelor Degree"),
// leading: Icon(Icons.school_outlined),
// ),
// ListTile(
// title: Text("Email"),
// subtitle: Text("nita.khgd@gmail.com"),
// leading: Icon(Icons.mail_outline),
// ),
// ListTile(
// title: Text("Phone"),
// subtitle: Text("+855 12 987 789"),
// leading: Icon(Icons.phone),
// ),
// ListTile(
// title: Text("Address"),
// subtitle:
// Text("Stung Meanchey District, Stung Meanchey Commune, Phnom Penh, Cambodia 1200"),
// leading: Icon(Icons.map),
// ),
// SizedBox(
// height: 10,
// ),
// ],
// ),
// )
