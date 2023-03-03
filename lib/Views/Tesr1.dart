import 'package:flutter/material.dart';

class Tesr1 extends StatefulWidget {
  const Tesr1({Key? key}) : super(key: key);

  @override
  State<Tesr1> createState() => _Tesr1State();
}

class _Tesr1State extends State<Tesr1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child:  TabBar(tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints.expand(),
                    color: Colors.yellow,
                    child: const Text("Home"),
                  ),
                  icon: Icon(Icons.home),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints.expand(),
                    color: Colors.cyanAccent,
                    child: Text("Articles"),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints.expand(),
                    color: Colors.blue,
                    child: Text("User"),
                  ),
                ),
              ]),
            ),
            const Expanded(
              child: TabBarView(children: [
                Text("Home Body"),
                Text("Articles Body"),
                Text("User Body"),
              ]),
            )
          ],
        ),
      ),
      );
  }
}
