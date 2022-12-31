package com.menu.model;

import java.sql.SQLException;
import java.util.List;

import com.image.model.ImageVO;

public class MenuService {
	private MenuDAO menuDao;
	
	public MenuService(){
		menuDao=new MenuDAO();
	}
	
	public List<MenuDetailVO> selectAll(String condition, String keyword) throws SQLException {
		return menuDao.selectAll(condition, keyword);
	}
	
	public int insertMenu(ImageVO imageVo, MenuVO menuVo, int mem_auth) throws SQLException {
		return menuDao.insertMenu(imageVo, menuVo, mem_auth);
	}
	
	public int updateMenu(ImageVO imageVo, MenuVO menuVo) throws SQLException {
		return menuDao.updateMenu(imageVo, menuVo);
	}
	
	
	public int menu_seq_curr() throws SQLException {
		return menuDao.menu_seq_curr();
	}
	
	public MenuDetailVO selectByMenuNo(int menuNo) throws SQLException {
		return menuDao.selectByMenuNo(menuNo);
	}
	
	public int deleteMenu(ImageVO imageVo, MenuVO menuVo) throws SQLException {
		return menuDao.deleteMenu(imageVo, menuVo);
	}
	
	public List<MenuDetailVO> selectApplyMenu(String condition, String keyword) throws SQLException {
		return menuDao.selectApplyMenu(condition, keyword);
	}
	
	public int menuApplyAppr(int menuNo, int LoginUserNo) throws SQLException {
		return menuDao.menuApplyAppr(menuNo, LoginUserNo);
	}
	
	public List<MenuDetailVO> selectByResNo(int resNo) throws SQLException {
		return menuDao.selectByResNo(resNo);
	}
}
