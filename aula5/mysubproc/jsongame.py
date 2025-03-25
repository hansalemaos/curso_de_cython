import json
import pickle

with open(r"C:\mypathforfiles3\1742313898.6383076.pkl", "rb") as f:
    data = pickle.load(f)


with open(r"C:\mypathforfiles3\1742313898.6383076.json", "w") as f:
    json.dump(data, f)
