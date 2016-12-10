package ec.mileage_pay;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class mpDao {
	public int mileagePayInitial(int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into mileage_pay values(null,?,0,0,?)";
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
	
	// 마일리지 사용 리스트 (단, 초기 테이블 생성을 위한 레코드인 mp_where==0 는 제외한다. )
	public ArrayList<mpVo> payList() {
		ArrayList<mpVo> list = new ArrayList<mpVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from mileage_pay where mp_where!=0 order by mp_time desc";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				mpVo vo = new mpVo();
				
				vo.setMp_id(rs.getInt("mp_id"));
				vo.setMp_mem_id(rs.getInt("mp_mem_id"));
				vo.setMp_where(rs.getInt("mp_where"));
				vo.setMp_value(rs.getInt("mp_value"));
				vo.setMp_time(rs.getString("mp_time"));
				
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
