import 'package:flutter/material.dart';

class RequestTypeColor {
  static final Map<String, Color> mapRequestTypeColor = {
    "IN PROGRESS": const Color(0xff2c7be5),
    "IN_PROGRESS": const Color(0xff2c7be5),
    "CANCEL": const Color(0xff959595),
    "COMPLETE": const Color(0xff06b806),
    "CLOSE": const Color(0xfff13d3d),
    "RE_INPROGRESS": const Color(0xff2c7be5),
    "RE_OPEN": const Color(0xff0bb6b6),
    "OPEN": const Color(0xff0bb6b6),
    "UPGRADE": const Color(0xff449dff),
    "CHANGE_REQUEST": const Color(0xff2c7be5),
    "SUPPORT_REQUEST": const Color(0xff8a5e3b),
  };

  static final Map<String, AssetImage> mapStatusImageIcon = {
    "OPEN_REQUEST": const AssetImage("assets/request.png"),
    "CANCEL_REQUEST": const AssetImage("assets/task_cancel.png"),
    "COMPLETE": const AssetImage("assets/task_done.png"),
    "IN_PROGRESS_REQUEST": const AssetImage("assets/task_in_progress.png"),
    "REOPEN_REQUEST": const AssetImage("assets/reopen_task.png"),
    "CLOSE": const AssetImage("assets/task_close.png"),

  };


}
