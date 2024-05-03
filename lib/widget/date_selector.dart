import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({
    super.key,
    required this.onSelectDate,
  });
  final Function(DateTime) onSelectDate;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();

  //date picker function
  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: now,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.red,
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
              ),
              buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            child: child!);
      },
    );
    if (pickedDate != null) {
      widget.onSelectDate(pickedDate);
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(context) {
    return Container(
      width: 230,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 15),

          //date
          Text(
            'DATE: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          //date icon to select
          GestureDetector(
            onTap: datePicker,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.date_range_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
