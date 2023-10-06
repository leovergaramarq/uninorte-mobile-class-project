import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/home_page.dart';

void main() {
  setUp(() {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(SessionController());
    Get.put(QuestionController());
  });
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    // Construir la página LoginPage
    await tester.pumpWidget(
      const GetMaterialApp(
        home: LoginPage(),
      ),
    );

    // Verificar que se muestre el texto "Sum+" en la pantalla
    expect(find.text("Sum+"), findsOneWidget);

    // Simular la entrada de texto en el campo de correo electrónico
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginEmail')), 'test@example.com');

    // Simular la entrada de texto en el campo de contraseña
    await tester.enterText(
        find.byKey(const Key('TextFormFieldLoginPassword')), 'password123');

    // Toca el botón "Submit" para enviar el formulario
    await tester.tap(find.byKey(const Key('ButtonLoginCreateAccount')));

    // Espera a que la UI se actualice después de tocar el botón
    await tester.pumpAndSettle();

    // Verificar que se haya realizado la navegación a otra pantalla
    expect(find.byKey(const Key('SignUpPage')), findsOneWidget);
  });
}
