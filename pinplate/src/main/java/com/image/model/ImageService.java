package com.image.model;

import java.sql.SQLException;
import java.util.List;

public class ImageService {
	private ImageDAO imageDao;
	
	public ImageService() {
		imageDao=new ImageDAO();
	}
	
	public int insertImg() throws SQLException {
		return imageDao.insertImg();
	}
}