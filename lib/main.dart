import 'package:blocflut/bloc/formbloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => FormBloC()),
      ],
      child: MaterialApp(
        title: 'BLoCFlut',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVisible = true;
  bool isVisiblePass = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FormBloC>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('BLoCFlut'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              StreamBuilder<String>(
                  stream: bloc.name,
                  builder: (context, snapshot) {
                    return TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        errorText: snapshot.error,
                      ),
                      onChanged: bloc.changeName,
                    );
                  }),
              StreamBuilder<String>(
                  stream: bloc.email,
                  builder: (context, snapshot) {
                    return TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        errorText: snapshot.error,
                      ),
                      onChanged: bloc.changeEmail,
                    );
                  }),
              StreamBuilder<String>(
                  stream: bloc.password,
                  builder: (context, snapshot) {
                    return TextField(
                      obscureText: isVisiblePass,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          errorText: snapshot.error,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisiblePass = !isVisiblePass;
                              });
                            },
                            icon: isVisiblePass
                                ? const Icon(
                                    Icons.visibility_off,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                  ),
                          )),
                      onChanged: bloc.changePassword,
                    );
                  }),
              StreamBuilder<String>(
                  stream: bloc.confirmPassword,
                  builder: (context, snapshot) {
                    return TextField(
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          errorText: snapshot.error,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? const Icon(
                                    Icons.visibility_off,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                  ),
                          )),
                      onChanged: bloc.changeConfirmPassword,
                    );
                  }),
              StreamBuilder(
                  stream: bloc.isValidForm,
                  builder: (context, snapshot) {
                    return TextButton(
                      onPressed: snapshot.hasError || !snapshot.hasData
                          ? null
                          : () {
                              bloc.submit();
                            },
                      child: Container(
                        height: 50,
                        width: 100,
                        color: snapshot.hasError || !snapshot.hasData
                            ? Colors.grey
                            : Colors.blueAccent,
                        child: const Center(
                            child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
