package ec.member_ec_pay;

import java.sql.Connection;
import java.sql.PreparedStatement;

import ec.connUtil.ConnUtil;

public class mepDao {
	public int insertMemberECCharge(mepVo vo, int mem_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_ec_pay values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setInt(2, vo.getMep_where());
			ps.setInt(3, vo.getMep_value());
			ps.setString(4, vo.getMep_time());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
