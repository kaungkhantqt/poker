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
        body: const Body(),
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
  late AnimationController _controller;
  late Animation _animation;
  Random random = Random();
  int winMark = 0;
  int loseMark = 0;
  int ques = 0;
  int ans = 0;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    time();
  }

  void time() {
    ques = random.nextInt(13);
    ans = random.nextInt(13);
    durationTimeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    durationTime = IntTween(begin: 10, end: 0).animate(durationTimeController);
    durationTimeController.forward();
    durationTimeController.addListener(() {
      if (durationTime.status == AnimationStatus.completed) {
        _controller.forward().then((value) {
          _controller.reset();
          time();
        });
      }
      if (winMark == 5 || loseMark == 5) {
        durationTimeController.stop();
        dialog();
      }
    });
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: winMark == 5 ? const Icon(Icons.check_circle, size: 50, color: Colors.green) : const Icon(Icons.dangerous, size: 50, color: Colors.red),
        title: Text(
          winMark == 5 ? 'You Win!' : 'Game Over',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void small() {
    if (questions[ques].cardsName < questions[ans].cardsName) {
      winMark++;
    } else {
      loseMark++;
    }
    _controller.forward().then((value) {
      _controller.reset();
      time();
    });
  }

  void equal() {
    if (questions[ques].cardsName == questions[ans].cardsName) {
      winMark += 2;
    } else {
      loseMark++;
    }
    _controller.forward().then((value) {
      _controller.reset();
      time();
    });
  }

  void large() {
    if (questions[ques].cardsName > questions[ans].cardsName) {
      winMark++;
    } else {
      loseMark++;
    }
    _controller.forward().then((value) {
      _controller.reset();
      time();
    });
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
                style: const TextStyle(fontSize: 30),
              );
            }),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  loseMark.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
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
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
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
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(2, 1, 0.0015)
                ..rotateY(pi * _animation.value),
              child: Card(
                child: _animation.value <= 0.5
                    ? Container(
                        color: Colors.blue,
                        width: 190,
                        height: 300,
                        child: const Center(
                            child: Text(
                          '?',
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        )))
                    : Container(
                        height: 300,
                        width: 190,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(questions[ans].imgUrl),
                                fit: BoxFit.cover)),
                      ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
                text: 'Small',
                onPressed: () {
                  small();
                }),
            Button(
                text: 'Equal',
                onPressed: () {
                  equal();
                }),
            Button(
                text: 'Large',
                onPressed: () {
                  large();
                }),
          ],
        ),
      ],
    );
  }
}
