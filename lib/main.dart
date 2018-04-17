import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:flux_example/stores.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flux Example',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with StoreWatcherMixin<HomeScreen> {
  CoinStore store;

  @override
  void initState() {
    super.initState();
    store = listenToStore(coinStoreToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flux Crypto Ticker'),
        actions: <Widget>[
          RaisedButton(
            color: Colors.blueGrey,
            onPressed: () {
              loadCoinsAction.call();
            },
            child: Text('Get Coins'),
          )
        ],
      ),
      body: ListView(
          children: store.coins.map((coin) => CoinWidget(coin)).toList()),
    );
  }
}

class CoinWidget extends StatelessWidget {
  CoinWidget(this.coin);
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(width: 5.0),
        ),
        child: Card(
          elevation: 10.0,
          color: Colors.lightBlue,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(coin.name),
                  leading: CircleAvatar(
                    child: Text(
                      coin.symbol,
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    radius: 90.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  subtitle: Text("\$${coin.price.toStringAsFixed(2)}"),
                ),
              )
            ],
          ),
        ));
  }
}
