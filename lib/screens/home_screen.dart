import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/provider/news_provider.dart';
import 'package:flutter_news/widgets/web_view_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final news = ref.watch(newsProvider);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (value) {
                        ref
                            .read(newsProvider.notifier)
                            .searchNews(query: value);
                        searchController.clear();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        hintText: 'Search for news..',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  news.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height - 150,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ),
                        )
                      : news[0].title == 'not found'
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                'No matches for your search.',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height - 150,
                              child: ListView.builder(
                                itemCount: news.length,
                                itemBuilder: (context, index) {
                                  final dat = news[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => WebViewWidget(dat.link),
                                          transition: Transition.leftToRight);
                                    },
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.only(bottom: 17),
                                        width: double.infinity,
                                        height: 250,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dat.title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    dat.summary,
                                                    maxLines: 6,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  if (dat.author != '')
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.grey,
                                                      ),
                                                      child: Text(
                                                        dat.author,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(dat.published_date),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              width: 160,
                                              height: 250,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: dat.media == ''
                                                    ? Image.asset(
                                                        'assets/images/NoImageFound.png')
                                                    : CachedNetworkImage(
                                                        imageUrl: dat.media,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                                'assets/images/NoImageFound.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ],
              ),
            );
          },

          // error: (err, stack) => Text('$err'),
          // loading: () => Center(
          //   child: CircularProgressIndicator(
          //     color: Colors.purple,
          //   ),
          // ),
        ),
      ),
    );
  }
}
