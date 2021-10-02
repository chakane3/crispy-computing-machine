import json
import urllib.request
import re
from bs4 import BeautifulSoup
from bs4.element import ProcessingInstruction
from lxml import html
import requests

# functions to scrape web
def range_price(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }

    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    lowend = soup.find_all("span", {"class":"value", "itemprop":"lowprice", "content": True})
    highend = soup.find_all("span", {"class":"value", "itemprop":"highprice", "content": True})
    range_p = 0.0

    for price in lowend:
        range_p = price['content']
        return(range_p)
        range_p += ' - '
        break

    # for price in highend:
    #     range_p += price['content']
    #     range_p += ' - '
    #     break

    # return range_p

def strip_price(price):
    rtn = ''
    aGroup = '0123456789.'
    for i in price:
        if i in aGroup:
            rtn += i
    return float(rtn)

def get_image(url):
    headers = {
       'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    try:
        imgSoup = soup.find('img', class_='d-block img-fluid primary-image') # d-block img-fluid primary-image
        if len(str(imgSoup['src'])) > 0:
            return str(imgSoup['src'])
    except:
        return 'no image' 

def scrape_helper(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }

    # get soup object
    url+= "=undefined&start=0&sz=100"  # make sure we get all the products
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'lxml')

    # get caliber for the product
    possibleCaliber = soup.find_all("li", class_="filter-value")
    caliber = possibleCaliber[0].text

    # collect product names
    ammo_soup = soup.find_all('div', class_='pdp-link')
    product_name = []
    for ammo in ammo_soup:
        product_name.append(ammo.find('span').text)
    
    # collect product price
    soup_price = soup.find_all('div', class_='tile-body')
    prices = []
    for price in soup_price:


        # if product has a range of prices, get the detail product link
        if 'span class="range">' in str(price):
            p = price.find('a', {'class': 'link', 'href': True})
            prices.append(p['href'])
        else:
            # if our price is slashed or normal get our price
            p = price.find('span', class_='sales')
            prices.append((p.find("span", {"class":"value", "content": True})))
    
    # further scrape prices for a consistent collection
    actual_price = []
    for price in prices:

        # use a helper function to get our high and low price
        if 'http' in price:
            rp = range_price(price)
            actual_price.append(str(rp))

        # collect price as normal
        else:
            html_price_tag = str(price)
            split_html_price_tag = html_price_tag.split(' ')
            p = split_html_price_tag[2].strip('content="')
            actual_price.append(float(p))

    # get product detail link and image URL
    soup_links = soup.find_all('div', class_='pdp-link')
    links = []
    img_url = []
    for link in soup_links:
        a_link = link.find('a')['href']
        links.append(a_link)
        img_url.append(get_image(a_link))
    
    try:
        product = {'name': product_name, 'price': actual_price, 'link': links, 'caliber': caliber.replace('\n\n', '').replace('\n', '').replace('\n\n\n', ''), 'imgURL': img_url}
        return product

    except:
        print("something went wrong")

def scrape(url, json_save):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    
    # get soup object
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'lxml')

    # returns an array of products from our caliber list
    sections = soup.find_all('div', class_='brand-link-list') 

    # get caliber number set
    caliber_numbers = []
    soup_caliber = soup.find_all('div', class_='refinements')
    for caliber in soup_caliber:
        soup_dict = caliber.find_all('div', {'id': True})
        for num in soup_dict:
            caliber_numbers.append(num['id'])

    caliber_links = []
    calibers = []

    # get links
    for link in sections:
        caliber_links.append(link.find_all('a')[0]['href'])

    caliber_links = {'number': caliber_numbers, 'section': caliber_links}

    # collect products from each caliber link
    name_list, price_list, link_list, caliber_list, images_list = [], [], [], [], []
    for caliber in caliber_links['section']:
        product_dict = {'caliber': '', 'name': '', 'price': '', 'link': '', 'imgURL': ''}

        products = scrape_helper(caliber)

        for name in products['name']:
            name_list.append(name)

        for price in products['price']:
            try:
                price_list.append(float(price))

            except:
                price_list.append(price)

        for caliber in products['caliber']:
            caliber_list.append(caliber)

        for img in products['imgURL']:
            images_list.append(img)

        for link in products['link']:
            link_list.append(link)

    
    for product in range(0, len(name_list)):
        single_product = {'name': name_list[product], 'price': price_list[product], 'caliber': caliber_list[product], 'link': link_list[product], 'imgURL': images_list[product]}
        json_save['ammo_results'].append(single_product)
    
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
    
