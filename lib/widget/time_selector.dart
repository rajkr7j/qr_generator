import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({
    super.key,
    required this.onSelectTime,
  });
  final Function(DateTime) onSelectTime;
  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  DateTime time = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );

  void timePicker() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey,
          ),
          height: 200,
          child: CupertinoDatePicker(
            initialDateTime: time,
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (newTime) {
              widget.onSelectTime(newTime);
              setState(() {
                time = newTime;
              });
            },
          ),
        );
      },
    );
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

          //time icon
          Text(
            'TIME: ${time.hour} : ${time.minute}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          //time icon to select time
          GestureDetector(
            onTap: timePicker,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.timelapse,
                color: Colors.black,
                size: 35,
              ),
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
