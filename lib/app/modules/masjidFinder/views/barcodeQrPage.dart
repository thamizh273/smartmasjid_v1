import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smartmasjid_v1/app/modules/masjidFinder/controllers/masjid_finder_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
final ctrl =Get.put(MasjidFinderController());
class barcodeQrScanner extends StatefulWidget {
   barcodeQrScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<barcodeQrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
              right: 10,
              top: .1.sh,
              child: Column(
                children: [
                  IconButton(
                      style:
                          ButtonStyle(iconSize: MaterialStatePropertyAll(30)),
                      color: Colors.white,
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      icon: FutureBuilder(
                        future: controller?.getFlashStatus(),
                        builder: (context, snapshot) {
                          print("ddddddd ${snapshot.data}");
                          return snapshot.data == true
                              ? Icon(Icons.flash_on)
                              : Icon(Icons.flash_off);
                          Text('Flash: ${snapshot.data}');
                        },
                      )),
                  IconButton(
                    style: ButtonStyle(iconSize: MaterialStatePropertyAll(30)),
                    color: Colors.white,
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                    icon: Icon(Icons.flip_camera_android),
                  ),
                ],
              )),
          Positioned(
              top: .3.sh,
              child: Column(
                children: [
                  // if (result != null) ...[
                  //   // if (logic.uid.value == "") ...{
                  //   logic.signUpComplete(result!.code)
                  //   // } else ...{
                  //   //  logic.loginGmail(result!.code)},
                  //
                  //   // Text(
                  //   //     'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!
                  //   //         .code}')
                  // ] else
                  //   const Text('Scan a code'),
                  Stxt(
                    text: "Scan Masjid your QR",
                    size: f3,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              )),

          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         if (result != null)
          //           Text(
          //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
          //         else
          //           const Text('Scan a code'),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Container(
          //               margin: const EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                   onPressed: () async {
          //                     await controller?.toggleFlash();
          //                     setState(() {});
          //                   },
          //                   child: FutureBuilder(
          //                     future: controller?.getFlashStatus(),
          //                     builder: (context, snapshot) {
          //                       return Text('Flash: ${snapshot.data}');
          //                     },
          //                   )),
          //             ),
          //             Container(
          //               margin: const EdgeInsets.all(8),
          //               child: ElevatedButton(
          //                   onPressed: () async {
          //                     await controller?.flipCamera();
          //                     setState(() {});
          //                   },
          //                   child: FutureBuilder(
          //                     future: controller?.getCameraInfo(),
          //                     builder: (context, snapshot) {
          //                       if (snapshot.data != null) {
          //                         return Text(
          //                             'Camera facing ${describeEnum(snapshot.data!)}');
          //                       } else {
          //                         return const Text('loading');
          //                       }
          //                     },
          //                   )),
          //             )
          //           ],
          //         ),
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   crossAxisAlignment: CrossAxisAlignment.center,
          //         //   children: <Widget>[
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //         onPressed: () async {
          //         //           await controller?.pauseCamera();
          //         //         },
          //         //         child: const Text('pause',
          //         //             style: TextStyle(fontSize: 20)),
          //         //       ),
          //         //     ),
          //         //     Container(
          //         //       margin: const EdgeInsets.all(8),
          //         //       child: ElevatedButton(
          //         //         onPressed: () async {
          //         //           await controller?.resumeCamera();
          //         //         },
          //         //         child: const Text('resume',
          //         //             style: TextStyle(fontSize: 20)),
          //         //       ),
          //         //     )
          //         //   ],
          //         // ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async{
        result = scanData;
        if(result !=null) {
         await ctrl.masjidFinder_get("", result!.code);
        

          Get.dialog(
              barrierColor:Get.theme.primaryColor.withOpacity(.8),
            

              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: AlertDialog(
                    elevation: 10,
                    backgroundColor: Get.theme.colorScheme
                        .primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10)),
                    // title: Center(
                    //     child: Stxt(
                    //   text: "Are you Sure?",
                    //   size: f3,
                    //   weight: FontWeight.bold,
                    //   color: Colors.white,
                    //   textAlign: TextAlign.center,
                    // )),

                    // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      children: [
                        Stxt(
                          text:
                          "Are you Sure you want to join",
                          size: f3,
                          // weight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8,),
                        Stxt(text: "${ctrl.masjidListdata.value.getMasjidFilter![0].masjidName} ?",
                          size: f3,
                          weight: FontWeight.bold,
                          color: Colors.white,)
                      ],
                    ),
                    actionsPadding: EdgeInsets.only(bottom: 20),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          SButton(
                              width: 90.w,
                              height: 25.h,
                              color: Get.theme.colorScheme
                                  .secondary,
                              ontap: () {
                                Get.toNamed(Routes.MASJID_FINDER);
                              },
                              text: "Cancel",
                              txtsize: f1,
                              txtClr:
                              Get.theme.colorScheme.primary),
                          SButton(
                              height: 25.h,
                              width: 90.w,
                              ontap: () async {
                                if(ctrl.uid.value==""){
                                  await    ctrl.signUpComplete(result!.code);;
                                }else{
                                  await ctrl.loginGmail(result!.code);}

                                // else{
                                //   await c.signUpComplete(id);
                                // }


                                ctrl.update();
                              },
                              text: "Confirm",
                              txtsize: f1,
                              txtClr:
                              Get.theme.colorScheme.primary),
                        ],
                      )
                    ],
                    //iconPadding: EdgeInsets.all(20),
                  )));
        }
      });



    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
