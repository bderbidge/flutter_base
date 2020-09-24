import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/blocs/form_validation_bloc.dart';
import 'package:flutter_base/blocs/state/auth_state.dart';
import 'package:flutter_base/ui/exceptions/error_handler.dart';
import 'package:flutter_base/ui/theme.dart';
import 'package:flutter_base/ui/widgets/buttons/external_auth_button.dart';
import 'package:flutter_base/util/bubble_indication_painter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Injector(
        inject: [
          Inject(
            () => SignInValidationBloc(),
            joinSingleton: JoinSingleton.withCombinedReactiveInstances,
          ),
          Inject(
            () => SignUpValidationBloc(),
            joinSingleton: JoinSingleton.withCombinedReactiveInstances,
          ),
        ],
        disposeModels: true,
        builder: (context) {
          return LoginForm();
        },
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  ReactiveModel<SignUpValidationBloc> _signUpValidBloc =
      Injector.getAsReactive<SignUpValidationBloc>();

  double _height;
  double _width;

  final FocusNode _focusNodeEmailLogin = FocusNode();
  final FocusNode _focusNodePasswordLogin = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeName = FocusNode();

  TextEditingController _loginEmailController;
  TextEditingController _loginPasswordController;

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController _signupEmailController;
  TextEditingController _signupNameController;
  TextEditingController _signupPasswordController;
  TextEditingController _signupConfirmPasswordController;

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _signupEmailController = TextEditingController();
    _signupNameController = TextEditingController();
    _signupPasswordController = TextEditingController();
    _signupConfirmPasswordController = TextEditingController();

    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _focusNodeEmailLogin?.dispose();
    _focusNodePasswordLogin?.dispose();
    _focusNodePassword?.dispose();
    _focusNodeEmail?.dispose();
    _focusNodeName?.dispose();

    _loginEmailController?.dispose();
    _loginPasswordController?.dispose();
    _signupNameController?.dispose();
    _signupEmailController?.dispose();
    _signupPasswordController?.dispose();
    _signupConfirmPasswordController?.dispose();

    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;

    _height = _deviceSize.height >= 775.0 ? _deviceSize.height : 775.0;
    _width = _deviceSize.width;

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
      },
      child: SingleChildScrollView(
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CompanyColors.lightGreen, CompanyColors.darkGreen],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 75.0),
                child: Image(
                  width: 120.0,
                  height: 91.0,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/login_logo.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: _buildMenuBar(context),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) {
                    if (i == 0) {
                      setState(() {
                        right = Colors.white;
                        left = Colors.black;
                      });
                    } else if (i == 1) {
                      setState(() {
                        right = Colors.black;
                        left = Colors.white;
                      });
                    }
                  },
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Builder(builder: _buildSignIn),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Builder(builder: _buildSignUp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: _width * 0.75,
      height: 50.0,
      decoration: BoxDecoration(
        color: CompanyColors.darkGrey50,
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(
                    color: left,
                    fontSize: 16.0,
                    fontFamily: "WorkSansSemiBold",
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(
                    color: right,
                    fontSize: 16.0,
                    fontFamily: "WorkSansSemiBold",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: _width * 0.8,
                  height: 240.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 25.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: StateBuilder<SignInValidationBloc>(
                            builder: (context, bloc) {
                              return TextField(
                                focusNode: _focusNodeEmailLogin,
                                controller: _loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (email) {
                                  bloc.setState(
                                    (s) => s.validateEmail(
                                        _loginEmailController.text),
                                    catchError: true,
                                  );
                                },
                                style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  hintText: "Email Address",
                                  hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0,
                                  ),
                                  errorText:
                                      bloc.hasError ? bloc.error.message : null,
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 2.0,
                          thickness: 1.0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: StateBuilder<SignInValidationBloc>(
                            builder: (context, bloc) {
                              return TextField(
                                focusNode: _focusNodePasswordLogin,
                                controller: _loginPasswordController,
                                obscureText: _obscureTextLogin,
                                onChanged: (password) {
                                  bloc.setState(
                                    (s) => s.validatePassword(password),
                                    catchError: true,
                                  );
                                },
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 22.0,
                                    color: Colors.black,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0,
                                  ),
                                  errorText:
                                      bloc.hasError ? bloc.error.message : null,
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleLogin,
                                    child: Icon(
                                      FontAwesomeIcons.eye,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: _signInButton(),
                bottom: -25.0,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 36.0,
              bottom: 8.0,
            ),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: "WorkSansMedium",
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white10,
                        Colors.white,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                    ),
                  ),
                  width: _width * 0.3,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium",
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white10,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                    ),
                  ),
                  width: _width * 0.3,
                  height: 1.0,
                ),
              ],
            ),
          ),
          StateBuilder<AuthState>(
              observe: () => RM.get<AuthState>(),
              builder: (_, authStateRM) {
                return ExternalAuthProviderButton(
                  () => authStateRM.setState(
                    (s) => AuthState.signInWithCredentials(s, 'google'),
                    onError: ErrorHandler.showErrorSnackBar,
                  ),
                  'google',
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CompanyColors.white,
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: _width * 0.8,
                  height: 340.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 25.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            focusNode: _focusNodeName,
                            controller: _signupNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 2.0,
                          thickness: 1.0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            focusNode: _focusNodeEmail,
                            controller: _signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                              ),
                              hintText: "Email Address",
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 2.0,
                          thickness: 1.0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            focusNode: _focusNodePassword,
                            controller: _signupPasswordController,
                            obscureText: _obscureTextSignup,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 2.0,
                          thickness: 1.0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _signupConfirmPasswordController,
                            obscureText: _obscureTextSignupConfirm,
                            style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignupConfirm,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: _signUpButton(),
                bottom: -25.0,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: CompanyColors.berry,
      ),
      child: StateBuilder<AuthState>(
        observeMany: [() => RM.get<AuthState>(), () => this._signUpValidBloc],
        builder: (_, authStateRM) {
          return authStateRM.isWaiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: "WorkSansBold",
                      ),
                    ),
                  ),
                  disabledColor: CompanyColors.lightBerry,
                  disabledTextColor: Colors.white24,
                  onPressed: authStateRM.isWaiting
                      ? null
                      : () => authStateRM.setState(
                            (s) => AuthState.signInWithEmailAndPassword(
                                s,
                                _loginEmailController.text.trim(),
                                _loginPasswordController.text.trim()),
                            onError: ErrorHandler.showErrorSnackBar,
                          ),
                );
        },
      ),
    );
  }

  Widget _signUpButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        color: CompanyColors.berry,
      ),
      child: StateBuilder<AuthState>(
        observe: () => RM.get<AuthState>(),
        builder: (__, authStateRM) {
          return FlatButton(
              child: authStateRM.isWaiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 42.0,
                      ),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "WorkSansBold",
                        ),
                      ),
                    ),
              onPressed: authStateRM.isWaiting || _signUpValidBloc.hasError
                  ? null
                  : () => authStateRM.setState(
                        (s) => AuthState.createUserWithEmailAndPassword(
                            s,
                            _signupEmailController.text.trim(),
                            _signupPasswordController.text.trim(),
                            _signupConfirmPasswordController.text.trim(),
                            _signupNameController.text.trim()),
                        onError: ErrorHandler.showErrorSnackBar,
                      ));
        },
      ),
    );
  }

  bool isEmail(String em) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regExp.hasMatch(em);
  }

  void _onSignInButtonPress() {
    _pageController?.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
