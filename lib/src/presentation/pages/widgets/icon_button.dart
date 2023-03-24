import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suggest_a_feature/src/presentation/pages/theme/suggestions_theme.dart';
import 'package:suggest_a_feature/src/presentation/utils/assets_strings.dart';
import 'package:suggest_a_feature/src/presentation/utils/dimensions.dart';

class SuggestionsIconButton extends StatefulWidget {
  final String imageIcon;
  final VoidCallback onClick;
  final Color? color;
  final double size;
  final EdgeInsets padding;

  const SuggestionsIconButton({
    required this.imageIcon,
    required this.onClick,
    this.color,
    this.size = Dimensions.defaultSize,
    this.padding = const EdgeInsets.all(Dimensions.marginMicro),
    super.key,
  });

  @override
  State<SuggestionsIconButton> createState() => _SuggestionsIconButtonState();
}

class _SuggestionsIconButtonState extends State<SuggestionsIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => widget.onClick(),
      onTapDown: (_) {
        setState(() => _pressed = true);
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
      child: Padding(
        padding: widget.padding,
        child: SvgPicture.asset(
          widget.imageIcon,
          package: AssetStrings.packageName,
          width: widget.size,
          height: widget.size,
          colorFilter: ColorFilter.mode(
            _pressed
                ? theme.actionPressedColor
                : widget.color ?? theme.primaryIconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}