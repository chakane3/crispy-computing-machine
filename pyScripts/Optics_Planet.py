from bs4 import BeautifulSoup
from bs4.element import ProcessingInstruction, XMLProcessingInstruction
from lxml import html
import requests
import re

hg_link = "https://www.opticsplanet.com/handgun-ammo.html?_iv_gridSize=240"

def scrape_handgun_helper(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'lxml')
    products = soup.find_all("div", class_="grid-c__main products qa-grid-c__main clearfix op-plugin")
    list_of_products = []
    for i in products:
        for product in i:
            if len(product) == 5:
                list_of_products.append(product)
    
    list_of_names = []
    for i in list_of_products:
        product = (i.find("img"))
        imgURL = (i.find("span"))
        # imgURL = (imgURL.find("img"))
        x = (imgURL)
        imgLink = []
        
        print("______________________________________________\n")
        


def scrape_handgun(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    products = soup.find_all("div", class_='grid two-block-tall product float-left js-carousel-item')
    list_of_handgun_ammo_links = []
    for i in products:
        aLink = (i.find("a"))
        aLink = aLink['href']
        
        scrape_handgun_helper(str(aLink) + "?_iv_gridSize=240")
        break
        
    
    

scrape_handgun(hg_link)
