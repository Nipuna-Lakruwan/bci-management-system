import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../controller/auth_controller.dart';
import '../../../app/router.dart';
import '../../../app/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin123');
  bool _isHovering = false;

  void _handleLogin() async {
    final success = await context.read<AuthController>().login(
          _usernameController.text,
          _passwordController.text,
        );
    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.dashboardRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthController>().isLoading;
    final errorMessage = context.watch<AuthController>().errorMessage;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      body: Row(
        children: [
          // Left Side: Branding / Image (Only visible on Desktop/Tablet)
          if (isDesktop)
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // A subtle geometric pattern could go here, for now just gradient
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 32,
                                )
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/bci-logo.png',
                              height: 120,
                            ),
                          ),
                          const SizedBox(height: 48),
                          Text(
                            'BCI Campus\nManagement System',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Empowering Education through Technology.',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          // Right Side: Login Form
          Expanded(
            flex: 4,
            child: Container(
              color: AppTheme.backgroundColor,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(48.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!isDesktop) ...[
                          Center(
                            child: Image.asset(
                              'assets/images/bci-logo.png',
                              height: 80,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to your administration account',
                          style: GoogleFonts.inter(
                            color: AppTheme.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 48),
                        if (errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline, color: Colors.red.shade700),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(color: Colors.red.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: AppTheme.primaryLight, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        MouseRegion(
                          onEnter: (_) => setState(() => _isHovering = true),
                          onExit: (_) => setState(() => _isHovering = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: Matrix4.identity()..scale(_isHovering ? 1.02 : 1.0),
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleLogin,
                              child: isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                    )
                                  : const Text('Sign In'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
