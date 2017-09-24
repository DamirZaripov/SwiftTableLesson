//
//  OwnInfoTableViewController.swift
//  Informantion&Followers
//
//  Created by Дамир Зарипов on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

enum InfoViewModelItemType {
    case status
    case basicInfo
    case contacts
    case carier
    case education
    case presents
    case files
}

protocol InfoViewModelItem {
    var type: InfoViewModelItemType {get}
    var sectionType: String {get}
    var rowCount: Int {get}
}

struct InfoViewModelStatusItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .status
    }
    var sectionType: String{
        return ""
    }
    var rowCount: Int {
        return 1
    }
    var status: String
}

struct BasicInfo {
    var title: String
    var info: String
}

struct InfoViewModelBasicInfoItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .basicInfo
    }
    var sectionType: String{
        return ""
    }
    
    var basicInfo: [BasicInfo]
    
    var rowCount: Int{
        return basicInfo.count
    }
    
}

struct Contacts {
    var image: UIImage
    var contact: String
}

struct InfoVIewModelContactsItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .contacts
    }
    var sectionType: String{
        return "Контакты"
    }
    var contacts: [Contacts]
    var rowCount: Int {
        return contacts.count
    }
}

struct InfoViewModelCarierItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .carier
    }
    
    var sectionType: String {
        return "Карьера"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var company: String
    var locationAndPeriod: String
    var position: String
}

struct Education {
    var type: String
    var name: String
}

struct InfoViewModelEducationItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .education
    }
    var sectionType: String{
        return "Образование"
    }
    var educations: [Education]
    var rowCount: Int {
        return educations.count
    }
}

struct InfoViewModelPresentsItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .presents
    }
    
    var sectionType: String {
        return "Подарки"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var presentsNumbers: String
}

struct Files {
    var name: String
    var numbersOfIt: String
}

struct InfoViewModelFilesItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .files
    }
    
    var sectionType: String {
        return ""
    }
    
    var files: [Files]
    var rowCount: Int {
        return 3
    }
    
}

class OwnInfoTableViewController: UITableViewController {
    
    var nameUser: String = ""
    var surnameUser: String = ""
    var avatarUser: UIImage? = nil
    var cityUser: String = ""
    var ageUser: String = ""
    let statusCellIdentifier = "statusCellIdentifier"
    let basicCellIdentifier = "basicCellIdentifier"
    let contatsCellIdentifier = "contatsCellIdentifier"
    let carierCellIdentifier = "carierCellIdentifier"
    let educationCellIdentifier = "educationCellIdentifier"
    let presentsCellIdentifier = "presentsCellIdentifier"
    let filesCellIdentifier = "filesCellIdentifier"
    var items: [InfoViewModelItem] = []
    var statusArray = ["Рубин чемпик", "Чемпик ли Рубин?", "Ya ne pishy po russki"]
    var basicInfoTitleArray = ["День рождения", "Место работы", "Семейное положение", "Языки", "Родители"]
    var basicInfoSubtitleArry = [ ["17 июня 1998", "24 января 2002"],
                                 ["Рубин", "Ростов"],
                                 ["Все hard", "Есть девушка, которой ставлю лайки"],
                                 ["Русский, Spain", "Английский, Татарча"],
                                 ["Курбан Бердыев, Маша", "Курбан Бердыев, Паша"] ]
    var contactArray = [ ["89178823292;;", "89189929222;;"],
                         ["Мадрид", "Казань"],
                         ["rubin_player", "rubin_golkiper"] ]
    var contactImageArray = [UIImage(named: "icon-info-phone")!, UIImage(named: "icon-info-home")!, UIImage(named: "icon-info-vk")!]
    var carierCompanyArray = ["Рубин", "Ростов"]
    var carierLocationAndPeriodArray = ["Казань, 2003-2015", "Мадрид, 2015-20018"]
    var carierPositionArray = ["Подавал навесы и к столу", "Разрезал тортики на др"]
    var carierLogoesCompany = [UIImage(named: "icon-info-phone")!, UIImage(named: "icon-info-home")!, UIImage(named: "icon-info-vk")!]
    let educationTypeArray = ["Вуз", "Школа"]
    let educationNameArray = [ ["КФУ", "МГУ", "ПТУ"],
                               ["It-лицей", "16 школа"] ]
    let presentsNumberArray = ["22 подарков", "24 подарок", "11 подарков"]
    let moreInfoTitleArray = ["Интересные страницы", "Заметки", "Документы"]
    let moreInfoCountArray = [["12", "43", "42"],
                              ["13", "49", "76"],
                              ["43", "97", "22"]]
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var surnameLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLable.text = nameUser
        nameLable.sizeToFit()
        surnameLable.text = surnameUser
        surnameLable.sizeToFit()
        avatarImageView.image = avatarUser
        cityLable.text = cityUser
        cityLable.sizeToFit()
        ageLable.text = ageUser
        ageLable.sizeToFit()
        createStatus()
        createBasicInfo()
        createContacts()
        createCarier()
        createEdicational()
        createPresents()
        let nib1 = UINib(nibName: "StatusTableViewCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: statusCellIdentifier)
        let nib2 = UINib(nibName: "BasicInfoTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: basicCellIdentifier)
        let nib3 = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: contatsCellIdentifier)
        let nib4 = UINib(nibName: "CarierTableViewCell", bundle: nil)
        tableView.register(nib4, forCellReuseIdentifier: carierCellIdentifier)
        let nib5 = UINib(nibName: "EducationTableViewCell", bundle: nil)
        tableView.register(nib5, forCellReuseIdentifier: educationCellIdentifier)
        let nib6 = UINib(nibName: "PresentsTableViewCell", bundle: nil)
        tableView.register(nib6, forCellReuseIdentifier: presentsCellIdentifier)
        let nib7 = UINib(nibName: "FilesTableViewCell", bundle: nil)
        tableView.register(nib7, forCellReuseIdentifier: filesCellIdentifier)
        self.refreshControl?.addTarget(self, action: #selector(OwnInfoTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    }

    func createStatus() {
        let status = InfoViewModelStatusItem(status: "\(statusArray[Int(arc4random_uniform(UInt32(statusArray.count)))])")
        items.append(status)
    }
    
    func createBasicInfo() {
        var basicInformations = [BasicInfo]()
        for i in 0 ..< 5 {
            let basicInfo = BasicInfo(title: "\(basicInfoTitleArray[i])",
                info: "\(basicInfoSubtitleArry[i][Int(arc4random_uniform(UInt32( basicInfoSubtitleArry[i].count)))])")
            basicInformations.append(basicInfo)
        }
        items.append(InfoViewModelBasicInfoItem(basicInfo: basicInformations))
    }
    
    func createContacts() {
        var contactsInformation = [Contacts]()
        for i in 0 ..< 3 {
            let contactInfo = Contacts(image: contactImageArray[i], contact: "\(contactArray[i][Int(arc4random_uniform(UInt32(contactArray[i].count)))])")
            contactsInformation.append(contactInfo)
        }
        items.append(InfoVIewModelContactsItem(contacts: contactsInformation))
    }
    
    
    func createCarier() {
        let carierInfo = InfoViewModelCarierItem(company: "\(carierCompanyArray[Int(arc4random_uniform(UInt32(carierCompanyArray.count)))])", locationAndPeriod: "\(carierLocationAndPeriodArray[Int(arc4random_uniform(UInt32(carierLocationAndPeriodArray.count)))])", position: "\(carierPositionArray[Int(arc4random_uniform(UInt32(carierPositionArray.count)))])")
        items.append(carierInfo)
    }
    
    func createEdicational() {
        var educationInformation = [Education]()
        for i in 0 ..< 2 {
            let educationalInfo = Education(type: "\(educationTypeArray[i])", name: "\(educationNameArray[i][Int(arc4random_uniform(UInt32(educationNameArray.count)))])")
            educationInformation.append(educationalInfo)
        }
        items.append(InfoViewModelEducationItem(educations: educationInformation))
    }
    
    func createPresents() {
        let presents = InfoViewModelPresentsItem(presentsNumbers: "\(presentsNumberArray[Int(arc4random_uniform(UInt32(presentsNumberArray.count)))])")
        items.append(presents)
    }
    
    func createFiles() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items[section].rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item.type {
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier: statusCellIdentifier, for: indexPath) as! StatusTableViewCell
            cell.prepateCell(with: item as! InfoViewModelStatusItem)
            return cell
            
        case .basicInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: basicCellIdentifier, for: indexPath) as! BasicInfoTableViewCell
            let basicInfoItem = item as! InfoViewModelBasicInfoItem
            cell.prepateCell(with: basicInfoItem.basicInfo[indexPath.row])
            return cell
            
        case .contacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: contatsCellIdentifier, for: indexPath) as! ContactsTableViewCell
            let contactInfoItem = item as! InfoVIewModelContactsItem
            cell.prepareCell(with: contactInfoItem.contacts[indexPath.row])
            return cell
            
        case .carier:
            let cell = tableView.dequeueReusableCell(withIdentifier: carierCellIdentifier, for: indexPath) as! CarierTableViewCell
            cell.prepareCell(with: item as! InfoViewModelCarierItem)
            return cell
            
        case .education:
            let cell = tableView.dequeueReusableCell(withIdentifier: educationCellIdentifier, for: indexPath) as! EducationTableViewCell
            let educationInfoItem = item as! InfoViewModelEducationItem
            cell.prepareCell(with: educationInfoItem.educations[indexPath.row])
            return cell
            
        case .presents:
            let cell = tableView.dequeueReusableCell(withIdentifier: presentsCellIdentifier, for: indexPath) as! PresentsTableViewCell
            cell.prepareCell(with: item as! InfoViewModelPresentsItem)
            return cell
//        case .files:
//            let cell = tableView.dequeueReusableCell(withIdentifier: filesCellIdentifier, for: indexPath) as! FilesTableViewCell
//            let fileInfoItem = item as! InfoViewModelFilesItem
//            cell.prepareCell(with: fileInfoItem.files[indexPath.row])
//            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: statusCellIdentifier, for: indexPath) as! StatusTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .basicInfo:
            return 50
        
        case .contacts:
            return 40
            
        case .carier:
            return 80
        
        case .presents:
            return 120
            
        default:
            return 44
        }
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        items.removeAll()
        createStatus()
        createBasicInfo()
        createContacts()
        createCarier()
        createEdicational()
        createPresents()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell =
//        return cell
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
