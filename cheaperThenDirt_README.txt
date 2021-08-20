Gets Ammo by caliber: handgunByCaliberLink = "https://www.cheaperthandirt.com/shop-by?cgid=78&searchBy=Caliber"


Uses 3 functions:
    range_price(url)
    scrape_handguns_helper(url)
    scrape_handguns(url)

First we get the links of each caliber available using "scrape_handguns(url)"
    - We use the url, "handgunByCaliberLink"
    - Then get the soup object
    - From the soup object well execute: sections = soup.find_all("ul",class_= "col-lg-11 right-list")
        It'' return an array of all "ul" tags with the class col-lg-11 right-list, therefore giving us a link to each caliber

            <ul class="col-lg-11 right-list">
            <li class="brand-refinements" title="Refine by Caliber: 10mm Automatic">
            <a class="custom-text-underline" href="https://www.cheaperthandirt.com/10mm-automatic/ammunition/handgun-ammo/?brand=10mmAutomatic">
            <span class="">10mm Automatic</span>
            </a>
            </li>
            </ul>

        What we want from this is a dataframe with calibers and another DF where the product list is 

        crispy-computing-machine
            jsonFiles
                cheaperThanDirt
                    ammo
                        handgun
                            caliber
                                . 10mm Automatic
                                .
                                .
                        rifle
                            caliber
                                .
                                .
                        shotgun
                            caliber
                                .

    