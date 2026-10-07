class EventModel {
  final String id;
  String name;
  String date;
  String time;
  String location;
  String description;

  EventModel({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'time': time,
      'location': location,
      'description': description,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

class StudentAccount {
  final String name;
  final String studentClass;
  final String username;
  final String password;

  StudentAccount({
    required this.name,
    required this.studentClass,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'class': studentClass,
      'username': username,
      'password': password,
    };
  }

  factory StudentAccount.fromMap(Map<String, dynamic> map) {
    return StudentAccount(
      name: map['name'] ?? '',
      studentClass: map['class'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}

class Participant {
  final String name;
  final String studentClass;
  final String username;

  Participant({
    required this.name,
    required this.studentClass,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'class': studentClass,
      'username': username,
    };
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      name: map['name'] ?? '',
      studentClass: map['class'] ?? '',
      username: map['username'] ?? '',
    );
  }
}
