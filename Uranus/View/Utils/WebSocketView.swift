//
//  WebSocketView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/21.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import UserNotifications
import Starscream

struct WebSocketView: UIViewControllerRepresentable {

    let url: URL

    class Coordinator: NSObject, WebSocketDelegate, UNUserNotificationCenterDelegate {
        var parent: WebSocketView
        var socket: WebSocket!

        init(_ parent: WebSocketView) {
            self.parent = parent

            super.init()

            var request = URLRequest(url: parent.url)
            request.timeoutInterval = 5
            socket = WebSocket(request: request)
            socket.delegate = self
            socket.connect()
        }

        func websocketDidConnect(socket: WebSocketClient) {
            logger.debug("websocket is connected")
            self.socket.write(string: "echo")
        }

        func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
            if let error = error as? WSError {
                logger.error("websocket is disconnected: \(error.message)")
            } else if let error = error {
                logger.error("websocket is disconnected: \(error.localizedDescription)")
            } else {
                logger.debug("websocket disconnected")
            }
        }

        func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
            scheduleNotification(notification: text)
        }

        func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
            return
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
        }

        func scheduleNotification(notification: String) {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.delegate = self
            let content = UNMutableNotificationContent()

            logger.debug(notification)
            // swiftlint:disable identifier_name
            guard let _notification: Notification = try? JSONDecoder().decode(Notification.self, from: notification.data(using: .utf8)!) else { return }
            content.title = _notification.message.title
            content.body = _notification.message.body
            content.sound = UNNotificationSound.default
            content.badge = 1

            let identifier = "Local Notification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)

            notificationCenter.add(request) { error in
                if let error = error {
                    logger.error(error.localizedDescription)
                }
            }
        }

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<WebSocketView>) -> UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WebSocketView>) {

    }
}
