import CTD_scrape
import LG_scrape
import json
from pathlib import Path
import os
import time

# function to help save our data
def ammo_dict_hg():
    d = {'type': 'handgun', 'ammo_results': []}
    return d
def ammo_dict_rf():
    d = {'type': 'rifle', 'ammo_results': []}
    return d
def ammo_dict_st():
    d = {'type': 'shotgun', 'ammo_results': []}
    return d
    

# links 
hg_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber', ammo_dict_hg())
rf_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=79&searchBy=Caliber', ammo_dict_rf())
st_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=80&searchBy=Gauge', ammo_dict_st())


hg_lg = LG_scrape.final_scrape("https://www.luckygunner.com/handgun", ammo_dict_hg())
rf_lg = LG_scrape.final_scrape("https://www.luckygunner.com/rifle", ammo_dict_rf())
# st_lg = LG_scrape.scrape_shotgun("https://www.luckygunner.com/shotgun", ammo_dict_st())



js_to_swift = {'results': [hg_ctd, rf_ctd, st_ctd, hg_lg, rf_lg]}
    


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


def update_json_LG(hg, rf, st):
    # save a copy of our json file to the 'web' folder
    rel = "jsonFiles/luckyGunner/ammo"
    savePath = str(cwd).replace("pyScripts", rel)

    with open(os.path.join(savePath, f"LGHandgunAmmo.json"), "w") as fp:
        json.dump(hg, fp)

    with open(os.path.join(savePath, f"LGRifleAmmo.json"), "w") as fp:
        json.dump(rf, fp)

    with open(os.path.join(savePath, f"LGShotGunAmmo.json"), "w") as fp:
        json.dump(st, fp)

    # save a copy of our json data to the "swift" folder
    rel = 'crispy-computing-app/crispy-computing-app/jsonFiles/luckyGunner/ammo'
    savePath = str(cwd).replace("pyScripts", rel)

    with open(os.path.join(savePath, f"LGHandgunAmmo.json"), "w") as fp:
        json.dump(hg, fp)

    with open(os.path.join(savePath, f"LGRifleAmmo.json"), "w") as fp:
        json.dump(rf, fp)

    with open(os.path.join(savePath, f"LGShotgunAmmo.json"), "w") as fp:
        json.dump(st, fp)

# update_json_LG(hg_lg, rf_lg, st_lg) 
update_json_CTD(js_to_swift)







