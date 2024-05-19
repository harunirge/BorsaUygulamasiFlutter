
import 'dart:math';

import 'package:borsauyg/DataBaseService.dart';
import 'package:borsauyg/StockModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({super.key});

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  
var dbService = DataBaseService();

List<Result> resultum = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbService.getStockList();
    dbService.getAllStocks()
  }
  
  
  @override
  Widget build(BuildContext context) {
    var dbService = DataBaseService();
   
  
    
    
    DataBaseService database  = DataBaseService();
    return Scaffold(
      body: Column(children: [
        Flexible(
          child: StreamBuilder(
            stream: database.getStockList(),
            builder: (context,snapshot){
              if (!snapshot.hasData){
                return Center(child: Column(children: [CircularProgressIndicator(),Text('Lütfen Bekleyiniz')]),);
              }else{
                List<Result>? resultList = snapshot.data;
                var lastList = dbService.takeFavoriteListAndReturn(resultList!);
               
                return ListView.builder(
                itemCount: resultList?.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title:Text( resultList![index].price.toString()),
                  ); 
                }
                );
              
              }
             
              
            } ),
        ) 

      ]),
      floatingActionButton: FloatingActionButton(
        
        child: Text('Hisse Ekle'),
        
        onPressed: () {
        
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
