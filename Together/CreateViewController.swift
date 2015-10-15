import UIKit
import Socket_IO_Client_Swift


class CreateViewController: UIViewController {
    
    let socket = SocketIOClient(socketURL: "localhost:5001")
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var flowerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flowerImage.backgroundColor = UIColor(patternImage: UIImage(named: "flowers")!)
        
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
                println(dict["status"]!)
            }
            return
        }
    }
    
    @IBAction func createRoom(sender: UIButton) {
        self.socket.emit("create", ["name": self.nameField.text,
            "password": self.passwordField.text])
    }
    
    func goToJoinView() {
        let joinViewController = self.storyboard?.instantiateViewControllerWithIdentifier("JoinViewController") as? JoinViewController
        self.presentViewController(joinViewController!, animated: true, completion: nil)
    }
}

