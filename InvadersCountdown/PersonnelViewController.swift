//
//  PersonnelViewController.swift
//  InvadersCountdown
//
//  Created by Julia Semyzhenko on 7/24/22.
//

import UIKit

class PersonnelViewController: UIViewController, UITabBarControllerDelegate {
    let lastTreckedPOW = 496
    
    @IBOutlet weak var dayOfWarLabel: UILabel!
    @IBOutlet weak var personnelLabel: UILabel!
    @IBOutlet weak var powLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayOfWarLabel.text = "\(screenData.day)"
        
        JSONCaller.shared.getPersonnelData { [weak self]
            result in
            switch result {
            case .success( let data):
                for item in data {
                    if item.date == screenData.date {
                        self?.labelUpdate(personnel: "\(item.personnel)", pow: "\( item.POW ?? self!.lastTreckedPOW)+", day: "\(item.day)")
                        break
                    }
                    self?.labelUpdate(personnel: "\(data[data.count - 1].personnel)", pow: "\(data[data.count - 1].POW ?? self!.lastTreckedPOW)+",  day: "\(screenData.day)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.delegate = self
        viewDidLoad()
    }
    
    func labelUpdate(personnel: String, pow: String, day:  String) {
        DispatchQueue.main.async {
            self.personnelLabel.text = personnel
            self.powLabel.text = pow
            self.dayOfWarLabel.text = day
        }
    }
}

