class Todo{
  final String? id;
  final String? title;
  final bool? completed;

  Todo(this.id, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(json['id'], json['title'], json['completed']);
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'completed':completed
    };
  }
}