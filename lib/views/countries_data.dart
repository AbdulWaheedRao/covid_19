import 'package:flutter/material.dart';
import 'package:flutter_covid/model/country_model.dart';
import 'package:flutter_covid/services/api_url.dart';

class CountriesData extends StatefulWidget {
  const CountriesData({super.key});

  @override
  State<CountriesData> createState() => _CountriesDataState();
}

class _CountriesDataState extends State<CountriesData> {
  // TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ApiProvider countryProvider = ApiProvider();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FutureBuilder(
        future: countryProvider.fetchCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CountryModel model = snapshot.data![index];
                return Column(
                  children: [
                    Image.network(model.countryInfo!.flag.toString()),
                    Text(model.countryInfo!.lat.toString()),
                    Text(model.countryInfo!.long.toString()),
                    Text(model.countryInfo!.iso2.toString()),
                    Text(model.countryInfo!.iso3.toString())
                  ],
                );
              },
            );
          } else {
            return const Text('Something went Wrong');
          }
        },
      )),
    );
  }
}
