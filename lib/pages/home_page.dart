import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hello_world/cubit/app_cubit_state.dart';
import 'package:flutter_hello_world/misc/colors.dart';
import 'package:flutter_hello_world/widgets/app_large_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hello_world/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _DiscoverType.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 20),
                  child: AppLargeText(text: localizations.home_discover),
                ),
                _buildTabBar(localizations),
                _buildTabBarView(context),
                _buildExploreMore(localizations),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 70, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, size: 30, color: Colors.black54),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar(AppLocalizations localizations) {
    return SizedBox(
      height: 60,
      width: double.maxFinite,
      child: TabBar(
        controller: _tabController,
        labelPadding: const EdgeInsets.only(left: 20, right: 20),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: CircleIndicatorDecoration(
          color: AppColors.mainColor,
          radius: 5,
        ),
        tabs: _DiscoverType.values
            .map((item) => Tab(text: item.toTitle(localizations)))
            .toList(),
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.maxFinite,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildPlacesTab(context),
          Center(child: Text("Tab 2")),
          Center(child: Text("Tab 3")),
        ],
      ),
    );
  }

  Widget _buildPlacesTab(BuildContext context) {
    Widget buildItem(BuildContext _, String? imageURL) {
      final image;
      if (imageURL != null) {
        image = NetworkImage(imageURL);
      } else {
        image = AssetImage("img/mountain.jpeg");
      }
      return Container(
        margin: const EdgeInsets.only(top: 10),
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return BlocBuilder(builder: (context, dynamic state) {
      if (state is LoadedState) {
        final imageURLs = state.trips.map((e) => e.image).toList();
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) => buildItem(context, imageURLs[index]),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: imageURLs.length,
        );
      }
      return Container();
    });
  }

  Widget _buildExploreMore(AppLocalizations localizations) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AppLargeText(text: localizations.home_explore_more, size: 22),
              AppText(
                text: localizations.home_see_all,
                color: AppColors.textColor1,
                size: 16,
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          width: double.maxFinite,
          margin: const EdgeInsets.only(top: 20),
          child: _buildScrollableExploreItems(localizations),
        ),
      ],
    );
  }

  Widget _buildScrollableExploreItems(AppLocalizations localizations) {
    final items =
        _ExploreType.values.map((e) => e.toItem(localizations)).toList();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _ExploreType.values.length,
      separatorBuilder: (context, index) => SizedBox(width: 30),
      itemBuilder: (_, index) {
        return Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage("img/${items[index].image}"),
                ),
              ),
            ),
            SizedBox(height: 10),
            AppText(
              text: items[index].title,
              color: AppColors.textColor2,
              size: 14,
            )
          ],
        );
      },
    );
  }
}

enum _DiscoverType {
  places,
  inspiration,
  emotions,
}

extension _DiscoverTypeExtension on _DiscoverType {
  String toTitle(AppLocalizations localizations) {
    switch (this) {
      case _DiscoverType.places:
        return localizations.home_tab_1;
      case _DiscoverType.inspiration:
        return localizations.home_tab_2;
      case _DiscoverType.emotions:
        return localizations.home_tab_3;
    }
  }
}

enum _ExploreType {
  kayaking,
  snorkeling,
  ballooning,
  hiking,
}

extension _ExploreTypeExtension on _ExploreType {
  _ExploreItem toItem(AppLocalizations localizations) {
    switch (this) {
      case _ExploreType.kayaking:
        return _ExploreItem(
          title: localizations.home_explore_kayaking,
          image: "kayaking.png",
        );
      case _ExploreType.snorkeling:
        return _ExploreItem(
          title: localizations.home_explore_snorkeling,
          image: "snorkeling.png",
        );
      case _ExploreType.ballooning:
        return _ExploreItem(
          title: localizations.home_explore_ballooning,
          image: "ballooning.png",
        );
      case _ExploreType.hiking:
        return _ExploreItem(
          title: localizations.home_explore_hiking,
          image: "hiking.png",
        );
    }
  }
}

@immutable
class _ExploreItem {
  final String title;
  final String image;

  _ExploreItem({required this.title, required this.image});
}

class CircleIndicatorDecoration extends Decoration {
  final double radius;
  final Color color;

  const CircleIndicatorDecoration({
    required this.radius,
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CircleIndicatorPainter(
      radius: radius,
      color: color,
    );
  }
}

class _CircleIndicatorPainter extends BoxPainter {
  final double radius;
  final Color color;

  _CircleIndicatorPainter({
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final circleOffset = Offset((configuration.size?.width ?? 0) / 2,
        (configuration.size?.height ?? 0) - radius - 6);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
