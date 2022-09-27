//
//  ChatController.swift
//  thinkapp-ios
//
//  Created by Mavlon on 16/09/22.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift

class ChatController: UIViewController, Routable {
    
    var router: MainRouter?
    
    private let picker = UIImagePickerController()
    
    private var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.25
        return button
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ava")
        imageView.layer.cornerRadius = 21
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.interMedium(with: 15)//syneBolt(with: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Gina Ostermann"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = BaseFont.interMedium(with: 10)//syneBolt(with: 10)
        label.textColor = UIColor(hex: "#978F8F", alpha: 0.66)
        label.textAlignment = .center
        label.text = "Online"
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#F5F5F5", alpha: 0.45)
        return view
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#000000", alpha: 0.19).cgColor
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let attachmentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
//        textView.text = "type message here"
        textView.font = BaseFont.interMedium(with: 11)
        return textView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#7C7C7C", alpha: 0.75)
        return view
    }()
    
    private let audioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "microphone"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "send"
        addViews()
        addConstraints()
        addTargets()
        conformProtocols()
    }
    
    private func addViews() {
        baseView.frame = view.bounds
        view.addSubview(baseView)
        textView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        baseView.addSubview(navigationView)
        navigationView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(backButton)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(avatarImageView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(statusLabel)
        baseView.addSubview(textContainerView)
        textContainerView.addSubview(attachmentButton)
        textContainerView.addSubview(lineView)
        textContainerView.addSubview(textView)
        textContainerView.addSubview(audioButton)
        baseView.addSubview(tableView)
    }
    
    private func addConstraints() {
        
        navigationView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
//            make.height.equalTo(100)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-22)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(42)
        }

        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(42)
        }
        
        attachmentButton.snp.makeConstraints { make in
            make.width.height.equalTo(21)
            make.left.equalToSuperview().offset(17)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(attachmentButton.snp.right).offset(15)
        }
        
        textContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-20)
//            make.top.equalTo(tableView.snp.bottom)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(11)
//            make.height.equalTo(52)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        audioButton.snp.makeConstraints { make in
            make.width.height.equalTo(23)
            make.left.equalTo(textView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.bottom.equalTo(textContainerView.snp.top)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
    }
    
    // MARK: - Private Actions
    @objc private func back() {
        router?.back()
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done"
    }
    
    @objc private func didTapAttachmentButton() {
        selectAttachmentType()
    }
    
    // MARK: - Set Actions
    func addTargets() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        attachmentButton.addTarget(self, action: #selector(didTapAttachmentButton), for: .touchUpInside)
    }
    
    func conformProtocols() {
        textView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        tableView.register(MeChatCell.self, forCellReuseIdentifier: MeChatCell.identifier)
        tableView.register(UINib(nibName: WelcomeCell.identifier, bundle: nil), forCellReuseIdentifier: WelcomeCell.identifier)
    }
}

//MARK: - TableView Methods
extension ChatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeCell.identifier, for: indexPath) as! WelcomeCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MeChatCell.identifier, for: indexPath) as! MeChatCell
            return cell
        }
           
    }
}

//MARK: - TextView Methods
extension ChatController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text!)
        textView.text = nil
        textContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-20)
//            make.top.equalTo(tableView.snp.bottom)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView.contentSize.height {
        case 0...60:
            return
        case 60...150:
            textContainerView.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
                let height = Int(textView.contentSize.height) + 4
                make.height.equalTo(height)
                make.bottom.equalToSuperview().offset(-20)
            }
        default:
            textContainerView.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
                make.height.equalTo(150)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
    }
}


//MARK: - ImagePicker Methods
extension ChatController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let _ = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - ActionSheet, Selecting attachment type
extension ChatController {
    private func selectAttachmentType() {
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.openCamera()
        }
        
        let gallery = UIAlertAction(title: "Галерея", style: .default) { _ in
            self.openLibrary()
        }
        
        let files = UIAlertAction(title: "Файлы", style: .default) { _ in
            self.openDocumentPicker()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertSheet.addAction(camera)
        alertSheet.addAction(gallery)
        alertSheet.addAction(files)
        alertSheet.addAction(cancel)
        
        present(alertSheet, animated: true)
    }
    
    private func openDocumentPicker() {
        print(#function)
    }
}
