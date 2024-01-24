import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/logoWidget/Logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Provider/Provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginStatusProvider()..loginStatusAction(context),
      child:
          Consumer<LoginStatusProvider>(builder: (context, actionValue, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).textTheme.bodyLarge!.color),
          child: Scaffold(
            body: Center(
              child: LogoView(
                height: 50,
                width: 50,
              ).animatedDisplay(Duration(milliseconds: 250)),
            ),
          ),
        );
      }),
    );
  }
}
