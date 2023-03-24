import 'package:flutter/material.dart';
import 'package:suggest_a_feature/src/presentation/pages/theme/suggestions_theme.dart';
import 'package:suggest_a_feature/src/presentation/pages/widgets/suggestions_back_button.dart';
import 'package:suggest_a_feature/src/presentation/utils/dimensions.dart';

class SuggestionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  final VoidCallback? onBackClick;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(Dimensions.size2x);

  const SuggestionsAppBar({
    required this.screenTitle,
    this.onBackClick,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.primaryBackgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: onBackClick != null
          ? Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginDefault,
                right: Dimensions.marginSmall,
              ),
              child: SuggestionsBackButton(
                onClick: onBackClick!,
                pressedColor: theme.actionPressedColor,
                color: theme.primaryTextColor,
              ),
            )
          : null,
      title: Text(
        screenTitle,
        style: theme.textMediumBold,
      ),
      actions: trailing != null ? <Widget>[trailing!] : null,
      key: key,
    );
  }
}