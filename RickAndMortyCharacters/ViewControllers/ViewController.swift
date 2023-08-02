//
//  ViewController.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 01.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let isAliveView = UIView()
    private let fetchButton = UIButton(type: .system)
    private let linkPickerView = UIPickerView()
    private let imageActivityIndicator = UIActivityIndicatorView(style: .large)
    private let pickerActivityIndicator = UIActivityIndicatorView(style: .large)
    private let statusSegmentedControl = UISegmentedControl(items: ["All", "Dead", "Alive", "Unknown"])
    
    //MARK: Private Properties
    private var selectedLink = ""
    private var selectedLinks = [String]()
    private var selectedNames = [String]()
    
    private var allLinks = [String]()
    private var deadLinks = [String]()
    private var aliveLinks = [String]()
    private var unknownLinks = [String]()
    
    private var allNames = [String]()
    private var deadNames = [String]()
    private var aliveNames = [String]()
    private var unknownNames = [String]()
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllLinks(with: "https://rickandmortyapi.com/api/character?page=1")
        
        linkPickerView.delegate = self
        linkPickerView.dataSource = self
        
        setupViews()
    }
    
    //MARK: OBJC Methods
    @objc private func fetchButtonTapped() {
        fetchCharacter()
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setNewValues(from: allLinks, and: allNames)
        case 1:
            setNewValues(from: deadLinks, and: deadNames)
        case 2:
            setNewValues(from: aliveLinks, and: aliveNames)
        default:
            setNewValues(from: unknownLinks, and: unknownNames)
        }
    }
    
    //MARK: Private Methods
    private func getSelectedOption(_ selectedOption: String) {
        selectedLink = selectedOption
    }
    
    private func setNewValues(from links: [String], and names: [String]) {
        selectedLink = links[1]
        linkPickerView.selectRow(1, inComponent: 0, animated: true)
        selectedNames = names
        selectedLinks = links
        linkPickerView.reloadAllComponents()
    }
}

//MARK: UIPickerView DataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        selectedLinks.count
    }
}

//MARK: UIPickerView Delegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getSelectedOption(selectedLinks[row])
    }
}

//MARK: Setup Views Methods
extension ViewController {
    private func setupViews() {
        setupPickerView()
        setUpButton()
        setupImageView()
        setupNameLabel()
        setupIsAliveView()
        setupActivityIndicator()
        
        setupStatusSegmentedControl()
        
        setupPickerActivityIndicator()
    }
    
    private func setupStatusSegmentedControl() {
        view.addSubview(statusSegmentedControl)
        statusSegmentedControl.selectedSegmentIndex = 0
        statusSegmentedControl.addTarget(
            self,
            action: #selector(segmentedControlValueChanged),
            for: .valueChanged
        )
        setupStatusSegmentedControlConstraints()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .scaleAspectFit
        
        setupImageViewConstraints()
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "Name\n     Status"
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Impact", size: 22)
        setupNameLabelConstraints()
    }
    
    private func setupIsAliveView() {
        view.addSubview(isAliveView)
        
        setupIsAliveViewConstraints()
        
        view.layoutIfNeeded()
        isAliveView.backgroundColor = .gray
        isAliveView.layer.cornerRadius = isAliveView.frame.width / 2
    }
    
    private func setUpButton() {
        view.addSubview(fetchButton)
        
        fetchButton.setTitle("FETCH", for: .normal)
        fetchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        fetchButton.tintColor = .white
        fetchButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        fetchButton.layer.cornerRadius = 10
        
        fetchButton.addTarget(
            self,
            action: #selector(fetchButtonTapped),
            for: .touchUpInside
        )
        
        setupButtonConstraints()
    }
    
    private func setupPickerView() {
        view.addSubview(linkPickerView)
        setupPickerConstraints()
    }
    
    private func setupPickerActivityIndicator() {
        view.addSubview(pickerActivityIndicator)
        
        pickerActivityIndicator.hidesWhenStopped = true
        
        pickerActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerActivityIndicator.centerXAnchor.constraint(equalTo: self.linkPickerView.centerXAnchor),
            pickerActivityIndicator.centerYAnchor.constraint(equalTo: self.linkPickerView.centerYAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        imageView.addSubview(imageActivityIndicator)
        
        imageActivityIndicator.backgroundColor = .white
        imageActivityIndicator.layer.opacity = 0.5
        imageActivityIndicator.layer.cornerRadius = 11
        
        imageActivityIndicator.hidesWhenStopped = true
        
        setupActivityIndicatorConstraints()
    }
}

//MARK: Layout
extension ViewController {
    private func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 28),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupIsAliveViewConstraints() {
        isAliveView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isAliveView.widthAnchor.constraint(equalToConstant: 15),
            isAliveView.heightAnchor.constraint(equalToConstant: 15),
            isAliveView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5.5),
            isAliveView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor)
        ])
    }
    
    private func setupStatusSegmentedControlConstraints() {
        statusSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusSegmentedControl.bottomAnchor.constraint(equalTo: fetchButton.topAnchor, constant: -10),
            statusSegmentedControl.centerXAnchor.constraint(equalTo: fetchButton.centerXAnchor),
            statusSegmentedControl.widthAnchor.constraint(equalTo: fetchButton.widthAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.bottomAnchor.constraint(equalTo: linkPickerView.topAnchor, constant: 10),
            fetchButton.widthAnchor.constraint(equalTo: linkPickerView.widthAnchor),
            fetchButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupPickerConstraints() {
        linkPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            linkPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        imageActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageActivityIndicator.widthAnchor.constraint(equalToConstant: 45),
            imageActivityIndicator.heightAnchor.constraint(equalToConstant: 45),
            imageActivityIndicator.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            imageActivityIndicator.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor)
        ])
    }
}

//MARK: Networking
extension ViewController {
    private func getAllLinks(with url: String) {
        pickerActivityIndicator.startAnimating()
        linkPickerView.layer.opacity = 0.6
        linkPickerView.isUserInteractionEnabled = false
        statusSegmentedControl.layer.opacity = 0.3
        statusSegmentedControl.isUserInteractionEnabled = false
        
        
        NetworkManager.shared.fetch(Page.self, from: url) { [weak self] result in
            switch result {
            case .success(let page):
                for index in 0..<(page.results?.count ??  10) {
                    self?.allLinks.append(page.results?[index].url ?? "")
                    self?.allNames.append(page.results?[index].name ?? "")
                }
                
                self?.selectedLinks = self?.allLinks ?? [""]
                self?.selectedNames = self?.allNames ?? [""]
                self?.selectedLink = self?.allLinks[1] ?? ""
                self?.linkPickerView.reloadAllComponents()
                self?.linkPickerView.selectRow(1, inComponent: 0, animated: true)
                
                if self?.allNames.count == page.info?.count {
                    DispatchQueue.main.async {
                        self?.pickerActivityIndicator.stopAnimating()
                        self?.linkPickerView.layer.opacity = 1
                        self?.linkPickerView.isUserInteractionEnabled = true
                        self?.statusSegmentedControl.layer.opacity = 1
                        self?.statusSegmentedControl.isUserInteractionEnabled = true
                    }
                    
                    DispatchQueue.main.async {
                        self?.getStatusArrays()
                    }
                }
                
                guard let nextPageLink = page.info?.next else { return }
                self?.getAllLinks(with: nextPageLink)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.linkPickerView.layer.opacity = 0
                }
                print(error)
            }
        }
    }
    
    
    private func fetchCharacter() {
        NetworkManager.shared.fetchCharacter(from: selectedLink) { [weak self] result in
            switch result {
            case .success(let character):
                self?.fetchImage(with: character.image)
                self?.nameLabel.text = "Name: \(character.name)\n     Status: \(character.status)"
                
                if character.status == "Alive" {
                    self?.isAliveView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                } else if character.status == "Dead" {
                    self?.isAliveView.backgroundColor = #colorLiteral(red: 0.9997950196, green: 0.2968846965, blue: 0.2968846965, alpha: 1)
                } else {
                    self?.isAliveView.backgroundColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
                }
                
            case . failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchImage(with url: String) {
        DispatchQueue.main.async {
            self.imageActivityIndicator.startAnimating()
        }
        
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.imageActivityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getStatusArrays() {
        for link in allLinks {
            NetworkManager.shared.fetch(Character.self, from: link) { [weak self] result in
                switch result {
                case .success(let character):
                    if character.status == "Alive" {
                        self?.aliveLinks.append(character.url)
                        self?.aliveNames.append(character.name)
                    } else if character.status == "Dead" {
                        self?.deadLinks.append(character.url)
                        self?.deadNames.append(character.name)
                    } else {
                        self?.unknownLinks.append(character.url)
                        self?.unknownNames.append(character.name)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
