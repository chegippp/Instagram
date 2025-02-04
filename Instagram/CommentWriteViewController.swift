//
//  CommentWriteViewController.swift
//  Instagram
//
//  Created by y.hara on 2025/02/02.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CommentWriteViewController: UIViewController {
    var postData: PostData!

    @IBOutlet weak var commentField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func commentSendButton(_ sender: UIButton) {
        if commentField.text == "" {
            return
        }
        let user = Auth.auth().currentUser
        let userName: String = user!.displayName! as String
        let commentData = "\(userName) : \(commentField.text!)"

        // commentsに更新データを書き込む
        let updateValue = FieldValue.arrayUnion([commentData])
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        postRef.updateData(["comments": updateValue])

        // 先頭画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
