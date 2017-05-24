package cn.suntak.ems.common.domain;

import java.util.Date;

/**
 * Created by Administrator on 2017/5/5.
 */
public class PRLinesV {
    private Long id;//ID
    private Date receiveDate;//接收日期

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(Date receiveDate) {
        this.receiveDate = receiveDate;
    }
}
