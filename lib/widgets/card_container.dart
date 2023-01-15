import 'package:flutter/material.dart';

import '../model/user.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [
          Color(0xFFFF422C),
          Color(0xFFFF9003),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.25, 0.90],
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF101012),
          offset: Offset(-12, 12),
          blurRadius: 8,
        ),
      ],
    );

    TextStyle headingTextStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );

    TextStyle valueTextStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
    );

    return Container(
      margin: const EdgeInsets.all(30),
      height: 160,
      decoration: boxDecoration,
      alignment: Alignment.topLeft, //to align its child
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Name - ',
                style: headingTextStyle,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                '${user.name}',
                style: valueTextStyle,
              ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Row(
            children: [
              Text(
                'Age - ',
                style: headingTextStyle,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                '${user.age}',
                style: valueTextStyle,
              ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Row(
            children: [
              Text(
                'Gender - ',
                style: headingTextStyle,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                '${user.gender}',
                style: valueTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
