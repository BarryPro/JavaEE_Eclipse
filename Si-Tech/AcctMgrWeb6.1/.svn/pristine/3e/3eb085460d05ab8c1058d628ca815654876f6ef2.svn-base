package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:求赠赠予扣费入参</p>
 * <p>Description:对入参进行解析成MBean，并检验入参的正确性</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author jiassa
 * @version 1.0
 */
public class SGivenCfmInDTO extends CommonInDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -397986086386522417L;
	
	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="40",desc="订单行ID",memo="略")
	protected String orderLineId;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.GIVE_FEE",cons=ConsType.CT001,type="long",len="14",desc="扣费金额,单位:分",memo="略")
	protected long giveFee;
	@ParamDesc(path="BUSI_INFO.PUB_FLAG",cons=ConsType.QUES,type="String",len="1",desc="公共号码标志:1-否;1-是",memo="略")
	protected String pubFlag ;
	@ParamDesc(path="BUSI_INFO.SERVE_TYPE",cons=ConsType.CT001,type="String",len="5",desc="业务小类",memo="略")
	protected String serveType;
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="String",len="60",desc="业务受理流水",memo="略")
	protected String foreignSN;
	@ParamDesc(path="BUSI_INFO.GPRS",cons=ConsType.CT001,type="String",len="15",desc="扣减GPRS流量",memo="略")
	protected String gprs;
	@ParamDesc(path="BUSI_INFO.MARK_PRC",cons=ConsType.CT001,type="String",len="1024",desc="营销案办理资费代码串",memo="略")
	protected String markPrc;
	@ParamDesc(path="BUSI_INFO.MARK_SN",cons=ConsType.CT001,type="String",len="1024",desc="营销案办理流水串",memo="略")
	protected String markSn;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.CT001,type="String",len="100",desc="备注",memo="略")
	protected String remark;
	
 
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setGiveFee(Long.parseLong(arg0.getObject(getPathByProperName("giveFee")).toString()));
		setPubFlag(arg0.getStr(getPathByProperName("pubFlag")));
		setServeType(arg0.getStr(getPathByProperName("serveType")));
		setForeignSN(arg0.getStr(getPathByProperName("foreignSN")));
		setGprs(arg0.getStr(getPathByProperName("gprs")));
		setMarkPrc(arg0.getStr(getPathByProperName("markPrc")));
		setMarkSn(arg0.getStr(getPathByProperName("markSn")));
		setRemark(arg0.getStr(getPathByProperName("remark")));

	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getGiveFee() {
		return giveFee;
	}

	public void setGiveFee(long giveFee) {
		this.giveFee = giveFee;
	}

	public String getPubFlag() {
		return pubFlag;
	}

	public void setPubFlag(String pubFlag) {
		this.pubFlag = pubFlag;
	}

	public String getServeType() {
		return serveType;
	}

	public void setServeType(String serveType) {
		this.serveType = serveType;
	}

	public String getForeignSN() {
		return foreignSN;
	}

	public void setForeignSN(String foreignSN) {
		this.foreignSN = foreignSN;
	}

	public String getGprs() {
		return gprs;
	}

	public void setGprs(String gprs) {
		this.gprs = gprs;
	}

	public String getMarkPrc() {
		return markPrc;
	}

	public void setMarkPrc(String markPrc) {
		this.markPrc = markPrc;
	}

	public String getMarkSn() {
		return markSn;
	}

	public void setMarkSn(String markSn) {
		this.markSn = markSn;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getOrderLineId() {
		return orderLineId;
	}

	public void setOrderLineId(String orderLineId) {
		this.orderLineId = orderLineId;
	}
}
