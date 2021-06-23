// This class is used to create an object out of a single round
// from a json file. This helps with accessing the data stored there
// and converting round data back to json format.
//
class SingleRound {
  String course;
  String layout;
  int par;
  String date;
  int startTime;
  int endTime;
  int throwsTotal;
  List<Putts> putts;
  List<Holes> holes;

  SingleRound(
      {this.course,
      this.layout,
      this.par,
      this.date,
      this.startTime,
      this.endTime,
      this.throwsTotal,
      this.putts,
      this.holes});

  SingleRound.fromJson(Map<String, dynamic> json) {
    course = json['course'];
    layout = json['layout'];
    par = json['par'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    throwsTotal = json['throwsTotal'];
    if (json['putts'] != null) {
      putts = [];
      json['putts'].forEach((v) {
        putts.add(new Putts.fromJson(v));
      });
    }
    if (json['holes'] != null) {
      holes = [];
      json['holes'].forEach((v) {
        holes.add(new Holes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course'] = this.course;
    data['layout'] = this.layout;
    data['par'] = this.par;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['throwsTotal'] = this.throwsTotal;
    if (this.putts != null) {
      data['putts'] = this.putts.map((v) => v.toJson()).toList();
    }
    if (this.holes != null) {
      data['holes'] = this.holes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Putts {
  String ring;
  int made;
  int missed;

  Putts({this.ring, this.made, this.missed});

  Putts.fromJson(Map<String, dynamic> json) {
    ring = json['ring'];
    made = json['made'];
    missed = json['missed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ring'] = this.ring;
    data['made'] = this.made;
    data['missed'] = this.missed;
    return data;
  }
}

class Holes {
  int holeNumber;
  int holePar;
  List<Throws> throws;

  Holes({this.holeNumber, this.holePar, this.throws});

  Holes.fromJson(Map<String, dynamic> json) {
    holeNumber = json['holeNumber'];
    holePar = json['holePar'];
    if (json['throws'] != null) {
      throws = [];
      json['throws'].forEach((v) {
        throws.add(new Throws.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holeNumber'] = this.holeNumber;
    data['holePar'] = this.holePar;
    if (this.throws != null) {
      data['throws'] = this.throws.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Throws {
  int throwNumber;
  String type;
  String style;
  String evaluation;
  bool wentIn;
  String ring;

  Throws(
      {this.throwNumber,
      this.type,
      this.style,
      this.evaluation,
      this.wentIn,
      this.ring});

  Throws.fromJson(Map<String, dynamic> json) {
    throwNumber = json['throwNumber'];
    type = json['type'];
    style = json['style'];
    evaluation = json['evaluation'];
    wentIn = json['wentIn'];
    ring = json['ring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['throwNumber'] = this.throwNumber;
    data['type'] = this.type;
    data['style'] = this.style;
    data['evaluation'] = this.evaluation;
    data['wentIn'] = this.wentIn;
    data['ring'] = this.ring;
    return data;
  }
}
