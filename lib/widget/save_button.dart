import 'package:flutter/material.dart';
import 'package:qr_generatot/view/booking_page.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.selectedDateTime,
  });

  final DateTime selectedDateTime;
  void onSave(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BookingPage(
        selectedDateTime: selectedDateTime,
      );
    }));
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        onSave(context);
      },
      child: Container(
        width: 230,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green[700]!),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SAVE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
