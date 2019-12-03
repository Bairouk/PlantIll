import os
import numpy as np
import PIL.Image
from datetime import datetime
import io
import base64
from flask import Flask,Blueprint,request,render_template,jsonify
#from modules.dataBase import collection as db
from fastai import *
from fastai.vision import *
from fastai.widgets import *

import fastai
fastai.device = torch.device('cpu')

app = Flask(__name__)


def get_model( ):
    global model 
    path = Path('/home/anass_bairouk_um5s_net_ma/app')
    model =  load_learner(path)
    print("model loaded")



def preprocess_img(image):
    
    image = image.convert("RGB")
    image = image.resize((256,256))
    image.save("out.jpg", "JPEG", quality=80, optimize=True, progressive=True)
    #image =  np.asarray(image)
    #image = np.expand_dims(image, axis=0)
    img = Image(pil2tensor(image, np.float32).div_(255))
    img.save("fast.jpg")
    return img

print("Loading our model ...")
get_model()

@app.route("/predict", methods=["POST"])

def predict(): 
    message = request.get_json(force=True)
    encoded = message['image']
    decoded = base64.b64decode(encoded)
    image = PIL.Image.open(io.BytesIO(decoded))
    processed_img = preprocess_img(image)
    pred_class,pred_idx,outputs = model.predict(processed_img)
    print("Our class is : ")
    print(str(pred_class))
    print("Accuracy: ")
    print(str(outputs[pred_idx]))
    response = {
        "predi":{
            "status":"success",
            "prediction":str(pred_class),
            "confidence":str(outputs[pred_idx].tolist()),
            "upload_time":datetime.now()
            }
    }

    return jsonify(response)




