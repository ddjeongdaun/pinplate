package com.review.model;

import java.sql.Timestamp;

public class ReviewVO {
	private int rev_no;				//디폴트 시퀀스 리뷰의 기본키
	private int mem_no;				//작성자 멤버테이블 기본키
	private int res_no;				//음식점 식당테이블	기본키
	private String rev_content;		//낫널
	private String use_yn;			//디폴트 Y - 삭제처리할때쓸꺼
	private Timestamp regdate;		//디폴트 현재날짜
	
	public ReviewVO() {
		super();
	}
	
	

	public ReviewVO(int rev_no, int mem_no, int res_no, String rev_content) {
		super();
		this.rev_no = rev_no;
		this.mem_no = mem_no;
		this.res_no = res_no;
		this.rev_content = rev_content;
	}

	public ReviewVO(int rev_no, int mem_no, int res_no, String rev_content, String use_yn, Timestamp regdate) {
		super();
		this.rev_no = rev_no;
		this.mem_no = mem_no;
		this.res_no = res_no;
		this.rev_content = rev_content;
		this.use_yn = use_yn;
		this.regdate = regdate;
	}

	public int getRev_no() {
		return rev_no;
	}

	public void setRev_no(int rev_no) {
		this.rev_no = rev_no;
	}

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public int getRes_no() {
		return res_no;
	}

	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}

	public String getRev_content() {
		return rev_content;
	}

	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "ReviewVO [rev_no=" + rev_no + ", mem_no=" + mem_no + ", res_no=" + res_no + ", rev_content="
				+ rev_content + ", use_yn=" + use_yn + ", regdate=" + regdate + "]";
	}

}
