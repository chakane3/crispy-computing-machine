import CTD_scrape
import LG_scrape
import LG_scrape_shotgun_exception
# import Optics_Planet
import json
from pathlib import Path
import os
import time

# function to help save our data
def ammo_dict():
    d = []
    return d

# links 
hg_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber', ammo_dict(), "handgun")
rf_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=79&searchBy=Caliber', ammo_dict(), "rifle")
st_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=80&searchBy=Gauge', ammo_dict(), "shotgun")


hg_lg = LG_scrape.final_scrape("https://www.luckygunner.com/handgun", ammo_dict(), "handgun")
rf_lg = LG_scrape.final_scrape("https://www.luckygunner.com/rifle", ammo_dict(), "rifle")
st_lg = LG_scrape_shotgun_exception.scrape_shotgun("https://www.luckygunner.com/shotgun", ammo_dict(), "shotgun")

# hg_op = Optics_Planet.scrape_handgun("https://www.opticsplanet.com/handgun-ammo.html?_iv_gridSize=240")


# add data to json
js_to_swift = {"ammo_results": []}
for i in hg_ctd:
    js_to_swift["ammo_results"].append(i)
for i in rf_ctd:
    js_to_swift["ammo_results"].append(i)
for i in st_ctd:
    js_to_swift["ammo_results"].append(i)

for i in hg_lg:
    js_to_swift["ammo_results"].append(i)
for i in rf_lg:
    js_to_swift["ammo_results"].append(i)
for i in st_lg:
    js_to_swift['ammo_results'].append(i)

    


# get user path
cwd = Path.cwd()
currentPath = str(Path.cwd())+""

# save json files
def update_json_CTD(hg):
    # save a copy of our json file to the 'web' folder
    rel = "jsonFiles/ammo"
    savePath = str(cwd).replace("pyScripts", rel)

    with open(os.path.join(savePath, f"allAmmo.json"), "w") as fp:
        json.dump(hg, fp)


    # save a copy of our json data to the "swift" folder
    rel = 'crispy-computing-appv2/crispy-computing-appv2/jsonFiles/ammo'
    savePath = str(cwd).replace("pyScripts", rel)
    with open(os.path.join(savePath, f"allAmmo.json"), "w") as fp:
        json.dump(hg, fp)


update_json_CTD(js_to_swift)







