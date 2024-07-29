import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';

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
