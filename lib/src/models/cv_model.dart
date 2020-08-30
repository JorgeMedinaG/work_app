import 'dart:convert';

Cv cvFromJson(String str) => Cv.fromJson(json.decode(str));

String cvToJson(Cv data) => json.encode(data.toJson());

Map<String,dynamic> cvToMap(Cv data) => data.toJson();
class Cv {
    Cv({
        this.postcvbasicid,
        this.name,
        this.email,
        this.phone,
        this.designation,
        this.address,
        this.country,
        this.state,
        this.latitude,
        this.longitude,
        this.city,
        this.industry,
        this.totalexp,
        this.lastcompany,
        this.highestedu,
        this.currentctc,
        this.salary,
        this.noticeperiod,
        this.skills,
        this.description,
        this.cvurl,
        this.imgurl,
        this.postcvuser,
        this.createddatetime,
        this.modifieddatetime,
        this.lastcvdatetime,
        this.status,
        this.radius,
        this.distance,
    });

    int postcvbasicid;
    String name;
    String email;
    String phone;
    String designation;
    String address;
    String country;
    String state;
    String latitude;
    String longitude;
    String city;
    String industry;
    String totalexp;
    String lastcompany;
    String highestedu;
    String currentctc;
    int salary;
    String noticeperiod;
    String skills;
    String description;
    dynamic cvurl;
    String imgurl;
    Postcvuser postcvuser;
    DateTime createddatetime;
    dynamic modifieddatetime;
    dynamic lastcvdatetime;
    int status;
    int radius;
    dynamic distance;

    factory Cv.fromJson(Map<String, dynamic> json) => Cv(
        postcvbasicid: json["postcvbasicid"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        designation: json["designation"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        industry: json["industry"],
        totalexp: json["totalexp"],
        lastcompany: json["lastcompany"],
        highestedu: json["highestedu"],
        currentctc: json["currentctc"],
        salary: json["salary"],
        noticeperiod: json["noticeperiod"],
        skills: json["skills"],
        description: json["description"],
        cvurl: json["cvurl"],
        imgurl: json["imgurl"],
        postcvuser: Postcvuser.fromJson(json["postcvuser"]),
        createddatetime: DateTime.parse(json["createddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        lastcvdatetime: json["lastcvdatetime"],
        status: json["status"],
        radius: json["radius"],
        distance: json["distance"],
    );

    Map<String, dynamic> toJson() => {
        "postcvbasicid": postcvbasicid,
        "name": name,
        "email": email,
        "phone": phone,
        "designation": designation,
        "address": address,
        "country": country,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "industry": industry,
        "totalexp": totalexp,
        "lastcompany": lastcompany,
        "highestedu": highestedu,
        "currentctc": currentctc,
        "salary": salary,
        "noticeperiod": noticeperiod,
        "skills": skills,
        "description": description,
        "cvurl": cvurl,
        "imgurl": imgurl,
        "postcvuser": postcvuser.toJson(),
        "createddatetime": createddatetime.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "lastcvdatetime": lastcvdatetime,
        "status": status,
        "radius": radius,
        "distance": distance,
    };
}

class Postcvuser {
    Postcvuser({
        this.userid,
        this.parentcode,
        this.companycode,
        this.company,
        this.username,
        this.email,
        this.phone,
        this.address,
        this.country,
        this.state,
        this.city,
        this.zipcode,
        this.department,
        this.mcnumber,
        this.dotnumber,
        this.designation,
        this.createddatetime,
        this.lastlogin,
        this.modifieddatetime,
        this.img,
        this.status,
        this.team,
        this.availstatus,
        this.shiftstatus,
        this.planid,
        this.emailverify,
        this.phoneverify,
        this.token,
        this.logintype,
        this.roles,
        this.authorities,
        this.accountNonExpired,
        this.accountNonLocked,
        this.credentialsNonExpired,
        this.enabled,
    });

    int userid;
    String parentcode;
    String companycode;
    String company;
    String username;
    String email;
    dynamic phone;
    dynamic address;
    dynamic country;
    dynamic state;
    dynamic city;
    dynamic zipcode;
    dynamic department;
    dynamic mcnumber;
    dynamic dotnumber;
    dynamic designation;
    DateTime createddatetime;
    DateTime lastlogin;
    dynamic modifieddatetime;
    String img;
    int status;
    dynamic team;
    int availstatus;
    int shiftstatus;
    int planid;
    int emailverify;
    int phoneverify;
    String token;
    String logintype;
    List<String> roles;
    List<Authority> authorities;
    bool accountNonExpired;
    bool accountNonLocked;
    bool credentialsNonExpired;
    bool enabled;

    factory Postcvuser.fromJson(Map<String, dynamic> json) => Postcvuser(
        userid: json["userid"],
        parentcode: json["parentcode"],
        companycode: json["companycode"],
        company: json["company"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        zipcode: json["zipcode"],
        department: json["department"],
        mcnumber: json["mcnumber"],
        dotnumber: json["dotnumber"],
        designation: json["designation"],
        createddatetime: DateTime.parse(json["createddatetime"]),
        lastlogin: DateTime.parse(json["lastlogin"]),
        modifieddatetime: json["modifieddatetime"],
        img: json["img"],
        status: json["status"],
        team: json["team"],
        availstatus: json["availstatus"],
        shiftstatus: json["shiftstatus"],
        planid: json["planid"],
        emailverify: json["emailverify"],
        phoneverify: json["phoneverify"],
        token: json["token"],
        logintype: json["logintype"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        authorities: List<Authority>.from(json["authorities"].map((x) => Authority.fromJson(x))),
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "parentcode": parentcode,
        "companycode": companycode,
        "company": company,
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "zipcode": zipcode,
        "department": department,
        "mcnumber": mcnumber,
        "dotnumber": dotnumber,
        "designation": designation,
        "createddatetime": createddatetime.toIso8601String(),
        "lastlogin": lastlogin.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "img": img,
        "status": status,
        "team": team,
        "availstatus": availstatus,
        "shiftstatus": shiftstatus,
        "planid": planid,
        "emailverify": emailverify,
        "phoneverify": phoneverify,
        "token": token,
        "logintype": logintype,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "authorities": List<dynamic>.from(authorities.map((x) => x.toJson())),
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
        "enabled": enabled,
    };
}

class Authority {
    Authority({
        this.authority,
    });

    String authority;

    factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        authority: json["authority"],
    );

    Map<String, dynamic> toJson() => {
        "authority": authority,
    };
}