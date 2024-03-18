import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/presentation/pages/message/message_controller.dart';

class MessagePage extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: Text("Message", style: TextStyle(color: Colors.black),)),
    );
  }
}
