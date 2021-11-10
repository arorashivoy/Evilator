# Shivoy Arora
# ~/Programs/test.py

import firebase_admin
from firebase_admin import messaging, credentials

def setupEvilator():
    cred = credentials.Certificate("./evilator-firebase-adminsdk.json")
    firebase_admin.initialize_app(cred)

def sendToTopic():
    topic = "pushNoti"

    message = messaging.Message(
        topic = topic,
        notification = messaging.Notification(
            title = "Fuck you",
            body = "you suck"
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
    sendToTopic()