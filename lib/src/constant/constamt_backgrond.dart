import 'package:flutter/cupertino.dart';

constantbgImage(){
  return const BoxDecoration(
image: DecorationImage(
image: AssetImage("assets/bgimage.jpg"),
opacity: 0.85,
fit: BoxFit.cover,
),
);}