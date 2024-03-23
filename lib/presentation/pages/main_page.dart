import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_list_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const ROUTE_NAME = '/main-page';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _listTabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    Text('Movies',),
    Text('TV Series'),
  ];

  final List<Widget> _listWidget = [
    HomeMoviePage(),
    TvListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Pabrik Gula Pangka'),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(16),
          controller: _tabController,
          indicator: BoxDecoration(
            color: kMikadoYellow,
            borderRadius: BorderRadius.circular(16),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: kBodyText.copyWith(fontWeight: FontWeight.w700),
          labelColor: Colors.white,
          unselectedLabelStyle: kBodyText,
          tabs: _listTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _listWidget,
      ),
    );
  }
}
