
class RootQueries{
  static String allTodos="""
    query {
      todos {
        id
        title
        completed
      }
    }
""";

static String filterTodo="""
  query(\$completed:Boolean, \$search:String){
    todos(completed:\$completed, search:\$serach){
        id
        title
        completed
    }
  }
""";

static String createTodo="""
  mutation(\$title:String!){
    createTodo(title:\$title){
      todo{
        id
        title
        completed
      }
    }
  }
""";

static String updatedTodo="""
  mutation(\$id:ID!, \$title:String!, \$completed:Boolean){
    updateTodo(id:\$id, title:\$title, completed:\$completed){
      todo{
        id
        title
        completed
      }
    }
  }
""";


static String deleteTodo="""
  mutation(\$id:ID!){
    deleteTodo(id:\$id){
      success
    }
  }
""";

}