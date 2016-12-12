package ec.fee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;

public class feeDao {
	public feeVo getFeeInfo() {
		feeVo vo = new feeVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from fee where f_id = 1";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setF_id(rs.getInt("f_id"));
				vo.setF_rate(rs.getFloat("f_rate"));
				vo.setF_reg(rs.getString("f_reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
	
	public int account(int price, int discount, int delivery, float fee){
		float acc = 0;
		acc = (price - discount + delivery)*(1-fee);
		int result = (int)acc;
		return result;
		
	}
}
