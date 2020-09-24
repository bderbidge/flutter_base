import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'base_page.dart';

mixin BaseBottomNav<Page extends BasePage> on BaseState<Page> {
  int _currTab = 0;
  Widget _currPage;
  List<Widget> _pages;
  List<StatesRebuilder<dynamic> Function()> observeMany = [];

  int get currTab => _currTab;
  Widget get currPage => _currPage;
  set currPage(Widget currPage) => _currPage = currPage;
  set pages(List<Widget> pages) => _pages = pages;

  @override
  void initState() {
    super.initState();
    _currPage = _pages[0];
    disableAppBar = true;
  }

  Widget body() => StateBuilder(
      observeMany: observeMany, builder: (context, model) => currPage);

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currTab,
      onTap: changePage,
      items: bottomItems(),
    );
  }

  changePage(int index) {
    setState(() {
      _currTab = index;
      _currPage = _pages[index];
    });
  }

  String screenName() => null;

  List<BottomNavigationBarItem> bottomItems();
}
