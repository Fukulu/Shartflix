import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodelabscase/Components/CustomButtons/back_chevron_button.dart';
import 'package:nodelabscase/Components/CustomButtons/primary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/secondary_large_button.dart';
import 'package:nodelabscase/Components/CustomButtons/x_mark_button.dart';
import 'package:nodelabscase/Components/CustomViews/custom_background_view.dart';
import 'package:nodelabscase/Core/Theme/app_icons.dart';
import 'package:provider/provider.dart';
import '../../Core/Theme/app_colors.dart';
import '../../Core/Theme/app_typography.dart';
import '../../ViewModel/auth_view_model.dart';

class UploadPhotoPage extends StatefulWidget {
  const UploadPhotoPage({super.key});

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    await authVM.uploadPhoto(_selectedImage!);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomBackgroundView(
        child: Consumer<AuthViewModel>(
            builder: (context, authVM, child) {
              final user = authVM.currentUser;

              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // TAG - 1 - HEADER
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BackChevronButton(onPressed: () {
                                Navigator.pop(context);
                              }),
                              const Text("Profile Detail", style: AppTypography.h4),
                              Container(color: Colors.transparent, width: 44, height: 44)
                            ],
                          ),
                        ),

                        // TAG - 2 - BODY
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.75),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: AppSvg(AppIcons.profilePhoto, size: 50,),
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text(
                                "Upload Photo",
                                style: AppTypography.h3,
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Upload a photo for your profile picture",
                                style: AppTypography.bodyMediumRegular,
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 30),

                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: DottedBorder(
                                      color: Colors.white24,
                                      strokeWidth: 1,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(40),
                                      dashPattern: const [6, 5],
                                      child: Container(
                                        width: 180,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        child: _selectedImage == null
                                            ? const Center(
                                          child: AppSvg(AppIcons.plus, size: 30),
                                        )
                                            :
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Image.file(
                                            _selectedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  if (_selectedImage != null)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: XMarkButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedImage = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),


                        // TAG - BUTTONS
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryLargeButton(
                                buttonText: "Continue",
                                onPressed: () {
                                  _uploadImage();
                                },
                                isActive: _selectedImage != null
                            ),
                            const SizedBox(height: 10,),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const SizedBox(
                                    width: 354,
                                    height: 56,
                                    child: Center(child: Text("Pass", style: AppTypography.bodyMediumBold,))
                                )
                            )
                          ],
                        ),

                      ]
                  )
              );
          },
        ),
      ),
    );
  }
}
