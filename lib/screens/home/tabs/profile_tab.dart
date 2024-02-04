import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 334,
                height: 50,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.28, -0.96),
                    end: Alignment(-0.28, 0.96),
                    colors: [Colors.white.withOpacity(0.800000011920929), Colors.white.withOpacity(0.20000000298023224)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 334,
                        height: 50,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 17,
                      child: SizedBox(
                        width: 178,
                        child: Text(
                          '${auth.getloggedinUser!.data!.name}',
                          style: TextStyle(
                            color: Color(0xFFBCBEC0),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 334,
                height: 50,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.28, -0.96),
                    end: Alignment(-0.28, 0.96),
                    colors: [Colors.white.withOpacity(0.800000011920929), Colors.white.withOpacity(0.20000000298023224)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 334,
                        height: 50,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 17,
                      child: SizedBox(
                        width: 178,
                        child: Text(
                          '${auth.getloggedinUser!.data!.email}',
                          style: TextStyle(
                            color: Color(0xFFBCBEC0),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 334,
                height: 50,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.28, -0.96),
                    end: Alignment(-0.28, 0.96),
                    colors: [Colors.white.withOpacity(0.800000011920929), Colors.white.withOpacity(0.20000000298023224)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 334,
                        height: 50,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 17,
                      child: SizedBox(
                        width: 178,
                        child: Text(
                          '${auth.getloggedinUser!.data!.phone}',
                          style: TextStyle(
                            color: Color(0xFFBCBEC0),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   width: 334,
              //   height: 50,
              //   decoration: ShapeDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment(0.28, -0.96),
              //       end: Alignment(-0.28, 0.96),
              //       colors: [Colors.white.withOpacity(0.800000011920929), Colors.white.withOpacity(0.20000000298023224)],
              //     ),
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(color: Colors.white),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         left: 0,
              //         top: 0,
              //         child: Container(
              //           width: 334,
              //           height: 50,
              //           decoration: ShapeDecoration(
              //             shape: RoundedRectangleBorder(
              //               side: BorderSide(width: 1, color: Colors.white),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 20,
              //         top: 17,
              //         child: SizedBox(
              //           width: 178,
              //           child: Text(
              //           '${auth.getloggedinUser!.data!.}',
              //             style: TextStyle(
              //               color: Color(0xFFBCBEC0),
              //               fontSize: 14,
              //               fontFamily: 'Inter',
              //               fontWeight: FontWeight.w400,
              //               height: 0,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                    (route) => false),
                child: Text('Log out'),
              )
            ],
          );
        },
      ),
    );
  }
}
