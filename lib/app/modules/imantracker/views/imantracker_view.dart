import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_array.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';

class ImantrackerView extends StatefulWidget {
  const ImantrackerView({super.key});

  @override
  State<ImantrackerView> createState() => _ImanTrackerViewState();
}

class _ImanTrackerViewState extends State<ImantrackerView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: SvgPicture.asset(
              "assets/svg/backnew.svg", fit: BoxFit.scaleDown),
          title: Text("Iman Tracker"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Entry",
              ),
              Tab(
                text: "Stats",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RotatedBox(
                          quarterTurns: 3,
                          child: Text("June", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Theme.of(context).primaryColor),)),
                      Space(8),
                      Column(
                        children: [
                          Text(
                            "M",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "D",
                            style: TextStyle(fontSize: 18),
                          ),

                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
