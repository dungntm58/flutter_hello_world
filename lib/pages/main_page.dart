import 'package:flutter/material.dart';
import 'package:flutter_hello_world/pages/bar_item_page.dart';
import 'package:flutter_hello_world/pages/home_page.dart';
import 'package:flutter_hello_world/pages/my_page.dart';
import 'package:flutter_hello_world/pages/search_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  final int _selectedTabIndex;

  MainPage({Key? key, int selectedTabIndex = 0})
      : this._selectedTabIndex = selectedTabIndex,
        super(key: key);

  @override
  State<MainPage> createState() => _MainPageState(_selectedTabIndex);
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex;

  _MainPageState(int selectedTabIndex)
      : this._selectedTabIndex = selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _PageType.values.length, vsync: this)
      ..addListener(() {
        setState(() {
          _selectedTabIndex = _tabController.index;
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => _tabController.index = value,
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _PageType.values
            .map((item) => item.toBottomNavigationBarItem(localizations))
            .toList(),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: _PageType.values.map((item) => item.toPage(context)).toList(),
      ),
    );
  }
}

enum _PageType {
  home,
  bar,
  search,
  my,
}

extension _PageTypeExtension on _PageType {
  BottomNavigationBarItem toBottomNavigationBarItem(
          AppLocalizations localizations) =>
      toTabItem(localizations)._toBottomNavigationBarItem();

  _TabItem toTabItem(AppLocalizations localizations) {
    switch (this) {
      case _PageType.home:
        return _TabItem(icon: Icons.home, title: localizations.main_home_tab);
      case _PageType.bar:
        return _TabItem(
            icon: Icons.bar_chart_sharp,
            title: localizations.main_bar_item_tab);
      case _PageType.search:
        return _TabItem(
            icon: Icons.search, title: localizations.main_search_tab);
      case _PageType.my:
        return _TabItem(
            icon: Icons.person, title: localizations.main_my_page_tab);
    }
  }

  Widget toPage(BuildContext context) {
    switch (this) {
      case _PageType.home:
        return HomePage();
      case _PageType.bar:
        return BarItemPage();
      case _PageType.search:
        return SearchPage();
      case _PageType.my:
        return MyPage();
    }
  }
}

@immutable
class _TabItem {
  final String? title;
  final IconData icon;

  const _TabItem({this.title, required this.icon});

  BottomNavigationBarItem _toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
    );
  }
}
