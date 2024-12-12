import 'package:flutter/material.dart';
import 'package:untitled/services/my_text.dart';

class MyButton extends StatelessWidget {
  final String textButton;
  final Function()? onTap;
  const MyButton({
    super.key,
    required this.textButton,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromARGB(255, 53, 29, 71),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: MyText(
              text: textButton,
              isTitle: false,
              isDeep: false,
            )
          )
      )
    );
  }
}


