




import '../app/routes/export.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({
    super.key,
    this.image,
    this.title,
    this.height,
    this.child,
    this.color,
    this.width, required this.onTap, this.subtit, this.tit, this.border,
  });

  final String? image;
  final double? height;
  final double? width;
  final String? title;
  final String? subtit;
  final String? tit;
  final Widget? child;
  final BoxBorder? border;
  final Color? color;
  final Function() onTap;


  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: ()=>onTap(),
      child: SizedBox(
        height: height ?? 120.h,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? themeData.primaryColor,
            border: Border.all(
              color: Color(0xff16627C)
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.shade400,
                  offset: Offset(0, 4)
              )
            ],
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
                        height: 80.h,
                        width: 100.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 10.w),
                        child: VerticalDivider(
                          color: color != null
                              ? themeData.primaryColor.withOpacity(.2)
                              : themeData.scaffoldBackgroundColor.withOpacity(.4),
                          thickness: 1.5,
                          width: 8.w,
                          endIndent: 5.h,
                          indent: 5.h,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stxt(
                            textAlign: TextAlign.center,
                            text: '$title',
                            size: f4,
                            color:
                            color != null ? themeData.primaryColor : Colors.white,
                            weight: FontWeight.w500,
                          ),
                          Space(16),
                          Stxt(
                            textAlign: TextAlign.center,
                            text: '$subtit',
                            size: f3,
                            color:
                            color != null ? themeData.primaryColor : Colors.white,
                            weight: FontWeight.w500,
                          ),
                          Space(8),
                          Stxt(
                            textAlign: TextAlign.center,
                            text: '$tit',
                            size: f1,
                            color:
                            color != null ? themeData.primaryColor : Colors.white,
                            weight: FontWeight.w500,
                          ),
                        ],
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
