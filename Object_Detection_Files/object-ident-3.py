import cv2
import requests
import os
import time
from gpiozero import AngularServo
servo =AngularServo(18, initial_angle=0, min_pulse_width=0.0006, max_pulse_width=0.0023)

#thres = 0.45 # Threshold to detect object
folder_path = "/home/arihant/Desktop/Object_Detection_Files/"
classNames = []
classFile = "/home/arihant/Desktop/Object_Detection_Files/coco.names"
with open(classFile,"rt") as f:
    classNames = f.read().rstrip("\n").split("\n")

configPath = "/home/arihant/Desktop/Object_Detection_Files/ssd_mobilenet_v3_large_coco_2020_01_14.pbtxt"
weightsPath = "/home/arihant/Desktop/Object_Detection_Files/frozen_inference_graph.pb"


detected_animals = []

net = cv2.dnn_DetectionModel(weightsPath,configPath)
net.setInputSize(320,320)
net.setInputScale(1.0/ 127.5)
net.setInputMean((127.5, 127.5, 127.5))
net.setInputSwapRB(True)


clear_folder_path = f"{folder_path}/captured_animals" 
def clear_folder(clear_folder_path):
    # Iterate over the files in the folder
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        
        # Check if it's a file (not a subdirectory)
        if os.path.isfile(file_path):
            # Remove the file
            os.remove(file_path)
            print(f"Deleted: {file_path}")


def getObjects(img, thres, nms, draw=True, objects=[]):
    classIds, confs, bbox = net.detect(img, confThreshold=thres, nmsThreshold=nms)
    
    if len(objects) == 0:
        objects = classNames
    
    objectInfo = []
    
    if len(classIds) != 0:
        img_width = cap.get(3)  # Get the width of the captured frame

        for classId, confidence, box in zip(classIds.flatten(), confs.flatten(), bbox):
            className = classNames[classId - 1]
            if className in objects:
                objectInfo.append([box, className])
                if draw:
                    cv2.rectangle(img, box, color=(0, 255, 0), thickness=2)
                    cv2.putText(img, classNames[classId - 1].upper(), (box[0] + 10, box[1] + 30),
                                cv2.FONT_HERSHEY_COMPLEX, 1, (0, 255, 0), 2)
                    cv2.putText(img, str(round(confidence * 100, 2)), (box[0] + 200, box[1] + 30),
                                cv2.FONT_HERSHEY_COMPLEX, 1, (0, 255, 0), 2)

                    # Determine object location (left or right) based on its bounding box
                    object_center_x = (box[0] + box[2]) / 2  # Get the horizontal center of the object
                    img_center_x = img_width / 4  # Get the horizontal center of the image
                    
                    
                    if object_center_x < img_center_x:
                        x_location = "Left"
                    else:
                        x_location = "Right"
                        
                        if className not in detected_animals:
                            title = "Animal Intrusion" 
                            body =  f"{className}"
                            
                            url = f"http://172.16.69.108:8000/send_notification?title={title}&body={body}"
                            response = requests.get(url)
                            detected_animals.append(className)
                           
                            if response.status_code == 200:
                                print(response.json())
                            else:
                                print(f"ERROR status code: {response.status_code}")
                            
                            # Read a frame from the webcam
                            ret, frame = cap.read()
                            
                            # Check if the frame was captured successfully
                            if ret:
                                photo_path = os.path.join(folder_path, f'captured_animals/{className}.jpg')
                                cv2.imwrite(photo_path, frame)
                                print(f"Photo saved at: {photo_path}")
                            else:
                                print("Failed to capture a photo.")
                            
#upload_image_url=f"http://172.16.69.108:8000/upload_images_to_firebase?image_name={className}"
                          #  response_image_name=requests.get(upload_image_url)
                        
                    #
                    print(object_center_x);
                    print(f"{className} is on the {x_location} side of the screen")

    return img, objectInfo
    
    
if __name__ == "__main__":

    cap = cv2.VideoCapture(0)
    cap.set(3,640)
    cap.set(4,480)
    #cap.set(10,70)
    #clear_folder(clear_folder_path)
    
    while True:
        success, img = cap.read()
        result, objectInfo = getObjects(img,0.45,0.2, objects=['cell phone','toothbrush','remote'])
        #print(objectInfo)
        
        
        
        cv2.imshow("Output",img)
        cv2.waitKey(1)
    #clear_folder(clear_folder_path)
