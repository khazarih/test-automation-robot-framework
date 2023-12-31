# Echo Park Test Automation

## Scenario
```
Given url “https://echopark.com”
When you enter <BMW X5> in the search bar
Then result should only contain <BMW X5>
```

## Requirements
- Python==3.11
    - robotframework==6.1.1
    - robotframework-seleniumlibrary==6.1.3

---
**NOTE**

Tested on Windows

---

## Setup environment Windows
```powershell
# Create a new virtual environment
python.exe -m venv automation_venv

# Enable script execution
powershell -ep bypass

# Activate virtual environment
.\automation_venv\Scripts\Activate.ps1

# Install requirements
pip install -r requirements.txt
```


## Setup environment Linux
```bash
# Create a new virtual environment
python3.11 -m venv automation_venv

# Activate virtual environment
source test_automation/bin/activate

# Install requirements
pip install -r requirements.txt
```

## Run tests
```powershell
# Windows
robot -d results .\TestCases\SearchTest.robot 

# Linux
robot -d results TestCases/SearchTest.robot 
```
