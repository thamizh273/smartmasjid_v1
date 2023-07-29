

import '../../../routes/export.dart';




class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar( {required this.tittle,  this.action, this.icon, this.bottom, this.height});
   final String tittle;
   final List<Widget>? action;
   final Widget? icon;
   final double? height;
   final PreferredSizeWidget? bottom;

  @override

  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        icon: Image.asset(
          'assets/images/back_icon.png',
          scale: 2,
        ),
        onPressed: () {
        Get.back();

        },
      ),
      title:  Stxt(
          text: tittle,
          size: f4,
          weight: FontWeight.bold,
          color: Colors.white),
      actions:action,
      bottom: bottom,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height??kToolbarHeight);
 // Size get preferredSize => throw UnimplementedError();
}
