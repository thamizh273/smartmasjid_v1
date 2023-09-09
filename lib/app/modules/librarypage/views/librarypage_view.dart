import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../widgets/button_widget.dart';
import '../../../../widgets/title_widget.dart';
import '../../membership/model/pdf_model/customer.dart';
import '../../membership/model/pdf_model/invoice.dart';
import '../../membership/model/pdf_model/supplier.dart';
import '../../membership/pdf_helper/pdf_helper.dart';
import '../../membership/pdf_helper/pdf_invoice_helper.dart';


class LibrarypageView extends StatefulWidget {
  const LibrarypageView({super.key});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<LibrarypageView> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      tittle: "library".tr,
    ),
    body: Working(),
  );
}