package ec.ec_charge;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;

import ec.connUtil.ConnUtil;
public class ecDao {
	public int ecChargeInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into ec_charge values(null,?,0,0,?)";
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
	
	public int getTotalCharge(int mem_id) {
		int sum = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
				conn = ConnUtil.getConnection();
				String sql = "select sum(ec_value) from ec_charge where ec_mem_id = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, mem_id);
					
			rs = ps.executeQuery();
			rs.next(); 
			sum = rs.getInt("sum(ec_value)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return sum;
	}
	
	public String getRecentChargeTime(int mem_id) {
		String recent_time = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
				conn = ConnUtil.getConnection();
				String sql = "select max(ec_time) from ec_charge where ec_id = ? and ec_how != 0;";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, mem_id);
					
			rs = ps.executeQuery();
			rs.next(); 
			recent_time = rs.getString("max(ec_time)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return recent_time;
	}
}
