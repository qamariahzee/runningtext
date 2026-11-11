// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('academic introduction displays its content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('260605110231 - Azizah Nur Qamariah'), findsOneWidget);
    expect(
      find.text('Tugas mata kuliah Introduction to Computer Science'),
      findsOneWidget,
    );
    expect(find.text('Saya Bangga Menjadi Mahasiswa IT'), findsWidgets);
    expect(find.text('Belajar, Berkarya, dan Menginspirasi'), findsWidgets);
    expect(
      find.text('Bersama Teknologi, Kita Membangun Masa Depan'),
      findsWidgets,
    );

    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Hello Mahasiswa UIN Maliki Malang'), findsOneWidget);
  });
}
