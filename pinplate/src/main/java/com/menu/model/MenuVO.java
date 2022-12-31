package com.menu.model;

import java.sql.Timestamp;

public class MenuVO {
	private int menu_no;
	private int res_no;
	private String menu_name;
	private int menu_price;
	private String menu_content;
	private String menu_yn;
	private String menu_use;
	private Timestamp menu_regdate;
	private int reg_adm;
	
	public MenuVO() {
		super();
	}

	public MenuVO(int menu_no, int res_no, String menu_name, int menu_price, String menu_content, String menu_yn,
			String menu_use, Timestamp menu_regdate, int reg_adm) {
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

	public Timestamp getmenu_regdate() {
		return menu_regdate;
	}

	public void setmenu_regdate(Timestamp menu_regdate) {
		this.menu_regdate = menu_regdate;
	}

	public int getReg_adm() {
		return reg_adm;
	}

	public void setReg_adm(int reg_adm) {
		this.reg_adm = reg_adm;
	}

	@Override
	public String toString() {
		return "menuVO [menu_no=" + menu_no + ", res_no=" + res_no + ", menu_name=" + menu_name + ", menu_price="
				+ menu_price + ", menu_content=" + menu_content + ", menu_yn=" + menu_yn + ", menu_use=" + menu_use
				+ ", menu_regdate=" + menu_regdate + ", reg_adm=" + reg_adm + "]";
	}
	
}
