import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_app/core/data/end_points.dart';
import 'package:todo_app/core/data/graphql_strings.dart';
import 'package:todo_app/core/data/model/add_todo_model.dart';
import 'package:todo_app/core/data/model/todo_model.dart';

class TodoApi {
  final GraphQLClient _qlClient = GraphQLClient(
    link: EndpointLinks.link,
    cache: GraphQLCache(store: HiveStore()),
  );
  Future<List<Todo>> fetchAllTodos() async {
    QueryResult queryResult = await _qlClient.query(QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(RootQueries.allTodos),
    ));

    return (queryResult.data!['todos'] as List)
        .map((todo) => Todo(todo['id'], todo['title'], todo['completed']))
        .toList();
  }

  Future<void> addTodo(TodoToBeAdded todo) async {
    QueryResult queryResult = await _qlClient.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(RootQueries.createTodo),
        variables: {'title': todo.title}));

    if (queryResult.hasException) {
      print(queryResult.exception.toString());
    }
  }

  Future<bool> isCompleted(Todo todo) async {
    QueryResult queryResult = await _qlClient.mutate(
        MutationOptions(document: gql(RootQueries.updatedTodo), variables: {
      'id': todo.id,
      'title': todo.title,
      'completed': todo.completed,
    }));

    if (queryResult.hasException) {
      return false;
    }
    return true;
  }

  Future<bool> deleteTodo(id) async {
    QueryResult queryResult = await _qlClient.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(RootQueries.deleteTodo),
        variables: {'id': id}));

        if(queryResult.hasException){
          return false;
        }
        return true;
        
  }
}
