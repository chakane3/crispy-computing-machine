

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

    print(caliber_links)
        
            
        

"""
cube_numbers = []
for n in range(0, 10):
    if n % 2 == 1:
        cube_numbers.append(n**3)

this code can actually just be:
cube_numbers  = [n**3 for n in range(1, 10) if n%2 == 1]
[appendThis for n in arr expression]


if you want to implement multiple loops in a comprehension list
the outermost loop goes first and work your way in
result = []

for tag in tags:
    for entry in entries:
        if tag in entry:
            result.extend(entry)
[entry for tag in tags for entry in entries if tag in entry]

"""
def scrape(url):
    
    # get soup object
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'lxml')

    # returns an array of products from our caliber list
    sections = soup.find_all('div', class_='brand-link-list') 

    """
    caliber_links = []
    correspondingTypes = []
    # get links
    for link in sections:
        for urls_for_caliber in link.find_all('a'):
            caliber_links.append(str(re.findall('(?P<url>https?://[^\s]+)', str(urls_for_caliber))).replace('"', "").replace(";W","").replace(">", "").replace("[", "").replace("]", "").replace("'", ""))
    """
    # get caliber number set
    caliber_numbers = []
    soup_caliber = soup.find_all('div', class_='refinements')
    caliber_numbers = [num for caliber in soup_caliber for num in caliber.find_all('div', {'id': True}) ]
    caliber_links = []


start_time = time.time()
scrape("https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber")
print("---%s seconds: new scrape---" % (time.time() - start_time))
start_time = time.time()
scrape_old("https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber")
print("---%s seconds: old scrape---" % (time.time() - start_time))