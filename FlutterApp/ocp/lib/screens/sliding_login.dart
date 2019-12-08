import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocp/screens/machines/machineActivity.dart';
import 'package:ocp/services/authentication.dart';
import 'package:ocp/services/validations.dart';

void main() => runApp(MyApp());
UserAuth userAuth = new UserAuth();
bool autovalidate = false;
Validations validations = new Validations();

UserData user = new UserData();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Sliding Login',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }

}
enum AuthState {
  signedIn,
  notSignedIn,
}
class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  AuthState authState = AuthState.notSignedIn;
  FirebaseUser user;
  bool isLogin = true;
  Animation<double> loginSize;
  AnimationController loginController;
  AnimatedOpacity opacityAnimation;
  Duration animationDuration = Duration(milliseconds: 270);


  @override
  void initState() {
    super.initState();

    /*widget.currentUser().then((userid){
      setState(() {
        authState = userid ==null ? AuthState.notSignedIn : AuthState.signedIn;

      });

    });
*/


    SystemChrome.setEnabledSystemUIOverlays([]);

    loginController =
        AnimationController(vsync: this, duration: animationDuration);

    opacityAnimation =
        AnimatedOpacity(opacity: 0.0, duration: animationDuration);
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  Widget _buildLoginWidgets() {
    return Container(
      padding: EdgeInsets.only(bottom: 62, top: 16),
      width: MediaQuery.of(context).size.width,
      height: loginSize.value,
      decoration: BoxDecoration(
          color: Color(0xFF2CDAB1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(190),
              bottomRight: Radius.
              circular(190))),


      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedOpacity(
          opacity: loginController.value,
          duration: animationDuration,
          child: GestureDetector(
            onTap: isLogin ? null : () {
              loginController.reverse();

              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Container(
              child: Text(
                'LOG IN'.toUpperCase(),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

          ),
        ),
      ),
    );
  }



  Widget _buildLoginComponents() {
    return Container(
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Form(
          key: _formKey,
          autovalidate: autovalidate,
        child: new Column(
        children: <Widget>[
        Visibility(
          visible: isLogin,
          child: Padding(
            padding: const EdgeInsets.only(left: 42, right: 42),
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.white, height: 0.5),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))
                      )
                  ),
                  onSaved: (input) => _email = input,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    obscureText : true,
                    style: TextStyle(color: Colors.white, height: 0.5),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Password',

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.
                                circular(32))
                        )
                    ),
                    onSaved: (input) => _password = input,
                  ),
                ),
                Container(
                  width: 200,
                  height: 40,
                  margin: EdgeInsets.only(top: 32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: FlatButton(
                    onPressed:signIn ,
                    child: Text(
                      'LOG IN',
                      style: TextStyle(color: Color(0xFF2CDAB1),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),


      ],
    ),
    ),
      ],
    ),
    );
  }

  Widget _buildRegistercomponents() {
    return Padding(
      padding: EdgeInsets.only(
        left: 42,
        right: 42,
        top: 32,
        bottom: 50
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Image.asset(
              "assets/images/daleaef.png",
              width: 100 * 0.754,
              height: 100 * 0.754,
              color: Color(0xFF2CDAB1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              'Sign Up'.toUpperCase(),
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2CDAB1)),
            ),
          ),
          TextField(
            style: TextStyle(color: Colors.black, height: 0.5),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32))
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: TextField(
              style: TextStyle(color: Colors.black, height: 0.5),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32))
                  )
              ),
            ),
          ),
          TextField(
            style: TextStyle(color: Colors.black, height: 0.5),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key),
                hintText: 'Confirm Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32))
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              width: 200,
              height: 40,
              margin: EdgeInsets.only(top: 32),
              decoration: BoxDecoration(
                  color: Color(0xFF2CDAB1),
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              child: Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
    ) ,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    if (currentUser()!=null){
////      Navigator.of(context).pushNamed("/machineActivity");
//      Navigator.push(context, MaterialPageRoute(builder: (context)
//      => machineActivity()));
//    }


    double _defaultLoginSize = MediaQuery.of(context).size.height / 1.6;

    loginSize = Tween<double>(begin: _defaultLoginSize, end: 200).animate(
        CurvedAnimation(parent: loginController, curve: Curves.linear));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: animationDuration,
                child: Container(child: _buildRegistercomponents()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: isLogin && !loginController.isAnimating ?
              Colors.white : Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: _defaultLoginSize/1.5,
              child: Visibility(
                visible: isLogin,
                child: GestureDetector(
                  onTap: () {
                    loginController.forward();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2CDAB1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: loginController,
            builder: (context, child) {
              return _buildLoginWidgets();
            },
          ),
          Align(
            alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                  child: Center(child: _buildLoginComponents()),
              )
          )
        ],
      ),
    );
  }

  void signIn() async {
    print('${_email}');
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{

        user = (await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: _email,
            password: _password)).user;
        print('heere is the ${user}');
        Navigator.push(context, MaterialPageRoute(builder: (context)
        => machineActivity()));

      }catch(e){
        print('heerree');
        print('here is the prob ${e}');
      }
    }
  }

}

