import CTD_scrape
import json
from pathlib import Path
import os, shutil, glob


# scrape data and save it as a json file
ammo = CTD_scrape.scrape("https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber")
rel = "jsonFiles/cheaperThanDirt/ammo"
cwd = Path.cwd()
currentPath = str(Path.cwd())+""
aCount = 0
savePath = str(cwd).replace("pyScripts/cheaperThanDirt", rel)

with open(os.path.join(savePath, f"CTDHandgunAmmo.json"), "w") as fp:
    json.dump(ammo, fp)


