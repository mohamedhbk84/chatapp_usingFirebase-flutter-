import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton(
        {double width, Color background, Function function, String text}) =>
    Container(
      width: width,
      color: background,
      child: TextButton(
          onPressed: function,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          )),
    );
Widget defaultTextButton({Function function, String text}) =>
    TextButton(onPressed: function, child: Text(text));

Widget defaultTextField(
    {TextEditingController controller,
    Function onsubmit,
    Function onchanege,
    Function validator,
    bool isShown,
    String label,
    String hint,
    IconData icon,
    IconData suffixicon,
    Function onsave,
    bool istrue = true,
    Function suffixPressed,
    Function ontap,
    TextInputType type,
    @required BuildContext context}) {
  return TextFormField(
    controller: controller,
    onFieldSubmitted: onsubmit,
    onChanged: onchanege,
    keyboardType: type,
    onSaved: onsave,
    onTap: ontap,
    validator: validator,
    obscureText: isShown,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixicon != null
          ? IconButton(onPressed: suffixPressed, icon: Icon(suffixicon))
          : null,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(),
    ),
  );
}

// Widget buildTasksItem(Map model, context) {

//   return Dismissible(
//     key: Key(model['id'].toString()),
//     child: Padding(
//       padding: EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             radius: 38,
//             backgroundColor: Colors.blue.shade300,
//             child: Text(
//               "${model['time']}",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "${model['title']}",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${model['date']}",
//                   style: TextStyle(
//                     color: Colors.blueAccent.shade200,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           IconButton(
//               icon: Icon(
//                 Icons.check_box,
//                 color: Colors.green,
//               ),
//               onPressed: () {
//                 AppCubit.get(context)
//                     .updateDataBase(status: 'done', id: model['id']);
//               }),
//           IconButton(
//               icon: Icon(
//                 Icons.archive_outlined,
//                 color: Colors.grey,
//               ),
//               onPressed: () {
//                 AppCubit.get(context)
//                     .updateDataBase(status: 'archive', id: model['id']);
//               }),
//         ],
//       ),
//     ),
//     onDismissed: (direction) {
//       AppCubit.get(context).deleteData(
//         id: model['id'],
//       );
//     },
//   );
// }

// Widget buildArticalItem(article, context) => InkWell(
//       onTap: () {
//         navigateTo(
//           context,
//           WebViewScreen(article['url']),
//         );
//       },
//       child: Padding(
//         padding: EdgeInsets.all(6),
//         child: Row(children: [
//           Container(
//             width: 110,
//             height: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               image: DecorationImage(
//                   image: NetworkImage('${article['urlToImage']}'),
//                   fit: BoxFit.fill),
//             ),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Expanded(
//             child: Container(
//               height: 120,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: Text(
//                         '${article['title']}',
//                         style: Theme.of(context).textTheme.bodyText1,

//                         // TextStyle(
//                         //     fontWeight: FontWeight.bold, fontSize: 16),
//                         maxLines: 5,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text('${article['publishedAt']}')
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

void showToast({@required String text, @required ToastStates states}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

//enum
enum ToastStates { Sucess, Error, Warrning }
Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.Sucess:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warrning:
      color = Colors.yellow;
      break;
  }

  return color;
}

////////// print full text ///////
void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //// 800 is the size of chunk
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}
