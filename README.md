# BinX Storage Level YOLO Project

This repository contains the YOLO object detection project for **BinX Storage Level**, which detects waste items using images and videos. The model is trained using a dataset hosted on [Roboflow](https://roboflow.com).

> ⚠️ **Note:** Sensitive files such as API keys, Firebase credentials, or service account JSON files are **not included** in this repository. Please make sure to keep your own credentials secure.

---

## Project Structure
**Key directories and files:**
- `mysampah_yolo/`: YOLO training scripts and model files.  
- `mysampah_app/`: Flutter app (connected to Firebase).  
- `.gitignore`: Ensures sensitive files and build artifacts are not committed.  

---

## Dataset

The dataset for this project is hosted on **Roboflow**:

- Project ID: `binx-storage-level-r58xx`  
- Project Name: **BinX Storage Level**

You can download the dataset using the Roboflow Python package:

```bash
# Install Roboflow package
pip install roboflow
from roboflow import Roboflow

# Replace YOUR_API_KEY with your Roboflow API key
rf = Roboflow(api_key="YOUR_API_KEY")
project = rf.workspace("YOUR_WORKSPACE").project("binx-storage-level-r58xx")
dataset = project.version(1).download("yolov8")
```

## Getting Started

### YOLO Training

1. Clone this repository (dataset not included; see Roboflow instructions).  
2. Install dependencies required for YOLO training.  
3. Run the training scripts in `mysampah_yolo/` as needed.  

### Flutter App

1. Navigate to `mysampah_app/`.  
2. Follow standard Flutter setup instructions.  
3. Add your own Firebase credentials locally (`google-services.json`, `firebase_options.dart`).  
> ⚠️ Do **not** commit these credentials to GitHub.

---

## Security & Secrets

This repository **does not include secrets**. Please ensure:

- Any `.json` files containing API keys or service account credentials are listed in `.gitignore`.  
- `firebase_options.dart` and `google-services.json` are **never committed**.  
- Keep your Roboflow API key and Firebase keys secure and private.

---

## References

- [Roboflow](https://roboflow.com/)  
- [YOLOv8 Documentation](https://docs.ultralytics.com/)  
- [Flutter Documentation](https://flutter.dev/docs)
