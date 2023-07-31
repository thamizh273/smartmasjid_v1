import 'dart:convert';

QuranJuzModel quranjuzModelFromJson(String str) => QuranJuzModel.fromJson(json.decode(str));

String quranjuzModelToJson(QuranJuzModel data) => json.encode(data.toJson());


class QuranJuzModel {
  String? sTypename;
  List<GetQuranJuzChapter>? getQuranJuzChapter;

  QuranJuzModel({this.sTypename, this.getQuranJuzChapter});

  QuranJuzModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['Get_Quran_Juz_Chapter'] != null) {
      getQuranJuzChapter = <GetQuranJuzChapter>[];
      json['Get_Quran_Juz_Chapter'].forEach((v) {
        getQuranJuzChapter!.add(new GetQuranJuzChapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getQuranJuzChapter != null) {
      data['Get_Quran_Juz_Chapter'] =
          this.getQuranJuzChapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetQuranJuzChapter {
  String? sTypename;
  String? id;
  String? masjidId;
  int? juzChapterNo;
  String? juzNameArb;
  String? juzNameEn;
  String? surahVersesStart;
  String? surahVersesEnd;
  int? totalVerses;

  GetQuranJuzChapter(
      {this.sTypename,
        this.id,
        this.masjidId,
        this.juzChapterNo,
        this.juzNameArb,
        this.juzNameEn,
        this.surahVersesStart,
        this.surahVersesEnd,
        this.totalVerses});

  GetQuranJuzChapter.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    masjidId = json['masjid_id'];
    juzChapterNo = json['juz_chapter_no'];
    juzNameArb = json['juz_name_arb'];
    juzNameEn = json['juz_name_en'];
    surahVersesStart = json['surah_verses_start'];
    surahVersesEnd = json['surah_verses_end'];
    totalVerses = json['total_verses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['id'] = this.id;
    data['masjid_id'] = this.masjidId;
    data['juz_chapter_no'] = this.juzChapterNo;
    data['juz_name_arb'] = this.juzNameArb;
    data['juz_name_en'] = this.juzNameEn;
    data['surah_verses_start'] = this.surahVersesStart;
    data['surah_verses_end'] = this.surahVersesEnd;
    data['total_verses'] = this.totalVerses;
    return data;
  }
}
