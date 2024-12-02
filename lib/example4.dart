import 'package:flutter/material.dart';

class Example4 extends StatelessWidget {
  const Example4({super.key});

  final List<Map<String, dynamic>> people = const [
    {
      'name': 'Usman',
      'age': 23,
      'emoji': '🙋🏻‍♂️',
    },
    {
      'name': 'Ali',
      'age': 20,
      'emoji': '👸🏽',
    },
    {
      'name': 'Amir',
      'age': 22,
      'emoji': '🧔🏿‍♂️',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('People'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.grey,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(person: person)));
                },
                leading: Hero(
                    tag: person['name'],
                    child: Text(
                      person['emoji'],
                      style: const TextStyle(fontSize: 40),
                    )),
                title: Text(
                  person['name'],
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  '${person['age'].toString()} Years Old',
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final dynamic person;
  const DetailsScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
            flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext) {
              switch(flightDirection){
                case HeroFlightDirection.push:
                 return Material(
                     color: Colors.transparent,
                     
                     child: ScaleTransition(
                         scale: animation.drive(
                           Tween<double>(
                             begin: 0.0,
                             end: 1.0,
                           ).chain(CurveTween(curve: Curves.fastOutSlowIn))
                         ),
                         child: toHeroContext.widget));
                case HeroFlightDirection.pop:
                  return Material(
                      color: Colors.transparent,
                      child: fromHeroContext.widget);
              }
            },
            tag: person['name'],
            child: Text(
              person['emoji'],
              style: const TextStyle(fontSize: 40),
            )),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              person['name'],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${person['age'].toString()} Years Old',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
