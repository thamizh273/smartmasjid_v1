import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

class MasjidHistory extends StatelessWidget {
  const MasjidHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "history".tr,
      ),
      body: Working(),
    );
  }
}
