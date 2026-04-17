from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.edge.service import Service


def main() -> None:
    project_root = Path(__file__).resolve().parents[2]
    driver_path = project_root / "msedgedriver.exe"

    if not driver_path.exists():
        raise FileNotFoundError(f"Edge WebDriver not found at: {driver_path}")

    service = Service(str(driver_path))
    options = webdriver.EdgeOptions()
    driver = webdriver.Edge(service=service, options=options)

    try:
        driver.get("https://www.google.com")
        search_box = driver.find_element(By.NAME, "q")
        print("Search box element found:", search_box)
    finally:
        driver.quit()


if __name__ == "__main__":
    main()
