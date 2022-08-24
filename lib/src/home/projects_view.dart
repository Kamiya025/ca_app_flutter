import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import '../model/project.dart';

Widget projectItemView(Project val) {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                val.image ?? "",
                scale: 16,
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    val.projectCode ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextScroll(
                      val.name ?? "",
                      intervalSpaces: 10,
                      mode: TextScrollMode.endless,
                      delayBefore: const Duration(milliseconds: 2000),
                      velocity: const Velocity(pixelsPerSecond: Offset(20, 30)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}