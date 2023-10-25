import 'package:firebase_auth/firebase_auth.dart';
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
        child: Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.verticalSpace,
              Image.asset(
                "assets/images/slogonw.png",
                scale: 2,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Ummati",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              25.verticalSpace,
              ElevatedButton(
                  onPressed: () {
                    AuthenticationRespository.instance.gsignBool.value=false;
                    Get.toNamed(Routes.FACE_AUTH);
                    FirebaseAuth.instance.signOut();
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
                    "register".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )),
              15.verticalSpace,
              OutlinedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN_PAGE);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xffD9D9D9), minimumSize: Size(200, 45),
                    side: BorderSide(color: Color(0xffD9D9D9)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "login".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )),
              15.verticalSpace,
              Text(
                "or_continue_with".tr,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xffD9D9D9)),
              ),
              15.verticalSpace,

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        AuthenticationRespository.instance.gsignBool.value=true;
                        // controller.signInWithGoogle();
                        controller.googleSignIns();
                        //AuthenticationRespository.instance.signInWithGoogle();
                      },
                      child:  Image.asset(
                          "assets/images/googlenew.png",
                          width: 27,
                          color:Colors.white,
                        ),
                  ),
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
                          //Get.offAllNamed(Routes.HOME);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => FaceAuth()));
                          Get.offAllNamed(Routes.GUESTMODE,arguments: [true]);
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
                          "guest".tr,
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
