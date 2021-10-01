import urllib.request
import re
from bs4 import BeautifulSoup
from lxml import html
import json
import requests

def strip_price(price):
    rtn = ''
    aGroup = '0123456789.'
    for i in price:
        if i in aGroup:
            rtn += i
    return rtn

def get_image(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    
        
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    img = soup.find_all('div', class_='lSSlideOuter')
    for i in img:
        return i.find('li', {'data-src': True})['data-src']

# returns 2 list of http links separated by availability
def luckyGunner_availability(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    
        
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    page_body = soup.body
    products = soup.find_all('div', class_='main')

    
    # list of all handgun ammo seperated by availability
    products = soup.find_all('div', class_='block-content block-no-padding')
    bulletsList = str(products).split('<div class="main-category-cols">')
    inStock = bulletsList[1]
    outofStock = bulletsList[2]

    inStockScrapedLinks = []
    outofStockScrapedLinks = []
    
    inStock = inStock.split("</li>")
    for inStockItems in inStock:
        inStockScrapedLinks.append(re.findall("(?P<url>https?://[^\s]+)", str(inStockItems)))


    outofStock = outofStock.split("</li>")
    for outofStockItems in outofStock:
        outofStockScrapedLinks.append(re.findall("(?P<url>https?://[^\s]+)", str(outofStockItems)))

    inStockCleanLinks = []
    outofStockCleanLinks = []
    

    for i in inStockScrapedLinks:
        cleanLink = ""
        for j in i:
            for k in j:
                if k != '"':
                    cleanLink += k
                    
                else:
                    inStockCleanLinks.append(cleanLink)
                    break
                
    for i in outofStockScrapedLinks:
        cleanLink = ""
        for j in i:
            for k in j:
                if k != '"':
                    cleanLink += k
                else:
                    outofStockCleanLinks.append(cleanLink)
                    break
    return inStockCleanLinks, outofStockCleanLinks

# scrape 
def scrape(link):

    link+="?limit=all"
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    
    page = requests.get(link)
    soup = BeautifulSoup(page.content, "lxml")

    detailPageLinks = []
    dictLinks = []
    imageURL = []

    links = soup.find_all('h3', class_='product-name')
    detailProduct = soup.find_all('div', class_='product-shop')

    for i in links:
        x = i.find('a')
        detailPageLinks = x['href']
        dictLinks.append(detailPageLinks)
        imageURL.append(get_image(detailPageLinks))

    names = []
    prices = []
    calibers = []

    try:
        calibers.append(soup.find('div', class_='category-title').text)
    except:
        print(link)

    linkIndex = 0 
    imageIndex = 0
    list_of_dicts = []

    for product in detailProduct:
        aDict = {'name': '', 'prices': '', 'links': '', 'caliber': '', 'imageUrl': ''}

        # scrape names
        name = product.find('a')
        name = name.find('span').text
        aDict['name'] = name
        
        aDict['imageUrl'] = imageURL[imageIndex]

        # scrape prices
        price = product.find('div', class_='price-box')
        if "Special Price" in str(price):
            price = price.find('span', class_='price')
            aDict['prices'] = strip_price(price.text)
        else:
            if 'As low as' in str(price):
                price = (price.find('span', class_='price'))
                aDict['prices'] = strip_price(price.text)
            else:
                try:
                    prices.append(price.text)
                    aDict['prices'] = strip_price(price.text)
                except:
                    prices.append("NOPE")
                    aDict['prices'] = "out of stock"

        aDict['links'] = dictLinks[linkIndex]
        linkIndex += 1
        imageIndex+=1
        try:
            aDict['caliber'] = calibers[0].replace('\n', '')
        except:
            print(link)

        list_of_dicts.append(aDict)
    return list_of_dicts

def final_scrape(url, json_save):
    x = luckyGunner_availability(url)
    ld = []
    for i in x[0]:
        dicts = scrape(i)
        for j in dicts:
            ld.append(j)
    for i in ld:
        json_save['ammo_results'].append(i)

    return json_save



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
    