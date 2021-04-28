import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class BedTime extends StatefulWidget {
  @override
  _BedTimeState createState() => _BedTimeState();
}

class _BedTimeState extends State<BedTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Bed Time"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: Clock(),
    );
  }
}

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hoursStr:$minutesStr:$secondsStr",
              style: TextStyle(
                fontSize: 90.0,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  onPressed: () {
                    timerStream = stopWatchStream();
                    timerSubscription = timerStream.listen((int newTick) {
                      setState(() {
                        hoursStr = ((newTick / (60 * 60)) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        minutesStr = ((newTick / 60) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        secondsStr =
                            (newTick % 60).floor().toString().padLeft(2, '0');
                      });
                    });
                  },
                  color: Colors.green,
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(width: 40.0),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  onPressed: () {
                    timerSubscription.cancel();
                    timerStream = null;
                    setState(() {
                      hoursStr = '00';
                      minutesStr = '00';
                      secondsStr = '00';
                    });
                  },
                  color: Colors.red,
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }
}
