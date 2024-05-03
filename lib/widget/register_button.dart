import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.register,
    required this.isRegistring,
  });
  final Function() register;
  final bool isRegistring;
  @override
  Widget build(context) {
    return GestureDetector(
      onTap: isRegistring ? () {} : register,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: isRegistring
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                )
              : const Text(
                  'Confirm Registration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
