import PackageDescription

let package = Package(
    name: "MasteringSwift-Client",
    dependencies: [
      .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", majorVersion: 0, minor: 10),
    ]
)
