import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerLoadingEffect extends StatelessWidget {
  const ShimmerLoadingEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        8,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12,
                  width: 150,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 6),
                ),
                Container(
                  height: 12,
                  width: 200,
                  color: Colors.white,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 180,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
