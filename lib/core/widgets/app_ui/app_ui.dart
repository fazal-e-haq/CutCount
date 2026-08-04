import 'package:flutter/material.dart';

import '../appbar/reusable_appbar.dart';

class AppUi extends StatelessWidget {
  const AppUi({
    super.key,
    this.body,
    this.slivers,
    this.appBarTitle,
    this.appBarActions,
    this.bodyPadding = const EdgeInsets.all(16),
    this.floatingActionButton,
    this.fabLocation,
    this.resizeToAvoidBottomInset = true,
  }) : assert(body != null || slivers != null, 'Provide either body or slivers');

  final Widget? body;
  final List<Widget>? slivers;
  final Widget? appBarTitle;
  final List<Widget>? appBarActions;
  final EdgeInsetsGeometry bodyPadding;

  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? fabLocation;

  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    // This wrapper keeps spacing, scrolling, and the app bar consistent across all feature pages.
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: ReusableAppbar(title: appBarTitle, actions: appBarActions),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const _SmoothScrollBehavior(),
          child: slivers != null
              ? CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    SliverPadding(
                      padding: bodyPadding,
                      sliver: SliverMainAxisGroup(slivers: slivers!),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: bodyPadding,
                  child: body,
                ),
        ),
      ),

      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: fabLocation,
    );
  }
}

class _SmoothScrollBehavior extends MaterialScrollBehavior {
  const _SmoothScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Smooth physics makes long pages feel more polished and predictable.
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
