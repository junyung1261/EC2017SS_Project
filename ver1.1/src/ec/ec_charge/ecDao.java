package ec.ec_charge;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
	
	public ArrayList<ecVo> chargeList() {
		ArrayList<ecVo> list = new ArrayList<ecVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from ec_charge where ec_how !=0 order by ec_time desc";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				ecVo vo = new ecVo();
				
				vo.setEc_id(rs.getInt("ec_id"));
				vo.setEc_mem_id(rs.getInt("ec_mem_id"));
				vo.setEc_how(rs.getInt("ec_how"));
				vo.setEc_value(rs.getInt("ec_value"));
				vo.setEc_time(rs.getString("ec_time"));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
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
