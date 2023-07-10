

import '../../../routes/export.dart';




class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar( {required this.tittle,  this.action, this.icon, this.bottom});
   final String tittle;
   final List<Widget>? action;
   final Widget? icon;
   final PreferredSizeWidget? bottom;

  @override

  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0.0),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        icon: Image.asset(
          'assets/images/back_icon.png',
          scale: 2,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title:  Stxt(
          text: tittle,
          size: f4,
          weight: FontWeight.bold,
          color: Colors.white),
      actions:action
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
 // Size get preferredSize => throw UnimplementedError();
}
