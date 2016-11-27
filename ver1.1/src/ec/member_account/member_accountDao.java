package ec.member_account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import ec.connUtil.ConnUtil;

public class member_accountDao {
	public int insertMemberAccount(member_accountVo vo, int mem_id, String time) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_account values(null,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setString(2, vo.getMac_name());
			ps.setInt(3, vo.getMac_bank());
			ps.setString(4, vo.getMac_account());
			ps.setString(5, time);
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public member_accountVo getMemberAccountInfo(int mem_id) {
		member_accountVo vo = new member_accountVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from member_account where mac_mem_id=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setMac_id(rs.getInt("mac_id"));
				vo.setMac_mem_id(rs.getInt("mac_mem_id"));
				vo.setMac_name(rs.getString("mac_name"));
				vo.setMac_bank(rs.getInt("mac_bank"));
				vo.setMac_account(rs.getString("mac_account"));
				vo.setMac_reg(rs.getString("mac_reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
