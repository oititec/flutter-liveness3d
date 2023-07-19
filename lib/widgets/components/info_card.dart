import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const InfoCardWidget(
    this.imagePath,
    this.title, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 5,
        top: 5,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: const Color.fromARGB(255, 224, 224, 224),
                style: BorderStyle.solid,
              ),
            ),
            child: Image.asset(
              imagePath,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
