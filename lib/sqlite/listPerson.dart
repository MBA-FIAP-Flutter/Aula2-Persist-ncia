import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_2_bd/sqlite/model/person.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoas"),
        actions: <Widget>[
          if (_database != null) IconButton(
            icon: Icon(Icons.add),
            onPressed: (){

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

          },
        ),
      ),
    );
  }

}


