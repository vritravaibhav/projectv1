// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

List<Data> dataFromJson(String str) => List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
    Data({
       required this.users,
    });

    List<User> users;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class User {
    User({
       required this.name,
       required this.id,
       this.atype,
    });

    String name;
    String id;
    Atype? atype;

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        atype: atypeValues.map[json["atype"]],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "atype": atypeValues.reverse[atype],
    };
}

enum Atype { PERMANENT, TEMPROARY }

final atypeValues = EnumValues({
    "Permanent": Atype.PERMANENT,
    "Temproary": Atype.TEMPROARY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
