import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:workspace/core/widgets/connection_status_view.dart';

/// يغلّف التطبيق بالكامل ويعرض overlay "لا يوجد اتصال" تلقائياً عند انقطاع
/// الإنترنت، مع زر إعادة المحاولة. يُركَّب عبر [MaterialApp.builder].
class ConnectivityGate extends StatefulWidget {
  final Widget child;

  const ConnectivityGate({super.key, required this.child});

  @override
  State<ConnectivityGate> createState() => _ConnectivityGateState();
}

class _ConnectivityGateState extends State<ConnectivityGate> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _sub;
  bool _offline = false;
  bool _retrying = false;

  @override
  void initState() {
    super.initState();
    _sub = _connectivity.onConnectivityChanged.listen((_) => _check());
    _check();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// فحص فعلي للوصول للإنترنت (وليس مجرد وجود شبكة).
  Future<bool> _hasInternet() async {
    try {
      final result =
          await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _check() async {
    final online = await _hasInternet();
    if (mounted) setState(() => _offline = !online);
  }

  Future<void> _retry() async {
    setState(() => _retrying = true);
    final online = await _hasInternet();
    if (mounted) {
      setState(() {
        _retrying = false;
        _offline = !online;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_offline)
          Positioned.fill(
            child: Material(
              color: const Color.fromRGBO(33, 33, 33, 0.45),
              child: Center(
                child: ConnectionStatusCard(onRetry: _retry, isRetrying: _retrying),
              ),
            ),
          ),
      ],
    );
  }
}
