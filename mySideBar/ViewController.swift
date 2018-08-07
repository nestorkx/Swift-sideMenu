//
//  ViewController.swift
//  mySideBar
//
//  Created by Nestor Kauil on 03/08/18.
//  Copyright © 2018 Nestor Kauil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sidebarView: SidebarView!
    var blackScreen: UIView! // Creamos una variable para crear una vista con fondo negro
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home" // Titulo por default de la pantalla principal
        
        let btnMenu = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(btnMenuAction)) // Se crea objeto para el boton del menu y se le asigna un selector para realizar una accion
        btnMenu.tintColor = UIColor(red: 54/255, green: 55/255, blue: 56/255, alpha: 1.0) // Se le aplican estilos al boton del menu para que quede gris oscuro
        self.navigationItem.leftBarButtonItem = btnMenu // Se alinea el boton hacia la izquierda
        
        
        // Creamos la barra lateral
        sidebarView = SidebarView(frame: CGRect(x:0, y:0, width: 0, height: self.view.frame.height))
        sidebarView.delegate               = self
        sidebarView.layer.zPosition        = 100
        self.view.isUserInteractionEnabled = true
        self.navigationController?.view.addSubview(sidebarView)
        
        
        // Creamos el fondo oscuro y le aplicamos ciertos estilos
        blackScreen                 = UIView(frame: self.view.bounds)
        blackScreen.backgroundColor = UIColor(white:0, alpha: 0.5)
        blackScreen.isHidden        = true // Ocultamos el fondo oscuro por default
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition = 99 // Lo sobreponemos ante los demas frames
        let tapGestRecognizer       = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
        
    }
    
    // Funcion para que al hacer clic al menu haga el efecto de sobreponerlo a la mitad
    @objc func btnMenuAction(){
        blackScreen.isHidden = false // Mostramos el fondo oscuro
        
        UIView.animate(withDuration: 0.3, animations: {
            // Creamos una animacion para que se vea como se alarga el menu de izquierda a derecha(Horizontal)
            self.sidebarView.frame = CGRect(x: 0, y:0, width: 250, height: self.sidebarView.frame.height)
        }) { (complete) in
            // Hacemos calculos para que el fondo oscuro se vaya en sincronia con el menu lateral y solo ocupe una cierta parte de la pantalla principal con fondo blanco
            self.blackScreen.frame = CGRect(x: self.sidebarView.frame.width, y:0, width: self.view.frame.width-self.sidebarView.frame.width, height: self.view.bounds.height+100)
        }
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer){
        blackScreen.isHidden = true // Ocultamos el fondo oscuro
        blackScreen.frame    = self.view.bounds
        // Creamos una animacion para que se regrese el menu, y no se vea muy tosco
        UIView.animate(withDuration: 0.3){
            self.sidebarView.frame = CGRect(x:0, y:0, width:0, height: self.sidebarView.frame.height)
        }
    }

}

extension ViewController: SidebarViewDelegate { // Esta extension hace llamado por herencia al protocolo del archivo SidebarView.swift
    // Funcion para Seleccionar las opciones del menu
    func sideDidSelectRow(row: Row) {
        blackScreen.isHidden = true // Ocultamos el fondo oscuro
        blackScreen.frame    = self.view.bounds
        UIView.animate(withDuration: 0.3){
            self.sidebarView.frame = CGRect(x:0, y:0, width: 0, height: self.sidebarView.frame.height)
        }
        switch row {
            case .editProfile:
                let vc = EditProfileVC() // Configuramos la vista de Editar perfil
                self.navigationController?.pushViewController(vc, animated: true)
            case .messages:
                print("Mensajes")
            case .contact:
                print("Contacto")
            case .settings:
                print("Configuracion")
            case .history:
                print("Historia")
            case .help:
                print("Ayuda")
            case .signOut:
                print("Sign out")
            case .none:
                break
                // default: Nunca sera ejecutado
                // break
        }
    }
}
