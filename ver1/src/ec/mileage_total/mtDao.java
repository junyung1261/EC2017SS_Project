package ec.mileage_total;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class mtDao {
	public int mileageTotalInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into mileage_total values(null,?,0,?)";
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
	
	public mtVo getMileageInfo(int pd_id) {
		mtVo vo = new mtVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from mileage_total where mt_mem_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pd_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				
				vo.setMt_id(rs.getInt("mt_id"));
				vo.setMt_mem_id(rs.getInt("mt_mem_id"));
				vo.setMt_value(rs.getInt("mt_value"));
				vo.setMt_time(rs.getString("mt_time"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
