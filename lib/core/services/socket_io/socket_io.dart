import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIO {
  io.Socket socket = io.io(
      'wss://socket1.izisoft.io',
      io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          // .setExtraHeaders({'authorization': 'Bearer ${sl.get<SharedPreferenceHelper>().getJwtToken}'}) // headers
          .enableAutoConnect()
          .build());

  ///
  /// _init
  ///
  void init() {
    if (socket.disconnected) {
      socket.connect();
      socket.onConnect(
        (_) {},
      );
    }
  }

  ///
  /// Reset socket.
  ///
  void reSetSocket() {
    socket = io.io(
      'wss://socket1.izisoft.io',
      io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          // .setExtraHeaders({'authorization': 'Bearer ${sl.get<SharedPreferenceHelper>().getJwtToken}'}) // headers
          .enableAutoConnect()
          .build(),
    );
  }
}
