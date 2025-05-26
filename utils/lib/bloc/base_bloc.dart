import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

part 'base_event.dart';
part 'base_state.dart';

abstract class BaseBloc<State extends BaseState>
    extends Bloc<BaseEvent, State> {
  OverlayEntry? _loadingOverlay;

  BaseBloc(super.baseBlocState) {
    on<StatusChanged>(_onStatusChanged);
  }

  void onInitialized(Initialized event, Emitter<State> emit) async {}

  void _onStatusChanged(StatusChanged event, Emitter<BaseState> emit) {
    emit(state.copyWith(status: event.status));

    if (event.status == AsyncStatus.error && event.errorMessage.isNotEmpty) {
      resolve<AppRouter>().scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(event.errorMessage),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    if (event.status == AsyncStatus.globalLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoadingOverlay();
      });
    } else {
      _removeLoadingOverlay();
    }
  }

  void _showLoadingOverlay() {
    if (_loadingOverlay != null) return;

    final overlay = Overlay.of(
      resolve<AppRouter>().navigatorKey.currentState!.context,
      rootOverlay: true,
    );
    _loadingOverlay = OverlayEntry(
      builder:
          (context) => const Stack(
            children: [
              ModalBarrier(color: Colors.black54, dismissible: false),
              Center(child: Preloader()),
            ],
          ),
    );

    overlay.insert(_loadingOverlay!);
  }

  void _removeLoadingOverlay() {
    if (_loadingOverlay != null) {
      _loadingOverlay?.remove();
      _loadingOverlay = null;
    }
  }
}
