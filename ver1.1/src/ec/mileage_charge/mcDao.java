package ec.mileage_charge;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;
public class mcDao {
	public int mileageChargeInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into mileage_charge values(null,?,0,0,?)";
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
	
	public ArrayList<mcVo> chargeList() {
		ArrayList<mcVo> list = new ArrayList<mcVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from mileage_charge where mc_how!=0 order by mc_time desc";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				mcVo vo = new mcVo();
				
				vo.setMc_id(rs.getInt("mc_id"));
				vo.setMc_mem_id(rs.getInt("mc_mem_id"));
				vo.setMc_how(rs.getInt("mc_how"));
				vo.setMc_value(rs.getInt("mc_value"));
				vo.setMc_time(rs.getString("mc_time"));
				
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
}
