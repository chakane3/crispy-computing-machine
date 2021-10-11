import urllib.request
import re
from bs4 import BeautifulSoup
from lxml import html
import json
import requests
#psize=600 to show all products
handgun_link = "https://www.brownells.com/ammunition/handgun-ammo/index.htm?view=l&psize=600"




def scrape(link):
    page = requests.get(link)
    soup = BeautifulSoup(page.content, 'lxml')
    products = (soup.find_all('div', class_='media listing'))
    # print(len(products)) can be used

    
scrape(handgun_link)