import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';

import '../../../../widgets/space.dart';
import '../controllers/masjidhistory_controller.dart';

class MasjidhistoryView extends GetView<MasjidhistoryController> {
  const MasjidhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppbar(
       tittle: "Masjid History",
     ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset("assets/images/masjidnoor.png"),
              ),
              Space(16),
              Text("The History of ", style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),),
              Text("Masjid-E-Nooranyya ", style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),),
              Space(16),
              Text("In the early 1980s, there were around 10 Muslim fami\nlies living in the Depesanpet area of Muthialpet, Pondicherry. "
                  "These people need to go to Kottakuppam Busthaniya Masjid for their prayers. On considering the difficulty, "
                  "Marhoom Janab Abdul Hammed was kind enough to spare a room of his house to convert into a prayer hall for offering prayer. "
                  "In the same room, a Madrassa for small children was also conducted."),
              Space(16),
              Text("In the meanwhile, the Muslim population has started growing in Depesanpet and Muthialpet area. In specific, "
                  "many families from the Koonimedu area have started acquiring "
                  "properties and settled in this area for admitting their children in Pondicherry schools. "
                  "As the Muslim population started growing, the people coming to attend the prayers has also increased considerably."
              ),
              Space(16),
              Text( "In the year 1987, a piece of land measuring 1150 square feet was purchased "
                  "by collection of donations and a thatched structure was built and named as Masjid-E-Noorania and "
                  "regular 5 times prayers were conducted by an engaged Imam. Subsequently in the year 1990 with grace of Allah, "
                  "the almighty, the present structure of Masjid was built with the fund received from various sources including from the "
                  "people of Kuwait. However there were no toilet facilities available in the main structure of the Masjid. Therefore,"
                  " another 230 square feet of land behind the Masjid was purchased in the year 1995 and toilet rooms were built. "
                  "Now a full fledged Masjid is functioning with Jumma and Eid al Fitr and Eid al Adha prayers. A Maktab Madrassa is "
                  "also functioning with two teachers in the Masjid where around 30 students are studying Islamic Education. "
                  "The Masjid is also registered with the Puducherry State Waqf Board."
              ),
              Space(16),
              Text("As day by day the Muslim population started growing in and around Muthialpet"
                  " area such as Viswanathan Nagar, Sentharamarai Nagar, Vasanth Nagar,Kennedy Garden, "
                  "Sankardoss Nagar etc., the present Mosque could not accommodate all the people in Jummah "
                  "prayer and other special occasions. Now a days, during Jummah many number of people were made offer"
                  "their prayer in the road under hot sun due paucity of place in the Masjid. Therefore again with grace of Allah,"
                  " the almighty, an area of 1080 square feet land behind "
                  "the was purchased for Rs.6 Lakh in the year 2007 by getting donation from Muslim people."
              ),
              Space(16),
              Text("The total extent of land of our Masjid is given below:-"
             " 1. Land purchased in the year 1987 - 1150 Sq.feet-Present Masjid"
             " 2.Land purchased in the year 1995 - 230 Sq.feet-Toilet rooms"
"              3: Land purchased in the year 2007 - 1080 Sq.feet-Vacant"
"              Total Area of land - 2410 Sq.feet"
"              Front entrance of the Masjid is at Depesanpet Street, Small Lane."
"                  Back of the Masjid is at Visvanathan Nagar, Sekkizhar Street"
"                  Considering paucity of space in the present Mosque, it was decided to construct a new Mosque of 2410 Sq.feet in the vacant land by demolishing the present mosque. Accordingly construction upto the basement level has been raised in the vacant place. On completion of the structure in the vacant land, the existing mosque will be demolished and the building will be extended to full length."
"                  Activities of Present Management Committee:-"
"                  1. The new management committee took charge in the month of March, 2015."
"                  2. NewMaktab Madrassa has been started"
"                  3. Qiyamullail prayer conducted in the last ten days of Ramzan month. Free Sahar food was offered to all who attended the Qiyamullail prayer."
"                  4. Ramzan and Bakrid prayers were conducted in the Masjid."
"                  5. Poor Muslim families (22 families) were identified and food materials worth Rs.2200/- were given to each family and andFitra amount of Rs.800/- were also given to Jamath and other Muslims."
"        6. Cash prizes and gifts received from Kuwait Jamath were distributed to Madrassa students and SSLC and Higher Secondary top rankers."
"        7. Nikkah has been conducted in its own New Nikkah Register. As of now 11 Nikkahs have been registered in our Masjid."
"        9. As of 2016 there are 296 Muslim families residing in the Muthialpet area. An amount of Rs.20,000/- is being received as monthly subscription. The amount is utilized for payment of salary to Imam and Muaddin. Regular monthly account is being submitted every month to the Puducherry State Wakf Board."
"        10. As of October, 2016 an amount of Rs.20 Lakh has been received as donation from the Muslim public and Kuwait Jamath. It is pertinent to mention that a person, who does not want to disclose his name, residing in the Devagi Nagar,Muthialpet, Pondicherry has donated a highest amount of Rs.5 Lakh for construction of Mosque."
"            11. All regular prayers, Maktab Madrassa in both the sessions have been conducted in our Masjid.    Alhamdhulillah."
        )

            ],
          ),
        ),
      ),
    );
  }
}
