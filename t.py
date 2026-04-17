from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.edge.service import Service
import time

# Set up Edge WebDriver (Selenium 4)
EDGE_DRIVER_PATH = r"C:\Users\yuges\Downloads\edgedriver_win64\msedgedriver.exe"
service = Service(EDGE_DRIVER_PATH)

options = webdriver.EdgeOptions()
driver = webdriver.Edge(service=service, options=options)

# Open Facebook Login Page
driver.get("https://www.facebook.com/")
time.sleep(3)

# Locate elements
email_field = driver.find_element(By.ID, "email")
password_field = driver.find_element(By.ID, "pass")
login_button = driver.find_element(By.NAME, "login")

# Enter credentials
email_field.send_keys("your_email@example.com")
password_field.send_keys("your_password")

# Click login
login_button.click()
time.sleep(5)

# Verify login
if "facebook.com" in driver.current_url:
    print("Login successful! Facebook homepage loaded.")
else:
    print("Login failed. Check credentials.")

# Close browser
driver.quit()