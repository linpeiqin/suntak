package cn.suntak.ems.transdata.dao;

import java.sql.SQLException;

public interface TransDataDao {
    int insertToEBS(String sql);

    String calEBS(Long id,String proName);

    String getRetMsg(Long id,String tableName,String idName);

    Long generateId();

    int excuteSql(String sql) throws SQLException, ClassNotFoundException;
}

