//
//  Signal+Exntesions.swift
//  PARSMVVMToolkit
//
//  Created by gz on 16/7/22.
//  Copyright © 2016年 PARS. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

extension SignalProducerType {
    public final func takeUntilObjectDeallocates(object: NSObject) -> SignalProducer<Self.Value, Self.Error> {
        return self.lift { $0.takeUntilObjectDeallocates(object) }
    }
    
    #if os(iOS)
    public final func takeUntilViewControllerDisappears(viewController: UIViewController) -> SignalProducer<Self.Value, Self.Error> {
    return self.lift { $0.takeUntilViewControllerDisappears(viewController) }
    }
    #endif
    
    /// Converts values into `Optional.Some`.
    public func wrapValuesInOptional() -> SignalProducer<Optional<Self.Value>, Self.Error> {
        return self.lift { $0.wrapValuesInOptional() }
    }
    
    /// Ignores errors emitted by this producer after logging them.
    ///
    /// IMPORTANT: this operators should not be used lightly.
    /// Consider using `flatMapError` to implement better error handling.
    public func logAndIgnoreErrors(errorMessage: String) -> SignalProducer<Self.Value, NoError> {
        return self.lift { $0.logAndIgnoreErrors(errorMessage) }
    }
    
    /// Returns a `SignalProducer` that will emit `value`, followed by this producer.
    public func startingWith(value: Self.Value) -> SignalProducer<Self.Value, Self.Error> {
        return SignalProducer<Value, Error>(value: value).concat(self.producer)
    }
    
//    public func toBoxedRACSignal() -> RACSignal {
//        return toRACSignal(self.map(Box.init))
//    }
    
    /// Assumes that the signal will never emit errors by asserting at runtime
    /// if it emits one.
    /// Note: this is not the preferred way of handling errors, consider using
    /// `flatMapError` instead. This is only recommended for signals bridged
    /// from `RACSignal` that you know will never emit errors.
    public func assumeNoErrors() -> SignalProducer<Self.Value, NoError> {
        return self.lift { $0.assumeNoErrors() }
    }
}

extension SignalType {
    public final func takeUntilObjectDeallocates(object: NSObject) -> Signal<Self.Value, Self.Error> {
        return self.takeUntil(object.willDeallocSignal())
    }
    
    #if os(iOS)
    public final func takeUntilViewControllerDisappears(viewController: UIViewController) -> Signal<Self.Value, Self.Error> {
    return self
    .takeUntil(viewController.viewDidDisappearSignal())
    .takeUntilObjectDeallocates(viewController)
    }
    #endif
    
    /// Converts values into `Optional.Some`.
    public func wrapValuesInOptional() -> Signal<Optional<Self.Value>, Self.Error> {
        return self.map { .Some($0) }
    }
    
    /// Ignores errors emitted by this producer after logging them.
    ///
    /// IMPORTANT: this operators should not be used lightly.
    /// Consider using `flatMapError` to implement better error handling.
    public func logAndIgnoreErrors(errorMessage: String) -> Signal<Self.Value, NoError> {
        return self.flatMapError { error in
            print("\(errorMessage): \(error)")
            
            return .empty
        }
    }
    
//    public func toBoxedRACSignal() -> RACSignal {
//        return toRACSignal(self.map(Box.init))
//    }
    
    /// Assumes that the signal will never emit errors by asserting at runtime
    /// if it emits one.
    /// Note: this is not the preferred way of handling errors, consider using
    /// `flatMapError` instead. This is only recommended for signals bridged
    /// from `RACSignal` that you know will never emit errors.
    public func assumeNoErrors() -> Signal<Self.Value, NoError> {
        return signal.mapError { error in
            fatalError("Unexpected error found in signal that shouldn't error: \(error)")
            ()
        }
    }
}

extension NSObject {
    private final func willDeallocSignal() -> Signal<(), NoError> {
        return self
            .rac_willDeallocSignal()
            .toTriggerSignal()
    }
}

#if os(iOS)
    extension UIViewController {
        private final func viewDidDisappearSignal() -> Signal<(), NoError> {
            return self
                .rac_signalForSelector(#selector(UIViewController.viewDidDisappear(_:)))
                .toTriggerSignal()
        }
    }
#endif

extension RACSignal {
    /// RAC 4 does not provide a method to create a `Signal` from a `RACSignal`
    /// because it can't know whether these underlying `RACSignal`s are hot or cold.
    /// For certain things, like event streams (see `UIControl.signalForControlEvents`)
    /// we use this method to be able to expose these inherently hot streams
    /// as `Signal`s.
    public func toSignalAssumingHot() -> Signal<AnyObject?, NSError> {
        return Signal { observer in
            return self.toSignalProducer().start(observer)
        }
    }
    
    /// Converts this signal into a `SignalProducer` that can be used
    /// with the `takeUntil` operator, or as an "activation" signal,
    /// for a button, for example.
    public final func toTriggerSignal() -> SignalProducer<(), NoError> {
        return self
            .toSignalProducer()
            .map { _ in () }
            .assumeNoErrors()
    }
    
    private final func toTriggerSignal() -> Signal<(), NoError> {
        return self
            .toSignalAssumingHot()
            .map { _ in () }
            .assumeNoErrors()
    }
}

#if os(iOS)
    
    extension UIControl {
        public final func signalForControlEvents(events: UIControlEvents) -> Signal<(), NoError> {
            return self
                .rac_signalForControlEvents(events)
                .toTriggerSignal()
        }
    }
    
    extension UICollectionReusableView {
        public final func prepareForReuseSignal() -> Signal<(), NoError> {
            return self
                .rac_prepareForReuseSignal
                .toTriggerSignal()
        }
    }
    
    extension UITableViewCell {
        public final func prepareForReuseSignal() -> Signal<(), NoError> {
            return self
                .rac_prepareForReuseSignal
                .toTriggerSignal()
        }
    }
    
    extension UIGestureRecognizer {
        public final func gestureSignal() -> Signal<UIGestureRecognizerState, NoError> {
            return self
                .rac_gestureSignal()
                .toSignalAssumingHot()
                .assumeNoErrors()
                .map { $0 as! UIGestureRecognizer }
                .map { $0.state }
        }
    }
    
#endif

extension MutablePropertyType {
    /// Returns a "view" of this property that can only be modified.
    public var immutableView: AnyProperty<Value> {
        return AnyProperty(self)
    }
}