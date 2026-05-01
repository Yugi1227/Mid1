import os
import sys
import time
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.edge.service import Service


sys.stdout.reconfigure(encoding="utf-8", errors="replace")


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
    service = Service(str(get_driver_path()))
    options = webdriver.EdgeOptions()
    driver = webdriver.Edge(service=service, options=options)

    try:
        driver.get("https://www.google.com")
        driver.maximize_window()
        time.sleep(2)

        search_box = driver.find_element(By.NAME, "q")
        search_box.send_keys("Selenium Web Testing")
        search_box.send_keys(Keys.RETURN)
        time.sleep(3)

        print("Search results loaded.")

        driver.get("https://www.google.com")
        time.sleep(2)

        search_button = driver.find_element(By.NAME, "btnK")
        print("Google Search button found.")

        apps_buttons = driver.find_elements(By.CLASS_NAME, "gb_D")
        if apps_buttons:
            print("Google Apps button located.")
        else:
            print("Google Apps button class differs on this page.")

        sign_in_buttons = driver.find_elements(By.LINK_TEXT, "Sign in")
        if sign_in_buttons:
            print("Sign-in button located.")
        else:
            print("Sign-in button text differs on this page.")

        footer_links = driver.find_elements(By.TAG_NAME, "a")
        print("Footer elements:")
        for link in footer_links:
            text = (link.text or "(no text)").strip()
            href = link.get_attribute("href")
            print(f"- {text} -> {href}")
    finally:
        driver.quit()


if __name__ == "__main__":
    main()
