import 'package:flutter/material.dart';
import 'package:flutter_base/ui/shared/base/base_page.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

mixin BaseTabNav<Page extends BasePage> on BaseState<Page> {
  TabController _tabController;
  List<Widget> _tabs;
  set tabs(List<Widget> tabs) => _tabs = tabs;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  TabBar tabBarItems() => TabBar(
      labelStyle: TextStyle(
          //up to your taste
          fontWeight: FontWeight.w700),
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.label, //makes it better
      unselectedLabelColor: Color(0xff5f6368), //niceish grey
      isScrollable: true, //up to your taste
      indicator: MD2Indicator(
          //it begins here
          indicatorHeight: 3,
          indicatorColor: Colors.white,
          indicatorSize:
              MD2IndicatorSize.normal //3 different modes tiny-normal-full
          ),
      tabs: _tabs);

  @override
  Widget body() => Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabContent(),
            ),
          ),
          additonalContent()
        ],
      );

  Widget additonalContent() => null;
  List<Widget> tabContent();
}
