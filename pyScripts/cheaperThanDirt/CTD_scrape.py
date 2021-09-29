import urllib.request
import re
from bs4 import BeautifulSoup
from bs4.element import ProcessingInstruction
from lxml import html
import json
import requests


# link to handgun by caliber
link = "https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber"

def range_price(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }

    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    lowend = soup.find_all("span", {"class":"value", "itemprop":"lowprice", "content": True})
    highend = soup.find_all("span", {"class":"value", "itemprop":"highprice", "content": True})
    range_p = ''

    for price in lowend:
        range_p += price['content']
        range_p += ' - '
        break

    for price in highend:
        range_p += price['content']
        range_p += ' - '
        break

    return range_p

def get_image(url):
    headers = {
       'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "lxml")
    imgSoup = soup.find('div', class_='desktop-zoom') # d-block img-fluid primary-image
    img = imgSoup.find('img')
    
    return img['src']

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
            prices.append(p)
        else:
            # if our price is slashed or normal get our price
            p = price.find('span', class_='sales')
            prices.append(p)
    
    # further scrape prices for a consistent collection
    actual_price = []
    for price in prices:

        # use a helper function to get our high and low price
        if 'http' in price:
            range_price = range_price(price)
            actual_price.append(str(range))

        # collect price as normal
        else:
            html_price_tag = str(price)
            split_html_price_tag = html_price_tag.split(' ')
            p = split_html_price_tag[2].strip('content="')
            actual_price.append(str(p))

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

def scrape(url):
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
            price_list.append(price)

        for caliber in products['caliber']:
            caliber_list.append(caliber)

        for img in products['imgURL']:
            images_list.append(img)

        for link in products['link']:
            link_list.append(link)

    # print(len(name_list))
    # print(len(price_list))
    # print(len(link_list))
    # print(len(caliber_list))
    # print(len(images_list))


    ammo_data = {'type': 'handgun', 'ammo_results': []}
    for product in range(0, len(name_list)):
        single_product = {'name': name_list[product], 'price': price_list[product], 'caliber': caliber_list[product], 'link': link_list[product], 'imgURL': images_list[product]}
        ammo_data['ammo_results'].append(single_product)
    
    return ammo_data
    
