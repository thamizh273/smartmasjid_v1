import 'dart:convert';

QuranJuzDetailModel quranjuzdetailModelFromJson(String str) => QuranJuzDetailModel.fromJson(json.decode(str));

String quranjuzdetailModelToJson(QuranJuzDetailModel data) => json.encode(data.toJson());


class QuranJuzDetailModel {
  String? sTypename;
  List<GetQuranJuzVersesList>? getQuranJuzVersesList;

  QuranJuzDetailModel({this.sTypename, this.getQuranJuzVersesList});

  QuranJuzDetailModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['Get_Quran_Juz_Verses_List'] != null) {
      getQuranJuzVersesList = <GetQuranJuzVersesList>[];
      json['Get_Quran_Juz_Verses_List'].forEach((v) {
        getQuranJuzVersesList!.add(new GetQuranJuzVersesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getQuranJuzVersesList != null) {
      data['Get_Quran_Juz_Verses_List'] =
          this.getQuranJuzVersesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetQuranJuzVersesList {
  String? sTypename;
  int? juzChapterNo;
  String? juzNameArb;
  String? juzNameEn;
  String? surahVersesStart;
  String? surahVersesEnd;
  int? totalVerses;
  List<AyahList>? ayahList;

  GetQuranJuzVersesList(
      {this.sTypename,
        this.juzChapterNo,
        this.juzNameArb,
        this.juzNameEn,
        this.surahVersesStart,
        this.surahVersesEnd,
        this.totalVerses,
        this.ayahList});

  GetQuranJuzVersesList.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    juzChapterNo = json['juz_chapter_no'];
    juzNameArb = json['juz_name_arb'];
    juzNameEn = json['juz_name_en'];
    surahVersesStart = json['surah_verses_start'];
    surahVersesEnd = json['surah_verses_end'];
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
    data['juz_chapter_no'] = this.juzChapterNo;
    data['juz_name_arb'] = this.juzNameArb;
    data['juz_name_en'] = this.juzNameEn;
    data['surah_verses_start'] = this.surahVersesStart;
    data['surah_verses_end'] = this.surahVersesEnd;
    data['total_verses'] = this.totalVerses;
    if (this.ayahList != null) {
      data['ayah_list'] = this.ayahList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AyahList {
  String? sTypename;
  int? suraChapterNo;
  String? versesKey;
  String? arabicText;
  ArabicAudio? arabicAudio;
  String? engTranslation;
  String? tamilTranslation;
  String? hindiTranslation;
  int? ayahNo;

  AyahList(
      {this.sTypename,
        this.suraChapterNo,
        this.versesKey,
        this.arabicText,
        this.arabicAudio,
        this.engTranslation,
        this.tamilTranslation,
        this.hindiTranslation,
        this.ayahNo});

  AyahList.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    suraChapterNo = json['sura_chapter_no'];
    versesKey = json['verses_key'];
    arabicText = json['arabic_text'];
    arabicAudio = json['arabic_audio'] != null
        ? new ArabicAudio.fromJson(json['arabic_audio'])
        : null;
    engTranslation = json['eng_translation'];
    tamilTranslation = json['tamil_translation'];
    hindiTranslation = json['hindi_translation'];
    ayahNo = json['ayah_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['sura_chapter_no'] = this.suraChapterNo;
    data['verses_key'] = this.versesKey;
    data['arabic_text'] = this.arabicText;
    if (this.arabicAudio != null) {
      data['arabic_audio'] = this.arabicAudio!.toJson();
    }
    data['eng_translation'] = this.engTranslation;
    data['tamil_translation'] = this.tamilTranslation;
    data['hindi_translation'] = this.hindiTranslation;
    data['ayah_no'] = this.ayahNo;
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
