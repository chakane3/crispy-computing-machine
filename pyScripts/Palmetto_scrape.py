import urllib.request
import re
from bs4 import BeautifulSoup
from lxml import html
import json
import requests



# handgunlink
link = "https://palmettostatearmory.com/ammo/handgun-ammo.html"


def scrape(link):
    page = requests.get(link)
    soup = BeautifulSoup(page.content, "lxml")
    print(soup.find_all('li', class_='item'))
    print(soup)

scrape(link)