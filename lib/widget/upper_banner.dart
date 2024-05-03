import 'package:flutter/material.dart';

class UpperBanner extends StatelessWidget {
  const UpperBanner({
    super.key,
    required this.selectedDateTime,
    required this.actualUsers,
    required this.predictedUsers,
  });
  final DateTime selectedDateTime;
  final double actualUsers;
  final double predictedUsers;
  @override
  Widget build(context) {
    String formattedHour = selectedDateTime.hour.toString().padLeft(2, '0');
    String formattedMinute = selectedDateTime.minute.toString().padLeft(2, '0');
    String formattedDay = selectedDateTime.day.toString().padLeft(2, '0');
    String formattedMonth = selectedDateTime.month.toString().padLeft(2, '0');
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 107, 104, 103),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //The date and time selected by user
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selected DateTime:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$formattedDay/$formattedMonth/${selectedDateTime.year}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$formattedHour : $formattedMinute',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // const Spacer(),

            //dummy user image
            const Center(
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/blank user.png'),
              ),
            ),

            // const Spacer(),

            //The actual and predicted users at that hour are displayed.
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'At ${selectedDateTime.hour} hours:',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Actual: ${actualUsers.toInt()} users',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Predicted: $predictedUsers%',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
