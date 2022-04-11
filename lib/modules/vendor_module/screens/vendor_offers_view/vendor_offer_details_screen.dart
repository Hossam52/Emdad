import 'package:emdad/shared/styles/app_colors.dart';
import 'package:emdad/shared/styles/font_styles.dart';
import 'package:emdad/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorOfferDetailsScreen extends StatelessWidget {
  const VendorOfferDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: custom(),
    );
  }

  custom() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: const Text(
              "Collapsing AppBar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            background: Image.network(
              "https://images.pexels.com/photos/1020315/pexels-photo-1020315.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) =>
                ListTile(
                  title: Text("List Item $index"),
                ),
          ),
        ),
      ],
    );
  }

  nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                "Collapsing AppBar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Container(
                height: 150.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  image: DecorationImage(
                    image: NetworkImage('https://lh3.googleusercontent.com/ogw/ADea4I6HQuFjHCQbpvTa5BuPCgZsz2hSb47f4ZODeR43yQ=s83-c-mo'),
                  ),
                ),
                // child: Image.network(
                //   "",
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          )
        ];
      },
      body: const Center(
        child: Text("The Parrot"),
      ),
    );
  }

}


