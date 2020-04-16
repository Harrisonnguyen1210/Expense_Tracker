import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'widgets/transaction_list.dart';
import 'widgets/transaction_input.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

// Force device to have desired orientation:
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(new MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) {
        return TransactionInput(_addNewTransaction);
      },
    );
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    setState(() {
      _transactions.add(
        Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: selectedDate,
        ),
      );
    });
    Navigator.of(context).pop();
  }

  void _deleteTransaction(int transactionIndex) {
    setState(() {
      _transactions.removeAt(transactionIndex);
    });
  }

  void _toggleChart(bool isSwitched) {
    setState(() {
      _showChart = isSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Expense Tracker',
        style: TextStyle(
          fontFamily: 'Quicksand',
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final _transactionListContainer = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.75,
      child: TransactionList(_transactions, _deleteTransaction),
    );
    final List<Widget> portraitTree = [
      Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.25,
        child: Chart(_recentTransactions),
      ),
      _transactionListContainer
    ];
    final List<Widget> landscapeTree = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show chart'),
          Switch(value: _showChart, onChanged: (value) => _toggleChart(value)),
        ],
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.75,
              child: Chart(_recentTransactions),
            )
          : _transactionListContainer
    ];

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_isLandscape) ...landscapeTree else ...portraitTree
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
