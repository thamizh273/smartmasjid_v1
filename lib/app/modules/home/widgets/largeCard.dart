
import '../../../routes/export.dart';



class LargerCard extends StatelessWidget {
  const LargerCard({
    super.key,
    required this.quranImg, required this.buttonTxt, required this.image, required this.title, required this.subtitle, required this.lastseen, this.onTap,
  });

  final List quranImg;
  final String buttonTxt;
  final String image;
  final String title;
  final String subtitle;
  final String lastseen;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
   final  themeData =Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: themeData.primaryColor,
      elevation: 4,
      child: Column(
        children: [
          SizedBox(
            height: 110.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {

                return Card(
                    margin: EdgeInsets.only(
                       left: index == 0 ? 10 : 0,
                        right: 5,
                        top: 15,
                        bottom: 10),
                    color: Colors.grey.shade400,
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/${quranImg[index]}.png'),
                            fit: BoxFit.fill),
                      ),
                      child:  const Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stxt(
                              text:
                              '''"Don\'t lose hope \n not be sad - Quran 3:139"''',
                              size: 10,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'assets/images/$image.png',
                    fit: BoxFit.fill,
                    height: 50.h,
                    width: 50.w,
                  ),
                ),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stxt(
                      text: title,
                      size: f4,
                      color: Colors.white,
                    ),
                    Stxt(
                      text: subtitle,
                      size: f0,
                      color: Colors.white,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    SButton(
                        rad: 5,
                        height: 20,
                        width: 90,
                        pad: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stxt(
                              text: buttonTxt,
                              size: f2,
                              color: themeData.primaryColor,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              'assets/svg/arrow.svg',
                              width: 10.w,
                            )
                          ],
                        ), ontap: () {  }),
                    SizedBox(
                      height: 5,
                    ),
                    Stxt(
                      text: lastseen,
                      size: f0.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}