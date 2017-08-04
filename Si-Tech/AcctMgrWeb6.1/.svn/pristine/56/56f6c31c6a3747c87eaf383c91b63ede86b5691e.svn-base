package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSmsRightJudgeIsGprsCmdOutDTO extends CommonOutDTO{

	@ParamDesc(path = "GPRS_FALG", desc = "是否可订购多上多奖资费目标用户", cons = ConsType.CT001, type = "string", len = "1", memo = "0：不是目标用户   1：是目标用户")
	private String gprsFlas;
	
    @Override
    public MBean encode() {
        MBean result = new MBean();
        
        result.setRoot(getPathByProperName("gprsFlas"), gprsFlas);
        return result;
    }

	public String getGprsFlas() {
		return gprsFlas;
	}

	public void setGprsFlas(String gprsFlas) {
		this.gprsFlas = gprsFlas;
	}
	
    
}
