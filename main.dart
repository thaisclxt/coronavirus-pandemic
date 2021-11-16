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
  final countries = File('./countries.txt').readAsLinesSync();

  final fullyVaccinated =
      File('./people_fully_vaccinated.txt').readAsLinesSync();
  // .map((e) => double.parse(e))
  // .toList();

  // final vaccinated = File('./people_vaccinated.txt')
  //     .readAsLinesSync()
  //     .map((e) => double.parse(e))
  //     .toList();

  // //getPartlyVaccinated(fullyVaccinated, vaccinated);

  final partlyVaccinated = File('./partly_vaccinated.txt').readAsLinesSync();

  final cases = File('./cases.txt').readAsLinesSync();
  final deaths = File('./deaths.txt').readAsLinesSync();

  var attributes = [];

  for (var i = 0; i < countries.length; i++) {
    attributes.add(
      countries[i].trim() +
          ', ' +
          fullyVaccinated[i].toString().trim() +
          ', ' +
          partlyVaccinated[i].trim() +
          ', ' +
          cases[i].trim() +
          ', ' +
          deaths[i].trim(),
    );
  }

  File('coronavirus.arff')
      .openSync(mode: FileMode.append)
      .writeString(attributes.join('\n'));
}
