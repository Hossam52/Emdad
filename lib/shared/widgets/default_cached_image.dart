import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultCachedNetworkImage extends StatelessWidget {
  DefaultCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String imageUrl;
  double? width;
  double? height;
  BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200]!.withOpacity(0.4),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) {
          return Image.asset(
            'assets/images/image_not_avilable.png',
            width: double.infinity,
            height: double.infinity,
          );
          return const Center(child: Icon(Icons.error));
        },
        placeholder: (context, url) => Shimmer.fromColors(
          highlightColor: (Colors.grey[200])!,
          baseColor: (Colors.grey[300])!,
          child: Container(
            width: double.infinity,
            height: height,
            color: Colors.grey[300],
          ),
        ),
        width: width,
        height: height,
      ),
    );
  }
}
