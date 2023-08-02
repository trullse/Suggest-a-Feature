import 'package:flutter/material.dart';
import 'package:suggest_a_feature/src/presentation/pages/theme/theme_extension.dart';
import 'package:suggest_a_feature/src/presentation/utils/context_utils.dart';
import 'package:suggest_a_feature/src/presentation/utils/dimensions.dart';
import 'package:suggest_a_feature/src/presentation/utils/platform_check.dart';

class BottomSheetActions extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback onDone;
  final bool isDoneActive;
  final bool hasLeftButton;

  const BottomSheetActions({
    required this.onDone,
    this.onCancel,
    this.isDoneActive = true,
    this.hasLeftButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.marginBig,
        right: Dimensions.marginBig,
        top: Dimensions.marginSmall,
        bottom: SuggestionsPlatform.isIOS
            ? Dimensions.marginBig
            : Dimensions.marginSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (hasLeftButton)
            _NewSuggestionTextButton(
              title: context.localization.cancel,
              onClick: onCancel ?? () {},
              isTonal: false,
            ),
          const SizedBox(width: Dimensions.marginMicro),
          _NewSuggestionTextButton(
            title: context.localization.done,
            onClick: onDone,
            enabled: isDoneActive,
          ),
        ],
      ),
    );
  }
}

class _NewSuggestionTextButton extends StatefulWidget {
  final String title;
  final bool enabled;
  final bool isTonal;
  final VoidCallback onClick;

  const _NewSuggestionTextButton({
    required this.title,
    required this.onClick,
    this.enabled = true,
    this.isTonal = true,
  });

  @override
  State<_NewSuggestionTextButton> createState() =>
      _NewSuggestionTextButtonState();
}

class _NewSuggestionTextButtonState extends State<_NewSuggestionTextButton> {
  var _pressed = false;

  void _onTap(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    var color = widget.enabled
        ? widget.isTonal
            ? context.theme.colorScheme.secondaryContainer
            : Colors.transparent
        : context.theme.disabledColor;
    var textColor = widget.enabled
        ? context.theme.colorScheme.primary
        : theme.disabledTextColor;
    if (_pressed) {
      color = widget.isTonal
          ? context.theme.colorScheme.secondary
          : context.theme.colorScheme.secondaryContainer;
      textColor = context.theme.colorScheme.primaryContainer;
    }
    return GestureDetector(
      onTap: () {
        if (widget.enabled) {
          widget.onClick();
        }
      },
      onTapDown: (_) => _onTap(widget.enabled || _pressed),
      onTapUp: (_) => _onTap(!widget.enabled && _pressed),
      onTapCancel: () => _onTap(!widget.enabled && _pressed),
      child: Container(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        height: Dimensions.largeSize,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginBig),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Dimensions.smallCircularRadius),
        ),
        child: Text(
          widget.title,
          style: context.theme.textTheme.labelLarge?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
