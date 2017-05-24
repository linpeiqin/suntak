package cn.suntak.ems.partinfo.job;

import cn.oz.exception.OzException;
import cn.oz.job.Job;
import cn.suntak.ems.common.domain.PRLinesV;
import cn.suntak.ems.common.service.PRLinesVService;
import cn.suntak.ems.partinfo.domain.PRLine;
import cn.suntak.ems.partinfo.service.PRLineService;

import java.util.List;

/**
 * Created by Administrator on 2017/5/4.
 */
public class GrabPRLine  implements Job {
    private PRLineService pRLineService;
    private PRLinesVService pRLinesVService;

    public void setpRLineService(PRLineService pRLineService) {
        this.pRLineService = pRLineService;
    }

    public void setpRLinesVService(PRLinesVService pRLinesVService) {
        this.pRLinesVService = pRLinesVService;
    }

    @Override
    public void execute() throws OzException {
        List<PRLine> pRLines = this.pRLineService.getPRLineList();
        for(PRLine pRLine:pRLines ){
            PRLinesV pRLinesV = this.pRLinesVService.getPRLinesVBy(pRLine.getId());
            pRLine.setNeedDate(pRLinesV.getReceiveDate());
        }
    }
}
