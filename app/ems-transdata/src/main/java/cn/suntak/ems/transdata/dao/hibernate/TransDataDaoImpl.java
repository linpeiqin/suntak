package cn.suntak.ems.transdata.dao.hibernate;

import cn.suntak.ems.transdata.dao.TransDataDao;


import java.sql.*;

public class TransDataDaoImpl  implements TransDataDao{
    private static final String ORACLE_NAME = "oracle.jdbc.OracleDriver";
    private static final String ORCALE_SERVICE = "jdbc:oracle:thin:@10.1.100.14:1528:TEST4";
    private static final String ORCALE_USER = "EMS";
    private static final String ORCALE_PASSWORD = "EMS";
    @Override
    public int insertToEBS(String sql) {
        Connection conn = null;
        Statement stat = null;
        int msgCode = 0;
        try {
            Class.forName(ORACLE_NAME);
            conn = DriverManager.getConnection(ORCALE_SERVICE,ORCALE_USER,ORCALE_PASSWORD);
            stat = conn.createStatement();
            msgCode =  stat.executeUpdate(sql);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                stat.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return msgCode;
    }

    @Override
    public String calEBS(Long id,String proName) {
        Connection conn = null;
        CallableStatement cst = null;
        String msgAndCode = null;
        try {
            Class.forName(ORACLE_NAME);
            conn = DriverManager.getConnection(ORCALE_SERVICE,ORCALE_USER,ORCALE_PASSWORD);
            String sql =  "{call "+proName+"(?,?,?)}";
            cst = conn.prepareCall(sql);
            cst.registerOutParameter(1, Types.NUMERIC);
            cst.registerOutParameter(2, Types.VARCHAR);
            cst.setLong(3,id);
            cst.executeUpdate();
            msgAndCode = String.valueOf(cst.getInt(1))+"-"+cst.getString(2);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                cst.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return msgAndCode;
    }

    @Override
    public String getRetMsg(Long id,String tableName,String idName) {
        Connection conn = null;
        Statement stat = null;
        ResultSet rs = null;
        String msg = null;
        try {
            Class.forName(ORACLE_NAME);
            conn = DriverManager.getConnection(ORCALE_SERVICE,ORCALE_USER,ORCALE_PASSWORD);
            stat = conn.createStatement();
            String sql = "select process_status,process_msg from "+tableName+" where "+idName+" ="+id;
            rs =  stat.executeQuery(sql);
            while (rs.next()){
                msg = rs.getString("process_msg");
                if (msg!=null){
                    return msg;
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                stat.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return msg;
    }

    @Override
    public Long generateId() {
        Connection conn = null;
        Statement stat = null;
        ResultSet rs = null;
        Long id = null;
        try {
            Class.forName(ORACLE_NAME);
            conn = DriverManager.getConnection(ORCALE_SERVICE,ORCALE_USER,ORCALE_PASSWORD);
            stat = conn.createStatement();
            String sql = "select ems_ebs_sequence.nextval from dual";
            rs =  stat.executeQuery(sql);
            while (rs.next()){
                id = new Long(rs.getLong(1));
                if (id!=null){
                    return id;
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                stat.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return id;
    }

    @Override
    public int excuteSql(String sql) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        Statement stat = null;
        int msgCode = 0;
        try {
            Class.forName(ORACLE_NAME);
            conn = DriverManager.getConnection(ORCALE_SERVICE,ORCALE_USER,ORCALE_PASSWORD);
            stat = conn.createStatement();
            msgCode =  stat.executeUpdate(sql);
        }finally {
            try {
                stat.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return msgCode;
    }
}
