package ec.statistics;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil2.ConnUtil2;

public class product_click {
	
	public int countProductClickTotal(){
		int cnt_today = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil2.getConnection();
			String sql = "SELECT sum(pd_clicks) FROM product_click";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			cnt_today = rs.getInt("sum(pd_clicks)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil2.close(ps, conn);
		}
		
		return cnt_today;
	}
	
	public int countProductClickToday(String today){
		int cnt_today = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil2.getConnection();
			String sql = "SELECT sum(pd_clicks) FROM product_click where pd_date = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, today);
			rs = ps.executeQuery();
			rs.next();
			cnt_today = rs.getInt("sum(pd_clicks)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil2.close(ps, conn);
		}
		
		return cnt_today;
	}
	
	public int createProductClick(String today, int pd_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil2.getConnection();  //Column 8개 중 1개 Auto_inrement mem_id
			String sql = "insert into product_click values(?,?,1)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, today);
			ps.setInt(2, pd_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil2.close(ps, conn);
		}
		return rst;
	}
	
	public int updateProductClick(String today, int pd_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil2.getConnection();  //Column 8개 중 1개 Auto_inrement mem_id
			String sql = "update product_click set pd_clicks = pd_clicks + 1 where pd_date = ? and pd_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, today);
			ps.setInt(2, pd_id);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil2.close(ps, conn);
		}
		return rst;
	}
}
