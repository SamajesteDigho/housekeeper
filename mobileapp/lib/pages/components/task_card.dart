import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/pages/components/rating_start.dart';
import 'package:housekeeper/pages/components/status_widget.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimension.appWidth,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${task.client?.firstname} ${task.client?.lastname}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimension.mediumText,
                          ),
                        ),
                        StatusShow(status: '${task.status}'),
                      ],
                    ),
                    Text('${task.description}', maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          MyUtilities.parseDate(task.start!),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimension.mediumText,
                          ),
                        ),
                        RatingStars(rating: task.rating ?? 0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: task.client?.avatar == null
                    ? const DecorationImage(image: AssetImage(AppStrings.logoDark))
                    : DecorationImage(image: NetworkImage(task.client!.avatar!)),
                borderRadius: BorderRadius.circular(5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
