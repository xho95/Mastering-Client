#if os(Linux)
  import Glibc
#else
  import Darwin
#endif

import Socket
import Foundation

class EchoClient {
  let bufferSize = 1024
  let port: Int
  let server: String
  var listenSocket: Socket? = nil

  init(port: Int, server: String) {
    self.port = port
    self.server = server
  }

  deinit {
    listenSocket?.close()
  }

  func start() throws {
    let socket = try Socket.create()
    listenSocket = socket
    try socket.connect(to: server, port: Int32(port))
    var dataRead = Data(capacity: bufferSize)
    var cont = true
    repeat {
      print("Enter Text:")
      if let entered = readLine(strippingNewline: true) {
        try socket.write(from: entered)
        if entered.hasPrefix("quit") {
          cont = false
        }
        let bytesRead = try socket.read(into: &dataRead)
        if bytesRead > 0 {
          if let readStr = String(data: dataRead, encoding: .utf8) {
            print("Received: \(readStr)")
          }

          dataRead.count = 0
        }
      }
    } while cont
  }
}

do {
  var echoClient = EchoClient(port: 3333, server: "192.168.0.142")
  try echoClient.start()
}
catch let error {
  print("Error: \(error)")
}
