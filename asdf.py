#!/usr/bin/env python3

from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver import Chrome
from selenium.webdriver.chrome.options import Options
import lxml
from bs4 import BeautifulSoup as bs
import re

options = Options()
options.add_argument('--headless')
driver = Chrome(ChromeDriverManager().install(),chrome_options=options)

pattern = r'span>.*</span'

file_name = '/Users/yamamotoryuuji/Documents/words.txt'
output = '/Users/yamamotoryuuji/Documents/mydict.txt'
with open(file_name, mode='r') as f:
    data = f.readlines()

for index, word in enumerate(data):
    driver.get(f'https://www.google.com/search?q={word}+definition')

    source = driver.page_source
    soup = bs(source, 'lxml')

    try:
        definition = re.search(pattern,str(soup.select('div[data-dobid]')[0]))
    except IndexError:
        definition = " "
    if definition == " ":
        definition2 = " "
    else:
        definition2 = definition.group().replace('span', ' ')
    with open(output, mode='a') as f:
        f.writelines(f'{word}: {definition2}\n')

with open(file_name, mode='w') as f:
    f.writelines('')



driver.quit()
