import CTD_scrape
import LG_scrape
import json
from pathlib import Path
import os, shutil, glob



# links 
# hg_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber', CTD_scrape.ammo_dict_hg())
# rf_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=79&searchBy=Caliber', CTD_scrape.ammo_dict_rf())
# st_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=80&searchBy=Gauge', CTD_scrape.ammo_dict_st())

hg_LG = LG_scrape.final_scrape("https://www.luckygunner.com/handgun", LG_scrape.ammo_dict_hg())
rf_LG = LG_scrape.final_scrape("https://www.luckygunner.com/rifle", LG_scrape.ammo_dict_rf())
st_LG = LG_scrape.final_scrape("https://www.luckygunner.com/shotgun", LG_scrape.ammo_dict_st())
# get user path
cwd = Path.cwd()
currentPath = str(Path.cwd())+""


def update_json_CTD(hg, rf, st):
    # save a copy of our json file to the 'web' folder
    rel = "jsonFiles/cheaperThanDirt/ammo"
    savePath = str(cwd).replace("pyScripts", rel)

    with open(os.path.join(savePath, f"CTDHandgunAmmo.json"), "w") as fp:
        json.dump(hg, fp)

    with open(os.path.join(savePath, f"CTDRifleAmmo.json"), "w") as fp:
        json.dump(rf, fp)

    with open(os.path.join(savePath, f"CTDShotGunAmmo.json"), "w") as fp:
        json.dump(st, fp)



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

    
update_json_LG(hg_LG, rf_LG, st_LG)






