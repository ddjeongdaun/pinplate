select * from member;
select * from restaurant;
select * from menu;
select * from review;
select * from images;

delete images;
delete review;
delete menu;
delete restaurant;
delete member;

drop sequence res_seq;
drop sequence menu_seq;
drop sequence rev_seq;
drop sequence images_seq;
drop sequence mem_seq;
