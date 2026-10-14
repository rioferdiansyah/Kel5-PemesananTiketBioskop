import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int selectedDate = 1;
  int selectedTime = 1;

  final dates = [
    {'day': '24', 'name': 'HARI INI'},
    {'day': '25', 'name': 'SABTU'},
    {'day': '26', 'name': 'MINGGU'},
    {'day': '27', 'name': 'SENIN'},
    {'day': '28', 'name': 'SELASA'},
  ];

  final times = ['13:00', '16:15', '19:30', '22:15'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xff22030D),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    const SizedBox(width: 10),
                    const Text(
                      "Movie Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                  ],
                ),
              ),

              // POSTER
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/dune.jpg",
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xffF5D061),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber[600]),
                        const SizedBox(width: 5),
                        const Text(
                          "8.9 (12.4k)",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Dune: Part Two",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      children: [
                        chip("13+"),
                        chip("2j 46m"),
                        chip("Action"),
                        chip("Sci-Fi"),
                        chip("Adventure"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // SINOPSIS
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xff3A1020),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Ringkasan Cerita",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Paul Atreides bersatu dengan Chani dan suku Fremen untuk membalas dendam terhadap konspirator yang telah menghancurkan keluarganya.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Pilih Tanggal",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          bool selected = selectedDate == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = index;
                              });
                            },
                            child: Container(
                              width: 75,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xffF4D15D)
                                    : const Color(0xff3A1020),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dates[index]['name']!,
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    dates[index]['day']!,
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xff3A1020),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "CineGold Grand Indonesia",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Regular Rp65.000",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Gold Class Rp150.000",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(times.length, (index) {
                              bool active = selectedTime == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTime = index;
                                  });
                                },
                                child: Container(
                                  width: 70,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: active
                                        ? const Color(0xffF4D15D)
                                        : Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      times[index],
                                      style: TextStyle(
                                        color: active
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Color(0xff22030D)),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Estimasi Total",
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    "Rp65.000",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF4D15D),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Pilih Kursi →",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
