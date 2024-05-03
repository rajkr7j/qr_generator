import 'package:flutter/material.dart';
import 'package:qr_generatot/widget/date_selector.dart';
import 'package:qr_generatot/widget/save_button.dart';
import 'package:qr_generatot/widget/time_selector.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  DateTime selectedDate = DateTime.now();
  void onSelectDate(DateTime pickedDate) {
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void onSelectTime(DateTime pickedTime) {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),

            //Date and date selector
            DateSelector(onSelectDate: onSelectDate),

            const SizedBox(height: 15),

            //time and time selector
            TimeSelector(onSelectTime: onSelectTime),

            const Spacer(),

            //save date button
            SaveButton(selectedDateTime: selectedDate),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
