import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyStore(),
        '/book': (context) => BookPage(),
        '/payment': (context) => PaymentPage(),
      },
    ));

class Book {
  String url;
  String title;
  int price;

  Book({this.title, this.price, this.url});
}

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
int currentIndex = 0;
List<Book> cart = [];

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
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
                  currentIndex = index;
                  Navigator.pushNamed(context, '/book')
                      .then((value) => setState(() {}));
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
            Image.asset(
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
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100.0,
                // vertical: 10,
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
                      // Navigator.of(context).pushNamed('/').then((value) => setState(() {}));
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
                  child: Image.asset(cart[index].url),
                ),
                title: Text(cart[index].title),
                subtitle: Text('Price: THB ${cart[index].price}'),
                // trailing: Icon(Icons.add),
                // onTap: () {
                //   currentIndex = index;
                //   Navigator.pushNamed(context, '/book').then((value) => setState(() {}));
                // },
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
