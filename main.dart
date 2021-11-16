import 'dart:io';

void getPartlyVaccinated(
    List<double> fullyVaccinated, List<double> vaccinated) {
  var partlyVaccinated = <String>[];

  for (var i = 0; i < fullyVaccinated.length; i++) {
    partlyVaccinated
        .add((vaccinated[i] - fullyVaccinated[i]).toStringAsFixed(2));
  }
  File('partly_vaccinated.txt').openWrite().write(partlyVaccinated.join('\n'));
}

void main(List<String> args) {
  final fullyVaccinated = File('./people_fully_vaccinated.txt')
      .readAsLinesSync()
      .map((e) => double.parse(e))
      .toList();

  final vaccinated = File('./people_vaccinated.txt')
      .readAsLinesSync()
      .map((e) => double.parse(e))
      .toList();

  getPartlyVaccinated(fullyVaccinated, vaccinated);
}
