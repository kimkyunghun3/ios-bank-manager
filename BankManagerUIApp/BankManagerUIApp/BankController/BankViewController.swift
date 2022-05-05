//
//  BankManagerUIApp - ViewController.swift
//  Created by Eddy, dudu.
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

private extension UIStackView {
    func removeAllSubViews() {
        arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
}
final class BankViewController: UIViewController {
    private lazy var bankView = BankView(frame: view.bounds)
    private let bank = Bank(loanWindow: BankLoanWindow(), depositWindow: BankDepositWindow())
    private var timer: Timer?
    private var seconds: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        bind()
    }
}

extension BankViewController {
    private func attribute() {
        bankView.backgroundColor = .systemBackground
        bank.delegate = self
    }
    
    private func bind() {
        view = bankView
        bankView.addCustomerbutton.addTarget(self, action: #selector(addCustomerButtonTapped), for: .touchUpInside)
        bankView.resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addCustomerButtonTapped() {
        let customers = BankCustomer.make(startNumber: bank.waitingNumber, count: 10)
        
        customers.forEach { customer in
            bankView.waitStackView.addArrangedSubview(CustomerView(customer: customer))
        }
        
        bank.add(customers: customers)
        setTimer()
    }
    
    @objc private func resetButtonTapped() {
        resetTimer()
        bankView.businessHoursLabel.text = "업무시간 - 00:00:000"
        
        bankView.workStackView.removeAllSubViews()
        bankView.waitStackView.removeAllSubViews()
        
        bank.reset()
    }
    
    private func setTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        }
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func startTimer() {
        seconds += 0.003
        
        let minute = Int(seconds / 60)
        let second = Int(seconds.truncatingRemainder(dividingBy: 60))
        let miliSecond = seconds.truncatingRemainder(dividingBy: 1) * 1000
            
        bankView.businessHoursLabel.text = String(format: "업무시간 - %02d:%02d:%03.0f", minute, second, miliSecond )
    }
}

extension BankViewController: BankDelegate {
    func bankWorkDidFinish(_ bank: Bank) {
        resetTimer()
    }
    
    func customerWorkDidStart(_ bank: Bank, id: String) {
        DispatchQueue.main.async { [weak self] in
            guard let customerViews = self?.bankView.waitStackView.arrangedSubviews as? [CustomerView] else { return }
            
            guard let targetView = customerViews.filter({ customerView in
                customerView.customer.id == id
            }).first else { return }
            
            targetView.removeFromSuperview()
            self?.bankView.workStackView.addArrangedSubview(targetView)
        }
    }
    
    func customerWorkDidFinish(_ bank: Bank, id: String) {
        DispatchQueue.main.async { [weak self] in
            guard let customerViews = self?.bankView.workStackView.arrangedSubviews as? [CustomerView] else { return }
            
            guard let targetView = customerViews.filter({ customerView in
                customerView.customer.id == id
            }).first else { return }
            
            targetView.removeFromSuperview()
        }
    }
}
