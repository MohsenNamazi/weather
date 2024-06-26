import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/dependency_injector/injector.dart';

class InjectedBlocProvider<B extends BlocBase<Object>> extends BlocProvider<B> {
  InjectedBlocProvider({
    super.key,
    ValueChanged<B>? onCreate,
    super.lazy,
    super.child,
  }) : super(
          create: (context) {
            final bloc = inject<B>();
            onCreate?.call(bloc);
            return bloc;
          },
        );
}
