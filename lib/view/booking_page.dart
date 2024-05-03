import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:qr_generatot/widget/bar_graph.dart';
import 'package:qr_generatot/widget/register_button.dart';
import 'package:qr_generatot/widget/upper_banner.dart';
import 'package:quickalert/quickalert.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
    required this.selectedDateTime,
  });
  final DateTime selectedDateTime;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<double> actualCrowd = List.filled(24, 0);
  List<double> predictedCrowd = List.filled(24, 0);
  bool isRegistring = false;

  //initializing all values
  @override
  void initState() {
    getActualCrowd();
    getpredictedCrowd();
    super.initState();
  }

  //get the actual crowd
  Future<void> getActualCrowd() async {
    String formattedDay =
        widget.selectedDateTime.day.toString().padLeft(2, '0');
    String formattedMonth =
        widget.selectedDateTime.month.toString().padLeft(2, '0');
    String date =
        '${widget.selectedDateTime.year}-$formattedMonth-$formattedDay';
    try {
      Uri url =
          Uri.parse('http://54.234.163.158:5000/get_visit_count/?date=$date');
      final response = await http.get(url);

      //decode the response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Map<String, dynamic> visitCounts = jsonResponse['visit_counts'];

      //store this is response in the actual crowd list
      visitCounts.forEach((hour, count) {
        int index = int.parse(hour);
        setState(() {
          actualCrowd[index] = count.toDouble();
        });
      });
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  //function to get predicted crowd
  Future<void> getpredictedCrowd() async {
    String formattedDay =
        widget.selectedDateTime.day.toString().padLeft(2, '0');
    String formattedMonth =
        widget.selectedDateTime.month.toString().padLeft(2, '0');
    String date =
        '${widget.selectedDateTime.year}-$formattedMonth-$formattedDay';
    try {
      Uri url = Uri.parse('http://54.234.163.158:5000/calculate/');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "date": date,
          },
        ),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      responseData.forEach((hour, count) {
        int index = int.parse(hour);
        setState(() {
          predictedCrowd[index] = count.toDouble();
        });
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data Fetched Successfully')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  //function to register the visit
  Future<void> register() async {
    setState(() {
      isRegistring = true;
    });
    String formattedDay =
        widget.selectedDateTime.day.toString().padLeft(2, '0');
    String formattedMonth =
        widget.selectedDateTime.month.toString().padLeft(2, '0');
    String date =
        '${widget.selectedDateTime.year}-$formattedMonth-$formattedDay';

    String hour = '${widget.selectedDateTime.hour}';
    try {
      Uri url = Uri.parse('http://54.234.163.158:5000/register_visit/');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "date": date,
            "hour": hour,
          },
        ),
      );
      if (response.statusCode == 200) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Visit registered successfully');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
    setState(() {
      isRegistring = false;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromARGB(119, 121, 208, 136),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.green[700]!,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.home_outlined,
                color: Colors.green[700],
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        title: const Center(
          child: Text(
            'CROWD PREDICTION',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      //register floating button
      floatingActionButton: RegisterButton(
        register: register,
        isRegistring: isRegistring,
      ),

      //scaffold body
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //upper banner
            UpperBanner(
              selectedDateTime: widget.selectedDateTime,
              actualUsers: actualCrowd[widget.selectedDateTime.hour],
              predictedUsers: predictedCrowd[widget.selectedDateTime.hour],
            ),

            //Bar graph and dropdown
            BarGraph(actualCrowd: actualCrowd, predictedCrowd: predictedCrowd),
          ],
        ),
      ),
    );
  }
}
