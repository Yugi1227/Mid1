from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.edge.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def main() -> None:
    project_root = Path(__file__).resolve().parents[2]
    driver_path = project_root / "msedgedriver.exe"

    if not driver_path.exists():
        raise FileNotFoundError(f"Edge WebDriver not found at: {driver_path}")

    service = Service(str(driver_path))
    options = webdriver.EdgeOptions()
    driver = webdriver.Edge(service=service, options=options)

    try:
        wait = WebDriverWait(driver, 20)
        driver.get("https://www.google.com")
        driver.maximize_window()

        search_box = wait.until(EC.presence_of_element_located((By.NAME, "q")))
        search_box.send_keys("Selenium Web Testing")
        search_box.send_keys(Keys.RETURN)

        wait.until(EC.presence_of_element_located((By.ID, "search")))
        print("Search results loaded.")

        driver.get("https://www.google.com")

        # Buttons and classes on Google can vary by region and language.
        search_button = wait.until(EC.presence_of_element_located((By.NAME, "btnK")))
        print("Google Search button found:", search_button.tag_name)

        sign_in_candidates = driver.find_elements(By.PARTIAL_LINK_TEXT, "Sign")
        if sign_in_candidates:
            print("Sign-in related link located:", sign_in_candidates[0].text)
        else:
            print("Sign-in link text differs in this locale.")

        footer_links = driver.find_elements(By.TAG_NAME, "a")
        print("Footer and page links sample:")
        for link in footer_links[:15]:
            text = (link.text or "(no text)").strip()
            href = link.get_attribute("href")
            print(f"- {text} -> {href}")
    finally:
        driver.quit()


if __name__ == "__main__":
    main()
