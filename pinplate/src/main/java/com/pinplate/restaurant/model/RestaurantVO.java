package com.pinplate.restaurant.model;

import java.sql.Timestamp;

public class RestaurantVO {
	
	private int res_no;
	private String res_name;
	private String res_tel;
	private String res_addr;
	private String res_type;
	private String res_content;
	private double res_x;
	private double res_y;
	private String res_yn;
	private String res_use;
	private Timestamp res_regdate;
	private int app_userno;
	
	
	private String imgone;//음식점의 단 하나의 이미지;
	
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	public String getRes_name() {
		return res_name;
	}
	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}
	public String getRes_tel() {
		return res_tel;
	}
	public void setRes_tel(String res_tel) {
		this.res_tel = res_tel;
	}
	public String getRes_addr() {
		return res_addr;
	}
	public void setRes_addr(String res_addr) {
		this.res_addr = res_addr;
	}
	public String getRes_type() {
		return res_type;
	}
	public void setRes_type(String res_type) {
		this.res_type = res_type;
	}
	public String getRes_content() {
		return res_content;
	}
	public void setRes_content(String res_content) {
		this.res_content = res_content;
	}
	public double getRes_x() {
		return res_x;
	}
	public void setRes_x(double res_x) {
		this.res_x = res_x;
	}
	public double getRes_y() {
		return res_y;
	}
	public void setRes_y(double res_y) {
		this.res_y = res_y;
	}
	public String getRes_yn() {
		return res_yn;
	}
	public void setRes_yn(String res_yn) {
		this.res_yn = res_yn;
	}
	public String getRes_use() {
		return res_use;
	}
	public void setRes_use(String res_use) {
		this.res_use = res_use;
	}
	public Timestamp getRes_regdate() {
		return res_regdate;
	}
	public void setRes_regdate(Timestamp res_regdate) {
		this.res_regdate = res_regdate;
	}
	public int getApp_userno() {
		return app_userno;
	}
	public void setApp_userno(int app_userno) {
		this.app_userno = app_userno;
	}

	public String getImgone() {
		return imgone;
	}
	public void setImgone(String imgone) {
		this.imgone = imgone;
	}
	//비어있는 레스토랑VO
	public RestaurantVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	//메뉴에서 음식점 리스트 작업용 //22.11.08 생성 ★
	public RestaurantVO(int res_no, String res_name, String res_yn, String res_use) {
		super();
		this.res_no = res_no;
		this.res_name = res_name;
		this.res_yn = res_yn;
		this.res_use = res_use;
	}
	
	//순수하게 레스토랑에 대한 정보만
	public RestaurantVO(int res_no, String res_name, String res_tel, String res_addr, String res_type,
			String res_content, double res_x, double res_y, String res_yn, String res_use, Timestamp res_regdate,
			int app_userno) {
		super();
		this.res_no = res_no;
		this.res_name = res_name;
		this.res_tel = res_tel;
		this.res_addr = res_addr;
		this.res_type = res_type;
		this.res_content = res_content;
		this.res_x = res_x;
		this.res_y = res_y;
		this.res_yn = res_yn;
		this.res_use = res_use;
		this.res_regdate = res_regdate;
		this.app_userno = app_userno;
		
	}
	
	//레스토랑과 그에 대한 단 하나의 이미지의 원래파일명에관한 vo
	public RestaurantVO(int res_no, String res_name, String res_tel, String res_addr, String res_type,
			String res_content, double res_x, double res_y, String res_yn, String res_use, Timestamp res_regdate,
			int app_userno, String imgone) {
		super();
		this.res_no = res_no;
		this.res_name = res_name;
		this.res_tel = res_tel;
		this.res_addr = res_addr;
		this.res_type = res_type;
		this.res_content = res_content;
		this.res_x = res_x;
		this.res_y = res_y;
		this.res_yn = res_yn;
		this.res_use = res_use;
		this.res_regdate = res_regdate;
		this.app_userno = app_userno;
		
		this.imgone = imgone;
	}
	@Override
	public String toString() {
		return "RestaurantVO [res_no=" + res_no + ", res_name=" + res_name + ", res_tel=" + res_tel + ", res_addr="
				+ res_addr + ", res_type=" + res_type + ", res_content=" + res_content + ", res_x=" + res_x + ", res_y="
				+ res_y + ", res_yn=" + res_yn + ", res_use=" + res_use + ", res_regdate=" + res_regdate
				+ ", app_userno=" + app_userno + ", reg_admno=" + imgone + "]";
	}
	
	
}
