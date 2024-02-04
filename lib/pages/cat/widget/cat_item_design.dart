import 'package:flutter/material.dart';

class GridTiles extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback voidCallback;
  final VoidCallback onShare;

  const GridTiles({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.voidCallback,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        child: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          elevation: 0,
          child: Center(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    onSelected: (value) {
                      onShare();
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 8.0),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Image.network(
                  imageUrl,
                  width: 150,
                  height: 150,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Text(
                    (name.length <= 40 ? name : name.substring(0, 40)),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF444444),
                      fontFamily: 'Roboto-Light.ttf',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
