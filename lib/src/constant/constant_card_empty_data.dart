import 'package:flutter/material.dart';

Widget cardData(String title, {Widget? child}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    color: const Color(0xfffaf9f9),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blueAccent)),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
            child:
                 child ?? Container(
                  padding: const EdgeInsets.all(20), child: const Text("Empty data"),)),
      ],
    ),
  );
}
