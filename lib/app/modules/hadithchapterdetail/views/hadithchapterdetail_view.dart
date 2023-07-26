import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../../widgets/space.dart';
import '../../quranpage/views/qurandetails.dart';
import '../controllers/hadithchapterdetail_controller.dart';

class HadithchapterdetailView extends GetView<HadithchapterdetailController> {
   HadithchapterdetailView({Key? key}) : super(key: key);
  final HadithchapterdetailController c = Get.put(HadithchapterdetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppbar(
       tittle: "Hadith",
       action: [
         Image.asset("assets/images/notes.png", width: 20,),
         Space(16)
       ],
     ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Color(0xff16627C)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Sahih Al-Bukhari", style: TextStyle(fontSize: 18),),
                    Text("Chapter: 1 (Revelation)"),
                  ],
                ),
              ),
            ),
            Space(16),
            Text("Chapter: How the Divine Revelation started being revealed to Allah's Messenger"),
            Space(16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0,4),
                                color: Colors.grey.shade400,
                                blurRadius: 4,
                                spreadRadius: 2
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("1.", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                                Spacer(),
                                PopupMenuButton(
                                  shadowColor: Colors.grey.shade400,
                                    itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(child: Row(
                                      children: [
                                        Image.asset("assets/images/bookmark.png", width: 20,color: Colors.black,),
                                        Space(12),
                                        Text("Bookmark"),
                                      ],
                                    )),
                                    PopupMenuItem(child: Row(
                                      children: [
                                        Icon(Icons.copy),
                                        Space(12),
                                        Text("Copy"),
                                      ],
                                    )),
                                    PopupMenuItem(child: Row(
                                      children: [
                                        Icon(Icons.share),
                                        Space(12),
                                        Text("Share"),
                                      ],
                                    )),
                                    PopupMenuItem(child: GestureDetector(
                                      onTap: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                              title: 'Custom Dialog Title',
                                              content:
                                              'This is the content of the custom dialog box.',
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Closes the dialog box when the button is pressed.
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/notes.png", width: 20, color: Colors.black,),
                                          Space(12),
                                          Text("Create Notes"),
                                        ],
                                      ),
                                    )),
                                  ];
                                }
                                )
                              ],
                            ),
                            Text("حَدَّثَنَا الْحُمَيْدِيُّ عَبْدُ اللَّهِ بْنُ الزُّبَيْرِ، قَالَ حَدَّثَنَا سُفْيَانُ، قَالَ حَدَّثَنَا يَحْيَى بْنُ سَعِيدٍ الأَنْصَارِيُّ، قَالَ أَخْبَرَنِي مُحَمَّدُ بْنُ إِبْرَاهِيمَ التَّيْمِيُّ، أَنَّهُ سَمِعَ عَلْقَمَةَ بْنَ وَقَّاصٍ اللَّيْثِيَّ،"
                                " يَقُولُ سَمِعْتُ عُمَرَ بْنَ الْخَطَّابِ ـ رضى "
                                "الله عنه ـ عَلَى الْمِنْبَرِ قَالَ سَمِعْتُ رَسُولَ اللَّهِ صلى الله عليه وسلم يَقُولُ ‏"
                                "‏ إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُه"
                                "ُ إِلَى دُنْيَا يُصِيبُهَا أَوْ إِلَى امْرَأَةٍ يَنْكِحُهَا فَهِجْرَتُهُ إِلَى مَا هَاجَرَ إِلَيْهِ ‏" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                            Space(8),
                            Text("Narrated 'Umar bin Al-Khattab:", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),),
                            Space(8),
                            Text("I heard Allah's Messenger (ﷺ) saying, The reward of deeds depends upon the intentions"
                                "and every person will get the reward according to what he has intended. "
                                "So whoever emigrated for worldly benefits or for a woman to marry, his emigration was for what he emigrated for"),
                            Space(8),
                            Text("Sahih Al-Bukhari, 1", style: TextStyle(color: Colors.black.withOpacity(0.6)),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController c = TextEditingController();
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomDialogBox({
    required this.title,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Create New Note", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
          Space(16),
          Container(
            width: 300.w,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,4),
                  blurRadius: 5 ,
                  color: Colors.grey.shade400
                )
              ]
            ),
            child: TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.4), fontWeight: FontWeight.w600),
              controller: pass ,
              decoration: InputDecoration(
                hintText: 'Note Title',
                // label: Text("Note Title"),
                filled: true,
                fillColor: Colors.grey.shade100,
                focusColor: Colors.black,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Space(16),
          TextFormField(
            controller: c,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Type ypur notes...',
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black),
            maxLines: 4,
          ),
          Space(16),
          ElevatedButton(
              onPressed: ()   {
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 40),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4.0,
              ),
              child: Text("Save", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color:Colors.white),)),
        ],
      ),
    );
  }
}