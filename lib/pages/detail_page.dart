import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hello_world/misc/colors.dart';
import 'package:flutter_hello_world/widgets/app_large_text.dart';
import 'package:flutter_hello_world/widgets/app_text.dart';
import 'package:flutter_hello_world/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _gottenStars = 3;
  int _peopleCount = 1;
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: 350,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/mountain.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                  ),
                  _buildDots(),
                ],
              ),
            ),
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(
                          text: "Yosemite",
                          size: 28,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        AppLargeText(
                          text: "\$ 250",
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.mainColor),
                        SizedBox(width: 5),
                        AppText(
                          text: "USA, California",
                          color: AppColors.textColor1,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        _buildRatingBar(context),
                        SizedBox(width: 10),
                        AppText(
                          text: "(4.5)",
                          color: AppColors.textColor2,
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    AppLargeText(
                      text: localizations.detail_people,
                      size: 20,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    SizedBox(height: 5),
                    AppText(
                      text: localizations.detail_number_of_people,
                      color: AppColors.mainTextColor,
                    ),
                    SizedBox(height: 15),
                    _buildPepleCountSelection(context),
                    SizedBox(height: 30),
                    AppLargeText(
                      text: localizations.detail_description,
                      size: 20,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    SizedBox(height: 5),
                    SingleChildScrollView(
                      child: AppText(
                        text:
                            "Yosemite National Park is located in central Sierra Nevada, in the Mojave Desert of California. It is a great place to visit for hiking, camping, and other activities. The park is known for its giant redwood trees, and has many waterfalls and streams. The park is also known for its rock art, and has a lot of it.",
                        color: AppColors.mainTextColor,
                        textHeight: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  _buildFavoriteButton(context),
                  SizedBox(width: 20),
                  ResponsiveButton(
                    title: localizations.detail_book_trip_now,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    Widget _buildDot(int index) {
      return Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
    }

    return Wrap(
      direction: Axis.vertical,
      spacing: 6,
      children: List.generate(2, _buildDot),
    );
  }

  Widget _buildRatingBar(BuildContext context) {
    final starCount = 5;

    Widget buildStar(int index) {
      return Icon(
        Icons.star,
        color:
            index < _gottenStars ? AppColors.starColor : AppColors.textColor2,
      );
    }

    return Wrap(children: List.generate(starCount, buildStar));
  }

  Widget _buildPepleCountSelection(BuildContext context) {
    final peopleCount = 5;

    Widget buildOption(int index) {
      final isSelected = index + 1 == _peopleCount;

      return InkWell(
        onTap: () => setState(() => _peopleCount = index + 1),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : AppColors.buttonBackground,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Center(
            child: AppLargeText(
              text: "${index + 1}",
              size: 20,
              color: isSelected ? Colors.white : Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 6,
      children: List.generate(peopleCount, buildOption),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _isFavourite = !_isFavourite),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: AppColors.textColor2,
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            _isFavourite ? Icons.favorite : Icons.favorite_border,
            color: _isFavourite ? Colors.black : AppColors.textColor2,
          ),
        ),
      ),
    );
  }
}
