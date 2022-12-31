package com.menu.model;

import java.sql.Timestamp;

public class MenuDetailVO {
	private int menu_no;
	private int res_no;
	private String menu_name;
	private int menu_price;
	private String menu_content;
	private String menu_yn;
	private String menu_use;
	private Timestamp menu_regdate;
	private int reg_adm;
	// detail용으로 셀렉한거에서 가져올 내용
	private String res_name;
	private String mem_id;
	private int img_no;
	private String img_filename;
	
	public MenuDetailVO() {
		super();
	}

	public MenuDetailVO(int menu_no, int res_no, String menu_name, int menu_price, String menu_content, String menu_yn,
			String menu_use, Timestamp menu_regdate, int reg_adm, String res_name, String mem_id, int img_no,
			String img_filename) {
		super();
		this.menu_no = menu_no;
		this.res_no = res_no;
		this.menu_name = menu_name;
		this.menu_price = menu_price;
		this.menu_content = menu_content;
		this.menu_yn = menu_yn;
		this.menu_use = menu_use;
		this.menu_regdate = menu_regdate;
		this.reg_adm = reg_adm;
		this.res_name = res_name;
		this.mem_id = mem_id;
		this.img_no = img_no;
		this.img_filename = img_filename;
	}

	public int getMenu_no() {
		return menu_no;
	}

	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}

	public int getRes_no() {
		return res_no;
	}

	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public int getMenu_price() {
		return menu_price;
	}

	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}

	public String getMenu_content() {
		return menu_content;
	}

	public void setMenu_content(String menu_content) {
		this.menu_content = menu_content;
	}

	public String getMenu_yn() {
		return menu_yn;
	}

	public void setMenu_yn(String menu_yn) {
		this.menu_yn = menu_yn;
	}

	public String getMenu_use() {
		return menu_use;
	}

	public void setMenu_use(String menu_use) {
		this.menu_use = menu_use;
	}

	public Timestamp getMenu_regdate() {
		return menu_regdate;
	}

	public void setMenu_regdate(Timestamp menu_regdate) {
		this.menu_regdate = menu_regdate;
	}

	public int getReg_adm() {
		return reg_adm;
	}

	public void setReg_adm(int reg_adm) {
		this.reg_adm = reg_adm;
	}

	public String getRes_name() {
		return res_name;
	}

	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getImg_no() {
		return img_no;
	}

	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}

	public String getImg_filename() {
		return img_filename;
	}

	public void setImg_filename(String img_filename) {
		this.img_filename = img_filename;
	}

	@Override
	public String toString() {
		return "menuDetailVO [menu_no=" + menu_no + ", res_no=" + res_no + ", menu_name=" + menu_name + ", menu_price="
				+ menu_price + ", menu_content=" + menu_content + ", menu_yn=" + menu_yn + ", menu_use=" + menu_use
				+ ", menu_regdate=" + menu_regdate + ", reg_adm=" + reg_adm + ", res_name=" + res_name + ", mem_id=" + mem_id
				+ ", img_no=" + img_no + ", img_filename=" + img_filename + "]";
	}
}
