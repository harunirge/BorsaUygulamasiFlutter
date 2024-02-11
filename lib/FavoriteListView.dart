
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({super.key});

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  
  FirebaseFirestore database = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    var favoriteListRef = database.collection('favoritelist');
    return Scaffold(
      body: Column(children: [
        Flexible(
          child: FutureBuilder(
            future: favoriteListRef.get(), 
            builder: (context,snapshot){
              if (snapshot.hasData){
                var abc = snapshot.data?.docs;
             
              return ListView.builder(
                itemCount: abc?.length,
                itemBuilder: (context,index){
                  return ListTile(
                    trailing: Text(abc![index].data()['currency'].toString()),
                  ); 
                }
                );
              }
              else {
                return CircularProgressIndicator();
              }
              
            } ),
        ) 

      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },),
    );
  }
}

/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();
  List<Result?> resultum = [];
  String? from = 'USD';
  String? to = 'TRY';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borsa Uygulaması'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black26,
            height: MediaQuery.of(context).size.height*0.10,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                    items: [
                      DropdownMenuItem(child: Text('USD'),value: 'USD',),
                      DropdownMenuItem(child: Text('TRY'),value: 'TRY',),
                      DropdownMenuItem(child: Text('EUR'),value: 'EUR',)
                    ],
                    value: from,
                    onChanged: (String? yeni) { setState(() {
                      from=yeni;
                    }); }),
                Expanded(child: TextField()),
                SizedBox(width: 50,),
                DropdownButton<String>(
                    items: [
                      DropdownMenuItem(child: Text('USD'),value: 'USD',),
                      DropdownMenuItem(child: Text('TRY'),value: 'TRY',),
                      DropdownMenuItem(child: Text('EUR'),value: 'EUR',)
                    ],
                    value: to,
                    onChanged: (String? yeni){
                      setState(() {
                        to=yeni;
                      });
                    }),
                Expanded(child: TextField()),
              ],
            ),
          ),
          Flexible(child: ListView.builder(
            itemCount: resultum.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(resultum.length.toString()));
            },))

        ],
      ),
    );
  }
}
*/
