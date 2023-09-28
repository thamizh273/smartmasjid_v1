

import '../../../routes/export.dart';


class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    this.image,
    this.title,
    this.height,
    this.child,
    this.color,
    this.width, required this.onTap, this.maxLines, this.rightpad,
  });

  final String? image;
  final int? maxLines;
  final double? height;
  final double? rightpad;
  final double? width;
  final String? title;
  final Widget? child;
  final Color? color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: ()=>onTap(),
      child: SizedBox(
        height: height ?? 67.h,
        width: width ?? .5.sw,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                color: Get.theme.highlightColor,
                offset: Offset(0,2)
              )
            ],
              borderRadius: BorderRadius.circular(8),
             color: color ?? themeData.primaryColor,
              // boxShadow: [
              //   BoxShadow(color:innerShadows ??Colors.black.withOpacity(.25)),
              //   BoxShadow(
              //     color: color ?? themeData.primaryColor,
              //     spreadRadius: -2.0,
              //     blurRadius: 4.0,
              //     offset: Offset(-2, -2)
              //   ),
              //
              //
              // ]
       ),
          // gradient:LinearGradient(colors: [themeData.primaryColor,Color(0xff426470)])

          child: child ??
              IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/$image.png',
                        //fit: BoxFit.cover,
                        height: 50.h,
                        width: 50.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right:rightpad?? 10.w),
                        child: VerticalDivider(
                          color: color != null
                              ? Get.theme.primaryColor.withOpacity(0.4)
                              : Get.theme.appBarTheme.backgroundColor!.withOpacity(0.7),
                          thickness: 1.5,
                          width: 8.w,
                          endIndent: 5.h,
                          indent: 5.h,
                        ),
                      ),
                      SizedBox(
                         width: 87.w,
                        child: Stxt(
                          maxLines: maxLines,
                          textAlign: TextAlign.center,
                          text: '$title',
                          size: f3,
                          color:
                              color != null ? themeData.primaryColor : Colors.white,
                          weight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
