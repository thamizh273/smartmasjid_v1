import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/invoicebg.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../global.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Invoice",
      ),
      body: InvoiceBG(
        child: Column(
          children: [
            Stxt(text: "", size: f3)
          ],
        )
      ),
    );
  }
}
