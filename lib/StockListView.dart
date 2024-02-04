import 'package:borsauyg/ApiService.dart';
import 'package:borsauyg/StockModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StockListView extends StatefulWidget {
  const StockListView({super.key});

  @override
  State<StockListView> createState() => _StockListViewState();
}

class _StockListViewState extends State<StockListView> {

 ApiService _service = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Flexible(
           child: FutureBuilder(
            future: _service.getAllStocks(),
            builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                          child:
                              Text('Bir Hata Oluştu, daha sonra tekrar deneyiniz'));
                    } else {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        List<Result>? hisselist = snapshot.data!.result;
                        return ListView.builder(
                          itemCount: hisselist?.length,
                          itemBuilder: (context,index){
                          return ListTile(
                            trailing: Text(hisselist![index].price.toString()),
                          );
                 
                          }
                        );
                      }
                    }
                  },
                 
           ),
         )
        ],
      ),
    );

  }
}

class StockListWidget extends StatefulWidget {
  const StockListWidget({
    super.key,
    required this.hisselist,
  });

  final List<Result>? hisselist;
  @override
  State<StockListWidget> createState() => _StockListWidgetState();
}

class _StockListWidgetState extends State<StockListWidget> {

  bool isFiltering=false;
  List<Result>? filteredList;

  @override
  Widget build(BuildContext context) {
    var fullList = widget.hisselist;
    return Flexible(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query){
              if(query.isNotEmpty){
                isFiltering=true;

                setState(() {
                  filteredList = fullList?.where((book ) => book.name!.toLowerCase().contains(query.toLowerCase())).toList();
                });

              }
              else{
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                setState(() {
                  isFiltering =false;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

            ),),
        ),
        Flexible(
            child: ListView.builder(
                itemCount: isFiltering? filteredList?.length : fullList?.length,
                itemBuilder: (context, index) {

                  var kontrollerList= isFiltering ? filteredList : fullList;

                  
                    child: Card(

                      child: ListTile(
                        //title: Text('harun'),
                        leading: Text(fullList![index].name ?? 'harun'),

                      ),
                    
                  );



                })),
      ],
    ));
  }}