import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String fieldKey;
  final Function(String?)? onChanged;
  final bool obscureText;
  final String? errorText;
  final Widget prefixIcon;
  final Widget? suffix;

  const CustomTextFormField({
    required this.labelText,
    required this.fieldKey,
    this.onChanged,
    this.obscureText = false,
    this.errorText,
    this.suffix,
    required this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 1200;
        var isDesktop = constraints.maxWidth > 1200;

        double width = isDesktop
            ? constraints.maxWidth * 0.3
            : isTablet
                ? constraints.maxWidth * 0.5
                : constraints.maxWidth;

        return Container(
          width: width,
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: TextFormField(
            key: ValueKey(fieldKey),
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: suffix,
              labelText: labelText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
      },
    );
  }
}





// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final String labelText;
//   final String fieldKey;
//   final Function(String?)? onChanged;
//   final bool obscureText;
//   final String? errorText;
//   final Widget prefixIcon;
//   final Widget? suffix;

//   const CustomTextFormField({
//     required this.labelText,
//     required this.fieldKey,
//     this.onChanged,
//     this.obscureText = false,
//     super.key,
//     this.errorText,
//     this.suffix,
//     required this.prefixIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var minWidth = size.width * 0.3;
//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: minWidth + 150,
//         minWidth: minWidth,
//       ),
//       margin: const EdgeInsets.symmetric(
//         vertical: 10,
//         horizontal: 5,
//       ),
//       child: TextFormField(
//         key: ValueKey(fieldKey),
//         onChanged: onChanged,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           suffixIcon: suffix,
//           labelText: labelText,
//           errorText: errorText,
//           prefixIcon: prefixIcon,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(
//               50,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
