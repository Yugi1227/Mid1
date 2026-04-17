from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.edge.service import Service
import time

# Path to msedgedriver.exe
service = Service(r"C:\Users\yuges\Downloads\edgedriver_win64\msedgedriver.exe")

# Create driver
driver = webdriver.Edge(service=service)

# Open Google
driver.get("https://www.google.com")
time.sleep(2)

# Find search box
search_box = driver.find_element(By.NAME, "q")
print("Search box element found:", search_box)

# Close browser
driver.quit()