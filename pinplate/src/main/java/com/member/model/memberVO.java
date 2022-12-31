package com.member.model;

import java.sql.Timestamp;

public class memberVO {
	private int mem_no;
	private String mem_name;
	private String mem_id;
	private String mem_pwd;
	private String mem_ssn;
	private String mem_addr;
	private String mem_tel;
	private String mem_email;
	private String mem_auth;
	private String mem_use;
	private Timestamp mem_regdate;
	
	public memberVO() {
		super();
	}
	
	public memberVO(int mem_no, String mem_name, String mem_id, String mem_pwd, String mem_ssn, String mem_addr,
			String mem_tel, String mem_email, String mem_auth, String mem_use, Timestamp mem_regdate) {
		super();
		this.mem_no = mem_no;
		this.mem_name = mem_name;
		this.mem_id = mem_id;
		this.mem_pwd = mem_pwd;
		this.mem_ssn = mem_ssn;
		this.mem_addr = mem_addr;
		this.mem_tel = mem_tel;
		this.mem_email = mem_email;
		this.mem_auth = mem_auth;
		this.mem_use = mem_use;
		this.mem_regdate = mem_regdate;
	}
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_ssn() {
		return mem_ssn;
	}
	public void setMem_ssn(String mem_ssn) {
		this.mem_ssn = mem_ssn;
	}
	public String getMem_addr() {
		return mem_addr;
	}
	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}
	public String getMem_tel() {
		return mem_tel;
	}
	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_auth() {
		return mem_auth;
	}
	public void setMem_auth(String mem_auth) {
		this.mem_auth = mem_auth;
	}
	public String getMem_use() {
		return mem_use;
	}
	public void setMem_use(String mem_use) {
		this.mem_use = mem_use;
	}
	public Timestamp getMem_regdate() {
		return mem_regdate;
	}
	public void setMem_regdate(Timestamp mem_regdate) {
		this.mem_regdate = mem_regdate;
	}
	
	
}
