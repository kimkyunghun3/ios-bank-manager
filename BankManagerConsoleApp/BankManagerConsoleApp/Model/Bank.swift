//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Eddy, dudu on 2022/04/26.
//

import Foundation

protocol BankDelegate: AnyObject {
    func bankWorkDidFinish(_ bank: Bank)
    func customerWorkDidStart(_ bank: Bank, waitingNumber: Int, workType: Banking)
    func customerWorkDidFinish(_ bank: Bank, waitingNumber: Int, workType: Banking)
}

final class Bank {
    private let waitingQueue = Queue<Customer>()
    private let loanWindow: BankWindow
    private let depositWindow: BankWindow
    private(set) var customerCount = 0
    private(set) var duration = 0.0
    weak var delegate: BankDelegate?

    init(loanWindow: BankWindow, depositWindow: BankWindow) {
        self.loanWindow = loanWindow
        self.depositWindow = depositWindow

        self.loanWindow.delegate = self
        self.depositWindow.delegate = self
    }

    func open() {
        duration = checkTime(target: sendCustomerToClerk)
        delegate?.bankWorkDidFinish(self)
        reset()
    }

    func add(customers: [Customer]) {
        customers.forEach { customer in
            waitingQueue.enqueue(customer)
        }
    }

    private func checkTime(target: () -> Void) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent()
        target()
        let endTime = CFAbsoluteTimeGetCurrent()
        return (endTime - startTime)
    }

    private func sendCustomerToClerk() {
        let loanQueue = OperationQueue()
        let depositQueue = OperationQueue()

        loanQueue.maxConcurrentOperationCount = 1
        depositQueue.maxConcurrentOperationCount = 2

        while let customer = waitingQueue.dequeue() {
            customerCount += 1

            switch customer.workType {
            case .loan:
                loanQueue.addOperation {
                    self.loanWindow.receive(customer)
                }
            case .deposit:
                depositQueue.addOperation {
                    self.depositWindow.receive(customer)
                }
            }
        }

        DispatchQueue.global().sync {
            loanQueue.waitUntilAllOperationsAreFinished()
            depositQueue.waitUntilAllOperationsAreFinished()
        }
    }

    private func reset() {
        customerCount = 0
        duration = 0.0
    }
}

extension Bank: BankWindowDelegate {
    func customerWorkDidStart(_ bankWindow: BankWindow, customer: Customer) {
        delegate?.customerWorkDidStart(self, waitingNumber: customer.waitingNumber, workType: customer.workType)
    }

    func customerWorkDidFinish(_ bankWindow: BankWindow, customer: Customer) {
        delegate?.customerWorkDidFinish(self, waitingNumber: customer.waitingNumber, workType: customer.workType)
    }
}
