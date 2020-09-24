import 'package:flutter/material.dart';

class MainAppbar extends AppBar {
  MainAppbar({
    this.color,
    this.tabBarItems,
    this.apptitle,
    this.leadingexists = false,
    this.actions,
  }) : super(
          leading: leadingexists ? Container() : null,
          backgroundColor: color,
          elevation: 0.0,
          title: Text(
            apptitle,
          ),
          actions: actions != null ? actions : [Container()],
          bottom: tabBarItems != null ? tabBarItems : null,
        );
  final String apptitle;
  final TabBar tabBarItems;
  final Color color;
  final bool leadingexists;
  final List<Widget> actions;
}
