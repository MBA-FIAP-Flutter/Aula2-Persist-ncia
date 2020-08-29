import 'package:floor/floor.dart';

//annotation entity indica pro flutter a presença de uma entidade
@entity
class Book {
  @PrimaryKey(autoGenerate: true)
  int id;

  final String name;
  final String author;

  //construtor com parâmetros opcionais (uso das chaves)
  Book({this.id, this.name, this.author});
}