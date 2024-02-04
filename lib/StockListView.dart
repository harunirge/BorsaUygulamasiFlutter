import 'package:borsauyg/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StockListView extends StatefulWidget {
  const StockListView({super.key});

  @override
  State<StockListView> createState() => _StockListViewState();
}

class _StockListViewState extends State<StockListView> {

 ApiService _service = ApiService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(

            future: _service.getAllStocks(),

            builder: (context,  snapshot) {

              if (snapshot.hasError || snapshot.data==null) {
                var resultList = snapshot.data?.result;
                return Flexible(
                  child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                  
                    return Card(child: ListTile(
                  
                      trailing: Column(
                  
                        mainAxisAlignment: MainAxisAlignment.center,
                  
                        children: [
                  
                          Text(resultList![index].name.toString()),
                  
                  
                  
                        ],
                  
                      ),
                  
                  
                  
                  
                  
                    ));
                  
                  },),
                );

              } else if (snapshot.hasError) {

                return Icon(Icons.error_outline);

              } else {

                return Center(child: CircularProgressIndicator());

              }

            })
      ],
    );

  }
}

class StockListWidget extends StatefulWidget {
  const StockListWidget({
    super.key,
    required this.kitaplist,
  });

  final List<Book>? kitaplist;
  @override
  State<StockListWidget> createState() => _StockListWidgetState();
}

class _StockListWidgetState extends State<StockListWidget> {

  bool isFiltering=false;
  List<Book>? filteredList;

  @override
  Widget build(BuildContext context) {
    var fullList = widget.kitaplist;
    return Flexible(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query){
              if(query.isNotEmpty){
                isFiltering=true;

                setState(() {
                  filteredList = fullList?.where((book ) => book.bookName.toLowerCase().contains(query.toLowerCase())).toList();
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateBookView(kontrollerList![index])));
                          },
                        ),
                        SlidableAction(
                          onPressed: (_)async {
                            await Provider.of<BooksViewModel>(context, listen: false)
                                .deleteBook(kontrollerList![index]);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(

                      child: ListTile(
                        //title: Text('harun'),
                        leading: Text(kontrollerList![index].authorName ?? 'harun'),

                      ),
                    ),
                  );



                })),
      ],
    ));
  }}