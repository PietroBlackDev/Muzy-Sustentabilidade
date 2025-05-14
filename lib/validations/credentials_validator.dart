import 'package:lucid_validation/lucid_validation.dart';
import 'package:tg/model/credenciais_model.dart';

class CredentialsValidator extends LucidValidator<CredenciaisModel> {
  CredentialsValidator() {
    ruleFor(
      (model) => model.usuario,
      key: 'usuario',
    ).minLength(message: 'Minimo de 3 caracteres', 3);

    ruleFor(
      (model) => model.senha,
      key: 'senha',
    ).minLength(message: 'Minimo de 3 caracteres', 3);
  }
}
