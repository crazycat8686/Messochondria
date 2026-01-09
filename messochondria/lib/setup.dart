// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';

class setup extends StatefulWidget {
  const setup({super.key});

  @override
  State<setup> createState() => _setupState();
}

class _setupState extends State<setup> {
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    checktd();
    weath();
  }

  var dt = "Current menu :";
  var dayst = "Good Morning !";
  var dayc = "day";
  String lt = 'ass/sun.json';
  dynamic temp;
  Future<void> weath() async {
    print("weather data fetcher");
    try {
      final res = await Dio().get(
        'https://api.open-meteo.com/v1/forecast?latitude=16.514&longitude=80.516&daily=temperature_2m_mean&hourly=,cloud_cover_high,cloud_cover_mid,cloud_cover_low,cloud_cover,is_day&current=temperature_2m,rain,showers,is_day,apparent_temperature',
      );
      print(res.data);
      print("res fetcher");
      setState(() {
        temp = res.data['current']['temperature_2m'];
        print(temp);
      });
      if (dayc == "day") {
        setState(() {
          lt = 'ass/csun.json';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checktd() async {
    print(DateTime.now().hour);
    final FirebaseFirestore fire = FirebaseFirestore.instance;
    final res = await fire
        .collection("decmhvegandnveg")
        .doc(DateTime.now().day.toString())
        .get();

    print(DateTime.now().day.toString());
    if (DateTime.now().hour > 0 && DateTime.now().hour <= 9) {
      print("bf");
      setState(() {
        dt = res['bf'];

        dayst = "Good Morning !";
      });
    }
    if (DateTime.now().hour > 9 && DateTime.now().hour <= 14) {
      print("lunch");
      setState(() {
        dt = res['lun'];

        dayst = "Good Afternoon !";
      });
    }
    if (DateTime.now().hour > 14 && DateTime.now().hour <= 18) {
      print("snacks");

      setState(() {
        dt = res['sn'];
        dayst = "Good Evening !";
      });
    }
    if (DateTime.now().hour > 18 && (DateTime.now().hour <= 21)) {
      setState(() {
        dt = res['din'];
        dayst = "Get some walk ...";
      });
    }
    if (DateTime.now().hour > 21) {
      final res = await fire
          .collection("decmhvegandnveg")
          .doc((DateTime.now().day.toInt() + 1).toString())
          .get();
      setState(() {
        dt = res['bf'];

        dayst = "Had a good day ?";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            backgroundBlendMode: BlendMode.screen,

                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 10.0,
                                color: const Color.fromARGB(70, 0, 0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentGeometry.centerRight,
                                  // widthFactor: 20,
                                  // heightFactor: 0,
                                  child: LottieBuilder.asset(
                                    lt,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  dayst,
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 41,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.45,
                                        height: 3,

                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            64,
                                            158,
                                            158,
                                            158,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),

                                      Text(
                                        "Inavolu",
                                        style: TextStyle(fontFamily: 'Lexened'),
                                      ),
                                      Align(
                                        alignment: AlignmentGeometry.centerLeft,
                                        child: temp == null
                                            ? CircularProgressIndicator(
                                                color: Colors.grey,
                                              )
                                            : Text(
                                                temp.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 34,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dt,
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: LottieBuilder.asset(
                            'ass/cat.json',
                            width: MediaQuery.of(context).size.width * 0.68,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
