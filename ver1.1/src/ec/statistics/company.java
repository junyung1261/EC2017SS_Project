package ec.statistics;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class company {
	public int totalCompanyCount() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM company;";
			ps = conn.prepareStatement(sql);
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
	
	//오늘 가입한 사람의 숫자가 곧 오늘의 증가량임
	public int compareCompany(String today){
		int cnt_today = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM company where co_reg_date like ? ;";
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
		
		return cnt_today;
	}
}
