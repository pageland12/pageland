# 페이지랜드 (Pageland)

> **어린이 도서 전집 대여 및 정기 구독 서비스 플랫폼**

---

### 1. 프로젝트 소개
- **페이지랜드**는 영유아 및 어린이 전집 도서를 합리적인 비용으로 대여하고 구독할 수 있는 웹 서비스입니다.
- 정기권/N회권 구독 시스템, 도서 대여 및 결제 프로세스, 관리자 도서·회원 관리 기능을 제공합니다.

---

### 2. 기술 스택 (Tech Stack)

| 구분 | 기술 |
|---|---|
| **Backend** | Java 17, Spring Boot 3.x, Spring Security, MyBatis |
| **Frontend** | JSP, JSTL, HTML5, CSS3, JavaScript |
| **Database** | Oracle DB |
| **Build / Server** | Gradle, Apache Tomcat 10.1 |
| **External API** | PortOne V2 (카카오페이 결제 연동) |

---

### 3. 핵심 기능 (Key Features)

* **회원 및 권한 관리 (Spring Security)**
  * 일반 회원(`ROLE_USER`), 정기 구독자(`ROLE_SUBSCRIBER`), 관리자(`ROLE_ADMIN`) 권한 분기
* **도서 대여 & 장바구니**
  * 연령별/분야별/출판사별 도서 탐색
  * 실시간 재고 검증 및 최대 대여 한도 체크
  * 연체 도서 보유 시 신규 대여 제한
* **주문 / 결제 및 구독 시스템**
  * PortOne V2 API를 통한 간편 결제(카카오페이) 연동
  * 정기권 보유자 전용 0원 즉시 대여 및 기간 누적 연장 처리
* **관리자 (Admin)**
  * 도서 입고/수정/삭제 및 대여 현황 관리
  * 공지사항 및 이벤트 게시판 관리
