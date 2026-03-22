import cv2
import tensorflow as tf
import numpy as np

import firebase_admin
from firebase_admin import credentials, firestore

def init_firebase():
    cred = credentials.Certificate("mysampahhero-key.json")
    firebase_admin.initialize_app(cred)
    return firestore.client()

db = init_firebase()

# Load the trained model
model = tf.keras.models.load_model("bin_level_model.keras")

# Define class labels (must match your Roboflow export order)
class_names = ["0_lines", "1_line", "2_lines", "3_lines"]  # change if needed

# Map label to human-readable bin level
label_to_percent = {
    "0_lines": 1.0,
    "1_line": 0.66,
    "2_lines": 0.33,
    "3_lines": 0.0
}

def update_stock(label, percent_value):
    doc_ref = db.collection("BinStorageCam").document(label)
    doc = doc_ref.get()

    if doc.exists:
        current_count = doc.to_dict().get("count", 0)
        doc_ref.update({
            "count": current_count + 1,
            "percent": percent_value
        })
    else:
        doc_ref.set({
            "count": 1,
            "percent": percent_value
        })
    print(f"[✓] Updated Firestore → {label} | {percent_value:.2f}")


# Start webcam
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("❌ Cannot access webcam")
    exit()

print("✅ Webcam started — press 'q' to quit")

# For stability detection
prev_label = None
stable_count = 0
required_stability = 10  # Number of frames required for stable detection

while True:
    ret, frame = cap.read()
    if not ret:
        print("❌ Failed to read frame")
        break

    # Resize and normalize image
    resized = cv2.resize(frame, (224, 224))            # match model input size
    normalized = resized / 255.0                        # scale pixels to [0, 1]
    input_array = np.expand_dims(normalized, axis=0)   # add batch dimension

    # Predict
    predictions = model.predict(input_array)
    class_index = np.argmax(predictions[0])
    predicted_label = class_names[class_index]
    confidence = predictions[0][class_index]
    percent_value = label_to_percent[predicted_label]
    bin_level = predicted_label

    # Check stability
    if predicted_label == prev_label:
        stable_count += 1
    else:
        stable_count = 1  # reset counter
        prev_label = predicted_label

    # Only upload if stable for N frames
    if stable_count == required_stability:
        #Upload to FireBase
        update_stock(predicted_label, percent_value)
        print(f"[✓] Stable Prediction: {predicted_label} — Uploaded")
    elif stable_count < required_stability:
        print(f"[~] Unstable: {predicted_label} ({stable_count}/{required_stability})")

    # Display on webcam frame
    display_percent = int(percent_value * 100)
    cv2.putText(frame, f"Bin Level: {display_percent}%", (10, 40),
                cv2.FONT_HERSHEY_SIMPLEX, 1.0, (0, 255, 0), 2)
    cv2.imshow("Smart Bin Detector", frame)

    # Exit key
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
