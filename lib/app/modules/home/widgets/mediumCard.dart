
import 'package:smartmasjid_v1/app/modules/home/widgets/smallCard.dart';

import '../../../routes/export.dart';


class MediumCard extends StatelessWidget {
  const MediumCard({
    super.key, required this.title, required this.image, this.color,
  });
  final String title;
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SmallCard(
      color: color??themeData.primaryColor,
      height: 135.h, onTap: () {  },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            'assets/images/$image.png',
            fit: BoxFit.cover,
            height: 60.h,
          ),
          Stxt(
            textAlign: TextAlign.center,
            text: '$title',
            size: f3,
            color: color!=null?themeData.primaryColor: Colors.white,
            weight: FontWeight.w500,
          ),

        ],
      ),
    );
  }
}