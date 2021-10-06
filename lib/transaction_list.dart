import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'Play Pubg!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Image.asset('assets/images/pngfind.com-mobile-png-1735603.png'),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            '\u{20B9} ${userTransactions[index].amount.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransactions[index].title,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(userTransactions[index].date),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          deleteTransaction(userTransactions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
                // return Card(
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         Container(
                //           child: Center(
                //             child: Text(
                //               '\u{20B9} ${userTransactions[index].amount}',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                   fontSize: 25,
                //                   fontWeight: FontWeight.bold,
                //                   color: Theme.of(context).shadowColor),
                //             ),
                //           ),
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: Theme.of(context).primaryColorLight,
                //                 style: BorderStyle.solid,
                //                 width: 2),
                //           ),
                //           margin: EdgeInsets.all(20),
                //           padding: EdgeInsets.all(10),
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               userTransactions[index].title,
                //               style: TextStyle(
                //                   fontSize: 22,
                //                   fontWeight: FontWeight.bold,
                //                   color: Theme.of(context).primaryColorDark),
                //             ),
                // Text(
                //   DateFormat.yMMMMd()
                //       .format(userTransactions[index].date),
                //   style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Theme.of(context).primaryColorLight),
                // ),
                //           ],
                //         ),
                //       ]),
                // );
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
