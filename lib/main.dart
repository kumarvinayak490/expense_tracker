import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/new_transaction.dart';
import 'package:flutter_complete_guide/transaction_list.dart';
import './transaction.dart';
import './chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.deepPurple),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   amount: 1500,
    //   date: DateTime.now(),
    //   title: 'New Shoes',
    // ),
    // Transaction(
    //   id: 't2',
    //   amount: 3000,
    //   date: DateTime.now(),
    //   title: 'Lended to Neeshu',
    // ),
  ];

  List<Transaction> get recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewtx(String txtitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        amount: txAmount,
        title: txtitle,
        date: selectedDate,
        id: DateTime.now().toString());

    setState(() {
      transactions.add(newTx);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(addNewtx),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => startNewTransaction(context),
              icon: Icon(Icons.add))
        ],
        title: Text('Flutter App'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Chart(recentTransaction),
          TransactionList(transactions, deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
