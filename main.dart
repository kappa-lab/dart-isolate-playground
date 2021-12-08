import 'dart:io';
import 'dart:isolate';

/**
------- print ------
main
workerRecieve :Init
workerRecieve :Send 1
workerRecieve :Send 2
end
--------------------
**/

void main() {
  print("main");

  final receivePort = new ReceivePort();
  Isolate.spawn(workerReciever, receivePort.sendPort);

  receivePort.listen((port) {
    if (port is SendPort) {
      port.send("Init");
      Isolate.spawn(workerSender, port);

      sleep(Duration(seconds: 1));

      //If receivePort dose not close, Process will not terminate.
      receivePort.close();
      print("end");
    }
  });
}

//ReceivePort Can Not set argument.
void workerReciever(SendPort port) {
  //Create ReceivePort into Worker.
  final receiver = new ReceivePort()
    ..listen((message) => print("workerRecieve :$message"));

  //and reply SendPort (boo...)
  port.send(receiver.sendPort);
}

void workerSender(SendPort port) {
  sleep(Duration(milliseconds: 100));
  port.send("Send 2");
  sleep(Duration(milliseconds: 100));
  port.send("Send 3");
}
