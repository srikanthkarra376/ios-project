//
//  ContactDetailsVC.swift
//  EPITA
//


import UIKit


class ContactDetailsVC: UIViewController {
    
     @IBOutlet weak var contactInfoTable: UITableView!
     @IBOutlet weak var profileImage: UIImageView!
    
    var profileInfor:ContactModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        contactInfoTable.separatorStyle = .none
        
        contactInfoTable.backgroundColor =  UIColor (hexString:"94bfbe").withAlphaComponent(0.1)
        self.title = "Contact Details"
    }


    override func viewWillAppear(_ animated: Bool) {
        if let url = URL(string: profileInfor?.Picture?.large ?? ""){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data:data)
                    }
                }
            }
        }
    }

}

extension ContactDetailsVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cellIdentifier = "ContactCell"
        let cell: ContactDetailsTVC! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ContactDetailsTVC)

        cell.labelName.text = String(format:"%@ %@ %@",profileInfor?.Name?.title ?? "",profileInfor?.Name?.first ?? "",profileInfor?.Name?.last ?? "")
        cell.labelStreet.text = String(format:"%@",profileInfor?.Location?.street ?? "")
        cell.labelCity.text = String(format:"%@",profileInfor?.Location?.city ?? "")
        cell.labelPhone.text = String(format:"%@",profileInfor?.phone ?? "")
        cell.labelEmail.text = String(format:"%@",profileInfor?.email ?? "")
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
