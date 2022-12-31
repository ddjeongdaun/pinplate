package com.image.model;

public class ImageVO {
	private int img_no;
	private int tb_type;
	private int tb_no;
	private String img_filename;
	private String img_originalfilename;
	
	public ImageVO() {
		super();
	}

	public ImageVO(int img_no, int tb_type, int tb_no, String img_filename, String img_originalfilename) {
		super();
		this.img_no = img_no;
		this.tb_type = tb_type;
		this.tb_no = tb_no;
		this.img_filename = img_filename;
		this.img_originalfilename = img_originalfilename;
	}

	public int getImg_no() {
		return img_no;
	}

	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}

	public int getTb_type() {
		return tb_type;
	}

	public void setTb_type(int tb_type) {
		this.tb_type = tb_type;
	}

	public int getTb_no() {
		return tb_no;
	}

	public void setTb_no(int tb_no) {
		this.tb_no = tb_no;
	}

	public String getImg_filename() {
		return img_filename;
	}

	public void setImg_filename(String img_filename) {
		this.img_filename = img_filename;
	}

	public String getImg_originalfilename() {
		return img_originalfilename;
	}

	public void setImg_originalfilename(String img_originalfilename) {
		this.img_originalfilename = img_originalfilename;
	}

	@Override
	public String toString() {
		return "imageVO [img_no=" + img_no + ", tb_type=" + tb_type + ", tb_no=" + tb_no + ", img_filename="
				+ img_filename + ", img_originalfilename=" + img_originalfilename + "]";
	}
	
}
