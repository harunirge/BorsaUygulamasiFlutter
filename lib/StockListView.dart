import 'package:borsauyg/ApiService.dart';
import 'package:borsauyg/StockModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    
    return SafeArea(
      child: Scaffold(
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
                          return HisselistViewWidget(hisselist: hisselist);
                        }
                      }
                    },
                   
             ),
           )
          ],
        ),
      ),
    );

  }
}

class HisselistViewWidget extends StatefulWidget {
  const HisselistViewWidget({
    super.key,
    required this.hisselist,
  });

  final List<Result>? hisselist;
  @override
  State<HisselistViewWidget> createState() => _HisselistViewWidgetState();
}

class _HisselistViewWidgetState extends State<HisselistViewWidget> {
FirebaseFirestore database = FirebaseFirestore.instance;
    
  bool isFiltering=false;
  List<Result>? filteredList;
  List<Result>? favoriteList;
  

  @override
  Widget build(BuildContext context) {
    final CollectionReference favoriteListRef = database.collection('favoritelist');
    Map<String,dynamic> eklenecekHisse = {'ad':'harun','soyad':'irge'};
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
              hintText: 'Hisse Adı Yazınız.',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

          ),),
        ),
        Flexible(
            child: ListView.builder(
                itemCount: isFiltering? filteredList?.length : fullList?.length,
                itemBuilder: (context, index) {

                  var kontrollerList= isFiltering ? filteredList : fullList;

                  return Slidable(
                    endActionPane:  ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                          onPressed: (_) {
                            
                          },
                        ),
                        SlidableAction(
                          onPressed: (_){},
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      color: (index % 2 == 0) ? Colors.grey.shade300 : Colors.grey.shade200,
                      child: ListTile(
                        
                        //title: Text('harun'),
                        leading: Text(kontrollerList![index].name.toString()),
                        trailing:Text(kontrollerList[index].price.toString()),
                        onTap: () {
                          favoriteListRef.doc(kontrollerList[index].name).set(kontrollerList[index].toJson());
                        },

                      ),
                    ),
                  );

                  /*Dismissible(
                      key: UniqueKey(),
                      onDismissed: (_) async {
                        await Provider.of<BooksViewModel>(context, listen: false)
                            .deleteBook(kitaplist[index]);
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        color: Colors.redAccent,
                      ),
                      child: Card(
                        child: ListTile(
                          //title: Text('harun'),
                          leading: Text(kitaplist![index].authorName ?? 'harun'),
                          trailing: IconButton(icon: Icon(Icons.edit) , onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateBookView(kitaplist[index])));

                          },),
                        ),
                      ))*/
                  
                })),
      ],
    ));
  }}