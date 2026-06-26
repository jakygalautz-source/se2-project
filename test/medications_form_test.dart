import 'package:flutter_test/flutter_test.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';
import 'package:pill_pilot/models/medication_form_model.dart';

void main() {
  test('MedicationForm ist ungueltig ohne Name', () {
    final intakeSlotModel = IntakeSlotModel();
    final formModel = MedicationFormModel(intakeSlotModel: intakeSlotModel);

    intakeSlotModel.addOne(DayPart.morning);

    expect(formModel.isValid, isFalse);
  });

  test('MedicationForm ist ungueltig ohne Einnahme', () {
    final intakeSlotModel = IntakeSlotModel();
    final formModel = MedicationFormModel(intakeSlotModel: intakeSlotModel);

    formModel.setMedicationName('Ibuprofen');

    expect(formModel.isValid, isFalse);
  });

  test('MedicationForm ist gueltig mit Name und Einnahme', () {
    final intakeSlotModel = IntakeSlotModel();
    final formModel = MedicationFormModel(intakeSlotModel: intakeSlotModel);

    formModel.setMedicationName('Ibuprofen');
    intakeSlotModel.addOne(DayPart.morning);

    expect(formModel.isValid, isTrue);
  });

  test('MedicationForm erstellt korrektes JSON fuer API', () {
    final intakeSlotModel = IntakeSlotModel();
    final formModel = MedicationFormModel(intakeSlotModel: intakeSlotModel);

    formModel.setMedicationName('Ibuprofen');
    intakeSlotModel.addOne(DayPart.morning);

    final json = formModel.toJson();

    expect(json['name'], 'Ibuprofen');
    expect(json['intakes'], isA<List>());
    expect(json['intakes'].length, 1);
    expect(json['intakes'][0]['dayPart'], 'morning');
    expect(json['intakes'][0]['amount'], 1.0);
    expect(json['intakes'][0]['reminder'], isFalse);
  });
}