import Foundation
import UIKit
import Socket_IO_Client_Swift


class CreateViewController: UIViewController {

    let socket = SocketIOClient(socketURL: "localhost:5001")
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.color = UIColor(UImage)
        
        self.addHandlers()
        self.socket.connect()
        
        
    }

    func addHandlers() {
        self.socket.on("error") {data, ack in
            if let dict = data?[0] as? NSDictionary {
                println(dict["error"])
            }
            return
        }
        
        self.socket.on("success") {data, ack in
            if let dict = data?[0] as? NSDictionary {
                println(dict["status"])
            }
            return
        }
    }
    
    
    @IBAction func createRoom(sender: UIButton) {
        self.socket.emit("create", ["name": self.nameField.text,
                                    "password": self.passwordField.text])
    }
}

