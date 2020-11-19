//
//  MakeBindable.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

//class MakeBindable<BindingType> {
//    private var observers = [(BindingType) -> ()]()
//    private var previousValue: BindingType?
//    init(_ value: BindingType? = nil) {
//        previousValue = value
//    }
//    
//    func currentValue() -> BindingType? {
//        return previousValue
//    }
//    
//    private func addObserver<T: AnyObject>(
//        for object: T,
//        completion: @escaping (T, BindingType) -> Void
//    ) {
//        // if there is a lastValue (which is commonly the initial value)
//        // run the completion handler on that value
//        previousValue.map { completion(object, $0) }
//        observers.append { [weak object] value in
//            guard let object = object else {
//                return
//            }
//            DispatchQueue.main.async {
//                completion(object, value)
//            }
//        }
//    }
//    
//    func update(with value: BindingType) {
//        previousValue = value
//        // call each of the functions
//        observers.forEach{ $0(value)}
//    }
//    
//    @objc func valueChanged( sender: UIControl) {
//        if let newValue = sender[keyPath: keyPath!] as? BindingType {
//            previousValue = newValue
//        }
//    }
//
//    var keyPath: AnyKeyPath?
//    
//    func bind<O: AnyObject, T>(
//        _ sourceKeyPath: KeyPath<BindingType, T>,
//        to anyObject: O,
//        _ objectKeyPath: ReferenceWritableKeyPath<O, T?>
//    ) {
//        if let control = anyObject as? UIControl {
//            control.addTarget(self, action: #selector(valueChanged), for: [.editingChanged, .valueChanged])
//            keyPath = objectKeyPath
//        }
//        
//        addObserver(for: anyObject) { object, observed in
//            let value = observed[keyPath: sourceKeyPath]
//            anyObject[keyPath: objectKeyPath] = value
//        }
//    }
//    
//    func bind<O: AnyObject, T>(
//        _ sourceKeyPath: KeyPath<BindingType, T>,
//        to anyObject: O,
//        _ objectKeyPath: ReferenceWritableKeyPath<O, T>
//    ) {
//        if let control = anyObject as? UIControl {
//            control.addTarget(self, action: #selector(valueChanged), for: [.editingChanged, .valueChanged])
//            keyPath = objectKeyPath
//        }
//        
//        addObserver(for: anyObject) { object, observed in
//            let value = observed[keyPath: sourceKeyPath]
//            anyObject[keyPath: objectKeyPath] = value
//        }
//    }
//}
