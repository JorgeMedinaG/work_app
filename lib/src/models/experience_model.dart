import 'dart:convert';

Experience experienceFromJson(String str) => Experience.fromJson(json.decode(str));

String experienceToJson(Experience data) => json.encode(data.toJson());

class Experiences {

  List<Experience> experiences = new List();

  Experiences();

  Experiences.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return ;

    for (var json in jsonList) {
      final experience = Experience.fromJson(json);
      experiences.add(experience);
    }

  }
}

class Experience {
    Experience({
        this.postcvexpid,
        this.jobtitle,
        this.company,
        this.city,
        this.jobfrom,
        this.jobto,
        this.ispresent,
        this.createddatetime,
        this.modifieddatetime,
        this.status,
    });

    int postcvexpid;
    String jobtitle;
    String company;
    String city;
    dynamic jobfrom;
    dynamic jobto;
    String ispresent;
    DateTime createddatetime;
    dynamic modifieddatetime;
    int status;

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        postcvexpid: json["postcvexpid"],
        jobtitle: json["jobtitle"],
        company: json["company"],
        city: json["city"],
        jobfrom: json["jobfrom"],
        jobto: json["jobto"],
        ispresent: json["ispresent"],
        createddatetime: DateTime.parse(json["createddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "postcvexpid": postcvexpid,
        "jobtitle": jobtitle,
        "company": company,
        "city": city,
        "jobfrom": jobfrom,
        "jobto": jobto,
        "ispresent": ispresent,
        "createddatetime": createddatetime.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "status": status,
    };
}