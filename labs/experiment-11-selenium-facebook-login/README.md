# Experiment 11: Automate Facebook Login with Selenium (Edge)

## Important
Use your own test account. Do not hardcode credentials in code.

## Run (PowerShell)

```powershell
cd ..\experiment-11-selenium-facebook-login
pip install selenium
$env:FB_EMAIL="your_email@example.com"
$env:FB_PASSWORD="your_password"
python facebook_login.py
```

## Expected Result
- Edge opens Facebook login page.
- Credentials are entered and login is attempted.
- Script prints current URL and closes browser.
