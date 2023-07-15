
import 'package:smartmasjid_v1/app/modules/home/widgets/smallCard.dart';


import '../app/routes/export.dart';


class HadithCard extends StatelessWidget {
  const HadithCard({
    super.key, required this.title, required this.image, this.color, required this.onTap, this.subtit, this.tit, required this.shadow, this.onPressed,
  });
  final String title;
  final String? subtit;
  final String? tit;
  final String image;
  final Color? color;
  final Function() onTap;
  final Function()? onPressed;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SmallCard(
      color: color??themeData.primaryColor,
      height: 100.h,
      width: 150.w,
      onTap: ()=>onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            'assets/images/$image.png',
            fit: BoxFit.cover,
            height: 30.h,
          ),
          Space(2),
          Stxt(
            textAlign: TextAlign.center,
            text: '$title',
            size: f1,
            color: color!=null?themeData.primaryColor: Colors.white,
            weight: FontWeight.w500,
          ),
          Space(2),
          Stxt(
            textAlign: TextAlign.center,
            text: '$subtit',
            size: f2,
            color: Colors.black,
            weight: FontWeight.w500,
          ),
          Space(5),
          Stxt(
            textAlign: TextAlign.center,
            text: '$tit',
            size: f1,
            color: Colors.black,
            weight: FontWeight.w400,
          ),

        ],
      ),
    );
  }
}