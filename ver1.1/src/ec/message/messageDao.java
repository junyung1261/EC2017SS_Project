package ec.message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import ec.connUtil.ConnUtil;

public class messageDao {
	public int insertMessageSend(messageVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 8개 중 1개 Auto_inrement mem_id
			String sql = "insert into message_send values(null,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getMsg_writer());
			ps.setString(2, vo.getMsg_receiver());
			ps.setString(3, vo.getMsg_title());
			ps.setString(4, vo.getMsg_contents());
			ps.setInt(5, vo.getMsg_type());
			ps.setInt(6, vo.getMsg_state());
			ps.setString(7, vo.getMsg_time());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	
	public int insertMessageReceive(messageVo vo) {
		int rst = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();  //Column 8개 중 1개 Auto_inrement mem_id
			String sql = "insert into message_receive values(null,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getMsg_writer());
			ps.setString(2, vo.getMsg_receiver());
			ps.setString(3, vo.getMsg_title());
			ps.setString(4, vo.getMsg_contents());
			ps.setInt(5, vo.getMsg_type());
			ps.setInt(6, vo.getMsg_state());
			ps.setString(7, vo.getMsg_time());
			rst = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
		return rst;
	}
	public ArrayList<messageVo> getReceivedMessage(String msg_receiver) {
		ArrayList<messageVo> list = new ArrayList<messageVo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from message_receive where msg_receiver = ? order by msg_time desc;";
			ps = conn.prepareStatement(sql);
			ps.setString(1, msg_receiver);
			rs = ps.executeQuery();
			while (rs.next()) {
				messageVo vo = new messageVo();
				
				vo.setMsg_id(rs.getInt("msg_id"));
				vo.setMsg_writer(rs.getString("msg_writer"));
				vo.setMsg_receiver(rs.getString("msg_receiver"));
				vo.setMsg_title(rs.getString("msg_title"));
				vo.setMsg_contents(rs.getString("msg_contents"));
				vo.setMsg_type(rs.getInt("msg_type"));
				vo.setMsg_state(rs.getInt("msg_state"));
				vo.setMsg_time(rs.getString("msg_time"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return list;
	}
	public messageVo selectReceivedMessage(int msg_id) {
		messageVo vo = new messageVo();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "select * from message_receive where msg_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, msg_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo.setMsg_id(rs.getInt("msg_id"));
				vo.setMsg_writer(rs.getString("msg_writer"));
				vo.setMsg_receiver(rs.getString("msg_receiver"));
				vo.setMsg_title(rs.getString("msg_title"));
				vo.setMsg_contents(rs.getString("msg_contents"));
				vo.setMsg_type(rs.getInt("msg_type"));
				vo.setMsg_state(rs.getInt("msg_state"));
				vo.setMsg_time(rs.getString("msg_time"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(rs, ps, conn);
		}
		return vo;
	}
	
	public void updateMessageReceiveState(int msg_id) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "update message_receive set msg_state = 1 where msg_id= ? ";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, msg_id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}
	}
	
	public void updateMessageSendState(int msg_id) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = ConnUtil.getConnection();
			String sql = "update message_send set msg_state = 1 where msg_id= ? ";
			ps = conn.prepareStatement(sql);

			ps.setInt(1, msg_id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnUtil.close(ps, conn);
		}

	}
}
