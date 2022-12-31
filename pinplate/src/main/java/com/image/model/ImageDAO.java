package com.image.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.db.ConnectionPoolMgr;


public class ImageDAO {
	private ConnectionPoolMgr pool;
	
	public ImageDAO() {
		pool=new ConnectionPoolMgr();
	}

	public int insertImg() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;
		try {
			con=pool.getConnection();
			String sql="insert into images valeu()";
			ps=con.prepareStatement(sql);
		}finally {
			pool.dbClose(ps, con);
		}
		return cnt;
	}
}
