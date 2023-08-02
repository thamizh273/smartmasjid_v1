import 'dart:convert';

QuranDetailModel qurandetailModelFromJson(String str) => QuranDetailModel.fromJson(json.decode(str));

String qurandetailModelToJson(QuranDetailModel data) => json.encode(data.toJson());


class QuranDetailModel {
  String? sTypename;
  List<GetQuranAyahVerse>? getQuranAyahVerse;

  QuranDetailModel({this.sTypename, this.getQuranAyahVerse});

  QuranDetailModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['Get_Quran_Ayah_Verse'] != null) {
      getQuranAyahVerse = <GetQuranAyahVerse>[];
      json['Get_Quran_Ayah_Verse'].forEach((v) {
        getQuranAyahVerse!.add(new GetQuranAyahVerse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getQuranAyahVerse != null) {
      data['Get_Quran_Ayah_Verse'] =
          this.getQuranAyahVerse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetQuranAyahVerse {
  String? sTypename;
  String? suraChapterNo;
  List<AyahList>? ayahList;
  String? suraNameEn;
  String? makkiMadina;
  String? titleArb;
  String? titleEn;
  String? totalVerses;

  GetQuranAyahVerse(
      {this.sTypename,
        this.suraChapterNo,
        this.ayahList,
        this.suraNameEn,
        this.makkiMadina,
        this.titleArb,
        this.titleEn,
        this.totalVerses});

  GetQuranAyahVerse.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    suraChapterNo = json['sura_chapter_no'];
    if (json['ayah_list'] != null) {
      ayahList = <AyahList>[];
      json['ayah_list'].forEach((v) {
        ayahList!.add(new AyahList.fromJson(v));
      });
    }
    suraNameEn = json['sura_name_en'];
    makkiMadina = json['makki_madina'];
    titleArb = json['title_arb'];
    titleEn = json['title_en'];
    totalVerses = json['total_verses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['sura_chapter_no'] = this.suraChapterNo;
    if (this.ayahList != null) {
      data['ayah_list'] = this.ayahList!.map((v) => v.toJson()).toList();
    }
    data['sura_name_en'] = this.suraNameEn;
    data['makki_madina'] = this.makkiMadina;
    data['title_arb'] = this.titleArb;
    data['title_en'] = this.titleEn;
    data['total_verses'] = this.totalVerses;
    return data;
  }
}

class AyahList {
  String? sTypename;
  String? arabicText;
  int? ayahNo;
  String? versesKey;
  ArabicAudio? arabicAudio;
  String? engTranslation;
  String? tamilTranslation;
  String? hindiTranslation;

  AyahList(
      {this.sTypename,
        this.arabicText,
        this.ayahNo,
        this.versesKey,
        this.arabicAudio,
        this.engTranslation,
        this.tamilTranslation,
        this.hindiTranslation});

  AyahList.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    arabicText = json['arabic_text'];
    ayahNo = json['ayah_no'];
    versesKey = json['verses_key'];
    arabicAudio = json['arabic_audio'] != null
        ? new ArabicAudio.fromJson(json['arabic_audio'])
        : null;
    engTranslation = json['eng_translation'];
    tamilTranslation = json['tamil_translation'];
    hindiTranslation = json['hindi_translation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['arabic_text'] = this.arabicText;
    data['ayah_no'] = this.ayahNo;
    data['verses_key'] = this.versesKey;
    if (this.arabicAudio != null) {
      data['arabic_audio'] = this.arabicAudio!.toJson();
    }
    data['eng_translation'] = this.engTranslation;
    data['tamil_translation'] = this.tamilTranslation;
    data['hindi_translation'] = this.hindiTranslation;
    return data;
  }
}

class ArabicAudio {
  String? type;
  List<int>? data;

  ArabicAudio({this.type, this.data});

  ArabicAudio.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}

