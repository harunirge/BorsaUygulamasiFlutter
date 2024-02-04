import 'dart:convert';
import 'package:http/http.dart' as http;
import 'StockModel.dart';

class ApiService{


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

    }}}













