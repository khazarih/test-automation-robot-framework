from selenium import webdriver
from selenium.webdriver.chrome.options import Options

chrome_options = Options()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')


svc = webdriver.ChromeService(executable_path="/usr/local/bin/chromedriver")
driver = webdriver.Chrome(service=svc, options=chrome_options)
driver.get("https://www.echopark.com/")
from time import sleep

sleep(10)
driver.save_screenshot("test.png")