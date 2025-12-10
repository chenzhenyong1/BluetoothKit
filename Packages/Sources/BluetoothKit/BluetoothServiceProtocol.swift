import Foundation

public enum BluetoothState {
    case poweredOff
    case poweredOn
    case scanning
    case unknown
}

public protocol BluetoothServiceProtocol: AnyObject {
    var currentState: BluetoothState { get }
    func startScanning()
    func stopScanning()
}
