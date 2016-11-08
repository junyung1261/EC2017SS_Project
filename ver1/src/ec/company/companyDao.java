package ec.company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class companyDao {
	public int insertCompany(companyVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into company values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getCo_id());
			ps.setString(2, vo.getCo_name());
			ps.setString(3, vo.getCo_ceo());
			ps.setString(4, vo.getCo_phone());
			ps.setString(5, vo.getCo_tel());
			ps.setString(6, vo.getCo_fax());
			ps.setString(7, vo.getCo_address());
			ps.setString(8, vo.getCo_email());
			ps.setString(9, vo.getCo_delivery());
			ps.setString(10, vo.getCo_reg_num1());
			ps.setString(11, vo.getCo_reg_num2());
			ps.setString(12, vo.getCo_bank());
			ps.setString(13, vo.getCo_account());
			ps.setString(14, vo.getCo_password());
			ps.setString(15, vo.getCo_grade());
			ps.setString(16, vo.getCo_reg_date());
			ps.setString(17, vo.getCo_exp_date());
			ps.setString(18, vo.getCo_tags());

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<companyVo> CompanyNameAndIDList() {
		ArrayList<companyVo> list = new ArrayList<companyVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from company order by co_name asc";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				companyVo vo = new companyVo();				
				vo.setCo_id(rs.getString("co_id"));
				vo.setCo_name(rs.getString("co_name"));
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
