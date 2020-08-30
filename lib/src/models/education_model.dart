import 'dart:convert';

Education educationFromJson(String str) => Education.fromJson(json.decode(str));

String educationToJson(Education data) => json.encode(data.toJson());

class Educations {

  List<Education> educations = new List();

  Educations();

  Educations.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return ;

    for (var json in jsonList) {
      final education = Education.fromJson(json);
      educations.add(education);
    }

  }
}

class Education {
    Education({
        this.postcveduid,
        this.education,
        this.college,
        this.studyfield,
        this.city,
        this.studyfrom,
        this.studyto,
        this.ispresent,
        this.createddatetime,
        this.modifieddatetime,
        this.status,
    });

    int postcveduid;
    String education;
    String college;
    String studyfield;
    String city;
    dynamic studyfrom;
    dynamic studyto;
    String ispresent;
    DateTime createddatetime;
    dynamic modifieddatetime;
    int status;

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        postcveduid: json["postcveduid"],
        education: json["education"],
        college: json["college"],
        studyfield: json["studyfield"],
        city: json["city"],
        studyfrom: json["studyfrom"],
        studyto: json["studyto"],
        ispresent: json["ispresent"],
        createddatetime: DateTime.parse(json["createddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "postcveduid": postcveduid,
        "education": education,
        "college": college,
        "studyfield": studyfield,
        "city": city,
        "studyfrom": studyfrom,
        "studyto": studyto,
        "ispresent": ispresent,
        "createddatetime": createddatetime.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "status": status,
    };
}