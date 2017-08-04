package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeOrderPayBackInDTO extends CommonInDTO{

	private static final long serialVersionUID = -3682083701969326333L;
	
	private MBean allJson;	//所有调用报文
	
	@ParamDesc(path="OPR_INFO",cons=ConsType.STAR,type="compx",len="1",desc="OPR_INFO节点",memo="略")
	protected MBean oprJson;
	
	@ParamDesc(path="BUSI_INFO",cons=ConsType.STAR,type="compx",len="1",desc="BUSI_INFO节点",memo="略")
	protected MBean busiJson;
	
	@ParamDesc(path="OPR_INFO.ORIGIN_ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="40",desc="原始订单行号",memo="略")
	private String originForeignSn;
	
	@ParamDesc(path="OPR_INFO.CREATE_TIME",cons=ConsType.QUES,type="String",len="14",desc="原始操作时间",memo="格式：YYYYMMDDHH24MISS")
	private String originForeignTime;
	
	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="40",desc="订单行号",memo="略")
	private String foreignSn;

	@ParamDesc(path="BUSI_INFO.ORIGIN_BUSI_CODE",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String oriBusiCode;		//费用冲正正向BUSI_CODE
	
	public void decode(MBean arg0){
		
		log.debug("qiaolin test1: " + arg0);
		
		super.decode(arg0);
		
		allJson = arg0;
		log.debug("qiaolin test: " + allJson);
		
		
		log.debug("oprJson: " + oprJson);
		log.debug("busiJson: " + busiJson);
		oriBusiCode =  arg0.getStr(getPathByProperName("oriBusiCode"));

		
	}

	public MBean getAllJson() {
		return allJson;
	}

	public void setAllJson(MBean allJson) {
		this.allJson = allJson;
	}

	
	public MBean getOprJson() {
		return oprJson;
	}

	public void setOprJson(MBean oprJson) {
		this.oprJson = oprJson;
	}

	public MBean getBusiJson() {
		return busiJson;
	}

	public void setBusiJson(MBean busiJson) {
		this.busiJson = busiJson;
	}

	public String getOriBusiCode() {
		return oriBusiCode;
	}

	public void setOriBusiCode(String oriBusiCode) {
		this.oriBusiCode = oriBusiCode;
	}

	public String getOriginForeignSn() {
		return originForeignSn;
	}

	public void setOriginForeignSn(String originForeignSn) {
		this.originForeignSn = originForeignSn;
	}

	public String getOriginForeignTime() {
		return originForeignTime;
	}

	public void setOriginForeignTime(String originForeignTime) {
		this.originForeignTime = originForeignTime;
	}

}
