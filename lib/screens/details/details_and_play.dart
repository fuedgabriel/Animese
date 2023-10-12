import 'package:flutter/material.dart';



class DetailsAndPlay extends StatelessWidget {
  const DetailsAndPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
              opacity: 0.6,
            child: Image.network(
                'https://cdn.myanimelist.net/images/anime/1100/138338.jpg',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                            child:  Image(
                              image: AssetImage('assets/images/nome.png'),
                              height: 40,
                            ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                            child: SizedBox(
                              height: 200,
                              width: double.maxFinite,
                              child: Text(
                                "DanMachi: É Errado Tentar Pegar Garotas em uma Masmorra? ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                )
                              ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: (){},
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    'https://cdn.myanimelist.net/images/anime/1100/138338.jpg',
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 150,
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.black.withOpacity(0.3),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          )
                                        ]
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 20,),

                  const Text('data', style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}

