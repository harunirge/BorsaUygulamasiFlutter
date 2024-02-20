import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'StockModel.dart';

class DataBaseService{

  FirebaseFirestore _database = FirebaseFirestore.instance;



  


  Future<LiveStockModel?> getAllStocks()async{
    final response = await http.get(

        Uri.parse('https://api.collectapi.com/economy/liveBorsa'),

        headers: {

          'authorization' : 'apikey 69YLfupH6pvWQMD7r1uO2n:5jZyOC1Un8OpWa16HWypA4',

          'content-type': 'application/json'

        }

    );

    if(response.statusCode==200){

      var resBody = LiveStockModel.fromJson(json.decode(response.body));

      return resBody;

    }else{

      print('hata');

    }
    }

Future<List<Result>?> takeFavoriteListAndReturn(List<Result> x )async{
    final response = await http.get(

        Uri.parse('https://api.collectapi.com/economy/liveBorsa'),

        headers: {

          'authorization' : 'apikey 69YLfupH6pvWQMD7r1uO2n:5jZyOC1Un8OpWa16HWypA4',

          'content-type': 'application/json'

        }

    );

    if(response.statusCode==200){

    var resBody = LiveStockModel.fromJson(json.decode(response.body));
    List<Result> favList = []; 

    for(int i = 0; i==x.length; i++){
      for(int y=0; y==resBody.result!.length ; y++ ){
       if(resBody.result![y].name == x[i].name ){
        favList.add(resBody.result![y]);
       } 
      }
    }
     


   


     

    }else{

      print('hata');

    }
    }




    }

    













