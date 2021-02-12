import 'package:flutter/material.dart';

class Book {
  String url;
  String title;
  int price;

  Book({this.title, this.price, this.url});
}

void main() => runApp(MyStore());

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  List<Book> books = [
    Book(
      title: 'KENNEDY CURSE',
      price: 446,
      url: 'assets/books/1.jpg',
    ),
    Book(
      title: 'TOM CLANCY\'S ENEMY CONTACT',
      price: 206,
      url: 'assets/books/2.jpg',
    ),
    Book(
      title: 'HOW WE LEARN',
      price: 712,
      url: 'assets/books/3.jpg',
    ),
    Book(
      title: 'LONELY PLANET',
      price: 487,
      url: 'assets/books/4.jpg',
    ),
    Book(
      title: 'UNFREE SPEECH',
      price: 296,
      url: 'assets/books/5.jpg',
    ),
    Book(
      title: 'ROSE PETAL SUMMER',
      price: 243,
      url: 'assets/books/6.jpg',
    ),
    Book(
      title: 'INTANGIBLES',
      price: 393,
      url: 'assets/books/7.jpg',
    ),
    Book(
      title: 'MONOCLE BOOK OF JAPAN',
      price: 1162,
      url: 'assets/books/8.jpg',
    ),
    Book(
      title: 'CARI MORA',
      price: 236,
      url: 'assets/books/9.jpg',
    ),
    Book(
      title: 'HOW TO WIN',
      price: 363,
      url: 'assets/books/10.jpg',
    ),
  ];

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Book Store',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 4,
              ),
              child: Card(
                child: ListTile(
                  leading: ClipRRect(
                    child: Image.asset(books[index].url),
                  ),
                  title: Text(books[index].title),
                  subtitle: Text('Price: THB ${books[index].price}'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      totalPrice += books[index].price;
                      print('Total Price: $totalPrice');
                    });
                  },
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 80,
          // color: Colors.blue[900],
          decoration: BoxDecoration(
            color: Colors.blue[900],
            boxShadow: [
              BoxShadow(color: Colors.grey),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'THB $totalPrice',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  RaisedButton(
                    color: Colors.blue[800],
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Check Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        totalPrice = 0;
                        print('Checked Out!\nTotal Price: $totalPrice');
                      });
                    },
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
