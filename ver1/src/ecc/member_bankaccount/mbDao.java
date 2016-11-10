package ecc.member_bankaccount;

import java.sql.Connection;
import java.sql.PreparedStatement;

import ec.connUtil.ConnUtil;
public class mbDao {
	public int insertMemberBankaccount(mbVo vo, int mem_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_bankaccount values(null,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setInt(2, vo.getMb_name());
			ps.setString(3, vo.getMb_bank());
			ps.setString(4, vo.getMb_account());
			ps.setString(5, vo.getMb_reg());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
