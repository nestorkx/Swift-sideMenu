//
//  EditProfileVC.swift
//  mySideBar
//
//  Created by Nestor Kauil on 06/08/18.
//  Copyright © 2018 Nestor Kauil. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white // Color de fondo blanco
    
        self.view.addSubview(lbl)
        lbl.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive              = true
        lbl.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive            = true
        lbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 60).isActive                      = true
    }
    
 let lbl: UILabel = {
    let label                                       = UILabel()
    label.text                                      = "Editar Perfil"
    label.textColor                                 = UIColor.black
    label.font                                      = UIFont.systemFont(ofSize: 30)
    label.textAlignment                             = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()
    
}
