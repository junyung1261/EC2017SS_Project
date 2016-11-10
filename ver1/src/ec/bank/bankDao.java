package ec.bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import ec.connUtil.ConnUtil;

public class bankDao {
	public ArrayList<bankVo> bankList() {
		ArrayList<bankVo> list = new ArrayList<bankVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from bank order by bank_id asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				bankVo vo = new bankVo();				
				vo.setBank_id(rs.getInt("bank_id"));
				vo.setBank_name(rs.getString("bank_name"));
				vo.setBank_name_eng(rs.getString("bank_name_eng"));
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
