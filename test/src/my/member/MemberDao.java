package my.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import my.util.ConnUtil;

public class MemberDao {
	public int insertMember(MemberVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into member values(null,?,?,?,?,?,?,sysdate())";
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPass());
			
			ps.setString(3, vo.getEmail1()+"@"+vo.getEmail2());
			ps.setString(4, vo.getPh1()+"-"+vo.getPh2()+"-"+vo.getPh3());
			ps.setString(5, vo.getGender());
			ps.setString(6, vo.getBirth1()+"-"+vo.getBirth2()+"-"+vo.getBirth3());
			
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
}
