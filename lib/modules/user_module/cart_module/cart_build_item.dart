import 'package:flutter/material.dart';
import 'package:emdad/shared/widgets/default_cached_image.dart';

class CartBuildItem extends StatelessWidget {
  const CartBuildItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline),
          ),
          const SizedBox(width: 3),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.29,
            child: DefaultCachedNetworkImage(
              imageUrl: 'https://unsplash.com/photos/EPwuZxdketc/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8Nnx8dmVnZXRhYmxlc3x8MHx8fHwxNjM4NzA2MDM3&force=true&w=640',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
                    'طماطم',
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 7),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: (Colors.grey[300])!,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '4 طن',
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
