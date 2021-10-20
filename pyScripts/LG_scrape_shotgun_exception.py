import urllib.request
import re
from bs4 import BeautifulSoup
from lxml import html
import json
import requests

# helper functions
def strip_price(price):
    rtn = ''
    aGroup = '0123456789.'
    for i in price:
        if i in aGroup:
            rtn += i
    return rtn

# exception for shotgun ammunition
def get_image_shotgun(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    img = soup.find('img', {'src': True})
    return img['src']

def get_description(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    description = soup.find("div", class_="col-2 product-section-details collapse")
    descriptReg = re.sub('<[^<]+?>', '', description.text)
    return descriptReg


def scrape_shotgun_helper(url, gunType):
    url+='?limit-all'
        
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    products = soup.find_all('ol', class_='products-list')
    caliber = soup.find('div', class_='category-title')
    list_of_dicts = []

    for detail in products:
        d = detail.find_all('li', class_='item')
        lastItem = detail.find('li', class_='item last')
        
        # scrape prices
        for price in d:
            aDict = {'name': '', 'price': '', 'caliber': '', 'link': '', 'imgURL': '', 'description': '', 'type': gunType}
            if_available = (price.find('p', class_='availability'))
    
            if 'Out of stock' not in str(if_available.text):
                aDict['name'] = price.find('span').text
                dLink = price.find('a')
                aDict['link'] = dLink['href']
                aDict['caliber'] = caliber.text.replace('\n', '')
                aDict['description'] = get_description(dLink['href'])
                aDict['imgURL'] = get_image_shotgun(dLink['href'])
                
                if "Special Price" in str(price):
                    productPrice = price.find('p', class_='special-price')
                    aDict['price'] = strip_price(productPrice.text)
                else:
                    productPrice = price.find('span', class_='regular-price')
                    aDict['price'] = strip_price(productPrice.text)
            else:
                aDict['price'] = 'out of stock'
            list_of_dicts.append(aDict)
    return list_of_dicts




def scrape_shotgun(url, json_save, gunType):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    productLinks = soup.find_all('td')
    detailLink = []
    for i in productLinks:
        scrapedLink = i.find('a')
        detailLink.append(scrapedLink["href"])
        results = scrape_shotgun_helper(scrapedLink["href"], gunType)

        if len(results) != 0:
            json_save.append(results)
        else:
            out_of_stock = scrapedLink['title']
            #.append({'name': 'out of stock', 'price': 'check back soon', 'link': '.', 'caliber': '.', 'imgURL': '.', 'description': '', 'type': gunType})

    jsonFinal = []   
    for i in json_save:
        if len(i) != 7:
            for j in i:
                jsonFinal.append(j)
        else:
            jsonFinal.append(i)


    return jsonFinal
