import 'dart:async';
import 'package:flutter/material.dart';

class Bai4 extends StatefulWidget {
  const Bai4({super.key});

  @override
  State<Bai4> createState() => _Bai4State();
}

class _Bai4State extends State<Bai4> {
  late int _minutes;
  late int _seconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _minutes = 0;
    _seconds = 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_seconds < 1) {
            if (_minutes < 1) {
              timer.cancel();
            } else {
              _minutes -= 1;
              _seconds = 59;
            }
          } else {
            _seconds -= 1;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bài 4'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _minutes = int.tryParse(value) ?? 0;
                    _seconds = 0;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nhập số phút :',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$_minutes : $_seconds',
                style: const TextStyle(fontSize: 40,color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  startTimer();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Bắt đầu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
