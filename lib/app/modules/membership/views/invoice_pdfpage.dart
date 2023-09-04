import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../routes/export.dart';

@immutable
class PdfPreviewPage extends StatelessWidget {
 final String? text;
  PdfPreviewPage(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: "Payment Receipt",),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/images/masjidlogoinvoice.png');
    final ByteData bytess = await rootBundle.load('assets/images/borderinvoice.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final Uint8List byteLists = bytess.buffer.asUint8List();
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a5,
            orientation: pw.PageOrientation.landscape,
            build: (context) {
              return pw.Stack(
                  children: [
                    pw.Center(
                      child: pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 200, width: 200, ),
                    ),
                    pw.Center(
                      child:  pw.Image(pw.MemoryImage(byteLists), fit: pw.BoxFit.fitHeight, height: 400, width: 570, ),
                    ),


                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.SizedBox(height: 1 * PdfPageFormat.cm),
                        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text("This Receipt generated by Smart Masjid", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal, fontSize: 10))
                            ]
                        ),
                        pw.SizedBox(
                            height: 4
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text("Masjid-E-Nooraniyya",
                                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 25))
                            ]
                        ),
                        pw.SizedBox(
                            height: 4
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                  "No.21, Debsanpet, Small Lane, Muthialpet, Puducherry-605003",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal, fontSize: 10))
                            ]
                        ),
                        pw.SizedBox(
                            height: 16
                        ),
                        pw.Container(
                            height: 20,
                            width: 80,
                            decoration: pw.BoxDecoration(
                                borderRadius: pw.BorderRadius.circular(4),
                                border: pw.Border.all(color: PdfColors.black, width: 2)
                            ),
                            child: pw.Center(child: pw.Text("Receipt", style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold,)),
                            )
                        ),
                        pw.SizedBox(
                            height: 16
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 30
                              ),
                              pw.Text("Receipt No.", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.Text("203154", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.Spacer(),
                              pw.Text("Date: ", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.Text("28/07/2023", style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.SizedBox(
                                  width: 30
                              ),
                            ]
                        ),
                        pw.SizedBox(
                            height: 16
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Text(
                                  "Received From Janab................................................................................................",
                                  style: pw.TextStyle(fontSize: 14,))
                            ]
                        ),
                        pw.SizedBox(
                            height: 16
                        ),
                        pw.Stack(
                            children: [
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(
                                        width: 26
                                    ),
                                    pw.Text(
                                        "MemberShip ID.................................................Payment for....................................",
                                        style: pw.TextStyle(fontSize: 14,))
                                  ]
                              ),
                            ]
                        ),
                        pw.SizedBox(
                            height: 16
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Text(
                                  "Month of...................................................Mode of Payment..................................",
                                  style: pw.TextStyle(fontSize: 14,))
                            ]
                        ),
                        pw.SizedBox(
                            height: 16
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                  width: 26
                              ),
                              pw.Text(
                                  "Amount in words...................................................................................................",
                                  style: pw.TextStyle(fontSize: 14,))
                            ]
                        ),
                        pw.SizedBox(
                            height: 50
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
                                      borderRadius: pw.BorderRadius.circular(4),
                                      border: pw.Border.all(color: PdfColors.black, width: 2)
                                  ),
                                  child: pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Row(
                                        mainAxisAlignment:pw. MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(width: 16),
                                          pw.Text("Rs. 500", style: pw.TextStyle(fontSize: 16,
                                              fontWeight: pw.FontWeight.bold,
                                              color: PdfColors.black))
                                        ],
                                      )
                                  )
                              ),
                              pw.SizedBox(
                                  width: 100
                              ),
                              pw.Text("Bill Collector", style: pw.TextStyle(fontSize: 14)),
                              pw.SizedBox(
                                  width: 100
                              ),
                              pw.Text("Secretary", style: pw.TextStyle(fontSize: 14)),
                            ]
                        )
                      ],
                    ),
                  ]
              );
            }
        ));
    return pdf.save();
  }
}