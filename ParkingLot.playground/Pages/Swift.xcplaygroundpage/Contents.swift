import UIKit
import Foundation


protocol Vehicle {
    var size: VehicleSize { get }
    var requiredSpots: Int { get }
}

enum VehicleSize {
    case motorcycle
    case compactCar
    case regularCar
    case van
}

@propertyWrapper
struct Observable<T> {
    private var value: T
    private var observer: ((T) -> Void)?
    
    var wrappedValue: T {
        get { return value }
        set {
            value = newValue
            observer?(newValue)
        }
    }
    
    init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    mutating func observe(observer: @escaping (T) -> Void) {
        self.observer = observer
    }
}

class ParkingSpot: Equatable  {
    var isAvailable: Bool = true
    var vehicle: Vehicle?
    
    func park(vehicle: Vehicle) {
        self.vehicle = vehicle
        isAvailable = false
    }
    
    func vacate() {
        vehicle = nil
        isAvailable = true
    }
    
    static func ==(lhs: ParkingSpot, rhs: ParkingSpot) -> Bool {
            return lhs === rhs
    }
}

class ParkingLot {
    private var parkingSpots: [ParkingSpot]
    
    @Observable private var motorcycleSpots: Int
    @Observable private var carSpots: Int
    @Observable private var largeSpots: Int
    
    private var occupiedMotorcycleSpots: Int = 0
    private var occupiedCompactCarSpots: Int = 0
    private var occupiedRegularCarSpots: Int = 0
    private var occupiedLargeSpots: Int = 0
    
    init(motorcycleSpots: Int, carSpots: Int, largeSpots: Int) {
        self.motorcycleSpots = motorcycleSpots
        self.carSpots = carSpots
        self.largeSpots = largeSpots
        
        self.parkingSpots = Array(repeating: ParkingSpot(), count: motorcycleSpots + carSpots + largeSpots)
        
        _motorcycleSpots.observe { [weak self] newValue in
            self?.updateSpotAvailability()
        }
        
        _carSpots.observe { [weak self] newValue in
            self?.updateSpotAvailability()
        }
        
        _largeSpots.observe { [weak self] newValue in
            self?.updateSpotAvailability()
        }
    }
    
    private func updateSpotAvailability() {
        let totalSpots = motorcycleSpots + carSpots + largeSpots
        
        if totalSpots < parkingSpots.count {
            parkingSpots.removeLast(parkingSpots.count - totalSpots)
        } else if totalSpots > parkingSpots.count {
            let additionalSpots = totalSpots - parkingSpots.count
            let newSpots = Array(repeating: ParkingSpot(), count: additionalSpots)
            parkingSpots.append(contentsOf: newSpots)
        }
    }
    
    func remainingSpots() -> Int {
        return parkingSpots.filter { $0.isAvailable }.count
    }
    
    func totalSpots() -> Int {
        return parkingSpots.count
    }
    
    func isFull() -> Bool {
        return remainingSpots() == 0
    }
    
    func isEmpty() -> Bool {
        return parkingSpots.allSatisfy { $0.isAvailable }
    }
    
    func areMotorcycleSpotsFull() -> Bool {
        let motorcycleSpots = parkingSpots.filter { $0.vehicle?.size == .motorcycle }
        return motorcycleSpots.count == self.motorcycleSpots
    }
    
    func vanSpotsOccupied() -> Int {
        let vanSpots = parkingSpots.filter { $0.vehicle?.size == .van }
        return vanSpots.count
    }
    
    func parkVehicle(vehicle: Vehicle) {
        if let availableSpot = parkingSpots.first(where: { $0.isAvailable }) {
            if canFitVehicle(vehicle: vehicle, inSpot: availableSpot) {
                availableSpot.park(vehicle: vehicle)
                updateOccupiedSpotsCount(vehicle: vehicle, increase: true)
                print("\(vehicle.size) parked successfully!")
            } else {
                print("Not enough consecutive spots available for \(vehicle.size).")
            }
        } else {
            print("No more spots available.")
        }
    }
    
    func canFitVehicle(vehicle: Vehicle, inSpot spot: ParkingSpot) -> Bool {
        if vehicle.requiredSpots == 1 {
            return spot.isAvailable
        } else {
            guard let startIndex = parkingSpots.firstIndex(of: spot) else { return false }
            let endIndex = startIndex + vehicle.requiredSpots - 1
            let consecutiveSpots = Array(parkingSpots[startIndex...endIndex])
            return consecutiveSpots.allSatisfy { $0.isAvailable }
        }
    }
    
    func updateOccupiedSpotsCount(vehicle: Vehicle, increase: Bool) {
        switch vehicle.size {
        case .motorcycle:
            occupiedMotorcycleSpots += increase ? 1 : -1
        case .compactCar:
            occupiedCompactCarSpots += increase ? 1 : -1
        case .regularCar:
            occupiedRegularCarSpots += increase ? 1 : -1
        case .van:
            occupiedLargeSpots += increase ? vehicle.requiredSpots : -vehicle.requiredSpots
        }
    }
}
