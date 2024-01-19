from django.shortcuts import render
from django.http import HttpResponse
# notifications/views.py
from django.http import JsonResponse, StreamingHttpResponse
from fcm_django.models import FCMDevice
from firebase_admin.messaging import Message, Notification
from django.views.decorators.csrf import csrf_exempt
import firebase_admin
from firebase_admin import credentials, firestore, storage, initialize_app, get_app
import picamera
import time
import io
import cv2
import threading





@csrf_exempt
def send_notification(request):
    
    notification_title = request.GET.get('title')
    notification_body=request.GET.get('body')
    doc_name = request.GET.get('doc_name')
    Date=request.GET.get('date')
    Name=request.GET.get('Name')
    Time=request.GET.get('Time')
    
    print(notification_title) 
    print(notification_body)
    print(doc_name) 
    print(Date)
    print(Name) 
    print(Time)
    
     
    try:
        device = FCMDevice.objects.get(registration_id="your_apps_registration_id") 
    except FCMDevice.DoesNotExist:
        return {'error': 'Device not found'}, 404

    device.send_message(
        message=Message(
            notification=Notification(
                title=notification_title,
                body=notification_body
            ),
        ),
    )  
    #image_url="send"
    image_url=upload_images_to_firebase(Name)
    upload_data(doc_name,Date,Name, Time,image_url)
    
    
    return JsonResponse({'success': f'{image_url}'}, status=200)
    
    
@csrf_exempt
def test(request):
    return HttpResponse("Maharani :)")


@csrf_exempt
def upload_data(doc_name, Date, Name, Time, image_url):
    cred = credentials.Certificate("/home/arihant/Desktop/capstone/capstone_backen/python_json.json")
    
    # Check if the default app is initialized
    try:
        app = get_app()
    except ValueError:
        # If the app is not initialized, initialize it
        initialize_app(cred)
    
    db = firestore.client()

    doc_ref = db.collection(u'Previous Intrusion').document(doc_name)
    doc_ref.set({
        u'Date': Date,
        u'Name': Name,
        u'Time': Time,
        u'image_url': image_url,
    })


def upload_images_to_firebase(image_name_to_save):
    cred = credentials.Certificate("/home/arihant/Desktop/capstone/capstone_backen/python_json.json")
    
    # Check if the app with the name 'storage' exists
    try:
        app = get_app(name='storage')
    except ValueError:
        # If the app with the name 'storage' doesn't exist, initialize it
        initialize_app(cred, {
            'storageBucket': 'Your Storage bucket id'
        }, name='storage')
    
    print("test")
    local_image_path = f"/home/arihant/Desktop/Object_Detection_Files/captured_animals/{image_name_to_save}.jpg"
    firebase_destination_path = f'{image_name_to_save}.jpg'

    # Get the bucket after ensuring app initialization
    bucket = storage.bucket(app=get_app(name='storage'))
    blob = bucket.blob(firebase_destination_path)
    blob.upload_from_filename(local_image_path)
    blob.make_public()
    download_url = blob.public_url
    
    return download_url




def stream_camera(request):
    cap = cv2.VideoCapture(0)
    while True:
        ret, frame = cap.read()
        # Process the frame if needed

        # Convert frame to JPEG
        _, buffer = cv2.imencode('.jpg', frame)
        frame_bytes = buffer.tobytes()

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n\r\n')

def camera_stream(request):
    return StreamingHttpResponse(stream_camera(request), content_type='multipart/x-mixed-replace; boundary=frame')             
    
