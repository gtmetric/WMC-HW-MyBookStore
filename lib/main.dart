import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyStore(),
        '/book': (context) => BookPage(),
        '/payment': (context) => PaymentPage(),
      },
    ));

List<Book> books;
int totalPrice = 0;
int currentIndex = 0;
List<Book> cart = [];

class Books {
  Books({books});

  Books.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = [];
      json['books'].forEach((v) {
        books.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (books != null) {
      data['book'] = books.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  String title;
  int price;
  String url;

  Book({this.title, this.price, this.url});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['url'] = this.url;
    return data;
  }
}

Future<List<Book>> fetchBooks() async {
  final response = await http.get('http://127.0.0.1:8000/data.json');
  if (response.statusCode == 200) {
    Books.fromJson(jsonDecode(response.body));
    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: FutureBuilder<List<Book>>(
          future: futureBooks,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
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
                              child: Image.network(books[index].url),
                            ),
                            title: Text(books[index].title),
                            subtitle: Text('Price: THB ${books[index].price}'),
                            trailing: Icon(Icons.add),
                            onTap: () {
                              currentIndex = index;
                              Navigator.pushNamed(context, '/book')
                                  .then((value) => setState(() {}));
                            },
                          ),
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                      if (totalPrice > 0)
                        Navigator.pushNamed(context, '/payment')
                            .then((value) => setState(() {}));
                    });
                  },
                ),
                SizedBox(width: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details of ${books[currentIndex].title}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              books[currentIndex].url,
              scale: 0.4,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                books[currentIndex].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Price:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'THB ${books[currentIndex].price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Text(
                'BEST SELLER',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
          ],
        ),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      totalPrice += books[currentIndex].price;
                      cart.add(books[currentIndex]);
                      Navigator.pop(context);
                    });
                  },
                ),
                SizedBox(width: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Books in Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1,
              horizontal: 4,
            ),
            child: Card(
              child: ListTile(
                leading: ClipRRect(
                  child: Image.network(cart[index].url),
                ),
                title: Text(cart[index].title),
                subtitle: Text('Price: THB ${cart[index].price}'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[500],
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      totalPrice = 0;
                      cart = [];
                      Navigator.pop(context);
                    });
                  },
                ),
                SizedBox(width: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
