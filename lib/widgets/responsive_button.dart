import 'package:flutter/material.dart';
import 'package:flutter_hello_world/misc/colors.dart';
import 'package:flutter_hello_world/widgets/app_text.dart';

@immutable
class ResponsiveButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Function()? onTap;

  ResponsiveButton({Key? key, this.width = 120, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isResponsive = title != null;

    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: isResponsive ? double.maxFinite : width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.mainColor,
          ),
          child: Row(
            mainAxisAlignment: isResponsive
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: title != null
                ? [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child:
                          AppText(text: title!, color: Colors.white, size: 16),
                    ),
                    Image.asset("img/button-one.png"),
                  ]
                : [Image.asset("img/button-one.png")],
          ),
        ),
      ),
    );
  }
}
