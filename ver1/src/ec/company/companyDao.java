package ec.company;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;
import ec.product.productVo;

public class companyDao {
	public int insertCompany(companyVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "insert into company values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
			ps.setInt(10, vo.getCo_delivery_base());
			ps.setInt(11, vo.getCo_delivery_exception());
			ps.setInt(12, vo.getCo_delivery_condition());
			ps.setString(13, vo.getCo_reg_num1());
			ps.setString(14, vo.getCo_reg_num2());
			ps.setString(15, vo.getCo_bank());
			ps.setString(16, vo.getCo_account());
			ps.setString(17, vo.getCo_password());
			ps.setString(18, vo.getCo_grade());
			ps.setString(19, vo.getCo_reg_date());
			ps.setString(20, vo.getCo_exp_date());
			ps.setString(21, vo.getCo_tags());

			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}

	public companyVo getCompanyInfo(String co_id) {
		companyVo vo = new companyVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from company where co_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, co_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setCo_id(rs.getString("co_id"));
				vo.setCo_name(rs.getString("co_name"));
				vo.setCo_ceo(rs.getString("co_ceo"));
				vo.setCo_phone(rs.getString("co_phone"));
				vo.setCo_tel(rs.getString("co_tel"));
				vo.setCo_fax(rs.getString("co_fax"));
				vo.setCo_address(rs.getString("co_address"));
				vo.setCo_email(rs.getString("co_email"));
				vo.setCo_delivery(rs.getString("co_delivery"));
				vo.setCo_delivery_base(rs.getInt("co_delivery_base"));
				vo.setCo_delivery_exception(rs.getInt("co_delivery_exception"));
				vo.setCo_delivery_condition(rs.getInt("co_delivery_condition"));
				vo.setCo_reg_num1(rs.getString("co_reg_num1"));
				vo.setCo_reg_num2(rs.getString("co_reg_num2"));
				vo.setCo_bank(rs.getString("co_bank"));
				vo.setCo_account(rs.getString("co_account"));
				vo.setCo_password(rs.getString("co_password"));
				vo.setCo_grade(rs.getString("co_grade"));
				vo.setCo_reg_date(rs.getString("co_reg_date"));
				vo.setCo_exp_date(rs.getString("co_exp_date"));
				vo.setCo_tags(rs.getString("co_tags"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
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
	
	public ArrayList<companyVo> companyList(int req, String co_id) {
		ArrayList<companyVo> list = new ArrayList<companyVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = null;
			switch(req){
				/*전체 리스트*/
			case 1:
				sql = "select * from company order by co_id asc";
				ps = conn.prepareStatement(sql);
				break;
			}
			rs = ps.executeQuery();
			while (rs.next()) {
				companyVo vo = new companyVo();
				
				vo.setCo_id(rs.getString("co_id"));
				vo.setCo_name(rs.getString("co_name"));
				vo.setCo_ceo(rs.getString("co_ceo"));
				vo.setCo_phone(rs.getString("co_phone"));
				vo.setCo_tel(rs.getString("co_tel"));
				vo.setCo_fax(rs.getString("co_fax"));
				vo.setCo_address(rs.getString("co_address"));
				vo.setCo_email(rs.getString("co_email"));
				vo.setCo_delivery(rs.getString("co_delivery"));
				vo.setCo_delivery_base(rs.getInt("co_delivery_base"));
				vo.setCo_delivery_exception(rs.getInt("co_delivery_exception"));
				vo.setCo_delivery_condition(rs.getInt("co_delivery_condition"));
				vo.setCo_reg_num1(rs.getString("co_reg_num1"));
				vo.setCo_reg_num2(rs.getString("co_reg_num2"));
				vo.setCo_bank(rs.getString("co_bank"));
				vo.setCo_account(rs.getString("co_account"));
				vo.setCo_password(rs.getString("co_password"));
				vo.setCo_grade(rs.getString("co_grade"));
				vo.setCo_reg_date(rs.getString("co_reg_date"));
				vo.setCo_exp_date(rs.getString("co_exp_date"));
				vo.setCo_tags(rs.getString("co_tags"));
				
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
