CREATE TABLE Member ( --회원 정보(탈퇴 시에도 삭제되지 않는 정보)
	num	NUMBER		NOT NULL CONSTRAINT pk_member PRIMARY KEY, --회원 번호
	id	VARCHAR2(20)		NOT NULL, --회원 아이디
	grade	NUMBER	DEFAULT 2	NOT NULL --회원 등급(0: 관리자, 1: 탈퇴회원, 2:일반회원, 3:구글, 4:카카오, 5:네이버)
);

CREATE SEQUENCE member_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE project ( --프로젝트 정보
	num	NUMBER		NOT NULL CONSTRAINT pk_project PRIMARY KEY, --프로젝트 번호
	name	VARCHAR2(50)		NOT NULL, --프로젝트명
	category	NUMBER		NOT NULL, --프로젝트 카테고리
	start_date	DATE	DEFAULT sysdate	NOT NULL, --프로젝트 후원 시작 날짜
	finish_date	DATE	DEFAULT sysdate	NOT NULL, --프로젝트 후원 종료 날짜
	goal_amount	NUMBER	DEFAULT 0	NOT NULL, --프로젝트 목표 후원 금액
	m_num	NUMBER		NOT NULL, -- 프로젝트 창작자 회원 번호
	approval	NUMBER	DEFAULT 0	NOT NULL, --프로젝트 승인 상태
	reason	VARCHAR2(100)		NULL, --프로젝트 반려 사유
	summary	VARCHAR2(200)		NOT NULL, -- 프로젝트 요약 설명
	photo	VARCHAR(20)		NULL, -- 프로젝트 대표 사진
	ship	NUMBER		NOT NULL, -- 후원 선물 배송 여부
	intro	CLOB		NOT NULL, -- 프로젝트 소개
	policy	CLOB		NULL --프로젝트 후원 정책
);

CREATE SEQUENCE project_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE notice ( --공지사항
	num	NUMBER		NOT NULL CONSTRAINT pk_notice PRIMARY KEY, --공지사항 번호
	p_num	NUMBER		NOT NULL, --프로젝트 번호(0: 전체 공지)
	title	VARCHAR2(20)		NOT NULL, --공지사항 제목
	content	CLOB		NOT NULL, --공지사항 내용
	NOT_DATE	DATE		NOT NULL, --공지 날짜
    MOD_DATE  DATE        NOT NULL --수정 날짜
);

ALTER TABLE notice
    ADD CONSTRAINT FK_notice_p_num_project_num FOREIGN KEY (p_num)
        REFERENCES project (num);

CREATE SEQUENCE notice_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE gift ( --선물
	num	NUMBER		NOT NULL    CONSTRAINT pk_gift PRIMARY KEY, --선물 번호
	p_num	NUMBER		NOT NULL, --프로젝트 번호
	price	NUMBER		NOT NULL, --선물의 총 후원 금액
	name	VARCHAR2(20)		NOT NULL, --선물의 이름
	intro	VARCHAR2(100)		NOT NULL, --선물의 소개
	due_ship	NUMBER	NOT NULL --배송 여부
);

ALTER TABLE gift
    ADD CONSTRAINT FK_gift_p_num_project_num FOREIGN KEY (p_num)
        REFERENCES project (num);

CREATE SEQUENCE gift_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE member_detail ( --회원의 상세 정보
    num     NUMBER      NOT NULL    CONSTRAINT pk_member_detail PRIMARY KEY, --회원 상세정보 번호
	m_num	NUMBER		NOT NULL, --회원 번호
	pass	VARCHAR2(20)		NOT NULL, --비밀번호
	name	VARCHAR2(20)		NOT NULL, --회원 이름
	reg_date	DATE	DEFAULT sysdate	NOT NULL, --가입 날짜
	mod_date	date	DEFAULT sysdate	NOT NULL, --정보 수정일
	phone	VARCHAR2(20)		NOT NULL, --전화번호
	phone_confirm	NUMBER	DEFAULT 0	NOT NULL, --전화번호 인증여부
	email	VARCHAR2(20)		NOT NULL, --이메일
	photo	VARCHAR2(20)	DEFAULT 'default_profile.jpg'	NOT NULL, --프로필 사진
	zipcode	NUMBER		NOT NULL, --우편번호
	address	VARCHAR2(50)		NOT NULL, --주소
	address_detail	VARCHAR2(50)		NOT NULL --상세 주소
);

ALTER TABLE member_detail
    ADD CONSTRAINT FK_member_detail_m_num FOREIGN KEY (m_num)
        REFERENCES member (num);

CREATE SEQUENCE member_detail_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE answer ( --질문의 답변
	num	NUMBER		NOT NULL     CONSTRAINT pk_answer PRIMARY KEY, --답변 번호
	q_num	NUMBER		NOT NULL, --질문 번호
	m_num	NUMBER		NOT NULL, --답변자의 회원 번호
	content	CLOB		NOT NULL, --답변 내용
	answer_date	DATE	DEFAULT sysdate	NOT NULL --답변 날짜
);


ALTER TABLE answer
    ADD CONSTRAINT FK_answer_q_num_question_num FOREIGN KEY (q_num)
        REFERENCES question (num);

ALTER TABLE answer
    ADD CONSTRAINT FK_answer_m_num_member_num FOREIGN KEY (m_num)
        REFERENCES member (num);
        
CREATE SEQUENCE answer_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE question ( --질문
	num	NUMBER		NOT NULL     CONSTRAINT pk_question PRIMARY KEY, --질문 번호
	m_num	NUMBER		NOT NULL, -- 질문한 회원 번호
	p_num	NUMBER	DEFAULT -1	NULL, --질문과 관련된 프로젝트 번호
	title	VARCHAR2(20)		NOT NULL, --질문 제목
	content	CLOB		NOT NULL,--질문 내용
	password	VARCHAR2(20)		NULL, --질문글의 비밀번호
	question_date	DATE	DEFAULT sysdate	NOT NULL --질문 작성 날짜
);

ALTER TABLE question
    ADD CONSTRAINT FK_question_m_num_member_num FOREIGN KEY (m_num)
        REFERENCES member (num);     

ALTER TABLE question
    ADD CONSTRAINT FK_question_p_num_project_num FOREIGN KEY (p_num)
        REFERENCES project (num);

CREATE SEQUENCE question_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE support ( --후원
	num	NUMBER		NOT NULL     CONSTRAINT pk_support PRIMARY KEY, --후원 번호
	m_num	NUMBER		NOT NULL, --후원자의 회원 번호
	p_num	NUMBER		NOT NULL, --후원한 프로젝트
	payment	NUMBER		NOT NULL, --후원금 결제 여부
	g_num	NUMBER		NOT NULL, --선택한 선물 번호
	support_amount	NUMBER		NOT NULL --전체 후원 금액
);

ALTER TABLE support
    ADD CONSTRAINT FK_support_m_num_member_num FOREIGN KEY (m_num)
        REFERENCES member (num);
      
ALTER TABLE support
    ADD CONSTRAINT FK_support_p_num_project_num FOREIGN KEY (p_num)
        REFERENCES project (num);
        
ALTER TABLE support
    ADD CONSTRAINT FK_support_g_num_gift_num FOREIGN KEY (g_num)
        REFERENCES gift (num);

CREATE SEQUENCE support_SEQ
START WITH 1
INCREMENT BY 1;

alter sequence gift_seq nocache;
alter sequence member_seq nocache;
alter sequence member_detail_seq nocache;
alter sequence notice_seq nocache;
alter sequence project_seq nocache;
alter sequence question_seq nocache;
alter sequence answer_seq nocache;
alter sequence support_seq nocache;

ALTER TABLE support ADD(gift_option VARCHAR2(100)); --후원의 추가적인 옵션 사항
ALTER TABLE support ADD(donation NUMBER); --추가 후원 금액
ALTER TABLE gift ADD(num_component NUMBER); --구성품목 번호

CREATE TABLE delivery ( --배송지
	num	NUMBER		NOT NULL     CONSTRAINT pk_delivery PRIMARY KEY, --배송지 번호
	m_num   NUMBER     NOT NULL, --회원 번호
    name    VARCHAR2(20)    NOT NULL, --배송지 명
    zipcode	NUMBER		NOT NULL, --배송지 우편 번호
	address	VARCHAR2(50)		NOT NULL, --배송지 주소
	address_detail	VARCHAR2(20)		NOT NULL --배송지 상세 주소
);

ALTER TABLE delivery
    ADD CONSTRAINT FK_delivery_m_num_member_num FOREIGN KEY (m_num)
        REFERENCES member (num);

CREATE SEQUENCE delivery_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE gift_detail ( --선물 구성품
	num	NUMBER		NOT NULL     CONSTRAINT pk_gift_detail PRIMARY KEY, --구성품 번호
	g_num   NUMBER     NOT NULL, --선물 번호
    name    VARCHAR2(20)    NOT NULL, --구성품 이름
    count	NUMBER		NOT NULL --구성품 개수
);

ALTER TABLE gift_detail
    ADD CONSTRAINT FK_gift_detail_g_num_gift_num FOREIGN KEY (g_num)
        REFERENCES gift (num);

CREATE SEQUENCE gift_detail_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE member_detail ADD nickname VARCHAR2(20); --닉네임 컬럼 추가
ALTER TABLE member MODIFY id VARCHAR(50); --이메일도 들어가도록 사이즈 수정

ALTER TABLE gift MODIFY due_ship number default 0; --배송여부 기본값 0설정
ALTER TABLE project MODIFY ship number default 0; --배송여부 기본값 0설정
ALTER TABLE support MODIFY payment number default 0; --결제여부 기본값 0설정
ALTER TABLE support MODIFY donation number default 0;
ALTER TABLE project MODIFY (photo DEFAULT 'default_team.jpg');
ALTER TABLE project MODIFY (goal_amount NULL);
ALTER TABLE project MODIFY (ship DEFAULT 0);
ALTER TABLE project modify name VARCHAR2(120); --프로젝트 이름 사이즈 수정
ALTER TABLE gift_detail MODIFY (g_num NULL);
ALTER TABLE support MODIFY g_num NULL;

--2010_10_14 추가 member detail 컬럼 값 변경 및 추가(프로필 변경관련)
ALTER TABLE member_detail ADD (photo2 BLOB);
UPDATE member_detail SET photo2 = photo;
ALTER TABLE member_detail DROP COLUMN photo;
ALTER TABLE member_detail RENAME COLUMN photo2 to photo;
ALTER TABLE member_detail ADD(photo_name varchar2(100));
--21.10.15 project photo size 변경
ALTER TABLE project modify photo VARCHAR2(200);
ALTER TABLE gift modify name VARCHAR2(120);
ALTER TABLE gift_detail modify name VARCHAR2(120);
--21.10.17 배송지 관련 테이블 값들 변경
ALTER TABLE delivery ADD address_check number(1) DEFAULT 0 NOT NULL;
ALTER TABLE delivery ADD phone varchar2(20) NOT NULL;
ALTER TABLE delivery MODIFY address_detail varchar(100);
ALTER TABLE delivery MODIFY address varchar(100);
--21.10.17 선물 테이블 소개항목 삭제
ALTER TABLE gift DROP COLUMN intro;
--21.10.18 문의하기에 프로젝트 넘버 fk 삭제
ALTER TABLE question DROP CONSTRAINT FK_QUESTION_P_NUM_PROJECT_NUM;
--21.10.21 support테이블에 결제날짜 추가
ALTER TABLE support ADD patment_date DATE DEFAULT sysdate NOT NULL;