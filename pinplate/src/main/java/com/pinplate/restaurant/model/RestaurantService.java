package com.pinplate.restaurant.model;

import java.sql.SQLException;
import java.util.List;

import com.image.model.ImageVO;
import com.member.model.memberVO;

public class RestaurantService {
	private RestaurantDAO resdao;
	public RestaurantService() {
		resdao=new RestaurantDAO();
	}
	
	public List<RestaurantVO> resimgselect() throws SQLException{
		
		return resdao.resimgselect();
	}
	public int res_seq_curr() throws SQLException {
		return resdao.res_seq_curr();
	}
	
	public int insertRes(RestaurantVO resvo,memberVO memvo,List<ImageVO> list) throws SQLException {
		return resdao.insertRes(resvo, memvo, list);
	}
	public RestaurantVO resSelectByNo(int no) throws SQLException {
		return resdao.resSelectByNo(no);
	}
	public List<RestaurantVO> resSelectByKeyword(String search) throws SQLException {
		return resdao.resSelectByKeyword(search);
	}
	public List<RestaurantVO> selectAllRes() throws SQLException{
		return resdao.selectAllRes();
	}
	public List<RestaurantVO> selectDisAgreeRes() throws SQLException{
		return resdao.selectDisAgreeRes();
	}
	public List<RestaurantVO> selectManageRes() throws SQLException{
		return resdao.selectManageRes();
	}
	public int updateAgree(int no) throws SQLException {
		return resdao.updateAgree(no);
	}
	public int updateResImg(RestaurantVO resvo,List<ImageVO> list) throws SQLException {
		return resdao.updateResImg(resvo, list);
	}
	public int updateRes(RestaurantVO resvo) throws SQLException {
		return resdao.updateRes(resvo);
	}

	public int deleteRes(int resno) throws SQLException {
		return resdao.deleteRes(resno);
	}
	
	public List<RestaurantVO> selectAllresName() throws SQLException {
		return resdao.selectAllresName();
	}
}
