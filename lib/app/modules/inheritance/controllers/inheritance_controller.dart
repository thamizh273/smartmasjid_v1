import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InheritanceController extends GetxController {
  //TODO: Implement InheritanceController

  RxList expand = [].obs;
  RxList count = [].obs;
  RxInt isSelected = 0.obs;

  // void toggleExpansion(int index) {
  //
  //   expand[index] = !expand[index];
  //   update(); // Notify GetX that the state has changed
  // }
  final List relativeNameList = [
    {
      "name": 'Husband',
      "descrp":
          "Must be legally married. Secret or undocumented marriages are not eligible."
    },
    {
      "name": 'Wives',
      "descrp":
          "Multiple wives are eligible. Secret or undocumented marriages are not eligible. A divorced wife is eligible if iddah period has not yet completed."
    },
    {
      "name": 'Sons',
      "descrp": "Adopted son, step-son, or illegitimate son is not eligible."
    },
    {
      "name": 'Daughters',
      "descrp":
          "Adopted daughter, step-daughter, or illegitimate daughter is not eligible."
    },
    {
      "name": 'Grandsons',
      "descrp":
          "Only son's sons are eligible. Daughter's sons are not eligible."
    },
    {
      "name": 'Granddaughters',
      "descrp":
          "Only son's daughters are eligible. Daughter's daughters are not eligible."
    },
    {
      "name": 'Father',
      "descrp": "Illegitimate father, or step-father is not eligible."
    },
    {
      "name": 'Mother',
      "descrp": "Illegitimate mother, or step-mother is not eligible."
    },
    {
      "name": 'Grandfather',
      "descrp":
          "Only father's father is eligible. Mother's father is not eligible."
    },
    {"name": 'Paternal Grandmother', "descrp": "Father's mother is eligible."},
    {"name": 'Maternal Grandmother', "descrp": "Mother's mother is eligible."},
    {
      "name": 'Full Brothers',
      "descrp":
          "Brothers who share the same father and the mother with the deceased."
    },
    {
      "name": 'Full Sisters',
      "descrp":
          "Sisters who share the same father and the mother with the deceased."
    },
    {
      "name": 'Paternal Brothers',
      "descrp": "Brothers who share the same father, but a different mother."
    },
    {
      "name": 'Paternal Sisters',
      "descrp": "Sisters who share the same father, but a different mother."
    },
    {
      "name": 'Maternal Brothers',
      "descrp": "Brothers who share the same mother, but a different father."
    },
    {
      "name": 'Maternal Sisters',
      "descrp": "Sisters who share the same mother, but a different father."
    },
    {
      "name": 'Full Nephews',
      "descrp": "Only brother's son is eligible. Sister's son is not eligible."
    },
    {
      "name": 'Paternal Nephews',
      "descrp":
          "Only paternal brother's son is eligible. Paternal brother's daughter is not eligible."
    },
    {"name": 'Full Nephew’s sons', "descrp": "Full brother's son's son."},
    {
      "name": 'Paternal Nephew’s sons',
      "descrp": "Paternal brother's son's son."
    },
    {"name": 'Full Paternal Uncles', "descrp": "Father's full brother."},
    {
      "name": 'Paternal Paternal Uncles',
      "descrp": "Father's paternal brother."
    },
    {"name": 'Full Cousins', "descrp": "Father's full brother's son."},
    {"name": 'Paternal Cousins', "descrp": "Father's paternal brother's son."},
    {
      "name": 'Full Cousin’s Sons',
      "descrp": "Father's full brother's son's son."
    },
    {
      "name": 'Paternal Cousin’s Sons',
      "descrp": "Father's paternal brother's son's son."
    },
    {
      "name": 'Full Cousin’s Grandsons',
      "descrp": "Father's full brother's son's son's son."
    },
    {
      "name": "Paternal Cousin's Grandsons",
      "descrp": "Father's paternal brother's son's son's son."
    },
  ];

  RxInt? openExpansionIndex;

  @override
  void onInit() {
    expand.assignAll(List.generate(29, (_) => false));
    count.assignAll(List.generate(29, (_) => 0));
    openExpansionIndex = RxInt(-1);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment(int index) {

    switch(index){
      case 0: if (count[index] < 1) {
        count[index]++;
      }
      break;
      case 1: if (count[index] < 4) {
        count[index]++;
      }
      break;
      case 6: if (count[index] < 1) {
        count[index]++;
      }
      break;
      case 7: if (count[index] < 1) {
        count[index]++;
      }
      break;
      case 8: if (count[index] < 1) {
        count[index]++;
      }
      break;
      case 9: if (count[index] < 1) {
        count[index]++;
      }
      break;
      case 10: if (count[index] < 1) {
        count[index]++;
      }
      break;
      default: count[index]++;
    }
  }

  var husband = 0.0.obs;
  var wife = 0.0.obs;
  var son = 0.0.obs;
  var daughter = 0.0.obs;
  var wifeShareFraction="".obs;
  var husbandShareFraction="".obs;
  var sonShareFraction="".obs;
  var daughterShareFraction="".obs;
  calculate() {
   // wife
    if (count[1] > 0 && count[2] > 0 && count[3] > 0) {
      wifeShareFraction.value="1/${8 * count[1]}";
      husband.value = (100 / (8 * count[1]));
      return;
    } else if (count[1] > 0 && count[2] == 0 && count[3] == 0) {
      wifeShareFraction.value="1/${8 * count[1]}";
      husband.value = (100 / count[1]);
      print("ssss1${husband.value}");
      return;
    }
    //husband
    if (count[0] > 0 && count[2] > 0 && count[3] == 0) {
      husbandShareFraction.value="1/4";
      sonShareFraction.value="3/${4 * count[2]}";
      wife.value = (100 / count[0]);
      son.value = ( (3/(4 * count[2]))*100);
      return;
    }  else if (count[0] > 0 && count[2] == 0 && count[3] > 0) {
      husbandShareFraction.value="1/4";
      daughterShareFraction.value="3/${4 * count[3]}";
      wife.value = (100 / count[0]);
      daughter.value = ( (3/(4 * count[3]))*100);
      return;
    }else if (count[0] > 0 && count[2] > 0 && count[3] > 0) {
      husbandShareFraction.value="1/4";
      daughterShareFraction.value="3/${4 * count[3]}";
      sonShareFraction.value="3/${4 * count[2]}";
      wife.value = (100 / count[0]);
      daughter.value = ( (3/(4 * count[3]))*100);
      son.value = ( (3/(4 * count[2]))*100);
      return;
    }else if (count[0] > 0 && count[2] == 0 && count[3] == 0) {
      husbandShareFraction.value="1/1";
      wife.value = (100 / count[0]);
      return;
    }
  }

  void decrement(int index) {
    if (count[index] > 0) {
      count[index]--;
    }
  }
}
