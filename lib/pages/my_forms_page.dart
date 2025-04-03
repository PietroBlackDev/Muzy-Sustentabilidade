import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tg/pages/my_screen_page.dart';

class MyFormsPage extends StatefulWidget {
  MyFormsPage();

  @override
  State<MyFormsPage> createState() => _MyFormsPageState();
}

class _MyFormsPageState extends State<MyFormsPage> {
  String dataAgora = DateFormat.yMMMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Questionario diário',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Data:',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Quantidade de comida produzida:',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 23),
              Text('Refeições', style: TextStyle(fontSize: 24)),
              Text(
                'Quantidade de comida desperdiçada por refeições',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Café da manhã:',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Almoço:',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Café da tarde:',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Jantar:',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 28),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Text(
                      "ENVIAR",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
