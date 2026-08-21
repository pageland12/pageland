import csv
import os
import re
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select

# Chrome 옵션 설정
chrome_options = Options()
chrome_options.add_experimental_option("detach", True)

driver = webdriver.Chrome(options=chrome_options)

# ==========================================
# 1. 로그인 수행
# ==========================================
login_url = "http://localhost:8080/login"
driver.get(login_url)
time.sleep(1)

driver.find_element(By.NAME, 'memail').send_keys("admin")
password_input = driver.find_element(By.NAME, 'mpasswd')
password_input.send_keys("1234")
password_input.send_keys(Keys.RETURN)

time.sleep(2)

# ==========================================
# 2. 책 등록 페이지 이동
# ==========================================
target_url = "http://localhost:8080/admin/bookWriteForm"
driver.get(target_url)
time.sleep(1)


# ==========================================
# 헬퍼 함수: 드롭다운 옵션 유연하게 매칭하기
# ==========================================
def smart_select_option(select_element, target_text):
    """
    공백, 백슬래시, 특수문자(~, - 등)를 모두 제거하고
    가장 유사한 option을 찾아서 선택합니다.
    """
    select_obj = Select(select_element)

    # 정제 함수: 특수문자, 백슬래시, 공백 제거
    def clean_text(text):
        return re.sub(r'[\s\\~·/]', '', str(text)).strip()

    clean_target = clean_text(target_text)

    # 1단계: 완전히 똑같은 text 시도
    try:
        select_obj.select_by_visible_text(target_text.strip())
        return
    except Exception:
        pass

    # 2단계: 특수문자/공백 제거 후 일치하거나 포함되는 option 탐색
    for option in select_obj.options:
        clean_opt = clean_text(option.text)
        if not clean_opt:
            continue

        # 서로 포함관계에 있으면 선택 (예: '초등저학년' <-> '초등 저학년')
        if clean_target in clean_opt or clean_opt in clean_target:
            select_obj.select_by_visible_text(option.text)
            return

    # 3단계: 도저히 못 찾으면 첫 번째 선택지가 아닌 두 번째(index 1)를 기본값으로 선택
    if len(select_obj.options) > 1:
        select_obj.select_by_index(1)


# ==========================================
# 3. CSV 파일 읽기 및 반복 입력
# ==========================================
csv_file_path = os.path.join(os.getcwd(), '전체상품.csv')

with open(csv_file_path, mode='r', encoding='utf-8-sig') as file:
    reader = csv.DictReader(file)

    for idx, row in enumerate(reader, start=1):
        try:
            # 등록 폼 페이지가 아닐 경우 다시 이동
            if driver.current_url != target_url:
                driver.get(target_url)
                time.sleep(1)

            # 1. 제목 (bname)
            bname_input = driver.find_element(By.NAME, 'bname')
            bname_input.clear()
            bname_input.send_keys(row['상품이름'])

            # 2. 연령 (bage) -> 스마트 매칭 함수 사용
            bage_element = driver.find_element(By.NAME, 'bage')
            smart_select_option(bage_element, row['연령'])

            # 3. 출판사 (bpublisher)
            bpublisher_input = driver.find_element(By.NAME, 'bpublisher')
            bpublisher_input.clear()
            bpublisher_input.send_keys(row['출판사'])

            # 4. 분야 (bgenre) -> 스마트 매칭 함수 사용
            bgenre_element = driver.find_element(By.NAME, 'bgenre')
            smart_select_option(bgenre_element, row['분야'])

            # 5. 책 이미지 (bimg)
            bimg_input = driver.find_element(By.NAME, 'bimg')
            bimg_input.clear()
            bimg_input.send_keys(row['썸네일 이미지'])

            # 6. 세부 정보 (binfo)
            binfo_input = driver.find_element(By.NAME, 'binfo')
            binfo_input.clear()
            binfo_input.send_keys(row['상품정보 이미지'])

            # 7. 가격 (bprice)
            bprice_input = driver.find_element(By.NAME, 'bprice')
            bprice_input.clear()
            bprice_input.send_keys(str(row['상품가격']))

            # 8. 재고 수량 (bstock) -> 10000개 고정
            bstock_input = driver.find_element(By.NAME, 'bstock')
            bstock_input.clear()
            bstock_input.send_keys("10000")

            time.sleep(0.3)

            # 9. 등록하기 버튼 클릭
            submit_btn = driver.find_element(By.CSS_SELECTOR, "input[value='등록하기']")
            submit_btn.click()

            print(f"[{idx}번] 등록 성공: {row.get('상품이름')}")
            time.sleep(1)

        except Exception as e:
            print(f"❌ [{idx}번] 등록 실패 ({row.get('상품이름', '제목없음')}): {e}")
            driver.get(target_url)
            time.sleep(1)