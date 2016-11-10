package ec.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class memberDao {
	public int nextInsertMemberId() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name = 'member' AND table_schema =database( );";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next(); 
			cnt = rs.getInt("AUTO_INCREMENT");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return cnt;
	}

	public int insertMember(memberVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 8개 중 1개 Auto_inrement mem_id
			String sql = "insert into member values(null,?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getMem_method());
			ps.setString(2, vo.getMem_user_id());
			ps.setString(3, vo.getMem_password());
			ps.setString(4, vo.getMem_birth());
			ps.setInt(5, vo.getMem_gender());
			ps.setInt(6, vo.getMem_msg_receive());
			ps.setString(7, vo.getMem_phone());
			ps.setInt(8, vo.getMem_grade());
			ps.setString(9, vo.getMem_reg());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public ArrayList<memberVo> memberList(int req, int mem_method) {
		ArrayList<memberVo> list = new ArrayList<memberVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			
			String sql = null;
			switch(req){
				/*전체 리스트*/
			case 1:
				sql = "select * from member order by mem_id desc";
				ps = conn.prepareStatement(sql);
				break;
			case 2:
				/*유입경로별 리스트 (android = 0, iOS = 1)*/
				sql = "select * from member where mem_method = ? order by pd_id asc;";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, mem_method);
				break;
			}
			
			rs = ps.executeQuery();
			while (rs.next()) {
				memberVo vo = new memberVo();
				
				vo.setMem_id(rs.getInt("mem_id"));
				vo.setMem_method(rs.getInt("mem_method"));
				vo.setMem_user_id(rs.getString("mem_user_id"));
				vo.setMem_birth(rs.getString("mem_birth"));
				vo.setMem_gender(rs.getInt("mem_gender"));
				vo.setMem_msg_receive(rs.getInt("mem_msg_receive"));
				vo.setMem_phone(rs.getString("mem_phone"));
				vo.setMem_grade(rs.getInt("mem_grade")); 
				vo.setMem_reg(rs.getString("mem_reg"));
				
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
