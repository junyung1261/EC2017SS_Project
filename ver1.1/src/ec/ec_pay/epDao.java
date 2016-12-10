package ec.ec_pay;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class epDao {
	public int ecPayInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into ec_pay values(null,?,0,0,?)";
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
	
	public ArrayList<epVo> payList() {
		ArrayList<epVo> list = new ArrayList<epVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from ec_pay where ep_where!=0 order by ep_time desc";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				epVo vo = new epVo();
				
				vo.setEp_id(rs.getInt("ep_id"));
				vo.setEp_mem_id(rs.getInt("ep_mem_id"));
				vo.setEp_where(rs.getInt("ep_where"));
				vo.setEp_value(rs.getInt("ep_value"));
				vo.setEp_time(rs.getString("ep_time"));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public String getRecentPayTime(int mem_id) {
		String recent_time = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
				conn = ConnUtil.getConnection();
				String sql = "select max(ep_time) from ec_pay where ep_id = ? and ep_where != 0;";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, mem_id);
					
			rs = ps.executeQuery();
			rs.next(); 
			recent_time = rs.getString("max(ep_time)");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return recent_time;
	}
}
