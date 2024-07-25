import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/constants/strings.dart';
import 'package:housekeeper/brain/data/models/tasks.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';
import 'package:housekeeper/pages/components/rating_start.dart';

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
                        RatingStarts(rating: task.rating ?? 0),
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

class StatusShow extends StatelessWidget {
  const StatusShow({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      decoration: BoxDecoration(
        color: getStatusColor(status),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: AppDimension.smallText - 3,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    if (status == 'ACCEPTED') {
      return Colors.orangeAccent.withOpacity(0.8);
    } else if (status == 'COMPLETED') {
      return Colors.greenAccent.withOpacity(0.8);
    } else if (status == 'REFUSED') {
      return Colors.red.withOpacity(0.8);
    } else if (status == 'PENDING') {
      return Colors.purpleAccent.withOpacity(0.8);
    } else if (status == 'ONGOING') {
      return Colors.indigo.withOpacity(0.8);
    } else {
      return Colors.tealAccent.withOpacity(0.8);
    }
  }
}
