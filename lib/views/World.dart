import 'package:flutter/material.dart';
import 'package:flutter_covid/services/api_url.dart';
import 'package:flutter_covid/views/countries_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({super.key});

  @override
  State<WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..forward();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Color> list = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    ApiProvider provider = ApiProvider();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: provider.fetch(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitFadingCircle(
                  color: const Color.fromARGB(255, 167, 77, 77),
                  size: 50,
                  controller: controller,
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: PieChart(
                          dataMap: {
                            'total':
                                double.parse(snapshot.data!.cases.toString()),
                            'recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'death':
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          animationDuration: const Duration(microseconds: 100),
                          chartType: ChartType.ring,
                          colorList: list,
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.grey,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Resue(
                              name: 'Cases',
                              value: snapshot.data!.cases!.toString(),
                            ),
                            Resue(
                                name: 'Updated',
                                value: snapshot.data!.updated!.toString()),
                            Resue(
                                name: 'TodayCase',
                                value: snapshot.data!.todayCases!.toString()),
                            Resue(
                                name: 'Active',
                                value: snapshot.data!.active!.toString()),
                            Resue(
                                name: 'Critical',
                                value: snapshot.data!.critical!.toString()),
                            Resue(
                                name: 'TodayDeaths',
                                value: snapshot.data!.todayDeaths!.toString()),
                            Resue(
                                name: 'TodayRecovered',
                                value:
                                    snapshot.data!.todayRecovered!.toString()),
                            Resue(
                                name: 'CasesPerOneMillion',
                                value: snapshot.data!.casesPerOneMillion!
                                    .toString()),
                            Resue(
                                name: 'DeathsPerOneMillion',
                                value: snapshot.data!.deathsPerOneMillion!
                                    .toString()),
                            Resue(
                                name: 'Tests',
                                value: snapshot.data!.tests!.toString()),
                            Resue(
                                name: 'TestsPerOneMillion',
                                value: snapshot.data!.testsPerOneMillion!
                                    .toString()),
                            Resue(
                                name: 'Population',
                                value: snapshot.data!.population!.toString()),
                            Resue(
                                name: 'oneCasePerPeople',
                                value: snapshot.data!.oneCasePerPeople!
                                    .toString()),
                            Resue(
                                name: 'OneDeathPerPeople',
                                value: snapshot.data!.oneDeathPerPeople!
                                    .toString()),
                            Resue(
                                name: 'OneTestPerPeople',
                                value: snapshot.data!.oneTestPerPeople!
                                    .toString()),
                            Resue(
                                name: 'ActivePerOneMillion',
                                value: snapshot.data!.activePerOneMillion!
                                    .toString()),
                            Resue(
                                name: 'RecoveredPerOneMillion',
                                value: snapshot.data!.recoveredPerOneMillion!
                                    .toString()),
                            Resue(
                                name: 'CriticalPerOneMillion',
                                value: snapshot.data!.criticalPerOneMillion!
                                    .toString()),
                            Resue(
                                name: 'AffectedCountries',
                                value: snapshot.data!.affectedCountries!
                                    .toString()),
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CountriesData(),
                              ));
                            },
                            child: const Text('Countries')),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Resue extends StatelessWidget {
  Resue({super.key, required this.name, required this.value});
  String name;
  String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(name), Text(value)],
          ),
        ),
      ],
    );
  }
}
