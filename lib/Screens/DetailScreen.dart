import 'package:covidtracker/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatefulWidget {
  String country_name, image, continent;
  int cases, todayCases, deaths, todayDeaths, recovered, critical;
  DetailScreen({
    super.key,
    required this.country_name,
    required this.image,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.critical,
    required this.continent,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country_name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: MediaQuery.of(context).size.height * 0.10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        ReuableRow(
                          title: "Cases",
                          value: widget.cases.toString(),
                        ),
                        ReuableRow(
                          title: "Today Cases",
                          value: widget.todayCases.toString(),
                        ),
                        ReuableRow(
                          title: "Deaths",
                          value: widget.deaths.toString(),
                        ),
                        ReuableRow(
                          title: "today Deaths",
                          value: widget.todayDeaths.toString(),
                        ),
                        ReuableRow(
                          title: "Recovered",
                          value: widget.recovered.toString(),
                        ),
                        ReuableRow(
                          title: "Critical",
                          value: widget.critical.toString(),
                        ),
                        ReuableRow(
                          title: "Continent",
                          value: widget.continent.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.fill,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
