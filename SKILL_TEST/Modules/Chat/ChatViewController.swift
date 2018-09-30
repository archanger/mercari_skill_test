//
//  ChatViewController.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol ChatViewSource: UITableViewDelegate, UITableViewDataSource { }

protocol ChatViewProtocol: class {
    func setTitle(_ title: String)
    func reloadData()
    func insert(indexes: [IndexPath])
    func registerModels(_ models: [CellPresentableModel.Type])
}

protocol ChatViewConfigurer: class {
    func readyToConfigure()
}

class ChatViewController: UIViewController {

    weak var configurator: ChatViewConfigurer?
    weak var source: ChatViewSource? {
        didSet {
            if tableView != nil {
                tableView.dataSource = source
                tableView.delegate = source
            }
        }
    }
    var interactor: ChatInteractorProtocol?
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var textField: UITextField!
    private var fetchedMessages: [MessageEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startAvoidingKeyboard()
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.dataSource = source
        tableView.delegate = source
        
        tableView.separatorStyle = .none
        
        configurator?.readyToConfigure()
        interactor?.loadData()
    }
    
    @IBAction private func send(_ sender: UIButton) {
        if let message = textField.text {
            interactor?.sendMessage(message)
            textField.text = nil
        }
    }
    
    private func startAvoidingKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardFrameWillChangeNotificationReceived(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    private func stopAvoidingKeyboard() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    @objc private func onKeyboardFrameWillChangeNotificationReceived(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
        
        let animationDuration: TimeInterval = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            self.additionalSafeAreaInsets.bottom = intersection.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    deinit {
        stopAvoidingKeyboard()
    }
}

extension ChatViewController: ChatViewProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func insert(indexes: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: .bottom)
        tableView.endUpdates()
        
        if let lastPath = indexes.last {
            tableView.scrollToRow(at: lastPath, at: .bottom, animated: true)
        }
    }
    
    func registerModels(_ models: [CellPresentableModel.Type]) {
        models.forEach { self.tableView.registerNib(of: $0.self) }
    }
}
