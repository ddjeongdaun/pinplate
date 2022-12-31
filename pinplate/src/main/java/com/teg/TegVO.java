package com.teg;

public class TegVO {
	private int teg_no;
	private String teg_name;
	public int getTeg_no() {
		return teg_no;
	}
	public void setTeg_no(int teg_no) {
		this.teg_no = teg_no;
	}
	public String getTeg_name() {
		return teg_name;
	}
	public void setTeg_name(String teg_name) {
		this.teg_name = teg_name;
	}
	public TegVO(int teg_no, String teg_name) {
		super();
		this.teg_no = teg_no;
		this.teg_name = teg_name;
	}
	public TegVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
