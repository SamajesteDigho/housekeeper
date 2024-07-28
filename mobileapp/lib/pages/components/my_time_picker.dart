import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';

class MyTimePicker extends StatelessWidget {
  MyTimePicker({super.key, this.selectedTime, this.setTimeVariable, this.width});
  final TimeOfDay? selectedTime;
  final Function? setTimeVariable;
  final double? width;

  String printable = '';

  @override
  Widget build(BuildContext context) {
    printable = MyUtilities.parseTime(selectedTime);
    return InkWell(
      onTap: () => pickDate(context),
      child: Container(
        height: 40,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(
          printable.isEmpty ? 'Time' : printable,
          style: const TextStyle(fontSize: AppDimension.mediumText),
        ),
      ),
    );
  }

  pickDate(BuildContext context) {
    showTimePicker(
      context: context,
      routeSettings: const RouteSettings(),
      initialTime: selectedTime == null
          ? TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
          : TimeOfDay(hour: selectedTime!.hour, minute: selectedTime!.minute),
    ).then((value) => setTimeVariable != null ? setTimeVariable!(value) : null);
  }
}
