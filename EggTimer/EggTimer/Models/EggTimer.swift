//
//  EggTimer.swift
//  EggTimer
//
//  Created by Zhishen Wen on 7/20/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import Foundation

protocol EggTimerProtocol {
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval)
    func timerHasFinished(_ timer: EggTimer)
}

class EggTimer {
    var timer: Timer?
    var startTime: Date?
    /// seconds
    var duration: TimeInterval = 360
    var elapsedTime: TimeInterval = 0
    
    var delegate: EggTimerProtocol?
    
    var isStopped: Bool {
        timer == nil && elapsedTime == 0
    }
    
    var isPaused: Bool {
        timer == nil && elapsedTime > 0
    }
    
    @objc func timerAction() {
        guard let startTime = startTime else { return }
        
        elapsedTime = -startTime.timeIntervalSinceNow
        
        let secondsRemaining = (duration - elapsedTime).rounded()
        if secondsRemaining > 0 {
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        } else {
            delegate?.timerHasFinished(self)
        }
    }
    
    func startTimer() {
        startTime = Date()
        elapsedTime = 0

        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )
        timerAction()
    }

    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)

        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )
        timerAction()
    }

    func stopTimer() {
        // really just pauses the timer
        timer?.invalidate()
        timer = nil

        timerAction()
    }

    func resetTimer() {
        // stop the timer & reset back to start
        timer?.invalidate()
        timer = nil

        startTime = nil
        duration = 360
        elapsedTime = 0

        timerAction()
    }
}
