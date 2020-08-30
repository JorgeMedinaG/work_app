import 'dart:convert';

Job jobFromJson(String str) => Job.fromJson(json.decode(str));

String jobToJson(Job data) => json.encode(data.toJson());


class Jobs {

  List<Job> jobs = new List();

  Jobs();

  Jobs.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return ;

    for (var json in jsonList) {
      final job = Job.fromJson(json);
      jobs.add(job);
    }

  }
}

class StoredJobs {

  List<StoredJob> jobs = new List();

  StoredJobs();

  StoredJobs.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return ;

    for (var json in jsonList) {
      final job = StoredJob.fromJson(json);
      jobs.add(job);
    }

  }
}

class StoredJob {
    StoredJob({
        this.savedjobid,
        this.company,
        this.location,
        this.jobtitle,
        this.job,
        this.createddatetime,
        this.modifieddatetime,
        this.status,
    });

    int savedjobid;
    String company;
    String location;
    String jobtitle;
    Job job;
    DateTime createddatetime;
    dynamic modifieddatetime;
    int status;

    factory StoredJob.fromJson(Map<String, dynamic> json) => StoredJob(
        savedjobid: json["savedjobid"],
        company: json["company"],
        location: json["location"],
        jobtitle: json["jobtitle"],
        job: Job.fromJson(json["jobpostid"]),
        createddatetime: DateTime.parse(json["createddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "savedjobid": savedjobid,
        "company": company,
        "location": location,
        "jobtitle": jobtitle,
        "job": job.toJson(),
        "createddatetime": createddatetime.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "status": status,
    };
}

class Job {
    Job({
        this.jobpostid,
        this.title,
        this.company,
        this.phone,
        this.website,
        this.email,
        this.location,
        this.country,
        this.state,
        this.latitude,
        this.longitude,
        this.city,
        this.totalposition,
        this.jobtype,
        this.industrytype,
        this.mineducation,
        this.employertype,
        this.expyear,
        this.expmonth,
        this.shift,
        this.salary,
        this.salarytype,
        this.jobsummary,
        this.responsibilitesduties,
        this.expskillcertification,
        this.qualification,
        this.additionalbenefits,
        this.receivableemail,
        this.additionalemail1,
        this.additionalemail2,
        this.additionalemail3,
        this.notifyfrequency,
        this.postbyparentcode,
        this.createddatetime,
        this.modifieddatetime,
        this.status,
        this.radius,
        this.distance,
    });

    int jobpostid;
    String title;
    String company;
    String phone;
    String website;
    String email;
    String location;
    String country;
    String state;
    String latitude;
    String longitude;
    String city;
    String totalposition;
    String jobtype;
    String industrytype;
    String mineducation;
    String employertype;
    String expyear;
    String expmonth;
    String shift;
    String salary;
    String salarytype;
    String jobsummary;
    String responsibilitesduties;
    String expskillcertification;
    String qualification;
    String additionalbenefits;
    String receivableemail;
    String additionalemail1;
    String additionalemail2;
    String additionalemail3;
    String notifyfrequency;
    String postbyparentcode;
    DateTime createddatetime;
    dynamic modifieddatetime;
    int status;
    int radius;
    double distance;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        jobpostid: json["jobpostid"],
        title: json["title"],
        company: json["company"],
        phone: json["phone"],
        website: json["website"],
        email: json["email"],
        location: json["location"],
        country: json["country"],
        state: json["state"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        totalposition: json["totalposition"],
        jobtype: json["jobtype"],
        industrytype: json["industrytype"],
        mineducation: json["mineducation"],
        employertype: json["employertype"],
        expyear: json["expyear"],
        expmonth: json["expmonth"],
        shift: json["shift"],
        salary: json["salary"],
        salarytype: json["salarytype"],
        jobsummary: json["jobsummary"],
        responsibilitesduties: json["responsibilitesduties"],
        expskillcertification: json["expskillcertification"],
        qualification: json["qualification"],
        additionalbenefits: json["additionalbenefits"],
        receivableemail: json["receivableemail"],
        additionalemail1: json["additionalemail1"],
        additionalemail2: json["additionalemail2"],
        additionalemail3: json["additionalemail3"],
        notifyfrequency: json["notifyfrequency"],
        postbyparentcode: json["postbyparentcode"],
        createddatetime: DateTime.parse(json["createddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        status: json["status"],
        radius: json["radius"],
        distance: json["distance"],
    );

    Map<String, dynamic> toJson() => {
        "jobpostid": jobpostid,
        "title": title,
        "company": company,
        "phone": phone,
        "website": website,
        "email": email,
        "location": location,
        "country": country,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "totalposition": totalposition,
        "jobtype": jobtype,
        "industrytype": industrytype,
        "mineducation": mineducation,
        "employertype": employertype,
        "expyear": expyear,
        "expmonth": expmonth,
        "shift": shift,
        "salary": salary,
        "salarytype": salarytype,
        "jobsummary": jobsummary,
        "responsibilitesduties": responsibilitesduties,
        "expskillcertification": expskillcertification,
        "qualification": qualification,
        "additionalbenefits": additionalbenefits,
        "receivableemail": receivableemail,
        "additionalemail1": additionalemail1,
        "additionalemail2": additionalemail2,
        "additionalemail3": additionalemail3,
        "notifyfrequency": notifyfrequency,
        "postbyparentcode": postbyparentcode,
        "createddatetime": createddatetime.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "status": status,
        "radius": radius,
        "distance": distance,
    };
}