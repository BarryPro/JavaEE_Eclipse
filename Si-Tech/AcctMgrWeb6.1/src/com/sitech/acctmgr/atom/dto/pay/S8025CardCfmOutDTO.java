package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8025CardCfmOutDTO extends CommonOutDTO {
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String totalDate;//缴费日期
	
	@JSONField(name="PAY_FLAG")
	@ParamDesc(path="PAY_FLAG",cons=ConsType.CT001,type="String",len="8",desc="请求充值卡平台后成功于否",memo="1:表示成功")
	protected String payFlag;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		result.setRoot(getPathByProperName("payFlag"), payFlag);
		return result;
	}


	public String getTotalDate() {
		return totalDate;
	}


	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}


	public String getPayFlag() {
		return payFlag;
	}


	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}


}
