import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';

import '../../widgets/galaxy_button.dart';

part 'repository_exception.g.dart';

@JsonSerializable()
class RepositoryException implements Exception{
  final String message;
  final int status;
  final DateTime timestamp;

  RepositoryException({
    required this.status,
    required this.message,
    DateTime? timestamp
  }) : timestamp = timestamp ?? DateTime.now();

  factory RepositoryException.fromJson(Map<String, dynamic> json) => _$RepositoryExceptionFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryExceptionToJson(this);

  void showMessageDialog(BuildContext context, Function() onClose, {String? title}){
    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: null,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FluentIcons.warning, color: Colors.white, size: 65),
                Text("Erro ${title??status}!", style: GalaxyFoodTheme.text.titleLarge),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(message, style: GalaxyFoodTheme.text.bodyLarge,
                    textAlign: TextAlign.center,),
                ),

                Center(
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: GalaxyButton(
                        onPressed: onClose,
                        child: const Text("FECHAR")
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}