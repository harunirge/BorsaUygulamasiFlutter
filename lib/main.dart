
import 'package:borsauyg/FavoriteListView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'StockListView.dart';
import 'firebase_options.dart';
Future main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
); runApp(MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borsa API',
      home: FavoriteListView(),
    );
  }
}


/*
FutureBuilder(



stream: _service.getAllStocks(),

builder: (context,  snapshot) {

if (snapshot.hasData) {

return ListView.builder(itemBuilder: (BuildContext context, int index) {

return Card(child: ListTile(

trailing: Column(

mainAxisAlignment: MainAxisAlignment.center,

children: [

Text(snapshot.data!.result![index].time.toString()),

Text('Güncellenme Saati'),

],

),

leading:  Text(snapshot.data!.result![index].price.toString()),

title: Text(snapshot.data!.result![index].name.toString(),style: TextStyle(color: Colors.red),),

));

},);

} else if (snapshot.hasError) {

return Icon(Icons.error_outline);

} else {

return Center(child: CircularProgressIndicator());

}

})

*/




/*

API SERVICE'İ METODU

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

yield resBody;

}else{

print('hata');

}*/
