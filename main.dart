import 'dart:io';

void getPartlyVaccinated(List<String> fullyVaccinated) {
  var partlyVaccinated = <String>[];

  final vaccinated = File('./people_vaccinated.txt')
      .readAsLinesSync()
      .map((e) => double.parse(e))
      .toList();

  for (var i = 0; i < fullyVaccinated.length; i++) {
    partlyVaccinated.add(
        (vaccinated[i] - double.parse(fullyVaccinated[i])).toStringAsFixed(2));
  }

  File('partly_vaccinated.txt')
      .openSync(mode: FileMode.write)
      .writeString(partlyVaccinated.join('\n'));
}

List<String> normalize(List<double> data) {
  var normalizedData = <String>[];

  final double min = data.reduce((value, next) => value < next ? value : next);
  final double max = data.reduce((value, next) => value > next ? value : next);

  for (var i = 0; i < data.length; i++) {
    normalizedData.add(((data[i] - min) / (max - min)).toStringAsFixed(2));
  }

  return normalizedData;
}

void main(List<String> args) {
  final countries = File('./countries.txt').readAsLinesSync();

  final fullyVaccinated =
      File('./people_fully_vaccinated.txt').readAsLinesSync();

  getPartlyVaccinated(fullyVaccinated);

  final partlyVaccinated = File('./partly_vaccinated.txt').readAsLinesSync();

  final cases = File('./cases.txt').readAsLinesSync();
  final deaths = File('./deaths.txt').readAsLinesSync();

  final normalizedFullyVaccinated =
      normalize(fullyVaccinated.map((e) => double.parse(e)).toList());

  final normalizedPartlyVaccinated =
      normalize(partlyVaccinated.map((e) => double.parse(e)).toList());

  final normalizedCases =
      normalize(cases.map((e) => double.parse(e.replaceAll(',', ''))).toList());

  final normalizedDeaths = normalize(
      deaths.map((e) => double.parse(e.replaceAll(',', ''))).toList());

  var attributes = [];

  for (var i = 0; i < countries.length; i++) {
    attributes.add(
      '\"' +
          countries[i].trim() +
          '\"' +
          ', ' +
          normalizedFullyVaccinated[i] +
          ', ' +
          normalizedPartlyVaccinated[i] +
          ', ' +
          normalizedCases[i] +
          ', ' +
          normalizedDeaths[i],
    );
  }

  File('coronavirus.arff')
      .openSync(mode: FileMode.append)
      .writeString(attributes.join('\n'));
}
