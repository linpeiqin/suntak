package cn.suntak.ems.oa.dao.hibernate;


import cn.suntak.ems.oa.dao.OaDepartDao;

import java.sql.*;

public class OaDepartDaoImpl implements OaDepartDao {
    private static final String ORACLE_NAME = "oracle.jdbc.OracleDriver";
    private static final String ORCALE_SERVICE = "jdbc:oracle:thin:@10.1.100.17:1521/OADB";
    private static final String ORCALE_USER = "EMS";
    private static final String ORCALE_PASSWORD = "123456";

    @Override
    public String getOaDepartId(String oaCode) {
        Connection conn = null;
        PreparedStatement  pstm = null;
        String oaDepartId = null;
        ResultSet rs = null;
        try {
            Class.forName(ORACLE_NAME);
            conn = DriverManager.getConnection(ORCALE_SERVICE,ORCALE_USER,ORCALE_PASSWORD);
            String sql = "select to_char(id) from v3xuser.mv_department where code = ?";
            pstm = conn.prepareCall(sql);
            pstm.setString(1,oaCode);
            rs = pstm.executeQuery();
            while(rs.next()){
                oaDepartId = rs.getString(1);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                pstm.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return oaDepartId;
    }
}
