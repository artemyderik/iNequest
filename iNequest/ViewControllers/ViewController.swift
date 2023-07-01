//
//  ViewController.swift
//  iNequest
//
//  Created by Артемий Дериглазов on 01.07.2023.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Private Properties
    private let fetchButton = UIButton(type: .system)
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }
    
    //MARK: OBJC Methods
    @objc func fetchButtonTapped() {
        fetchCartoonPerson()
    }
    
    //MARK: Private Methods
    private func setUpButton() {
        view.addSubview(fetchButton)
                
        fetchButton.setTitle("Fetch It", for: .normal)
        fetchButton.tintColor = .white
        fetchButton.backgroundColor = .brown
        fetchButton.layer.cornerRadius = 9
        
        fetchButton.addTarget(
            self,
            action: #selector(fetchButtonTapped),
            for: .touchUpInside
        )
        
        fetchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fetchButton.widthAnchor.constraint(equalToConstant: 130),
            fetchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: Networking
extension ViewController {
    private func fetchCartoonPerson() {
        guard let url = URL(string: Link.florflock.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let cartoonPerson = try JSONDecoder().decode(
                    CartoonPerson.self,
                    from: data
                )
                print(cartoonPerson)
            }
            catch let error {
                print(error)
            }

        }.resume()
    }
}

