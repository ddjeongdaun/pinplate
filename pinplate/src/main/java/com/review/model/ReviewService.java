package com.review.model;

import java.sql.SQLException;
import java.util.List;

public class ReviewService {
	private ReviewDAO reviewDao;
	
	public ReviewService(){
		reviewDao=new ReviewDAO();
	}
	
	public int insertRev(ReviewVO vo) throws SQLException {
		return reviewDao.insertRev(vo);
	}
	
	public int deleteRev(ReviewVO vo, String mem_auth) throws SQLException {
		return reviewDao.deleteRev(vo, mem_auth);
	}
	
	public List<ReviewVO> selectReview(int res_no) throws SQLException{
		return reviewDao.selectReview(res_no);
	}
	
	public List<ReviewVO> selectReviewByUserNo(int mem_no) throws SQLException{
		return reviewDao.selectReviewByUserNo(mem_no);
	}
}
