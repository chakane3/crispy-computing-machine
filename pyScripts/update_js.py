import CTD_scrape
import LG_scrape
import json
from pathlib import Path
import os
import time

js_to_swift = []

# links 
hg_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber', CTD_scrape.ammo_dict_hg())
# rf_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=79&searchBy=Caliber', CTD_scrape.ammo_dict_rf())
# st_ctd = CTD_scrape.scrape('https://www.cheaperthandirt.com/shop-by?cgid=80&searchBy=Gauge', CTD_scrape.ammo_dict_st())


hg_lg = LG_scrape.final_scrape("https://www.luckygunner.com/handgun", LG_scrape.ammo_dict_hg())
# rf_lg = LG_scrape.final_scrape("https://www.luckygunner.com/rifle", LG_scrape.ammo_dict_rf())
# st_lg = LG_scrape.scrape_shotgun("https://www.luckygunner.com/shotgun", LG_scrape.ammo_dict_st())

js_to_swift.append(hg_ctd)
js_to_swift.append(hg_lg)




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







