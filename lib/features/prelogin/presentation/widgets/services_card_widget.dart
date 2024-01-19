import 'package:age_care/features/prelogin/presentation/widgets/card_widget.dart';
import 'package:flutter/widgets.dart';

import '../../../../config/constants/image_strings.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 110,
              //padding: const EdgeInsets.all(5),
              child: const CardWidgetPre(
                title: "Service 1",
                routeName: "/hospital",
                imagePath: AppImages.cardImage1,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 110,
              //padding: const EdgeInsets.all(10),
              child: const CardWidgetPre(
                title: "Service 2",
                routeName: "/appointment",
                imagePath: AppImages.cardImage2,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 110,
              //padding: const EdgeInsets.all(10),
              child: const CardWidgetPre(
                title: "Service 3",
                routeName: "/appointment",
                imagePath: AppImages.cardImage3,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 110,
              //padding: const EdgeInsets.all(10),
              child: const CardWidgetPre(
                title: "Service 4",
                routeName: "/appointment",
                imagePath: AppImages.cardImage4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
