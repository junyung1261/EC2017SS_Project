package ec.statistics;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class member {
	public int totalMemberCount() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM member;";
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
	
	//���� ������ ����� ���ڰ� �� ������ ��������
	public int compareMember(String today){
		int cnt_today = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT count(*) FROM member where mem_reg like ? ;";
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
