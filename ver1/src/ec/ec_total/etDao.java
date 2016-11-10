package ec.ec_total;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class etDao {
	public int ecTotalInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into ec_total values(null,?,0,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setString(2, time);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public int getTotal(int mem_id) {
		int total = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
				conn = ConnUtil.getConnection();
				String sql = "select et_value from ec_total where et_mem_id = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, mem_id);
					
			rs = ps.executeQuery();
			rs.next(); 
			total = rs.getInt("et_value");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return total;
	}
}
