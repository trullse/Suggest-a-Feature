import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suggest_a_feature/src/presentation/pages/theme/suggestions_theme.dart';
import 'package:suggest_a_feature/src/presentation/pages/widgets/dotted_border.dart';
import 'package:suggest_a_feature/src/presentation/utils/assets_strings.dart';
import 'package:suggest_a_feature/src/presentation/utils/context_utils.dart';
import 'package:suggest_a_feature/src/presentation/utils/dimensions.dart';

class AddPhotoButton extends StatelessWidget {
  final double width;
  final double height;
  final TextStyle style;
  final bool isLoading;

  const AddPhotoButton({
    required this.width,
    required this.height,
    required this.style,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.marginDefault),
      child: DottedBorder(
        dashPattern: const <double>[10, 4],
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        color: theme.actionColor,
        radius: const Radius.circular(Dimensions.smallCircularRadius),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  strokeWidth: 1,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(theme.primaryIconColor),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      AssetStrings.addPhotoButton,
                      package: AssetStrings.packageName,
                      height: Dimensions.defaultSize,
                      colorFilter: ColorFilter.mode(
                        theme.primaryTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: Dimensions.marginSmall),
                      child: Text(
                        context.localization.add,
                        style: style.copyWith(color: theme.primaryTextColor),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}