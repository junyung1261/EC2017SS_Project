package ec.couriercompany;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class ccDao {
	public ArrayList<ccVo> CourierCompanyList() {
		ArrayList<ccVo> list = new ArrayList<ccVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();

			String sql = "select * from couriercompany order by cc_id asc limit 0, 1";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				ccVo vo = new ccVo();
				
				vo.setCc_id(rs.getInt("cc_id"));
				vo.setCc_name(rs.getString("cc_name"));
				vo.setCc_reg(rs.getString("cc_reg"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	public String getCourierCompanyName(int cc_id) {
		String pd_name = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from couriercompany where cc_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cc_id);
			rs = ps.executeQuery();
			rs.next();
			pd_name = rs.getString("cc_name");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return pd_name;
	}
}
