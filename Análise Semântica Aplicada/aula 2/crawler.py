#!/usr/bin/env python
# coding: utf-8

# In[1]:


# importing required libraries
import requests
from bs4 import BeautifulSoup
import pandas as pd


# In[2]:


# target URL to scrap
url = "https://www.goibibo.com/hotels/hotels-in-shimla-ct/"


# In[3]:


# headers
headers = {
 'User-Agent': "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"
}


# In[4]:


# send request to download the data
response = requests.request("GET", url, headers=headers)


# In[5]:


# parse the downloaded data
data = BeautifulSoup(response.text, 'html.parser')
print(data)


# In[6]:


# find all the sections with specifiedd class name
cards_data = data.find_all('div', attrs={'class', 'width100 fl htlListSeo hotel-tile-srp-container hotel-tile-srp-container-template new-htl-design-tile-main-block'})


# In[7]:


# total number of cards
print('Total Number of Cards Found : ', len(cards_data))


# In[8]:


# source code of hotel cards
for card in cards_data:
    print(card)


# In[9]:


# extract the hotel name and price per room
for card in cards_data:

    # get the hotel name
    hotel_name = card.find('p')

    # get the room price
    room_price = card.find('li', attrs={'class': 'htl-tile-discount-prc'})
    print(hotel_name.text, room_price.text)


# In[11]:


# create a list to store the data
scraped_data = []

for card in cards_data:

    # initialize the dictionary
    card_details = {}

    # get the hotel name
    hotel_name = card.find('p')

    # get the room price
    room_price = card.find('li', attrs={'class': 'htl-tile-discount-prc'})

    # add data to the dictionary
    card_details['hotel_name'] = hotel_name.text
    card_details['room_price'] = room_price.text

    # append the scraped data to the list
    scraped_data.append(card_details)
    
# create a data frame from the list of dictionaries
dataFrame = pd.DataFrame.from_dict(scraped_data)

# save the scraped data as CSV file
dataFrame.to_csv('hotels_data.csv', index=False)


# In[ ]:




