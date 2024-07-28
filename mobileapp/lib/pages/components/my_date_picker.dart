import 'package:flutter/material.dart';
import 'package:housekeeper/brain/constants/dimensions.dart';
import 'package:housekeeper/brain/helpers/utilities.dart';

class MyDatePicker extends StatelessWidget {
  MyDatePicker({super.key, this.selectedDate, this.setDateVariable, this.width});
  final DateTime? selectedDate;
  final Function? setDateVariable;
  final double? width;

  DateTime? date;

  String printable = '';

  @override
  Widget build(BuildContext context) {
    date = selectedDate;
    printable = MyUtilities.parseDate(date);
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
          printable.isEmpty ? 'Select Date' : printable,
          style: const TextStyle(fontSize: AppDimension.mediumText),
        ),
      ),
    );
  }

  pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
      currentDate: date,
      initialDate: DateTime.now(),
    ).then((value) => setDateVariable != null ? setDateVariable!(value) : null);
  }
}
