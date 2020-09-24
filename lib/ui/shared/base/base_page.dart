import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/widgets/app/app_bar.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);
}

abstract class BaseState<Page extends BasePage> extends State<Page>
    with TickerProviderStateMixin {
  BuildContext navContext;
  bool _disableAppBar = false;
  set disableAppBar(disable) => _disableAppBar = disable;

  @override
  Widget build(BuildContext context) {
    navContext = context;
    return Scaffold(
      appBar: !_disableAppBar
          ? MainAppbar(
              tabBarItems: tabBarItems(),
              apptitle: screenName(),
              actions: actions(),
            )
          : null,
      body: body(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  String screenName();
  List<Widget> actions() => null;
  Widget body();
  Widget bottomNavigationBar() => null;
  TabBar tabBarItems() => null;
}
