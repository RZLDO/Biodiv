// import 'dart:io';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../BloC/class/class_bloc.dart';
// import '../../repository/class_repository.dart';
// import '../../utils/colors.dart';
// import '../../utils/custom_app_bar.dart';
// import '../../utils/custom_button.dart';
// import '../../utils/custom_textfield.dart';
// import '../../utils/validation.dart';
// import '../home/home_screen.dart';

// class EditDataClass extends StatefulWidget {
//   final String commonName;
//   final String latinName;
//   final String characteristics;
//   final String description;

//   const EditDataClass({super.key, 
//     required this.

//   });

//   @override
//   State<EditDataClass> createState() => _EditDataClassState();
// }

// class _EditDataClassState extends State<EditDataClass> {
//   final latinName = TextEditingController();
//   final commonName = TextEditingController();
//   final characteristics = TextEditingController();
//   final description = TextEditingController();
//   XFile? _imagePicker;
//   final ClassBloc _classBloc = ClassBloc(repository: ClassRepository());
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         resizeToAvoidBottomInset: false,
//         appBar: const CustomAppBar(text: "Add Class Data"),
//         body: Padding(
//           padding: const EdgeInsets.all(24),
//           child: BlocProvider<ClassBloc>(
//             create: (context) => _classBloc,
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     getImage();
//                   },
//                   child: Card(
//                     elevation: 4,
//                     child: SizedBox(
//                       height: 150,
//                       width: 150,
//                       child: _imagePicker == null
//                           ? Icon(
//                               Icons.image_search,
//                               size: 100,
//                               color: Colors.black45.withOpacity(0.5),
//                             )
//                           : Image.file(
//                               File(_imagePicker!.path),
//                             ),
//                     ),
//                   ),
//                 ),
//                 Form(
//                     key: _key,
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 24,
//                         ),
//                         CustomTextField(
//                             hintText: "Latin Name",
//                             controller: latinName,
//                             validator: Validator.basicValidate,
//                             obsecure: false),
//                         const SizedBox(
//                           height: 24,
//                         ),
//                         CustomTextField(
//                             hintText: "Common Name",
//                             controller: commonName,
//                             validator: Validator.basicValidate,
//                             obsecure: false),
//                         const SizedBox(
//                           height: 24,
//                         ),
//                         CustomTextField(
//                             hintText: "Characteristics",
//                             controller: characteristics,
//                             validator: Validator.basicValidate,
//                             obsecure: false),
//                         const SizedBox(
//                           height: 24,
//                         ),
//                         CustomTextField(
//                             hintText: "Description",
//                             controller: description,
//                             validator: Validator.basicValidate,
//                             obsecure: false),
//                       ],
//                     )),
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 BlocConsumer<ClassBloc, ClassState>(builder: (context, state) {
//                   return CustomButton(
//                       text: state is ClassLoading ? "Loading" : "Add Data",
//                       onTap: () {
//                         if (_key.currentState!.validate() &&
//                             _imagePicker != null) {
//                           _classBloc.add(
//                             PostDataClass(
//                                 latinName: latinName.text,
//                                 commonName: commonName.text,
//                                 characteristics: characteristics.text,
//                                 description: description.text,
//                                 image: _imagePicker),
//                           );
//                         }
//                       });
//                 }, listener: (context, state) {
//                   if (state is AddDataSuccess) {
//                     AwesomeDialog(
//                         context: context,
//                         dialogType: DialogType.success,
//                         autoDismiss: false,
//                         title: "Add Data Success",
//                         body: const Text(
//                           "Silahkan tunggu Admin untuk memverivikasi data",
//                         ),
//                         onDismissCallback: (type) => Navigator.pop(context),
//                         btnOkOnPress: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const HomeScreen()));
//                         }).show();
//                   } else if (state is Failure) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       backgroundColor: AppColor.mainColor,
//                       content: Text(state.errorMessage),
//                       duration: const Duration(seconds: 1),
//                     ));
//                   }
//                 })
//               ],
//             ),
//           ),
//         ));
//   }

//   Future<void> getImage() async {
//     final picker = ImagePicker();
//     final imagePicked = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _imagePicker = imagePicked;
//     });
//   }
// }
