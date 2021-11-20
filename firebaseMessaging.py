# Shivoy Arora
# ~/Programs/Swift/Evilator/firebaseMessaging.py
#
# For sending cloud messages via firebase

import firebase_admin
from firebase_admin import messaging, credentials

Topics = [
    "pushNoti",
    "removeAdNoti",
    "personalNoti"
]

def setupEvilator():
    cred = credentials.Certificate("./evilator-firebase-adminsdk.json")
    firebase_admin.initialize_app(cred)

def sendToTopic(topic, title, body):
    message = messaging.Message(
        topic = topic,
        notification = messaging.Notification(
            title = title,
            body = body
        ),
        apns= messaging.APNSConfig(
            payload=messaging.APNSPayload(
                aps=messaging.Aps(
                    sound='default'
                )
            )
        ),
    )

    response = messaging.send(message)

    print("Sent message:", response)

if __name__ == "__main__":
    setupEvilator()

    print("Select Topic: ")
    for i in range(0,len(Topics)):
        print(i+1,":",Topics[i])

    topicIndex = int(input("Enter the topic index: "))

    topic = Topics[topicIndex - 1]
    title = input("Enter title: ")
    body = input("Enter body: ")

    sendToTopic(topic, title, body)
