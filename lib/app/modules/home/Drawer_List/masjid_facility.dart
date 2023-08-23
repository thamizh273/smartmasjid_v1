import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';

import '../../../../widgets/space.dart';

class MasjidFacility extends StatelessWidget {
  const MasjidFacility({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Facilities",
      ),
      body: Working(),
    );
  }
}
