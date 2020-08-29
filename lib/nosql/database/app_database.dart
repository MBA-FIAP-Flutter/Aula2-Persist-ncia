import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_fiap_aula_2_bd/nosql/dao/book_dao.dart';
import 'package:flutter_fiap_aula_2_bd/nosql/model/book.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Book])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
}