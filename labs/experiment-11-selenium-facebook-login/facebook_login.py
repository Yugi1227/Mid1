import os
import time
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.edge.service import Service


def get_driver_path() -> Path:
    project_root = Path(__file__).resolve().parents[2]
    configured_path = os.getenv("EDGE_DRIVER_PATH")
    driver_path = Path(configured_path) if configured_path else project_root / "msedgedriver.exe"

    if not driver_path.exists():
        raise FileNotFoundError(
            "Edge WebDriver not found. Put msedgedriver.exe in the project root "
            "or set EDGE_DRIVER_PATH to its full path."
        )

    return driver_path


def main() -> None:
    email = os.getenv("FB_EMAIL", "testingground@gmail.com")
    password = os.getenv("FB_PASSWORD", "testtest1227")

    service = Service(str(get_driver_path()))
    options = webdriver.EdgeOptions()
    driver = webdriver.Edge(service=service, options=options)

    try:
        driver.get("https://www.facebook.com/")
        time.sleep(3)

        email_field = driver.find_element(By.ID, "email")
        password_field = driver.find_element(By.ID, "pass")
        login_button = driver.find_element(By.NAME, "login")
        email_field.clear()
        email_field.send_keys(email)
        password_field.clear()
        password_field.send_keys(password)
        password_field.send_keys(Keys.TAB)
        login_button.click()
        time.sleep(5)

        if "facebook.com" in driver.current_url:
            print("Login process completed. Current URL:", driver.current_url)
        else:
            print("Login failed. Check credentials.")
    finally:
        driver.quit()


if __name__ == "__main__":
    main()
