//
//  TimerView.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/19/24.
//

import UIKit

/// View, displaying the remaining time, until the particular event 
final class TimerView: UIView {

    // MARK: - Initializers

    private var timer: Timer?

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.textColor = .commonTextColor
        return label
    }()

    private var eventDate: Date?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Functionality

    private func setupView() {
        backgroundColor = UIColor.clear

        let borderView = UIView()
        borderView.layer.borderColor = UIColor.commonTextColor.cgColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 5

        borderView.addSubview(timerLabel)
        timerLabel.fillSuperview(padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))

        addSubview(borderView)
        borderView.fillSuperview()
    }

    private func runTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }

    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func expireTimer() {
        timerLabel.text = "00:00:00"
        timerLabel.textColor = .red
        invalidateTimer()
    }

    @objc private func updateTimer() {
        guard let eventDate = eventDate else { return }


        let countdown = Calendar.current.dateComponents([.hour, .minute, .second],
                                                        from: Date(),
                                                        to: eventDate)
        guard let hours = countdown.hour,
              let minutes = countdown.minute,
              let seconds = countdown.second else {
            invalidateTimer()
            return
        }

        guard hours > 0 else {
            expireTimer()
            return
        }

        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    /// Configuration of timer label and starting of the timer
    /// - Parameter eventDate: date of the particular event
    func configureTime(eventDate: Date) {
        self.eventDate = eventDate
        runTimer()
    }
    
    /// Brings the timer to default
    func resetTimer() {
        timerLabel.text = "00:00:00"
        timerLabel.textColor = .commonTextColor
        invalidateTimer()
    }

}

