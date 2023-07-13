import 'dart:convert';

QuranModel quranModelFromJson(String str) => QuranModel.fromJson(json.decode(str));

String quranModelToJson(QuranModel data) => json.encode(data.toJson());

class QuranModel {
  String? sTypename;
  List<QuranFilter>? quranFilter;

  QuranModel({this.sTypename, this.quranFilter});

  QuranModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['Quran_Filter'] != null) {
      quranFilter = <QuranFilter>[];
      json['Quran_Filter'].forEach((v) {
        quranFilter!.add(new QuranFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.quranFilter != null) {
      data['Quran_Filter'] = this.quranFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuranFilter {
  String? sTypename;
  String? id;
  String? masjidId;
  String? suraChapterNo;
  String? suraNameArb;
  String? suraNameEn;
  String? suraNameHindi;
  String? suraNameTamil;
  String? titleEn;
  String? titleHindi;
  String? titleTamil;
  String? totalVerses;

  QuranFilter(
      {this.sTypename,
        this.id,
        this.masjidId,
        this.suraChapterNo,
        this.suraNameArb,
        this.suraNameEn,
        this.suraNameHindi,
        this.suraNameTamil,
        this.titleEn,
        this.titleHindi,
        this.titleTamil,
        this.totalVerses});

  QuranFilter.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    masjidId = json['masjid_id'];
    suraChapterNo = json['sura_chapter_no'];
    suraNameArb = json['sura_name_arb'];
    suraNameEn = json['sura_name_en'];
    suraNameHindi = json['sura_name_hindi'];
    suraNameTamil = json['sura_name_tamil'];
    titleEn = json['title_en'];
    titleHindi = json['title_hindi'];
    titleTamil = json['title_tamil'];
    totalVerses = json['total_verses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['id'] = this.id;
    data['masjid_id'] = this.masjidId;
    data['sura_chapter_no'] = this.suraChapterNo;
    data['sura_name_arb'] = this.suraNameArb;
    data['sura_name_en'] = this.suraNameEn;
    data['sura_name_hindi'] = this.suraNameHindi;
    data['sura_name_tamil'] = this.suraNameTamil;
    data['title_en'] = this.titleEn;
    data['title_hindi'] = this.titleHindi;
    data['title_tamil'] = this.titleTamil;
    data['total_verses'] = this.totalVerses;
    return data;
  }
}


