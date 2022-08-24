import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';


  Widget linesView() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                      borderRadius: BorderRadius.circular(8),
                      height: 18,
                      width: 200,
                      maxLength: 20),
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      borderRadius: BorderRadius.circular(8),
                      padding: const EdgeInsets.only(top: 10, left: 0),
                      height: 35,
                      width: 80,
                      maxLength: 20),
                ),
              ],
            ),
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.rectangle, height: 52, width: 42),
            ),
          ],
        ),
      ),
    );
  }

  Widget skeletonChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.blueAccent)),
              ),
              alignment: Alignment.centerLeft,
              child: SkeletonLine(
                style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(8),
                    height: 18,
                    width: 100,
                    maxLength: 20),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(8),
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget skeletonListItem() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.blueAccent)),
              ),
              alignment: Alignment.centerLeft,
              child: SkeletonLine(
                style: SkeletonLineStyle(
                    borderRadius: BorderRadius.circular(8),
                    height: 18,
                    width: 100,
                    maxLength: 20),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                for(int i=0; i <= 3; i++)
                SkeletonListTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }