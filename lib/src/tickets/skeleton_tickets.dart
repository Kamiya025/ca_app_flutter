import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget skeletonTicketsItem() {
  return Card(
    borderOnForeground: true,
    elevation: 3,
    margin: const EdgeInsets.only(bottom: 20.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Container(
      height: 200,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(8),
                height: 30,
                width: 200,),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      shape: BoxShape.circle,
                      height: 30,
                      width: 30),
                ),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(8),
                  height: 10,
                  width: 100,),
              ),
            ],
          ),
          SkeletonParagraph(style: const SkeletonParagraphStyle(lines: 1),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(8),
                  height: 10,
                  width: 80,),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(8),
                  height: 10,
                  width: 80,),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
// Card(
// elevation: 3,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(15.0),
// ),
// color: Colors.white,
// child: Column(
// children: [
// Container(
// padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
// decoration: const BoxDecoration(
// border: Border(bottom: BorderSide(color: Colors.blueAccent)),
// ),
// alignment: Alignment.centerLeft,
// child: SkeletonLine(
// style: SkeletonLineStyle(
// borderRadius: BorderRadius.circular(8),
// height: 18,
// width: 100,
// maxLength: 20),
// )
// ),
// Padding(
// padding: const EdgeInsets.all(10),
// child: Column(
// children: [
// for(int i=0; i <= 3; i++)
// SkeletonListTile(),
// ],
// ),
// ),
// ],
// ),
// );
