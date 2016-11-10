package ec.member_ec_charge;

import java.sql.Connection;
import java.sql.PreparedStatement;

import ec.connUtil.ConnUtil;
public class mecDao {
	public int insertMemberECCharge(mecVo vo, int mem_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_ec_charge values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setInt(2, vo.getMec_how());	//0:관리자발급	1:고객충전
			ps.setInt(3, vo.getMec_value());
			ps.setString(4, vo.getMec_time());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
