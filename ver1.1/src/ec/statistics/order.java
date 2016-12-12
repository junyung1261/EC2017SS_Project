package ec.statistics;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class order {
	
	public int todayOrderCount(String today) {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM order_info where or_account_time like ? ;";
			ps = conn.prepareStatement(sql);
			ps.setString(1, today+"%");
			rs = ps.executeQuery();
			rs.next();
			cnt = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return cnt;
	}
	public int compareOrder(String today, String yesterday){
		int cnt_today = 0;
		int cnt_yesterday = 0;
		int result = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM order_info where or_account_time like ? ;";
			ps = conn.prepareStatement(sql);
			ps.setString(1, today+"%");
			rs = ps.executeQuery();
			rs.next();
			cnt_today = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM order_info where or_account_time like ? ;";
			ps = conn.prepareStatement(sql);
			ps.setString(1, yesterday+"%");
			rs = ps.executeQuery();
			rs.next();
			cnt_yesterday = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		
		result = cnt_today - cnt_yesterday;
		return result;
	}
}
