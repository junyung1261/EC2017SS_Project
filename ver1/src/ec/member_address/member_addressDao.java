package ec.member_address;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import ec.connUtil.ConnUtil;
public class member_addressDao {
	public int insertMemberAddress(member_addressVo vo, int mem_id) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member_address values(null,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			ps.setString(2, vo.getMa_name_recipient());
			ps.setString(3, vo.getMa_addr_zipcode());
			ps.setString(4, vo.getMa_addr_base());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public member_addressVo getMemberInfo(int mem_id) {
		member_addressVo vo = new member_addressVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from member_address where ma_mem_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mem_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setMa_id(rs.getInt("ma_id"));
				vo.setMa_mem_id(rs.getInt("ma_mem_id"));
				vo.setMa_name_recipient(rs.getString("ma_name_recipient"));
				vo.setMa_addr_zipcode(rs.getString("ma_addr_zipcode"));
				vo.setMa_addr_base(rs.getString("ma_addr_base"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
}
