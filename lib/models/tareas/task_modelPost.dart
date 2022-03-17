import 'dart:convert';


TaskModelPost taskModelFromJson(String str) => TaskModelPost.fromJson(json.decode(str));

String taskModelToJson(TaskModelPost data) => json.encode(data.toJson());

class TaskModelPost {
    TaskModelPost({
        this.name='',
        this.description='',
    });

    String name;
    String description;

    factory TaskModelPost.fromJson(Map<String, dynamic> json) => TaskModelPost(
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
    };
}
