import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefreshWidget extends StatelessWidget {
  CustomRefreshWidget({Key? key, required this.onRefresh, required this.child})
      : super(key: key);
  final Future<void> Function() onRefresh;
  final _refreshController = RefreshController();
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        onRefresh: () async {
          await onRefresh();
          _refreshController.refreshCompleted();
        },
        header: const WaterDropHeader(),
        controller: _refreshController,
        child: child);
  }
}
