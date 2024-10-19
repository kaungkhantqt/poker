import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_quizz/button.dart';
import 'package:poker_quizz/data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController durationTimeController;
  late Animation durationTime;
  Random random = Random();
  int winMark = 0;
  int loseMark = 0;
  int ques = 0;
  int ans = 0;
  @override
  void initState() {
    super.initState();
    time();
  }

  void time() {
    ques = random.nextInt(13);
    ans = random.nextInt(13);
    durationTimeController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 10,
      ),
    );
    durationTime = IntTween(begin: 10, end: 0).animate(durationTimeController);
    durationTimeController.forward();
    durationTimeController.addListener(() {
      if (durationTime.status == AnimationStatus.completed) {
        time();
        setState(() {});
      } else if (winMark == 20 || loseMark == 10) {
        durationTimeController.stop();
        //dialog();
      }
    });
  }

  // void dialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) => const AboutDialog(
  //             applicationIcon: FlutterLogo(),
  //             applicationLegalese: 'Aung Kaung Khant',
  //             applicationName: 'Flutter App',
  //             applicationVersion: 'version 1.3.2',
  //           ));
  // }

  void small() {
    if (questions[ques].cardsName < questions[ans].cardsName) {
      winMark++;
    } else {
      // winMark--;
      loseMark++;
    }
    time();
    setState(() {});
  }

  void equal() {
    if (questions[ques].cardsName == questions[ans].cardsName) {
      winMark += 2;
    } else {
      // winMark--;
      loseMark++;
    }
    time();
    setState(() {});
  }

  void large() {
    if (questions[ques].cardsName > questions[ans].cardsName) {
      winMark++;
    } else {
      // winMark--;
      loseMark++;
    }
    time();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
            animation: durationTime,
            builder: (context, child) {
              return Text(
                durationTime.value.toString(),
                style: TextStyle(fontSize: 30),
              );
            }),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  loseMark.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Lose',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  winMark.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Win',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 300,
              width: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(questions[ques].imgUrl),
                      fit: BoxFit.cover)),
            ),
            Container(
              height: 300,
              width: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(questions[ans].imgUrl),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
                text: 'Small',
                onPressed: () {
                  small();
                  print('Small');
                }),
            Button(
                text: 'Equal',
                onPressed: () {
                  equal();
                  print('Equal');
                }),
            Button(
                text: 'Large',
                onPressed: () {
                  large();
                  print('Large');
                }),
          ],
        ),
        // ElevatedButton(
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (context) => const AboutDialog(
        //                 applicationIcon: FlutterLogo(),
        //                 applicationLegalese: 'Aung Kaung Khant',
        //                 applicationName: 'Flutter App',
        //                 applicationVersion: 'version 1.3.2',
        //               ));
        //     },
        //     child: const Text('data'))
      ],
    );
  }
}
