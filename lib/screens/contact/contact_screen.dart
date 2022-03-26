import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/services/firebase_services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/contact_cubit.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact-us';
  const ContactScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => BlocProvider<ContactCubit>(
        create: (context) => ContactCubit(
          firebaseServices: context.read<FirebaseServices>(),
        ),
        child: const ContactScreen(),
      ),
    );
  }

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _openEmail() async {
    await launch('mailto:rishukumar.prince@gmail.com?body=Hello there !');
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _message = TextEditingController();

  void _submit(BuildContext context) {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        context.read<ContactCubit>().submit();
        _name.clear();
        _email.clear();
        _message.clear();
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Something went wrong try again !',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _message.dispose();
    _email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Contact Us'),
      ),
      body: BlocConsumer<ContactCubit, ContactState>(
        listener: (context, state) {
          if (state.status == ContactStatus.succuss) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  'Message sent, Thanks for contacting us we will soon reach out to you !',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 25.0,
                  ),
                  child: Text(
                    _contactNote,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _openEmail();
                  },
                  icon: const Icon(Icons.mail),
                  label: const Text('EMAIL US'),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'or',
                  style: TextStyle(fontSize: 17.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Card(
                    child: SizedBox(
                      width: 600.0,
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 40.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name can\t be empty';
                                  }
                                  return null;
                                },
                                onChanged: (value) => context
                                    .read<ContactCubit>()
                                    .nameChanged(value),
                                decoration: InputDecoration(
                                  hintText: 'Please enter your name eg, Rishu',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      4.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25.0),
                              TextFormField(
                                controller: _email,
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isEmpty && value.contains('@')) {
                                      return 'Invalid email address ';
                                    }
                                  }
                                  return null;
                                },
                                onChanged: (value) => context
                                    .read<ContactCubit>()
                                    .emailChanged(value),
                                decoration: InputDecoration(
                                  hintText:
                                      'Please enter your email eg, rishu@gmailcom',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      4.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25.0),
                              TextFormField(
                                controller: _message,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onChanged: (value) => context
                                    .read<ContactCubit>()
                                    .messageChanged(value),
                                maxLength: 1000,
                                maxLines: 8,
                                minLines: 4,
                                decoration: InputDecoration(
                                  hintText:
                                      'Please enter your query, suggestions or feedback',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      4.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                height: 40.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _submit(context);
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 16.0,
                                    ),
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
                const SizedBox(height: 10.0),
                const Text(
                  'Made with ❤️ by Taleway team',
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 7.0),
                // const Text(
                //   '© sixteenbrains.com',
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 12.0),
              ],
            ),
          );
        },
      ),
    );
  }
}

const String _contactNote =
    'Hello there, we are very thankful for your love and support and eagerly waiting to hear more from you. If you have any query, suggestions or feedback, please feel free to contact us, and we will be more than happy to help you.';
