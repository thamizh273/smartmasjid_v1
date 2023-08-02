import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/bgcontainer_register.dart';
import '../../../authRepository.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/register_login_controller.dart';

class RegisterLoginView extends GetView<RegisterLoginController> {
  const RegisterLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGContainerRegister(
        image: Image.asset(
          'assets/images/register_login.png',
          height: .37.sh,
          width: 1.sw,
          fit: BoxFit.cover,
        ),
        child: SizedBox(
          height: .63.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.verticalSpace,
              Image.asset(
                "assets/images/masjidlogonew.png",
                scale: 4,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Smart Masjid",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              25.verticalSpace,
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.FACE_AUTH);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FaceAuth()));
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     transitionDuration: Duration(milliseconds: 400), // Set the duration of the transition animation
                    //     pageBuilder: (_, __, ___) => HomePage(), // Destination screen
                    //     transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                    //       return SlideTransition(
                    //         position: Tween<Offset>(
                    //           begin: Offset(1.0, 0.0), // Start position of the screen (slide from right)
                    //           end: Offset.zero, // End position of the screen (slide to center)
                    //         ).animate(animation),
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 45),
                    backgroundColor: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    foregroundColor: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4.0,
                  ),
                  child: Text(
                    "Register".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )),
              15.verticalSpace,
              OutlinedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
                    Get.toNamed(Routes.LOGIN_PAGE);
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     transitionDuration: Duration(milliseconds: 500), // Set the duration of the transition animation
                    //     pageBuilder: (_, __, ___) => HomePage(), // Destination screen
                    //     transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                    //       return SlideTransition(
                    //         position: Tween<Offset>(
                    //           begin: Offset(1.0, 0.0), // Start position of the screen (slide from right)
                    //           end: Offset.zero, // End position of the screen (slide to center)
                    //         ).animate(animation),
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(200, 45),
                    primary: Color(0xffD9D9D9),
                    side: BorderSide(color: Color(0xffD9D9D9)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Login".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )),
              15.verticalSpace,
              Text(
                "Or Continue with".tr,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xffD9D9D9)),
              ),
              15.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        // controller.signInWithGoogle();
                        controller.googleSignIns();
                        //AuthenticationRespository.instance.signInWithGoogle();
                      },
                      child: Obx(() {
                        return controller.isGoogleSign.value?CircularProgressIndicator(): Image.asset(
                          "assets/images/googlenew.png",
                          width: 27,
                        );
                      })),
                  25.horizontalSpace,
                  Image.asset(
                    "assets/images/apple.png",
                    width: 27,
                  )
                ],
              ),
              // SizedBox(
              //   height: 50,
              // ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FaceAuth()));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 20),
                          backgroundColor: Color(0xffD9D9D9),
                          foregroundColor: Color(0xff11323B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4.0,
                        ),
                        child: Text(
                          "Guest".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 10),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
