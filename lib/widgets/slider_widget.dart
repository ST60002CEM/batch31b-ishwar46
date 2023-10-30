import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/appcolor.dart';

class RemitancePage extends StatelessWidget {
  const RemitancePage({super.key});

  @override
  Widget build(BuildContext context) {
    //AppLocalizations localization = AppLocalizations.of(context)!;

//Static Images for Slider
    List<String> sliderImages = [
      'assets/img/logo.png',
      'assets/img/logo.png',
    ];
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlayCurve: Curves.easeInOut,
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.85,
              aspectRatio: 16 / 9,
            ),
            items: sliderImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.accent.withOpacity(0.2),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FutureBuilder(
                        future: precacheImage(AssetImage(imagePath), context),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Error loading image');
                          } else {
                            return Image.asset(
                              imagePath,
                              fit: BoxFit.fill,
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          const HeadingWidget(
              heading:
                  "It provides remit services through its branch offices. The list of remit services is given below."),
          const SizedBox(
            height: 10,
          ),
          const RemitServiceWidget(
              title: "International Remit",
              subtitle: "Incoming Only",
              image: "assets/img/international_remit.png"),
          const SizedBox(
            height: 10,
          ),
          const RemitServiceWidget(
            title: "Domestic Remit",
            subtitle: "Incoming & Outgoing",
            image: "assets/img/domestic_money.png",
          ),
          const DescriptionWidget(
              description:
                  "Forward Laghubittya Bittya Santha Ltd. has been providing easy and secure remittance services to its valued clients."),
        ],
      ),
    );
  }
}

//Heading Widget
class HeadingWidget extends StatelessWidget {
  final String heading;
  const HeadingWidget({required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        heading,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColor.secondaryColor,
        ),
      ),
    );
  }
}

//List Tile Widget
class RemitServiceWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isLoading;
  const RemitServiceWidget({
    required this.title,
    required this.subtitle,
    required this.image,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show Shimmer when loading content
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            tileColor: AppColor.accent.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            leading: Container(
              width: 56,
              height: 56,
              color: Colors.white,
            ),
            title: Container(
              height: 16,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 16,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    // Show the actual content when not loading content
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        tileColor: AppColor.accent.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        leading: Image.asset(image),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}

//Description Widget
class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: AppColor.secondaryColor,
          ),
        ),
      ),
    );
  }
}
