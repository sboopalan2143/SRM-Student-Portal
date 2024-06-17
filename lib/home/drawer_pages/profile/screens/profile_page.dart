import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            // height: 800,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.whiteColor,
              ),
              color: const Color.fromARGB(255, 252, 250, 250),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            'Priyadharshini',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 2 - 60,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register NO',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            '236025365',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date of birth',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            '15-08-2001',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width - 120,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Institution',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            'faculty of engineering and technology',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Program',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            'b.Tech - CSE',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Semester/Section',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            '3rd Sem - B',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Number',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            '9876543210',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 2 - 60,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email ID',
                            style: TextStyles.fontStyle7,
                          ),
                          Text(
                            'apple@gmail.com',
                            style: TextStyles.smallLightAshColorFontStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
