import 'package:flutter/material.dart';
import 'package:flutter_hello_world/pages/bar_item_page.dart';
import 'package:flutter_hello_world/pages/home_page.dart';
import 'package:flutter_hello_world/pages/my_page.dart';
import 'package:flutter_hello_world/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  late List<_TabItem> _tabItems;

  @override
  void initState() {
    super.initState();
    _tabItems = [
      _TabItem(icon: Icons.home, title: 'Home', page: HomePage()),
      _TabItem(icon: Icons.bar_chart_sharp, title: 'Bar', page: BarItemPage()),
      _TabItem(icon: Icons.search, title: 'Search', page: SearchPage()),
      _TabItem(icon: Icons.person, title: 'My', page: MyPage()),
    ];
    _tabController = TabController(length: _tabItems.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => _tabController.index = value,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: _tabItems
                .map((item) => item.toBottomNavigationBarItem())
                .toList()),
        body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: _tabItems.map((e) => e.page).toList()));
  }
}

@immutable
class _TabItem {
  final String? title;
  final IconData icon;
  final Widget page;

  const _TabItem({this.title, required this.icon, required this.page});

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
    );
  }
}
