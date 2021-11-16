import 'dart:io';

void main(List<String> args) {
  var partlyVaccinated = <String>[];

  final fullyVaccinated = File('./people_fully_vaccinated.txt')
      .readAsLinesSync()
      .map((e) => double.parse(e))
      .toList();

  final vaccinated = File('./people_vaccinated.txt')
      .readAsLinesSync()
      .map((e) => double.parse(e))
      .toList();

  for (var i = 0; i < fullyVaccinated.length; i++) {
    partlyVaccinated
        .add((vaccinated[i] - fullyVaccinated[i]).toStringAsFixed(2));
  }
  File('partly_vaccinated.txt').openWrite().write(partlyVaccinated.join('\n'));
}
