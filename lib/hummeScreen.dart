import 'package:crypto_app/crypto_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _cryptoData;

  @override
  void initState() {
    super.initState();
    _cryptoData = CryptoService().getCryptoPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crypto Tracker')),
      body: FutureBuilder<List<dynamic>>(
        future: _cryptoData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune donnée disponible'));
          } else {
            List<dynamic> cryptoList = snapshot.data!;
            return ListView.builder(
              itemCount: cryptoList.length,
              itemBuilder: (context, index) {
                var crypto = cryptoList[index];
                return ListTile(
                  leading: Image.network(
                    crypto['image'],
                    scale: 5,
                  ),
                  title: Text(crypto['name']),
                  subtitle: Text('\$${crypto['current_price']}'),
                  trailing: Text('${crypto['price_change_percentage_24h']}%'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
