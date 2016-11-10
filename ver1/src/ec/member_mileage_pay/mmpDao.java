package ec.member_mileage_pay;

import java.sql.Connection;
import java.sql.PreparedStatement;

import ec.connUtil.ConnUtil;

public class mmpDao {
	public int insertMemberMileagePay(mmpVo vo, int mem_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_mileage_pay values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setInt(2, vo.getMmp_where());	//0:판매자발급	1:관리자발급
			ps.setInt(3, vo.getMmp_value());
			ps.setString(4, vo.getMmp_time());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
