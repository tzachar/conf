from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
import click
import time
import plumbum


def create_driver(headless=False):
    chrome_options = webdriver.ChromeOptions()
    if headless:
        chrome_options.add_argument('headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('window-size=1200x600')
    chrome_options.add_argument("--incognito")
    chrome_options.add_experimental_option("prefs", {"profile.managed_default_content_settings.images": 2})
    return webdriver.Chrome(ChromeDriverManager().install(), options=chrome_options)


def driver_wait_for_element(driver, by, elm, delay=30):
    try:
        myelm = WebDriverWait(driver, delay).until(EC.presence_of_element_located((by, elm)))
    except TimeoutException:
        return None
    return myelm


def try_update(school, user, pw, visible):
        driver = create_driver(not visible)
        driver.get('https://web.mashov.info/students/login')

        # school
        school_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-input-3"]', delay=30)
        school_input.send_keys(school)
        # drop down with school
        # dropdown = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-option-115"]/span')
        dropdown = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-autocomplete-0"]/mat-option/span', delay=30)
        dropdown.click()

        user_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-input-0"]', delay=30)
        user_input.send_keys(user)

        pw_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-input-4"]', delay=30)
        pw_input.send_keys(pw)

        login_btn = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-tab-content-0-0"]/div/div/button[1]/span/span', delay=30)
        login_btn.click()

        side_menu = driver_wait_for_element(driver, By.XPATH, '//*[@id="mshv-main-toolbar"]/button[1]', delay=30)
        side_menu.click()

        covid = driver_wait_for_element(driver, By.XPATH, '//*[@id="mainMenu"]/ul/li[2]/button/span/div/span/span', delay=30)
        covid.click()

        change = False
        fever = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-checkbox-1"]', delay=30)
        if not ('mat-checkbox-checked' in fever.get_attribute('class').split()):
            fever.click()
            change = True

        nocontact = driver_wait_for_element(driver, By.XPATH, '//*[@id="mat-checkbox-2"]', delay=30)
        if not ('mat-checkbox-checked' in nocontact.get_attribute('class').split()):
            nocontact.click()
            change = True

        if change:
            submit = driver_wait_for_element(
                driver, By.XPATH,
                '//*[@id="mainView"]/mat-sidenav-content/mshv-students-covid-clearance/mat-card/mat-card-actions/button',
                delay=30)
            submit.click()


ishurim_configs = {
    'ron': {
        'school': '414805',
        'id': '336678354',
        'pw': '336678354',
        'name': 'רון צחר',
        'city': 'קדימה-צורן',
        'class': 'ד',
        'class_number': '1',
        'parent_name': 'שני צחר',
    },
    'gali': {
        'school': '413773',
        'id': '333020493',
        'pw': '31406036',
        'name': 'גלי צחר',
        'city': 'קדימה-צורן',
        'class': 'ו',
        'class_number': '1',
        'parent_name': 'שני צחר',
    },
}
def try_update_ishurim(config, is_first, visible):
        driver = create_driver(not visible)
        driver.get('https://ishurim.edupage.co.il/login-edu.asp')

        # school
        school_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="schoolCode"]', delay=30)
        school_input = Select(school_input)
        school_input.select_by_value(config['school'])

        password_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="userPass"]', delay=30)
        password_input.send_keys(config['pw'])

        submit = driver_wait_for_element(driver, By.XPATH,'//*[@id="btnlogin"]')
        submit.click()

        # the folllowing is only needed for the first login
        if is_first:
            name = driver_wait_for_element(driver, By.XPATH, '//*[@id="student1"]', delay=30)
            name.send_keys(config['name'])

            name = driver_wait_for_element(driver, By.XPATH, '//*[@id="studId1"]', delay=30)
            name.send_keys(config['id'])

            city_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="sel-city-1"]')
            city_input = Select(city_input)
            city_input.select_by_value(config['city'])

            school_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="sel-school-1"]')
            school_input = Select(school_input)
            school_input.select_by_value(config['school'])

            class_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="sel-class-1"]')
            class_input = Select(class_input)
            class_input.select_by_value(config['class'])

            number_input = driver_wait_for_element(driver, By.XPATH, '//*[@id="sel-subclass-1"]')
            number_input = Select(number_input)
            number_input.select_by_value(config['class_number'])

            parent = driver_wait_for_element(driver, By.XPATH, '//*[@id="fatherName"]', delay=30)
            parent.send_keys(config['parent_name'])

            time.sleep(2)
            submit = driver_wait_for_element(driver, By.XPATH,'//*[@id="btnSaveData"]')
            submit.click()

        check = driver_wait_for_element(driver, By.XPATH, '//*[@id="chk-1"]')
        check.click()

        check = driver_wait_for_element(driver, By.XPATH, '//*[@id="chk1"]')
        check.click()

        for i in range(1, 7):
            check = driver_wait_for_element(driver, By.XPATH, f'//*[@id="d{i}"]')
            check.click()

        parent = driver_wait_for_element(driver, By.XPATH, '//*[@id="fatherName"]', delay=30)
        parent.send_keys(config['parent_name'])

        submit = driver_wait_for_element(driver, By.XPATH,'//*[@id="btnSaveData"]')
        submit.click()

        time.sleep(5)


@click.group()
def cli():
    pass


@cli.command()
@click.option('--target', required=True)
@click.option('--email', default=None, type=str)
@click.option('--visible', is_flag=True)
@click.option('--is_first', is_flag=True)
def ishurim(target, email, visible, is_first):
    for _ in range(5):
        try:
            try_update_ishurim(ishurim_configs[target], is_first, visible)
            time.sleep(5)
            if email is not None:
                plumbum.local['mail'][
                    '-s', f'Ishurim updated for {target}',
                    email,
                ]()
            return
        except Exception as e:
            print(e)
            time.sleep(20)

    if email is not None:
        plumbum.local['mail'][
            '-s', f'Error with Ishurim for {target}',
            email,
        ]()

    return


@cli.command()
@click.option('--school', required=True)
@click.option('--user', required=True)
@click.option('--pw', required=True)
@click.option('--email', default=None, type=str)
@click.option('--visible', is_flag=True)
def mashov(school, user, pw, email, visible):
    for _ in range(5):
        try:
            try_update(school, user, pw, visible)
            time.sleep(5)
            if email is not None:
                plumbum.local['mail'][
                    '-s', f'Mashov updated for {user}@{school}',
                    email,
                ]()
            return
        except Exception as e:
            print(e)
            time.sleep(20)

    if email is not None:
        plumbum.local['mail'][
            '-s', f'Error with Mashov for {user}@{school}',
            email,
        ]()

    return


if __name__ == '__main__':
    cli()
