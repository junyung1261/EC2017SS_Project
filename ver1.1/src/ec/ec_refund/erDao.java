package ec.ec_refund;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class erDao {
	public int ecRefundInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into ec_refund values(null,?,0,0,0,?)";
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
	
	public ArrayList<erVo> refundList() {
		ArrayList<erVo> list = new ArrayList<erVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from ec_refund where er_state !=0 order by er_time desc";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				erVo vo = new erVo();
				
				vo.setEr_id(rs.getInt("er_id"));
				vo.setEr_mem_id(rs.getInt("er_mem_id"));
				vo.setEr_why(rs.getInt("er_why"));
				vo.setEr_value(rs.getInt("er_value"));
				vo.setEr_state(rs.getInt("er_state"));
				vo.setEr_time(rs.getString("er_time"));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public String getRecentRefundTime(int mem_id) {
		String recent_time = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
				conn = ConnUtil.getConnection();
				String sql = "select max(er_time) from ec_refund where er_id = ? and er_why != 0 and er_state=1";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, mem_id);
					
			rs = ps.executeQuery();
			rs.next(); 
			recent_time = rs.getString("max(er_time)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return recent_time;
	}
}
