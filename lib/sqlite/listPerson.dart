import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_2_bd/sqlite/model/person.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'addPerson.dart';

class ListPerson extends StatefulWidget {
  @override
  _ListPersonState createState() => _ListPersonState();
}

//StatelessWidget ou State pra ter acesso a função build
class _ListPersonState extends State<ListPerson> {

  Database _database;
  List<Person> personsList = List<Person>();

  //ele faz parte do ciclo de vida do state - StatefulWidget
  @override
  void initState() {
    super.initState();

    //como o ciclo de todo State começa no initState
    //é neste ponto que nós camos abrir a conexão com o banco de dados
    getDatabase();
  }

  getDatabase() async {
    //SQLITE - usando o mais crú possível
    //Floor - Room
    openDatabase(
        join(await getDatabasesPath(), 'person_database.db'),
        onCreate: (db, version)
        {
          return db.execute(
            "CREATE TABLE person(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT)",
          );
        },
        version: 1
    ).then((db) {
      setState(() {
        _database = db;
      });

      readAll();
    });
  }

  readAll() async {
    //quando encontramos a palavra reservada await, estamos em uma função
    //assíncrona
    //sempre que uma linha usa await, a sua função pai precisa ter o async
    final List<Map<String, dynamic>> maps = await _database.query('person');

    personsList = List.generate(maps.length, (i) {
      return Person(
        id: maps[i]['id'],
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
      );
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoas"),
        actions: <Widget>[
          if (_database != null) IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPerson()
                )
              ).then((newPerson) {
                if (newPerson != null){
                  insertPerson(newPerson);
                }
              });
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: personsList.length,
        itemBuilder: (context, index) => buildListItem(index),
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
      ),
    );
  }

  Widget buildListItem(int index){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        //BoxDecoration insere os cantos arredondados
        //Usando BoxDecoration vc pode estilizar com bem entender
        //ex: fundo degradee
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          leading: Text("${personsList[index].id}"),
          title: Text(personsList[index].firstName),
          subtitle: Text(personsList[index].lastName),
          onLongPress: (){
            deletePerson(index);
          },
        ),
      ),
    );
  }

  insertPerson(Person person) {
    _database.insert(
      'person',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ).then((value) {
      person.id = value;
      setState(() {
        personsList.add(person);
      });
    });
  }

  deletePerson(int index) {
    _database.delete(
      'person',//table
      where: "id = ?", //where "id = ?" - sql injection - hacker/crackers usam para zoar bancos
      whereArgs: [personsList[index].id],//argumentos do where
    ).then((value) {
      setState(() {
        personsList.removeAt(index);
      });
    });
  }

}


