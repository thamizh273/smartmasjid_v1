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
  String? makkiMadina;
  String? suraChapterNo;
  String? suraNameEn;
  String? titleEn;
  String? totalVerses;
  List<AyahList>? ayahList;

  GetQuranAyahVerse(
      {this.sTypename,
        this.makkiMadina,
        this.suraChapterNo,
        this.suraNameEn,
        this.titleEn,
        this.totalVerses,
        this.ayahList});

  GetQuranAyahVerse.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    makkiMadina = json['makki_madina'];
    suraChapterNo = json['sura_chapter_no'];
    suraNameEn = json['sura_name_en'];
    titleEn = json['title_en'];
    totalVerses = json['total_verses'];
    if (json['ayah_list'] != null) {
      ayahList = <AyahList>[];
      json['ayah_list'].forEach((v) {
        ayahList!.add(new AyahList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['makki_madina'] = this.makkiMadina;
    data['sura_chapter_no'] = this.suraChapterNo;
    data['sura_name_en'] = this.suraNameEn;
    data['title_en'] = this.titleEn;
    data['total_verses'] = this.totalVerses;
    if (this.ayahList != null) {
      data['ayah_list'] = this.ayahList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AyahList {
  String? sTypename;
  ArabicAudio? arabicAudio;
  String? arabicText;
  int? ayahNo;
  String? engTranslation;
  String? hindiTranslation;
  String? tamilTranslation;
  String? versesKey;

  AyahList(
      {this.sTypename,
        this.arabicAudio,
        this.arabicText,
        this.ayahNo,
        this.engTranslation,
        this.hindiTranslation,
        this.tamilTranslation,
        this.versesKey});

  AyahList.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    arabicAudio = json['arabic_audio'] != null
        ? new ArabicAudio.fromJson(json['arabic_audio'])
        : null;
    arabicText = json['arabic_text'];
    ayahNo = json['ayah_no'];
    engTranslation = json['eng_translation'];
    hindiTranslation = json['hindi_translation'];
    tamilTranslation = json['tamil_translation'];
    versesKey = json['verses_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.arabicAudio != null) {
      data['arabic_audio'] = this.arabicAudio!.toJson();
    }
    data['arabic_text'] = this.arabicText;
    data['ayah_no'] = this.ayahNo;
    data['eng_translation'] = this.engTranslation;
    data['hindi_translation'] = this.hindiTranslation;
    data['tamil_translation'] = this.tamilTranslation;
    data['verses_key'] = this.versesKey;
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
