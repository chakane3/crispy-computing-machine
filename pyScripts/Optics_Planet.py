from bs4 import BeautifulSoup
from bs4.element import ProcessingInstruction, XMLProcessingInstruction
from lxml import html
import requests
import re

def checkNextPage(soupObject):


hg_link = "https://www.opticsplanet.com/handgun-ammo.html?_iv_gridSize=240"
def scrape_handgun(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    x = soup.find("div", class_='grid-c__main products qa-grid-c__main clearfix op-plugin')
    productList = []
    stop = 10
    for i in x:
        if len(i) == 5:
            productList.append(i)
        

    print(len(productList))
        

    

