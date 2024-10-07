abstract class Handler {
  Handler? next;

  Handler setNext(Handler handler) {
    next = handler;
    return handler;
  }

  void handle(String request);
}

class First extends Handler {
  @override
  void handle(String request) {
    if (request == "Breath") {
      print("Lung handled $request");
    } else if (next != null) {
      next!.handle(request);
    }
  }
}

class Second extends Handler {
  @override
  void handle(String request) {
    if (request == "View") {
      print("Eyes handled $request");
    } else if (next != null) {
      next!.handle(request);
    }
  }
}

void main() {
  Handler handler1 = First();
  Handler handler2 = Second();

  handler1.setNext(handler2);

  handler1.handle("Breath"); // Output: Lung handled Breath
  handler1.handle("View"); // Output: Eyes handled View
}
