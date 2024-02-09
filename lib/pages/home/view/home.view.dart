import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home/provider/home.provider.dart';
import 'package:weather_app/pages/settings/provider/theme.provider.dart';
import 'package:weather_app/pages/settings/view/setting.view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeProvider>().getcurrentLocation();
    super.initState();
  }

  final placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
              top: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.loading == false) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd, MMM yyyy')
                                    .format(DateTime.now()),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.place_rounded,
                                    size: 25,
                                  ),
                                  Text(
                                    provider.city,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()));
                            },
                            icon: const Icon(Icons.settings, size: 30),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/world.png',
                            color: context.watch<ThemeProvider>().isDark
                                ? Colors.grey.shade700
                                : null,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 100),
                                Text(
                                  "${provider.currentWeather!.main!.temp!.floor() - 273}°",
                                  style: const TextStyle(
                                    fontSize: 90,
                                  ),
                                ),
                                Text(
                                  provider.currentWeather!.weather!.first.main
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Feel Like ${provider.currentWeather!.main!.feelsLike!.floor() - 273}°C',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Wind Speed ${(provider.currentWeather!.wind!.speed!.toInt() * (5 / 18)).toStringAsFixed(2)} km/hr',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DetailWidget(
                                title: 'Min Temp',
                                value:
                                    '${provider.currentWeather!.main!.tempMin!.floor() - 273}°C',
                              ),
                              const SizedBox(width: 30),
                              DetailWidget(
                                title: 'Max Temp',
                                value:
                                    '${provider.currentWeather!.main!.tempMax!.floor() - 273}°C',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          DetailWidget(
                              title: 'Humidity',
                              value:
                                  '${provider.currentWeather!.main!.humidity!.floor()}%'),
                          const SizedBox(height: 20),
                          DetailWidget(
                              title: 'Visibility',
                              value:
                                  '${provider.currentWeather!.visibility!.floor() / 1000} km'),
                        ],
                      ),
                      const SizedBox(height: 80),
                      TextField(
                        controller: placeController,
                        onSubmitted: (value) {
                          context
                              .read<HomeProvider>()
                              .getWeatherUsingCity(value);
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  if (placeController.text.trim().isNotEmpty) {
                                    context
                                        .read<HomeProvider>()
                                        .getWeatherUsingCity(
                                            placeController.text.trim());
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                child: const Icon(Icons.send)),
                            hintText: 'Search your place',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
