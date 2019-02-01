//
//  ContactModel.swift
//  EPITA
//

import UIKit

class ContactModel: NSObject {
    
    var gender: String?
    var email: String?
    var phone: String?
    var cell: String?
    var nat: String?
    
    var Name: name?
    var Location: location?
    var Login: login?
    var DOB: dOB?
    var Registered: registered?
    var Picture: picture?
    var ID: id?
    
    func initData(dictionary: [String:Any]) {
        
         self.gender = ContactModel.nullToNil(value: dictionary["gender"] as AnyObject) as? String
         self.email = ContactModel.nullToNil(value: dictionary["email"] as AnyObject) as? String
         self.phone = ContactModel.nullToNil(value: dictionary["phone"] as AnyObject) as? String
         self.cell = ContactModel.nullToNil(value: dictionary["cell"] as AnyObject) as? String
         self.nat = ContactModel.nullToNil(value: dictionary["nat"] as AnyObject) as? String
       
        self.Name = name.init(dictionary:ContactModel.nullToNil(value:(dictionary["name"] as AnyObject)) as? [String : Any] ?? ["" : ""])
        self.Location = location.init(dictionary:ContactModel.nullToNil(value:(dictionary["location"] as AnyObject)) as? [String : Any] ?? ["" : ""])
        self.DOB = dOB.init(dictionary:ContactModel.nullToNil(value:(dictionary["dob"] as AnyObject)) as? [String : Any] ?? ["" : ""])
        self.Registered = registered.init(dictionary:ContactModel.nullToNil(value:(dictionary["registered"] as AnyObject)) as? [String : Any] ?? ["" : ""])
        self.Picture = picture.init(dictionary:ContactModel.nullToNil(value:(dictionary["picture"] as AnyObject)) as? [String : Any] ?? ["" : ""])
        self.ID = id.init(dictionary:ContactModel.nullToNil(value:(dictionary["id"] as AnyObject)) as? [String : Any] ?? ["" : ""])
    }

    
   class func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return " " as AnyObject
        } else {
            return value
        }
    }
}

class name: NSObject {
    var title: String?
    var first: String?
    var last: String?
    
    init(dictionary: [String:Any]) {
        super.init()
        self.title = ContactModel.nullToNil(value:dictionary["title"] as AnyObject) as? String
        self.first = ContactModel.nullToNil(value:dictionary["first"] as AnyObject) as? String
        self.last = ContactModel.nullToNil(value:dictionary["last"] as AnyObject) as? String
    }
}
class location: NSObject {
    var street: String?
    var city: String?
    var state: String?
    var postcode: String?
    
    init(dictionary: [String:Any]) {
        super.init()
        self.street = ContactModel.nullToNil(value:dictionary["street"] as AnyObject) as? String
        self.city = ContactModel.nullToNil(value:dictionary["city"] as AnyObject) as? String
        self.state = ContactModel.nullToNil(value:dictionary["state"] as AnyObject) as? String
        self.postcode = ContactModel.nullToNil(value:dictionary["postcode"] as AnyObject) as? String
    }
}

class login: NSObject {
    var uuid: String?
    var username: String?
    var password: String?
    var salt: String?
    var md5: String?
    var sha1: String?
    var sha256: String?
    
    init(dictionary: [String:Any]) {
        super.init()
        self.uuid = ContactModel.nullToNil(value:dictionary["uuid"] as AnyObject) as? String
        self.username = ContactModel.nullToNil(value:dictionary["username"] as AnyObject) as? String
        self.password = ContactModel.nullToNil(value:dictionary["password"] as AnyObject) as? String
        self.salt = ContactModel.nullToNil(value:dictionary["salt"] as AnyObject) as? String
        self.md5 = ContactModel.nullToNil(value:dictionary["md5"] as AnyObject) as? String
        self.sha1 = ContactModel.nullToNil(value:dictionary["sha1"] as AnyObject) as? String
        self.sha256 = ContactModel.nullToNil(value:dictionary["sha256"] as AnyObject) as? String
    }
}

class dOB: NSObject {
    var date: String?
    var age: String?
    init(dictionary: [String:Any]) {
        super.init()
        self.date = ContactModel.nullToNil(value:dictionary["date"] as AnyObject) as? String
        self.age = ContactModel.nullToNil(value:dictionary["age"] as AnyObject) as? String
    }
}

class registered: NSObject {
    var date: String?
    var age: String?
    init(dictionary: [String:Any]) {
        super.init()
        self.date = ContactModel.nullToNil(value:dictionary["date"] as AnyObject) as? String
        self.age = ContactModel.nullToNil(value:dictionary["age"] as AnyObject) as? String
    }
}


class picture: NSObject {
    var large: String?
    var medium: String?
    var thumbnail: String?
    init(dictionary: [String:Any]) {
        super.init()
        self.large = ContactModel.nullToNil(value:dictionary["large"] as AnyObject) as? String
        self.medium = ContactModel.nullToNil(value:dictionary["medium"] as AnyObject) as? String
        self.thumbnail = ContactModel.nullToNil(value:dictionary["thumbnail"] as AnyObject) as? String
    }
}

class id: NSObject {
    var name: String?
    var value: String?
    init(dictionary: [String:Any]) {
        super.init()
        self.name = ContactModel.nullToNil(value:dictionary["name"] as AnyObject) as? String
        self.value = ContactModel.nullToNil(value:dictionary["value"] as AnyObject) as? String
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}


