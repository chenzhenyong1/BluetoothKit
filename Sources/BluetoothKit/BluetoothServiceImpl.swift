//
//  Untitled.swift
//  BluetoothKit
//
//  Created by 陈振勇 on 2025/12/10.
//

import Foundation
import CoreBluetooth

public class BluetoothServiceImpl: NSObject, BluetoothServiceProtocol, CBCentralManagerDelegate {
    
    public private(set) var currentState: BluetoothState = .unknown
    private var centralManager: CBCentralManager!
    
    override public init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    public func startScanning() {
        guard centralManager.state == .poweredOn else {
            print("Bluetooth not ready")
            return
        }
        centralManager.scanForPeripherals(withServices: nil)
        currentState = .scanning
        print("✅ Start scanning...")
    }
    
    public func stopScanning() {
        centralManager.stopScan()
        currentState = .poweredOn
    }
    
    // MARK: - CBCentralManagerDelegate
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            currentState = .poweredOn
            print("Bluetooth powered on")
        case .poweredOff:
            currentState = .poweredOff
            print("Bluetooth powered off")
        default:
            currentState = .unknown
        }
    }
}
