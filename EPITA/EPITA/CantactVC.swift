//
//  ViewController.swift
//  EPITA

import UIKit

class CantactVC: UIViewController {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var contacts_array = NSMutableArray()
    @IBOutlet weak var contactTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Contacts"
        self.getContactResults()
    }
    
    func getContactResults() {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://randomuser.me/api/?results=50&seed=srikanth") {
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    print(error.localizedDescription)
                    
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            data, options: [])
                        if let jsondict = jsonResponse as? [String: Any]  {
                            if let jsonArray = jsondict["results"] as? [[String: Any]] {
                                print(jsonArray)
                                for dic in jsonArray{
                                    let cModel = ContactModel()
                                    cModel.initData(dictionary:dic)
                                    self.contacts_array.add(cModel)
                              }
                           }
                        }
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                    DispatchQueue.main.async {
                        self.contactTable.reloadData()
                    }
                }
            }
            dataTask?.resume()
        }
    }
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        let rr:CGRect = CGRect(x:0,y:0,width:width, height:height);
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return newImage ?? UIImage()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
}


extension CantactVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.contacts_array.count
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CantactVC_Cell", for: indexPath)
            as! CantactVC_Cell

        let conctact = self.contacts_array.object(at:indexPath.row) as?  ContactModel
        
        cell.textLabel?.text = String(format:"%@.%@ %@",conctact?.Name?.title ?? "",conctact?.Name?.first ?? "",conctact?.Name?.last ?? "")
        cell.detailTextLabel?.text = String(format:"%@",conctact?.email ?? "")
        
        if let url = URL(string: conctact?.Picture?.thumbnail ?? ""){
            cell.imageView?.image = UIImage(named: "defaultUser")
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        let newImage = self.resizeImage(image: UIImage(data: data)!, toTheSize: CGSize(width:32,height:32))
                        let cellImageLayer: CALayer?  = cell.imageView?.layer
                        cellImageLayer!.cornerRadius = 16
                        cellImageLayer!.masksToBounds = true
                        cell.imageView?.image = newImage
                    }
                }
            }
        }
        
        cell.textLabel?.textColor = UIColor(hexString:"944bbb")
        cell.detailTextLabel?.textColor = UIColor(hexString: "61304b")
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        
        if indexPath.row % 2 == 0 {
          cell.backgroundColor = UIColor (hexString:"94bfbe").withAlphaComponent(0.4)
        } else {
            cell.backgroundColor = UIColor (hexString:"94bfbe").withAlphaComponent(0.1)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactDetailsVC") as? ContactDetailsVC {
            viewController.profileInfor =  self.contacts_array.object(at:indexPath.row) as?  ContactModel
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

