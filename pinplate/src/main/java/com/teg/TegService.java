package com.teg;

import java.sql.SQLException;
import java.util.List;

public class TegService {
private TegDAO tegDao;
	public TegService() {
		tegDao=new TegDAO();
	}
	public List<TegVO> selectTeg() throws SQLException{
		return tegDao.selectTeg();
	}
}
