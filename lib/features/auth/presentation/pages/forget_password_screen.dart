import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/back_button_widget.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/auth/presentation/pages/confirm_pass_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: const BackButtonWidget(),
        title: const Text("Forget password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reset password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
                'Tempor est dolore eiusmod fugiat aQuis consectetur excepteur qui consectetur nisi id labore nulla proident amet in commodo magna.liquip laborum in.'),
            20.hs(),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            10.hs(),
            TextWidget(
              labelText: 'Email',
              controller: emailController,
            ),
            const Spacer(),
            ButtonWidget(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPassScreen(),
                    ));
              },
              text: 'Send',
            ),
          ],
        ),
      ),
    );
  }
}
