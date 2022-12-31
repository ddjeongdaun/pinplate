create table member(
mem_no number primary key,--기본키
mem_name varchar2(50) not null,--회원이름
mem_id varchar2(50) not null unique,--회원아이디,유니크
mem_pwd varchar2(50) not null,--비밀번호
mem_ssn varchar2(50) not null unique,--주민등록번호,유니크
mem_addr varchar2(255) not null,--회원주소
mem_tel varchar2(50) not null,--회원전화번호
mem_email varchar2(50),--회원이메일
mem_auth char default '0',--'0'이면 회원'1'이면 관리자
mem_use char default 'Y',--유저아이디 사용여부 n이면 delete처리된것과 같은상태
mem_regdate date default sysdate
);

create sequence mem_seq--회원테이블의시퀸스
start with 1
increment by 1
nocache;

create table restaurant(
res_no number primary key,--음식점기본키
res_name varchar2(50) not null,--음식점이름
res_tel varchar2(50) not null,--음식점 전화번호
res_addr varchar2(255) not null,--음식점 주소
res_type varchar2(50) not null,--음식점 종류
res_content clob not null,--음식점내용
res_x number not null,--음식점의x좌표
res_y number not null,--음식점의y좌표
res_yn char default 'N',--음식점의 등록여부
res_use char default 'Y',--음식점의 사용여부 delete시 N으로변경
res_regdate date default sysdate,--음식점의 등록일
app_userno number constraint FK_res_app_userno references member(mem_no),--음식점을 등록한 사람의pk
reg_admno number constraint FK_res_reg_admno references member(mem_no)--음식점을 등록하게해준 관리자의pk
);

create sequence res_seq--음식점 테이블의시퀸스
start with 1
increment by 1
nocache;

create table menu(
menu_no number primary key,--매뉴의 기본키
res_no number constraint FK_menu_tb_res_no references restaurant(res_no),--매뉴가 등록된 음식점의 기본키
menu_name varchar2(50) not null,--매뉴이름
menu_price number not null,--매뉴가격
menu_content clob,--매뉴내용
menu_yn char default 'N',--매뉴가 등록되었는지
menu_use char default 'Y',--매뉴가 사용중인지 매뉴삭제시N으로 변경
menu_regdate date default sysdate,--매뉴등록일
reg_adm number constraint FK_menu_tb_reg_adm references member(mem_no)--매뉴등록을 허가한 관리자의번호
);

create sequence menu_seq--매뉴의 시퀸스
start with 1
increment by 1
nocache;

create table like_tb(
like_no number primary key,--좋아요테이블 기본키
mem_no number constraint FK_like_tb_mem_no references member(mem_no),--좋아요를 누른 유저의 기본키
res_no number constraint FK_like_tb_res_no references restaurant(res_no),--좋아요를 누른 음식점의 기본키
like_day date default sysdate--좋아요를 누른 날
);

create sequence like_seq--좋아요테이블의 시퀸스
start with 1
increment by 1
nocache;

create table teg(
teg_no number primary key,--태그테이블의 기본키
teg_name varchar2(30) not null unique--태그이름 유니크
);

create sequence teg_seq--태그테이블의 시퀸스
start with 1
increment by 1
nocache;

create table res_teg(--음식점에 어느태그가 들어가는지에 대한 테이블
res_teg_no number primary key,
res_no number constraint FK_res_teg_res_no references restaurant(res_no),
teg_no number constraint FK_res_teg_teg_no references teg(teg_no)
);

create sequence res_teg_seq--음식점태그테이블의 시퀸스
start with 1
increment by 1
nocache;

create table send_msg(--쪽지를 보내는사람의 테이블
smsg_no number primary key,--보내는쪽지 기본키
smsg_title varchar2(50) not null,--보내는쪽지 제목
smsg_content clob not null,--보내는쪽지 내용
smsg_mem_no number constraint FK_smsg_mem_no references member(mem_no),--발신인
smsg_date date default sysdate --보내는 날짜
);

create sequence smsg_seq--보내는쪽지 시퀸스
start with 1
increment by 1
nocache;

create table recive_msg(
rmsg_no number primary key,--받는쪽지의 기본키
smsg_no number constraint FK_rmsg_smsg_no references send_msg(smsg_no),--보내는쪽지테이블에서온 기본키
rmsg_mem_no number constraint FK_rmsg_mem_no references member(mem_no)--받은 사람의 기본키
);

create sequence rmsg_seq
start with 1
increment by 1
nocache;

create table tb_type(--테이블의 타입테이블 이 테이블로 어느이미지가 어느 테이블에 들어가는지 확인
tb_type_no number primary key,--기본키
tb_type_name varchar2(50) not null unique--테이블의 타입명 리뷰,음식점,메뉴등등(추가될수 있으므로)
);

create sequence tb_type_seq
start with 1
increment by 1
nocache;

create table images(--이미지테이블
img_no number primary key,--기본키
tb_type_no number constraint FK_images_tb_type_no references tb_type(tb_type_no),--테이블 타입
tb_no number not null,--테이블의 기본키
img_filename varchar2(255) not null,--유저에게 보여줄 파일명
img_originalfilename varchar2(255) not null--실제 파일명
);

create sequence images_seq
start with 1
increment by 1
nocache;

create table review(
rev_no number primary key,--리뷰 기본키
mem_no number constraint FK_rev_mem_no references member(mem_no),--리뷰 쓴사람
res_no number constraint FK_rev_res_no references restaurant(res_no),--리뷰가 작성된 음식점
rev_title varchar2(255) not null,--리뷰제목
rev_content clob not null,--리뷰내용
rev_score number not null check(rev_score>0),--리뷰점수 0점 초과
use_yn char default 'Y',--리뷰 사용여부
regdate date default sysdate--등록된 리뷰의 날짜
);

create sequence rev_seq
start with 1
increment by 1
nocache;

create or replace view v_menuDetail
as
select 
m.*, r.res_name, mem.mem_id, i.img_no, i.img_filename
from menu m join restaurant r
on m.res_no=r.res_no
join member mem
on mem.mem_no=m.reg_adm
join images i
on i.tb_type_no=2 and i.tb_no=m.menu_no;

create or replace view resimgone
as select r.*,(select img_filename from images i where r.res_no=i.tb_no and i.tb_type_no=1 and rownum<=1)as imgone from restaurant r;

create or replace view imgresall 
as select i.*,(select res_no from restaurant r where r.res_no=i.tb_no)as res_no from images i where tb_type_no=1;

insert into tb_type
values(tb_type_seq.nextval, 'res');

insert into tb_type
values(tb_type_seq.nextval, 'menu');

insert into tb_type
values(tb_type_seq.nextval, 'rev');

insert into member
values(mem_seq.nextval,'관리자','admin','123','910101-1112222','서울시 마포구 망원동 111-11','010-1111-2222','admin@naver.com','1','Y',sysdate);