//
//  EasyTimer.swift
//  EasyTimer
//
//  Created by Niklas Fahl on 3/2/16.
//  Copyright © 2016 High Bay. All rights reserved.
//

import Foundation

// MARK: - NSTimeInterval Extension for easy timer functionality

extension NSTimeInterval {
    /// Create a timer that will call `block` once or repeatedly in specified time intervals.
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop. To start it use the start function.
    ///         Use the delay or interval functions to create and schedule a timer in one step.
    ///
    /// - Parameters:
    ///     - repeats:  Bool representing if timer repeats.
    ///     - delays:   Bool representing if timer executes immediately
    ///     - block:    Code in block will run in every timer repetition.
    /// - returns: A new NSTimer instance
    func timer(repeats repeats: Bool, delays: Bool, _ block: () -> Void) -> NSTimer {
        if !delays {
            block()
        }
        if repeats {
            return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + self, self, 0, 0) { _ in
                block()
            }
        } else {
            return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + self, 0, 0, 0) { _ in
                block()
            }
        }
    }
    
    /// Create a timer that will call `block` once or repeatedly in specified time intervals.
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop. To start it use the start function.
    ///         Use the delay or interval functions to create and schedule a timer in one step.
    ///
    /// - Parameters:
    ///     - repeats:  Bool representing if timer repeats.
    ///     - block:    Code in block will run in every timer repetition. (NSTimer available as parameter in block)
    /// - returns: A new NSTimer instance
    func timer(repeats repeats: Bool, delays: Bool, _ block: (NSTimer) -> Void) -> NSTimer {
        if repeats {
            let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + self, self, 0, 0) { timer in
                block(timer)
            }
            if !delays {
                block(timer)
            }
            return timer
        } else {
            let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + self, 0, 0, 0) { timer in
                block(timer)
            }
            if !delays {
                block(timer)
            }
            return timer
        }
    }
    
    /// Create and schedule a timer that will call `block` once with delay of time interval it is called on.
    ///
    /// - Parameters:
    ///     - block:    Code in `block` will run once after delay.
    /// - returns: A new NSTimer instance
    public func delay(block: () -> Void) -> NSTimer {
        let timer = self.timer(repeats: false, delays: true, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` once with delay of time interval it is called on.
    ///
    /// - Parameters:
    ///     - block:    Code in `block` will run once after delay. (NSTimer available as parameter in `block`)
    /// - returns: A new NSTimer instance
    public func delay(block: (NSTimer) -> Void) -> NSTimer {
        let timer = self.timer(repeats: false, delays: true, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` repeatedly in time interval it is called on without delay.
    ///
    /// - Parameters:
    ///     - block:    Code in `block` will run in every timer repetition.
    /// - returns: A new NSTimer instance
    public func interval(block: () -> Void) -> NSTimer {
        let timer = self.timer(repeats: true, delays: false, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` repeatedly in time interval it is called on without delay.
    ///
    /// - Parameters:
    ///     - block:    Code in `block` will run in every timer repetition. (NSTimer available as parameter in `block`)
    /// - returns: A new NSTimer instance
    public func interval(block: (NSTimer) -> Void) -> NSTimer {
        let timer = self.timer(repeats: true, delays: false, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` repeatedly in time interval it is called on delayed by the same time interval.
    ///
    /// - Parameters:
    ///     - block:    Code in `block` will run in every timer repetition.
    /// - returns: A new NSTimer instance
    public func delayedInterval(block: () -> Void) -> NSTimer {
        let timer = self.timer(repeats: true, delays: true, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` repeatedly in time interval it is called on delayed by the same time interval.
    ///
    /// - Parameters:
    ///     - block:    Code in `block` will run in every timer repetition. (NSTimer available as parameter in `block`)
    /// - returns: A new NSTimer instance
    public func delayedInterval(block: (NSTimer) -> Void) -> NSTimer {
        let timer = self.timer(repeats: true, delays: true, block)
        timer.start()
        return timer
    }
}

// MARK: - NSTimer Extension for timer start and cancel functionality

extension NSTimer {
    /// Schedules this timer on the run loop
    ///
    /// By default, the timer is scheduled on the current run loop for the default mode.
    /// Specify `runLoop` or `modes` to override these defaults.
    public func start(runLoop runLoop: NSRunLoop = NSRunLoop.currentRunLoop(), modes: String...) {
        let modes = modes.isEmpty ? [NSDefaultRunLoopMode] : modes
        
        for mode in modes {
            runLoop.addTimer(self, forMode: mode)
        }
    }
    
    /// Remove this timer from the run loop
    ///
    /// By default, the timer is removed from the current run loop for the default mode.
    /// Specify `runLoop` or `modes` to override these defaults.
    public func stop(runLoop runLoop: NSRunLoop = NSRunLoop.currentRunLoop(), modes: String...) {
        self.invalidate()
        let modes = modes.isEmpty ? [NSDefaultRunLoopMode] : modes
        
        for mode in modes {
            CFRunLoopRemoveTimer(runLoop.getCFRunLoop(), self, mode)
        }
    }
}