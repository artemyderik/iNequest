//
//  ViewController.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 01.07.2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Outlets
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let isAliveView = UIView()
    private let fetchButton = UIButton(type: .system)
    private let linkPickerView = UIPickerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    //MARK: Private Properties
    private let links = Link.allCases
    private var selectedLink = ""
    private var nextPageLink = ""
    private var allLinks = [String]()
    private var allNames = [String]()
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllLinks(with: "https://rickandmortyapi.com/api/character?page=1")
        
        linkPickerView.delegate = self
        linkPickerView.dataSource = self
        
        setupViews()
    }
    
    //MARK: OBJC Methods
    @objc func fetchButtonTapped() {
        fetchCharacter()
    }
    
    //MARK: Private Methods
    private func getSelectedOption(_ selectedOption: String) {
        selectedLink = selectedOption
      }
    
    //MARK: UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        allLinks.count
    }
    
    //MARK: UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        allNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getSelectedOption(allLinks[row])
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
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.text = "Name\n     Status"
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Impact", size: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        setupNameLabelConstraints()
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 28),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupIsAliveView() {
        view.addSubview(isAliveView)
        
        isAliveView.translatesAutoresizingMaskIntoConstraints = false
        setupIsAliveViewConstraints()
        
        view.layoutIfNeeded()
        isAliveView.backgroundColor = .gray
        isAliveView.layer.cornerRadius = isAliveView.frame.width / 2
    }
    
    private func setupIsAliveViewConstraints() {
        NSLayoutConstraint.activate([
            isAliveView.widthAnchor.constraint(equalToConstant: 15),
            isAliveView.heightAnchor.constraint(equalToConstant: 15),
            isAliveView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5.5),
            isAliveView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor)
        ])
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
        
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        setupButtonConstraints()
    }
    
    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.bottomAnchor.constraint(equalTo: linkPickerView.topAnchor, constant: 10),
            fetchButton.widthAnchor.constraint(equalTo: linkPickerView.widthAnchor),
            fetchButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupPickerView() {
        view.addSubview(linkPickerView)

        linkPickerView.translatesAutoresizingMaskIntoConstraints = false
        setupPickerConstraints()
    }
    
    private func setupPickerConstraints() {
        NSLayoutConstraint.activate([
            linkPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupActivityIndicator() {
        imageView.addSubview(activityIndicator)
                
        activityIndicator.backgroundColor = .white
        activityIndicator.layer.opacity = 0.5
        activityIndicator.layer.cornerRadius = 11
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        setupActivityIndicatorConstraints()
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 45),
            activityIndicator.heightAnchor.constraint(equalToConstant: 45),
            activityIndicator.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor)
        ])
    }
}

//MARK: Networking
extension ViewController {
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
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage(with url: String) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getAllLinks(with url: String) {
        NetworkManager.shared.fetchPage(from: url) { [weak self] result in
            switch result {
            case .success(let page):
                
                for index in 0..<page.results.count {
                    self?.allLinks.append(page.results[index].url)
                    self?.allNames.append(page.results[index].name)
                }
                
                guard let nextPageLink = page.info.next else { return }
                self?.nextPageLink = nextPageLink
                
                self?.selectedLink = self?.allLinks[1] ?? ""
                self?.linkPickerView.reloadAllComponents()
                self?.linkPickerView.selectRow(1, inComponent: 0, animated: true)
                
                if let nextPageLink = self?.nextPageLink, !nextPageLink.isEmpty {
                    self?.getAllLinks(with: nextPageLink)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
