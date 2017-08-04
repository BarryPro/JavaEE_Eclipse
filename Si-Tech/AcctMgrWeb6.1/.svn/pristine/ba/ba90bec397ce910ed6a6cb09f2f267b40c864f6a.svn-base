package com.sitech.acctmgr.comp.impl.detail;

import com.sitech.acctmgr.atom.domains.detail.PTOPEntity;
import com.sitech.acctmgr.atom.dto.detail.SDetailCheckCheckOutDTO;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.comp.dto.detail.SDetailCheckCompCheckInDTO;
import com.sitech.acctmgr.inter.detail.IDetailCheckComp;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

import java.util.List;

/**
 * Created by wangyla on 2017/3/20.
 */
@ParamTypes({
        @ParamType(c = SDetailCheckCompCheckInDTO.class, m = "check", oc = SDetailCheckCheckOutDTO.class)
})
public class SDetailCheckComp extends AcctMgrBaseService implements IDetailCheckComp {

    @Override
    public OutDTO check(InDTO inParam) {
        SDetailCheckCompCheckInDTO inDTO = (SDetailCheckCompCheckInDTO) inParam;
        
        MBean in = new MBean(inDTO.getMbean().toString());
        
        log.debug("inDTO=" + inDTO.getMbean());

        String opCode = inDTO.getOpCode();

        String interName = "com_sitech_acctmgr_inter_detail_IDetailCheckSvc_check";
        
        int curDay = DateUtils.getCurDay() % 100;
        int curYm = DateUtils.getCurYm();
        int lastYm1 = DateUtils.addMonth(curYm, -3);
        int lastYm2 = DateUtils.addMonth(curYm, -1);

        //根据一个标识确定开始时间和结束时间
        String beginTime = String.format("%6d%02d", lastYm1, curDay);
        String endTime = String.format("%6d%02d", lastYm2, curDay);

        in.setBody("BUSI_INFO.BEGIN_TIME", beginTime);
        in.setBody("BUSI_INFO.END_TIME", endTime);
        log.debug("invoke service in: " + in.toString());
        String outString = ServiceUtil.callService(interName, in.toString());
        log.debug("invoke service out: " + outString);
        
        MBean outBean = new MBean(outString);
        String retCode = outBean.getBodyStr("RETURN_CODE");
        String retMsg = outBean.getBodyStr("RETURN_MSG");
        if(!"0".equals(retCode)){
        	throw new BusiException(retCode,retMsg);
        }
        List<PTOPEntity> outList = outBean.getBodyList("OUT_DATA.TARGET_LIST", PTOPEntity.class);

        SDetailCheckCheckOutDTO outDTO = new SDetailCheckCheckOutDTO();
        outDTO.setOutList(outList);

        return outDTO;
    }
}
