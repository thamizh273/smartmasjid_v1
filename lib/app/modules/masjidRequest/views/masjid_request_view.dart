import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../widgets/bgcontainer_auth.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/masjid_request_controller.dart';

class MasjidRequestView extends GetView<MasjidRequestController> {
   MasjidRequestView({Key? key}) : super(key: key);
  final homectrl=Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGContainerAuth(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 270,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("assets/svg/requestprof.svg"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/svg/arrowload.svg"),
                              SizedBox(height: 5,),
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset("assets/images/time.png")),
                              SvgPicture.asset("assets/svg/arrowrev.svg"),
                            ],
                          ),
                        ),
                        Container(
                            height: 70,
                            width: 80,
                            child: Image.asset("assets/images/masjidreq.png")),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Your joining request has been sent to Your masjid. you can wait for Masjid approval or"),
                    Text("Continue as guest"),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: () async {
                              Get.offNamed(Routes.REGISTER_LOGIN);
                              await homectrl.box1.remove('fruits');
                              await homectrl.box1.remove('masjidId');
                              await GoogleSignIn().signOut();
                              await FirebaseAuth.instance.signOut();

                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(100, 30),
                              primary: Theme.of(context).colorScheme.primary,
                              side: BorderSide(color: Theme.of(context).colorScheme.primary ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Wait", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),)),
                        SizedBox(width: 30,),
                        ElevatedButton(
                            onPressed: (){
                              Get.offAllNamed(Routes.GUESTMODE,arguments: [true]);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 30),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4.0,
                            ),
                            child: Text("Continue as Guest", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
