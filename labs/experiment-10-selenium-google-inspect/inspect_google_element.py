import os
import time
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
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
    service = Service(str(get_driver_path()))
    options = webdriver.EdgeOptions()
    driver = webdriver.Edge(service=service, options=options)

    try:
        driver.get("https://www.google.com")
        time.sleep(2)
        search_box = driver.find_element(By.NAME, "q")
        print("Search box element found:", search_box)
    finally:
        driver.quit()


if __name__ == "__main__":
    main()
