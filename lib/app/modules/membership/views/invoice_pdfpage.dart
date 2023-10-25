import 'dart:io';
import 'dart:typed_data';


import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';


import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/membership/controllers/membership_controller.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../routes/export.dart';
import '../../../routes/export.dart';
import '../../../routes/export.dart';


@immutable
class PdfPreviewPage extends StatelessWidget {
  final String? text;
  final invoicecntrl = Get.put(MembershipController());

  PdfPreviewPage(this.text, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(tittle: "Payment Receipt",),
        body: Obx(() {
          return invoicecntrl.invoiceloading.value? DialogHelper.showLoading(): PdfPreview(
            build: (context) => makePdf(),
          );
        })
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load(
        'assets/images/masjidinvoicelogo.png');
    final ByteData bytess = await rootBundle.load(
        'assets/images/bordernew.png');
    final ByteData bytesss = await rootBundle.load(
        'assets/images/rupeesblack.png');
    final ByteData bismillah = await rootBundle.load(
        'assets/images/bismillahnew.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final Uint8List byteLists = bytess.buffer.asUint8List();
    final Uint8List byteListss = bytesss.buffer.asUint8List();
    final Uint8List byteListsss = bismillah.buffer.asUint8List();
    var invoice = invoicecntrl.getpaymentinvoice.value.viewPaymentReceipt;
    final customFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Qalam.ttf"));


    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a5,
            orientation: pw.PageOrientation.landscape,
            build: (context) {
              return pw.Stack(
                  children: [
                    pw.Center(
                      child: pw.Image(
                        pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight,
                        height: 200,
                        width: 200,),
                    ),
                    pw.Center(
                      child: pw.Image(
                        pw.MemoryImage(byteLists), fit: pw.BoxFit.fitHeight,
                        height: 400,
                        width: 570,),
                    ),

                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.SizedBox(height: 1 * PdfPageFormat.cm),
                        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              // pw.Text("بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ",
                              //     style: pw.TextStyle(
                              //         fontWeight: pw.FontWeight.normal,
                              //         font: customFont,
                              //         fontSize: 10)),
                              pw.Image(
                                pw.MemoryImage(byteListsss), fit: pw.BoxFit.fitHeight,
                                height: 40,
                                width: 400, ),
                            ]
                        ),
                        // pw.SizedBox(
                        //     height: 2
                        // ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text("${invoice!.masjidId!.masjidName}",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 19))
                            ]
                        ),
                        pw.SizedBox(
                            height: 4
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                  "No.${invoice.masjidId!.address}, ${invoice
                                      .masjidId!.area}, ${invoice.masjidId!
                                      .district}, ${invoice.masjidId!
                                      .state},-${invoice.masjidId!.pinCode}",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                      fontSize: 8))
                            ]
                        ),
                        pw.SizedBox(
                            height: 12
                        ),
                        pw.Container(
                            height: 20,
                            width: 80,
                            decoration:
                            pw.BoxDecoration(
                            //     borderRadius: pw.BorderRadius.circular(4),
                                border: pw.Border.all(
                                    color: PdfColors.black, width: 1),
                              borderRadius: pw.BorderRadius.circular(4),

                            ),
                            child: pw.Center(
                              child: pw.Text("Receipt", style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.bold,)),
                            )
                        ),
                        pw.SizedBox(
                            height: 12
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 30
                              ),
                              pw.Text("Receipt No ", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 12)),
                              pw.Text(
                                  "${invoice.receiptNo}", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 12)),
                              pw.Spacer(),
                              pw.Text("Date: ", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 12)),
                              pw.Text(
                                  "${invoice.paymentDate}", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 12)),
                              pw.SizedBox(
                                  width: 30
                              ),
                            ]
                        ),
                        pw.SizedBox(
                            height: 12
                        ),

                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 28
                              ),
                              pw.Text(
                                "Received From Janab",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(
                                  width: 20
                              ),
                              pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      "${invoice.userId!.firstName}",
                                      // "Mohamed Bharagath Basha Abdulla",
                                      style: pw.TextStyle(
                                        fontSize: 16, fontWeight: pw.FontWeight
                                          .bold,),
                                    ),
                                    pw.Text(
                                        "·········································································································")
                                  ]
                              )
                            ]
                        ),
                        pw.SizedBox(
                            height: 8
                        ),
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Text(
                                  "MemberShip ID  ",
                                  style: pw.TextStyle(fontSize: 14,)),
                              pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Text(
                                        "${invoice.userId!.userUniqueId}",
                                        style: pw.TextStyle(
                                            fontSize: 14, fontWeight: pw
                                            .FontWeight.bold)),
                                    pw.Text(
                                      "·····················································",)
                                  ]
                              ),
                              pw.SizedBox(
                                  width: 10
                              ),
                              pw.Text(
                                  "Payment for",
                                  style: pw.TextStyle(fontSize: 14,)),
                              pw.SizedBox(
                                  width: 10
                              ),
                              pw.Column(
                                  children: [
                                    pw.Text(
                                        "${invoice.paymentType}",
                                        style: pw.TextStyle(
                                            fontSize: 14, fontWeight: pw
                                            .FontWeight.bold)),
                                    pw.Text(
                                        "·········································")
                                  ]
                              )


                            ]
                        ),
                        pw.SizedBox(
                            height: 8
                        ),
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Text(
                                  "Month of  ",
                                  style: pw.TextStyle(fontSize: 14,)),
                              pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Text(
                                        "${invoice.paymentMonth}",
                                        style: pw.TextStyle(
                                            fontSize: 14, fontWeight: pw
                                            .FontWeight.bold)),
                                    pw.Text(
                                      "······································",)
                                  ]
                              ),
                              pw.SizedBox(
                                  width: 10
                              ),
                              pw.Text(
                                  "Mode of Payment",
                                  style: pw.TextStyle(fontSize: 14,)),
                              pw.SizedBox(
                                  width: 10
                              ),
                              pw.Column(
                                  children: [
                                    pw.Text(
                                        "${invoice.paymentMethod}",
                                        style: pw.TextStyle(
                                            fontSize: 14, fontWeight: pw
                                            .FontWeight.bold)),
                                    pw.Text(
                                        "··························································")
                                  ]
                              )


                            ]
                        ),
                        pw.SizedBox(
                            height: 8
                        ),
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Text(
                                  "Amount in words",
                                  style: pw.TextStyle(fontSize: 14,)),
                              pw.SizedBox(
                                  width: 10
                              ),
                              pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        "${invoice.inWords}",
                                        style: pw.TextStyle(
                                            fontSize: 14, fontWeight: pw
                                            .FontWeight.bold)),
                                    pw.Text(
                                        "·······················································································································")
                                  ]
                              )


                            ]
                        ),
                        pw.SizedBox(
                            height: 37
                        ),
                        pw.Row(
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Container(
                                  height: 20,
                                  width: 80,
                                  decoration: pw.BoxDecoration(
                                      // borderRadius: pw.BorderRadius.circular(4),
                                      border: pw.Border.all(
                                          color: PdfColors.black, width: 2),
                                    borderRadius: pw.BorderRadius.circular(4),
                                  ),
                                  child: pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment
                                            .center,
                                        children: [
                                          // SizedBox(width: 16),
                                          pw.Image(
                                            pw.MemoryImage(byteListss), fit: pw.BoxFit.fitHeight,
                                            height: 10,
                                            width: 10, ),
                                          pw.SizedBox(
                                              width: 3
                                          ),
                                          pw.Text("${invoice.amount}",
                                              style: pw.TextStyle(fontSize: 16,
                                                  fontWeight: pw.FontWeight
                                                      .bold,
                                                  color: PdfColors.black))
                                        ],
                                      )
                                  )
                              ),
                              pw.SizedBox(
                                  width: 100
                              ),
                              pw.Text("Bill Collector",
                                  style: pw.TextStyle(fontSize: 14)),
                              pw.SizedBox(
                                  width: 100
                              ),
                              pw.Text("Secretary",
                                  style: pw.TextStyle(fontSize: 14)),
                            ]
                        )
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(top: 12),
                      child:  pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text("Powered by Smart Masjid",
                                      style: pw.TextStyle(fontSize: 5)),
                                  pw.SizedBox(
                                      width: 20
                                  ),
                                ]
                            )
                          ]
                      )
                    )

                  ]
              );
            }
        ));
    final directory = await getExternalStorageDirectory();
    final file = File("${directory?.path}/invoice.pdf");

    final pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes.toList());

    DocumentFileSavePlus().saveMultipleFiles(
      dataList: [pdfBytes],
      fileNameList: ["${invoice!.paymentMonth} Invoice.pdf"],
      mimeTypeList: ["application/pdf"],
    );

    // Display a notification
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel ID',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // notification ID
      'PDF Downloaded', // notification title
      '${invoice.paymentMonth} Invoice Downloaded', // notification body
      platformChannelSpecifics,
    );
    return pdf.save();
  }


}