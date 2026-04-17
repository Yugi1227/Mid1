import os
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.edge.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def main() -> None:
    email = os.getenv("FB_EMAIL", "")
    password = os.getenv("FB_PASSWORD", "")

    if not email or not password:
        raise ValueError(
            "Set FB_EMAIL and FB_PASSWORD environment variables before running."
        )

    project_root = Path(__file__).resolve().parents[2]
    driver_path = project_root / "msedgedriver.exe"

    if not driver_path.exists():
        raise FileNotFoundError(f"Edge WebDriver not found at: {driver_path}")

    service = Service(str(driver_path))
    options = webdriver.EdgeOptions()
    driver = webdriver.Edge(service=service, options=options)

    try:
        wait = WebDriverWait(driver, 20)
        driver.get("https://www.facebook.com/")

        email_field = wait.until(EC.presence_of_element_located((By.ID, "email")))
        password_field = wait.until(EC.presence_of_element_located((By.ID, "pass")))
        login_button = wait.until(EC.element_to_be_clickable((By.NAME, "login")))

        email_field.clear()
        email_field.send_keys(email)
        password_field.clear()
        password_field.send_keys(password)
        login_button.click()

        wait.until(lambda d: "facebook.com" in d.current_url)
        print("Login process completed. Current URL:", driver.current_url)
    finally:
        driver.quit()


if __name__ == "__main__":
    main()
