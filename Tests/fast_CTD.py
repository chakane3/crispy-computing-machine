

from bs4 import BeautifulSoup
from bs4.element import ProcessingInstruction
from lxml import html
import requests
import re
import time

def scrape_old(url):
    
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
    correspondingTypes = []
    # get links
    for link in sections:
        for urls_for_caliber in link.find_all('a'):
            caliber_links.append(str(re.findall('(?P<url>https?://[^\s]+)', str(urls_for_caliber))).replace('"', "").replace(";W","").replace(">", "").replace("[", "").replace("]", "").replace("'", ""))

    # print(caliber_links)
        
def scrape(url):
    
    # get soup object
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'lxml')

    # grab links for each caliber
    caliber_numbers = []
    soup_caliber = soup.find_all('div', class_='refinements')
    caliber_numbers = [num for caliber in soup_caliber for num in caliber.find_all('div', {'id': True}) ]
    caliber_links_html = [i.find_all('a') for i in caliber_numbers]
    caliber_links_str = [str(re.findall('(?P<url>https?://[^\s]+)', str(j))).replace('"', "").replace(">", "").replace("'","").replace("[", "").replace("]", "") for j in caliber_links_html]
    caliber_links_arr = [i.split(", ") for i in caliber_links_str]
    calibers_urls = [link for arr in caliber_links_arr for link in arr]
    
    # for i in caliber_numbers:
    #     links = i.find_all('a')
    #     for j in links: 
    #         caliber_links.append(str(re.findall('(?P<url>https?://[^\s]+)', str(j))).replace('"', "").replace(">", "").replace("'","").replace("[", "").replace("]", ""))
    
    
           
        


start_time = time.time()
scrape("https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber")
print("---%s seconds: new scrape---" % (time.time() - start_time))
start_time = time.time()
scrape_old("https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber")
print("---%s seconds: old scrape---" % (time.time() - start_time))