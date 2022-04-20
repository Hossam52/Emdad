import 'package:flutter/material.dart';

class LoadMoreData extends StatelessWidget {
  const LoadMoreData(
      {Key? key,
      required this.onLoadingMore,
      this.isLoading = false,
      this.visible = true})
      : super(key: key);
  final VoidCallback onLoadingMore;
  final bool isLoading;
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextButton(
        onPressed: onLoadingMore,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Text('Show more'),
      ),
    );
  }
}
