//
//  Sidebar.swift
//  mySideBar
//
//  Created by Nestor Kauil on 03/08/18.
//  Copyright © 2018 Nestor Kauil. All rights reserved.
//

import Foundation
import UIKit
// Define metodo, propiedades y otros requerimientos, puede ser adoptado por una clase, estructura o enumeracion
protocol SidebarViewDelegate: class{
    func sideDidSelectRow(row:Row)
}

// Esta es la enumeracion para saber a cual parte del menu dio clic el usuario
enum Row: String {
    case editProfile
    case messages
    case contact
    case settings
    case history
    case help
    case signOut
    case none
    
    // Se enumeran las opciones haciendo llamado con variables referentes en texto
    init (row: Int){
        switch row {
        case 0: self  = .editProfile
        case 1: self  = .messages
        case 2: self  = .contact
        case 3: self  = .settings
        case 4: self  = .history
        case 5: self  = .help
        case 6: self  = .signOut
        default: self = .none
        }
    }
}

class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource {
    // Declaramos un arreglo de strings
    var titleArr = [String]()
    // Una referencia weak es solo un puntero a un objeto que no protege el objeto siendo desasignado por ARC
    // ARC: Es el tiempo de compilacion que la version de Apple gestiona la memoria automatizada, solo libera memoria para objetos
    weak var delegate: SidebarViewDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 54/255, green:55/255, blue:56/255, alpha:1.0)
        self.clipsToBounds   = true
        
        titleArr = ["Nestor Kauil", "Mensajes", "Contacto", "Configuracion", "Historia", "Ayuda", "Salir"] // Arrays de las opciones del menu
        
        setupViews()
        
        // Creamos la tabla que se muestran las opciones del menu
        myTableView.delegate                     = self
        myTableView.dataSource                   = self
        myTableView.register(UITableViewCell.self,forCellReuseIdentifier:"Cell")
        myTableView.tableFooterView              = UIView()
        myTableView.separatorStyle               = UITableViewCellSeparatorStyle.none
        myTableView.allowsSelection              = true
        myTableView.bounces                      = false
        myTableView.showsVerticalScrollIndicator = false
        myTableView.backgroundColor              = UIColor.clear
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Creamos una celda dentro de la tabla
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle  = .none
        // Solo para la primera celda personalizamos
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
            let cellImg: UIImageView! // Creamos el objeto para mostrar una imagen
            cellImg                     = UIImageView(frame: CGRect(x:15, y:10, width: 80, height: 80))
            cellImg.layer.cornerRadius  = 40 // Bordeamos las esquinas
            cellImg.layer.masksToBounds = true
            cellImg.contentMode         = .scaleAspectFill
            cellImg.layer.masksToBounds = true
            cellImg.image               = #imageLiteral(resourceName: "user") // Agregamos una imagen a la primera celda
            cell.addSubview(cellImg)
            
            let cellLbl = UILabel(frame: CGRect(x:110, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLbl)
            // Personalizamos las fuentes
            cellLbl.text      = titleArr[indexPath.row] // Texto
            cellLbl.font      = UIFont.systemFont(ofSize: 17) // Tamaño de texto
            cellLbl.textColor = UIColor.white; // Color del texto
        } else {
            cell.textLabel?.text      = titleArr[indexPath.row]
            cell.textLabel?.textColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.delegate?.sideDidSelectRow(row: Row(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)->CGFloat{
        if indexPath.row == 0{
            return 100
        } else {
            return 60
        }
    }
    
    // Funcion construye la vista de la tabla
    func setupViews(){
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive       = true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive     = true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive   = true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    let myTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder): No ha sido implementado")
    }
    
}
