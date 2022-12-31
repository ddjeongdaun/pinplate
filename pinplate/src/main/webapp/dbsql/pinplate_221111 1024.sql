create table member(
mem_no number primary key,--�⺻Ű
mem_name varchar2(50) not null,--ȸ���̸�
mem_id varchar2(50) not null unique,--ȸ�����̵�,����ũ
mem_pwd varchar2(50) not null,--��й�ȣ
mem_ssn varchar2(50) not null unique,--�ֹε�Ϲ�ȣ,����ũ
mem_addr varchar2(255) not null,--ȸ���ּ�
mem_tel varchar2(50) not null,--ȸ����ȭ��ȣ
mem_email varchar2(50),--ȸ���̸���
mem_auth char default '0',--'0'�̸� ȸ��'1'�̸� ������
mem_use char default 'Y',--�������̵� ��뿩�� n�̸� deleteó���ȰͰ� ��������
mem_regdate date default sysdate
);

create sequence mem_seq--ȸ�����̺��ǽ�����
start with 1
increment by 1
nocache;

create table restaurant(
res_no number primary key,--�������⺻Ű
res_name varchar2(50) not null,--�������̸�
res_tel varchar2(50) not null,--������ ��ȭ��ȣ
res_addr varchar2(255) not null,--������ �ּ�
res_type varchar2(50) not null,--������ ����
res_content clob not null,--����������
res_x number not null,--��������x��ǥ
res_y number not null,--��������y��ǥ
res_yn char default 'N',--�������� ��Ͽ���
res_use char default 'Y',--�������� ��뿩�� delete�� N���κ���
res_regdate date default sysdate,--�������� �����
app_userno number constraint FK_res_app_userno references member(mem_no),--�������� ����� �����pk
reg_admno number constraint FK_res_reg_admno references member(mem_no)--�������� ����ϰ����� ��������pk
);

create sequence res_seq--������ ���̺��ǽ�����
start with 1
increment by 1
nocache;

create table menu(
menu_no number primary key,--�Ŵ��� �⺻Ű
res_no number constraint FK_menu_tb_res_no references restaurant(res_no),--�Ŵ��� ��ϵ� �������� �⺻Ű
menu_name varchar2(50) not null,--�Ŵ��̸�
menu_price number not null,--�Ŵ�����
menu_content clob,--�Ŵ�����
menu_yn char default 'N',--�Ŵ��� ��ϵǾ�����
menu_use char default 'Y',--�Ŵ��� ��������� �Ŵ�������N���� ����
menu_regdate date default sysdate,--�Ŵ������
reg_adm number constraint FK_menu_tb_reg_adm references member(mem_no)--�Ŵ������ �㰡�� �������ǹ�ȣ
);

create sequence menu_seq--�Ŵ��� ������
start with 1
increment by 1
nocache;

create table like_tb(
like_no number primary key,--���ƿ����̺� �⺻Ű
mem_no number constraint FK_like_tb_mem_no references member(mem_no),--���ƿ並 ���� ������ �⺻Ű
res_no number constraint FK_like_tb_res_no references restaurant(res_no),--���ƿ並 ���� �������� �⺻Ű
like_day date default sysdate--���ƿ並 ���� ��
);

create sequence like_seq--���ƿ����̺��� ������
start with 1
increment by 1
nocache;

create table teg(
teg_no number primary key,--�±����̺��� �⺻Ű
teg_name varchar2(30) not null unique--�±��̸� ����ũ
);

create sequence teg_seq--�±����̺��� ������
start with 1
increment by 1
nocache;

create table res_teg(--�������� ����±װ� �������� ���� ���̺�
res_teg_no number primary key,
res_no number constraint FK_res_teg_res_no references restaurant(res_no),
teg_no number constraint FK_res_teg_teg_no references teg(teg_no)
);

create sequence res_teg_seq--�������±����̺��� ������
start with 1
increment by 1
nocache;

create table send_msg(--������ �����»���� ���̺�
smsg_no number primary key,--���������� �⺻Ű
smsg_title varchar2(50) not null,--���������� ����
smsg_content clob not null,--���������� ����
smsg_mem_no number constraint FK_smsg_mem_no references member(mem_no),--�߽���
smsg_date date default sysdate --������ ��¥
);

create sequence smsg_seq--���������� ������
start with 1
increment by 1
nocache;

create table recive_msg(
rmsg_no number primary key,--�޴������� �⺻Ű
smsg_no number constraint FK_rmsg_smsg_no references send_msg(smsg_no),--�������������̺����� �⺻Ű
rmsg_mem_no number constraint FK_rmsg_mem_no references member(mem_no)--���� ����� �⺻Ű
);

create sequence rmsg_seq
start with 1
increment by 1
nocache;

create table tb_type(--���̺��� Ÿ�����̺� �� ���̺�� ����̹����� ��� ���̺� ������ Ȯ��
tb_type_no number primary key,--�⺻Ű
tb_type_name varchar2(50) not null unique--���̺��� Ÿ�Ը� ����,������,�޴����(�߰��ɼ� �����Ƿ�)
);

create sequence tb_type_seq
start with 1
increment by 1
nocache;

create table images(--�̹������̺�
img_no number primary key,--�⺻Ű
tb_type_no number constraint FK_images_tb_type_no references tb_type(tb_type_no),--���̺� Ÿ��
tb_no number not null,--���̺��� �⺻Ű
img_filename varchar2(255) not null,--�������� ������ ���ϸ�
img_originalfilename varchar2(255) not null--���� ���ϸ�
);

create sequence images_seq
start with 1
increment by 1
nocache;

create table review(
rev_no number primary key,--���� �⺻Ű
mem_no number constraint FK_rev_mem_no references member(mem_no),--���� �����
res_no number constraint FK_rev_res_no references restaurant(res_no),--���䰡 �ۼ��� ������
rev_title varchar2(255) not null,--��������
rev_content clob not null,--���䳻��
rev_score number not null check(rev_score>0),--�������� 0�� �ʰ�
use_yn char default 'Y',--���� ��뿩��
regdate date default sysdate--��ϵ� ������ ��¥
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
values(mem_seq.nextval,'������','admin','123','910101-1112222','����� ������ ������ 111-11','010-1111-2222','admin@naver.com','1','Y',sysdate);