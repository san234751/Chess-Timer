import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chess Timer'),
        ),
        body: const Homepage(),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool ispressed = true, isshow = true, isup1 = false, isup2 = false;
  int time1 = 300, time2 = 300;
  Timer? timer1, timer2;

  void starttime({bool isroot = false}) {
    if (isroot) {
      if (time1 == 0 || time2 == 0) {
        setState(() {
          time1 = 300;
          time2 = 300;
          isup1 = false;
          isup2 = false;
        });
      }
      timer1 = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          time1--;
        });
      });
    } else if (ispressed == false) {
      if (timer1!.isActive) {
        timer1!.cancel();
      }
      timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (time2 > 0) {
          setState(() {
            time2--;
          });
        } else {
          timer2!.cancel();
        }
      });
    } else {
      if (timer2!.isActive) {
        timer2!.cancel();
      }
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (time1 > 0) {
          setState(() {
            time1--;
          });
        } else {
          timer1!.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size devicesize = MediaQuery.of(context).size;
    var first1 = time1 / 60, first2 = time2 / 60;
    String first = '0${first1.floor()}:${time1 % 60}',
        second = '0${first2.floor()}:${time2 % 60}';
    if (time1 == 0 || time2 == 0) {
      isshow = true;
      if (time1 == 0) {
        isup1 = true;
      } else {
        isup2 = true;
      }
    }
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: isup1
                        ? Colors.red
                        : ispressed
                            ? Colors.orange
                            : Colors.white,
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Text(
                        first,
                        style: const TextStyle(fontSize: 70),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    ispressed = !ispressed;
                  });
                  starttime();
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: isup2
                        ? Colors.red
                        : ispressed
                            ? Colors.white
                            : Colors.orange,
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 0,
                      child: Text(
                        second,
                        style: const TextStyle(fontSize: 70),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    ispressed = !ispressed;
                  });
                  starttime();
                },
              ),
            )
          ],
        ),
        if (isshow)
          Center(
            child: GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                height: devicesize.width / 3.5,
                width: devicesize.width / 3.5,
                child: const Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  isshow = false;
                });
                starttime(isroot: true);
              },
            ),
          ),
      ],
    );
  }
}
