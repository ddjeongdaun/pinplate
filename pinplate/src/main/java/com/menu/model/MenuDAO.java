package com.menu.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.db.ConnectionPoolMgr;
import com.image.model.ImageVO;

public class MenuDAO {
	private ConnectionPoolMgr pool;
	
	public MenuDAO() {
		pool=new ConnectionPoolMgr();
	}
	
	public List<MenuDetailVO> selectAll(String condition, String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		MenuDetailVO menuDetailVo=null;
		List<MenuDetailVO> list =new ArrayList<>();
		
		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="select * from v_menuDetail where";
			ps=con.prepareStatement(sql);
			
			//검색의 경우
			if(keyword!=null && !keyword.isEmpty()) {
				sql+=" "+condition +" like '%' || ? || '%' and";
			}			
			sql+=" menu_yn='Y' and menu_use='Y' order by menu_no";
			ps=con.prepareStatement(sql);

			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}
			
			//4
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int menu_no = rs.getInt("menu_no");
				int res_no = rs.getInt("res_no");
				String menu_name = rs.getString("menu_name");
				int menu_price = rs.getInt("menu_price");
				String menu_content = rs.getString("menu_content");
				String menu_yn = rs.getString("menu_yn");
				String menu_use = rs.getString("menu_use");
				Timestamp menu_regdate = rs.getTimestamp("menu_regdate");
				int reg_adm = rs.getInt("reg_adm");
				String res_name = rs.getString("res_name");
				String mem_id = rs.getString("mem_id");
				int img_no = rs.getInt("img_no");
				String img_filename=rs.getString("img_filename");
				
				menuDetailVo = new MenuDetailVO(menu_no, res_no, menu_name, menu_price, menu_content,
							menu_yn, menu_use, menu_regdate, reg_adm, res_name,
							mem_id, img_no, img_filename);
				list.add(menuDetailVo);
			}
			System.out.println("글 전체 조회 결과 list.size="+list.size()
			+", 매개변수 condition="+condition+", keyword="+keyword);
			
			return list;
		}finally {
			//5
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int insertMenu(ImageVO imageVo, MenuVO menuVo, int mem_auth) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int cnt=0;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//트랜잭션 시작 : 자동커밋 막기
			con.setAutoCommit(false);
			
			//3-1 : 메뉴 테이블 업데이트
			String sql="";
			
			if(mem_auth==1) {
				sql="insert into menu(menu_no, res_no, menu_name, menu_price, reg_adm, menu_yn)"
					+ "values(menu_seq.nextval, ?, ?, ?, ?,'Y')";
			}else {
				sql="insert into menu(menu_no, res_no, menu_name, menu_price, reg_adm, menu_yn)"
						+ "values(menu_seq.nextval, ?, ?, ?, ?,'N')";
			}
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, menuVo.getRes_no());
			ps.setString(2, menuVo.getMenu_name());
			ps.setInt(3, menuVo.getMenu_price());
			ps.setInt(4, menuVo.getReg_adm());
			
			//4-1
			cnt=ps.executeUpdate();
			
			//3-2 : 이미지 먼저 테이블에 넣기 insert
			sql="insert into images"
					+ " values(images_seq.NEXTVAL, ?, ?, ?, ?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1, imageVo.getTb_type());
			ps.setInt(2, imageVo.getTb_no());
			ps.setString(3, imageVo.getImg_filename());
			ps.setString(4, imageVo.getImg_originalfilename());
			
			//4-2
			cnt=ps.executeUpdate();
			
			
			//모두 성공하면 commit
			con.commit();
			
			//트랜잭션 종료
		}catch(SQLException e) {
			e.printStackTrace();
			
			//하나라도 실패하면 rollback
			con.rollback();
		}finally {
			//자동커밋 다시 켜기
			con.setAutoCommit(true);
			//5
			pool.dbClose(ps, con);
		}
		return cnt;
	}
	
	public int updateMenu(ImageVO imageVo, MenuVO menuVo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int cnt=0;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//트랜잭션 시작 : 자동커밋 막기
			con.setAutoCommit(false);
			
			//3-1 : 메뉴 테이블 업데이트
			String sql="update menu"
					+ " set res_no=?, menu_name=?, menu_price=?,"
					+ " reg_adm=?, menu_yn='Y'"
					+ " where menu_no=?";
			
			ps=con.prepareStatement(sql);
			ps.setInt(1, menuVo.getRes_no());
			ps.setString(2, menuVo.getMenu_name());
			ps.setInt(3, menuVo.getMenu_price());
			ps.setInt(4, menuVo.getReg_adm());
			ps.setInt(5, menuVo.getMenu_no()); 
			
			//4-1
			cnt=ps.executeUpdate();
			
			//if 걸어서
			if(imageVo.getImg_no()!=0){
				//3-2
				sql="update images"
					+ " set img_filename=?, img_originalfilename=?"
					+ " where tb_type_no=? and tb_no=?";
				ps=con.prepareStatement(sql);
				ps.setString(1, imageVo.getImg_filename());
				ps.setString(2, imageVo.getImg_originalfilename());
				ps.setInt(3, imageVo.getTb_type());
				ps.setInt(4, imageVo.getTb_no());
					
				//4-2
				cnt=ps.executeUpdate();
			}
			
			//모두 성공하면 commit
			con.commit();
		
		//트랜잭션 종료
		}catch(SQLException e) {
			e.printStackTrace();
			
			//하나라도 실패하면 rollback
			con.rollback();
		}finally {
			//자동커밋 다시 켜기
			con.setAutoCommit(true);
			//5
			pool.dbClose(ps, con);
		}
		return cnt;
	}
	
	public int deleteMenu(ImageVO imageVo, MenuVO menuVo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int cnt=0;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//트랜잭션 시작 : 자동커밋 막기
			con.setAutoCommit(false);
			
			//3-1 : 메뉴 use:n으로
			String sql="update menu"
					+ " set menu_use='N'"
					+ " where menu_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, menuVo.getMenu_no());
			
			//4-1
			cnt=ps.executeUpdate();
			
			//3-2 : 메뉴에 해당하는 2번만 제거
			sql="delete from images"
				+ " where tb_type_no=2 and tb_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, imageVo.getTb_no());
			
			//4-2
			cnt=ps.executeUpdate();

			//모두 성공하면 commit
			con.commit();
		}catch(SQLException e) {
			e.printStackTrace();
			//하나라도 실패하면 rollback
			con.rollback();
		}finally{
			//자동커밋 다시 켜기
			con.setAutoCommit(true);
			//5
			pool.dbClose(ps, con);
		}
		return cnt;
	}	
	
	public int menu_seq_curr() throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int menu_seq_curr=0;
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="select last_number from user_sequences"
					+ " where sequence_name='MENU_SEQ'";
			ps=con.prepareStatement(sql);
			//4
			rs=ps.executeQuery();
			
			if(rs.next()) {
				menu_seq_curr=rs.getInt("LAST_NUMBER");
			}		
		}finally {
			//5
			pool.dbClose(rs, ps, con);
		}
		return menu_seq_curr;
	}

	public MenuDetailVO selectByMenuNo(int menuNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		MenuDetailVO menuDetailVo=null;
		
		//1,2
		con=pool.getConnection();
		//3
		String sql="select * from v_menuDetail "
				+ " where menu_no=?";
		ps=con.prepareStatement(sql);
		ps.setInt(1, menuNo);
		//4
		rs=ps.executeQuery();
		
		if(rs.next()) {
			int menu_no = rs.getInt("menu_no");
			int res_no = rs.getInt("res_no");
			String menu_name = rs.getString("menu_name");
			int menu_price = rs.getInt("menu_price");
			String menu_content = rs.getString("menu_content");
			String menu_yn = rs.getString("menu_yn");
			String menu_use = rs.getString("menu_use");
			Timestamp menu_regdate = rs.getTimestamp("menu_regdate");
			int reg_adm = rs.getInt("reg_adm");
			String res_name = rs.getString("res_name");
			String mem_id = rs.getString("mem_id");
			int img_no = rs.getInt("img_no");
			String img_filename=rs.getString("img_filename");
			
			menuDetailVo = new MenuDetailVO(menu_no, res_no, menu_name, menu_price, menu_content,
						menu_yn, menu_use, menu_regdate, reg_adm, res_name,
						mem_id, img_no, img_filename);
		}	
		return menuDetailVo;
	}

	public List<MenuDetailVO> selectApplyMenu(String condition, String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		MenuDetailVO menuDetailVo=null;
		List<MenuDetailVO> list =new ArrayList<>();
		
		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="select * from v_menuDetail where";
			ps=con.prepareStatement(sql);
			
			//검색의 경우
			if(keyword!=null && !keyword.isEmpty()) {
				sql+=" "+condition +" like '%' || ? || '%' and";
			}			
			sql+=" menu_yn='N' and menu_use='Y' order by menu_no";
			ps=con.prepareStatement(sql);

			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}
			
			//4
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int menu_no = rs.getInt("menu_no");
				int res_no = rs.getInt("res_no");
				String menu_name = rs.getString("menu_name");
				int menu_price = rs.getInt("menu_price");
				String menu_content = rs.getString("menu_content");
				String menu_yn = rs.getString("menu_yn");
				String menu_use = rs.getString("menu_use");
				Timestamp menu_regdate = rs.getTimestamp("menu_regdate");
				int reg_adm = rs.getInt("reg_adm");
				String res_name = rs.getString("res_name");
				String mem_id = rs.getString("mem_id");
				int img_no = rs.getInt("img_no");
				String img_filename=rs.getString("img_filename");
				
				menuDetailVo = new MenuDetailVO(menu_no, res_no, menu_name, menu_price, menu_content,
							menu_yn, menu_use, menu_regdate, reg_adm, res_name,
							mem_id, img_no, img_filename);
				list.add(menuDetailVo);
			}
			System.out.println("글 전체 조회 결과 list.size="+list.size()
			+", 매개변수 condition="+condition+", keyword="+keyword);
			
			return list;
		}finally {
			//5
			pool.dbClose(rs, ps, con);
		}
	}

	public int menuApplyAppr(int menuNo, int LoginUserNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		int cnt=0;
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="update menu"
					+ " set menu_yn='Y', reg_adm=?"
					+ " where menu_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, LoginUserNo);
			ps.setInt(2, menuNo);
			
			//4
			cnt=ps.executeUpdate();
		
		}finally {
			//5
			pool.dbClose(ps, con);
		}
		return cnt;
	}

	public List<MenuDetailVO> selectByResNo(int resNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		MenuDetailVO menuDetailVo=null;
		List<MenuDetailVO> list =new ArrayList<>();
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="select * from v_menudetail "
				+ " where res_no=? and menu_yn='Y' and menu_use='Y'"
				+ " order by menu_no";
			ps=con.prepareStatement(sql);
			ps.setInt(1, resNo);
			//4
			rs=ps.executeQuery();
			
			while(rs.next()) {
				int menu_no = rs.getInt("menu_no");
				int res_no = rs.getInt("res_no");
				String menu_name = rs.getString("menu_name");
				int menu_price = rs.getInt("menu_price");
				String menu_content = rs.getString("menu_content");
				String menu_yn = rs.getString("menu_yn");
				String menu_use = rs.getString("menu_use");
				Timestamp menu_regdate = rs.getTimestamp("menu_regdate");
				int reg_adm = rs.getInt("reg_adm");
				String res_name = rs.getString("res_name");
				String mem_id = rs.getString("mem_id");
				int img_no = rs.getInt("img_no");
				String img_filename=rs.getString("img_filename");
				
				menuDetailVo = new MenuDetailVO(menu_no, res_no, menu_name, menu_price, menu_content,
							menu_yn, menu_use, menu_regdate, reg_adm, res_name,
							mem_id, img_no, img_filename);
				list.add(menuDetailVo);
			}			
		}finally{
			//5
			pool.dbClose(rs, ps, con);
		}
		return list;
	}	
}
