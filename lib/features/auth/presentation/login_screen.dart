import 'package:flutter/cupertino.dart';
import '../../auth/presentation/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    // В реальном приложении здесь была бы логика авторизации
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Успешно'),
        content: const Text('Вы успешно вошли в систему (демо)'),
        actions: [
          CupertinoDialogAction(
            child: const Text('ОК'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Авторизация'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Icon(
                CupertinoIcons.lock_circle_fill,
                size: 80,
                color: CupertinoColors.activeBlue,
              ),
              const SizedBox(height: 32),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email',
                padding: const EdgeInsets.all(16),
                keyboardType: TextInputType.emailAddress,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Пароль',
                padding: const EdgeInsets.all(16),
                obscureText: true,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: _onLogin,
                child: const Text('Войти'),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                child: const Text('Нет аккаунта? Зарегистрироваться'),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
