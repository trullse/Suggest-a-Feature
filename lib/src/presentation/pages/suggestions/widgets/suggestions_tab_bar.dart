import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:suggest_a_feature/src/presentation/pages/suggestions/suggestions_state.dart';
import 'package:suggest_a_feature/src/presentation/utils/assets_strings.dart';
import 'package:suggest_a_feature/src/presentation/utils/context_utils.dart';
import 'package:suggest_a_feature/src/presentation/utils/dimensions.dart';
import 'package:suggest_a_feature/suggest_a_feature.dart';

class SuggestionsTabBar extends StatelessWidget {
  final TabController tabController;
  final SuggestionsState state;

  const SuggestionsTabBar({
    required this.tabController,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const tabHeight = 60.0;
    return TabBar(
      indicator: BoxDecoration(
        color: theme.primaryBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.smallCircularRadius),
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      controller: tabController,
      tabs: <Tab>[
        Tab(
          height: tabHeight,
          child: _TabButton(
            status: SuggestionStatus.requests,
            activeImage: AssetStrings.suggestionsRequests,
            inactiveImage: AssetStrings.suggestionsRequestsInactive,
            color: theme.requestsTabColor,
            text: context.localization.requests,
            state: state,
          ),
        ),
        Tab(
          height: tabHeight,
          child: _TabButton(
            status: SuggestionStatus.inProgress,
            activeImage: AssetStrings.suggestionsInProgress,
            inactiveImage: AssetStrings.suggestionsInProgressInactive,
            color: theme.inProgressTabColor,
            text: context.localization.inProgress,
            state: state,
          ),
        ),
        Tab(
          height: tabHeight,
          child: _TabButton(
            status: SuggestionStatus.completed,
            activeImage: AssetStrings.suggestionsCompleted,
            inactiveImage: AssetStrings.suggestionsCompletedInactive,
            color: theme.completedTabColor,
            text: context.localization.completed,
            state: state,
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final SuggestionStatus status;
  final String activeImage;
  final String inactiveImage;
  final Color color;
  final String text;
  final SuggestionsState state;

  /// We need different heights because of svg files differences
  /// (inactive icons have smaller margins);
  static const double activeIconHeight = 38;
  static const double inactiveIconHeight = 22;
  static const double textHeight = 1.17;

  const _TabButton({
    required this.status,
    required this.activeImage,
    required this.color,
    required this.state,
    required this.text,
    required this.inactiveImage,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = state.activeTab == status;
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: inactiveIconHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: isActive
                        ? color.withOpacity(0.3)
                        : theme.secondaryBackgroundColor,
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: activeIconHeight,
              child: SvgPicture.asset(
                isActive ? activeImage : inactiveImage,
                package: AssetStrings.packageName,
                colorFilter: ColorFilter.mode(
                  isActive ? color : theme.secondaryIconColor,
                  BlendMode.srcIn,
                ),
                height: isActive ? activeIconHeight : inactiveIconHeight,
              ),
            ),
          ],
        ),
        FittedBox(
          child: Text(
            text,
            style: isActive
                ? theme.textSmallPlusBold.copyWith(
                    color: color,
                    height: textHeight,
                  )
                : theme.textSmallPlusSecondary.copyWith(height: textHeight),
          ),
        ),
      ],
    );
  }
}