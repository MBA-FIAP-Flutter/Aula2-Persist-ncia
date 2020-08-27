import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_2_bd/sqlite/model/person.dart';

class ListPerson extends StatelessWidget {

  List<Person> personsList = List<Person>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoas"),
        actions: <Widget>[
          IconButton(
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
