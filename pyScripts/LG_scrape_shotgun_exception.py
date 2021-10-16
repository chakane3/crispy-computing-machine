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
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    img = soup.find_all('div', class_='lSSlideOuter')
    for i in img:
        return i.find('li', {'data-src': True})['data-src']

def scrape_shotgun_helper(url):
    url+='?limit-all'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
        
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
            aDict = {'name': '', 'price': '', 'caliber': '', 'link': '', 'imgURL': ''}
            if_available = (price.find('p', class_='availability'))
    
            if 'Out of stock' not in str(if_available.text):
                aDict['name'] = price.find('span').text
                dLink = price.find('a')
                aDict['link'] = dLink['href']
                aDict['caliber'] = caliber.text.replace('\n', '')
                
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
       
def scrape_shotgun(url, json_save):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
        
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    productLinks = soup.find_all('td')
    detailLink = []
    for i in productLinks:
        scrapedLink = i.find('a')
        detailLink.append(scrapedLink["href"])
        
        results = scrape_shotgun_helper(scrapedLink["href"])
        if len(results) != 0:
            json_save['ammo_results'].append(results)
        else:
            out_of_stock = scrapedLink['title']
            json_save['ammo_results'].append({'name': 'out of stock', 'price': 'check back soon', 'caliber': '.', 'link': '.', 'imgURL': '.'})
            
    return json_save
