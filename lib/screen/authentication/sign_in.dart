import 'package:flutter/material.dart';
import 'package:finalproject/services/base_auth.dart';

class SignIn extends StatefulWidget {
  SignIn({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _username;
  String _errorMessage;

  bool _isSignInForm;
  bool _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;

    if(form.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if(validateAndSave()) {
      String  userId = "";
      try {
        if(_isSignInForm) {
          userId = await widget.auth.signIn(_email, _password);

          FocusScope.of(context).unfocus();

          print('Signed In: userId = $userId');
          print('Email: $_email, Password: $_password');
        } else {
          userId = await widget.auth.signUp(_email, _password, _username);

          FocusScope.of(context).unfocus();

          print('Signed up: userId = $userId');
          print('Email: $_email, Password: $_password, Username: $_username');
        }

        setState(() {
          _isLoading = false;
        });

        if(userId.length > 0 && userId != null && _isSignInForm) {
          widget.loginCallback();
        }
      } catch(e) {
        print('validate_sumbit error: $e');

        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isSignInForm = true;

    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();

    setState(() {
      _isSignInForm = !_isSignInForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SingleChildScrollView(
          child: Stack(
          children: _isSignInForm ? <Widget>[
            _showSignInForm(),
            // showCircularProgress(),
          ] : <Widget> [
            _showSignUpForm(),
            // showCircularProgress(),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );  
  }

  Widget showCircularProgress() {
    if(_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

    Widget _showSignUpForm() {
    return new Container(
      child: Column(
        children: <Widget>[
          showLogo(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  showEmailInput(),
                  showUsernameInput(),
                  showPasswordInput(),
                  showErrorMessage(),
                  showPrimaryButton(),
                  showSecondaryButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showSignInForm() {
    return new Container(
      child: Column(
        children: <Widget>[
          showLogo(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  showEmailInput(),
                  showPasswordInput(),
                  showErrorMessage(),
                  showPrimaryButton(),
                  showSecondaryButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showLogo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new Container(
            width: 900.00,
            height: 300.00,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage('assets/images/logo.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(color: Colors.teal[300]),
        decoration: new InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.teal[300]),
          icon: new Icon(
            Icons.mail,
            color: Colors.teal[300],
          ),
        ),
        validator: (value) => value.isEmpty ?  'Email cant\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

    Widget showUsernameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(color: Colors.teal[300]),
        decoration: new InputDecoration(
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.teal[300]),
          icon: new Icon(
            Icons.person,
            color: Colors.teal[300],
          ),
        ),
        validator: (value) => value.isEmpty ?  'Username cant\'t be empty' : null,
        onSaved: (value) => _username = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(color: Colors.teal[300]),
        decoration: new InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.teal[300]),
          icon: new Icon(
            Icons.lock,
            color: Colors.teal[300],
          ),
        ),
        validator: (value) => value.isEmpty ?  'Password cant\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.purple[300],
          child: new Text(_isSignInForm ? 'Sign-In' : 'Create account',
              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
      child: new Text(
          _isSignInForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.teal[300])),
      onPressed: toggleFormMode
    );
  }

  Widget showErrorMessage() {
    if(_errorMessage.length > 0 && _errorMessage != null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 0.0),
        child: new Text(
          _errorMessage,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}