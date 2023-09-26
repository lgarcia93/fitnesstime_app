import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Container(
        height: 50.0,
        child: RaisedButton(
          color: const Color(0xFF4267B2),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/facebook.svg',
                height: 28,
                width: 28,
                //  package: package_name,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Continuar com Facebook',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
