import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false, initialScrollOffset: 0.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextField(
                          autofocus: false,
                          onSubmitted: (value) {},
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.amber.withOpacity(0.6),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.amber,
                              ),
                              hintText: 'Search',
                              hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.2)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: ListView.builder(
                  controller: ScrollController(keepScrollOffset: true),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10 ),
                  scrollDirection: Axis.vertical,
                  itemCount: 90,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {

                      },
                      splashColor: Colors.cyan,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 120,
                              width: 140,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage('https://cdn.myanimelist.net/images/anime/1188/136926.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Ao no Exorcist: Shimane Illuminati Hen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  Text('Blue Exorcist: Shimane Illuminati Saga', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
