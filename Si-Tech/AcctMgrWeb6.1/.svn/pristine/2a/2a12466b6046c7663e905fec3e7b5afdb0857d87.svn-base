package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
*
* <p>Title: 飞豆充值验证入参DTO  </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public class SFeiDouPayCheckInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -803390055220685319L;

	@ParamDesc(path="BUSI_INFO.OPT_SEQ",cons=ConsType.CT001,type="String",len="32",desc="操作流水",memo="略")
    private String optSeq;

    @ParamDesc(path="BUSI_INFO.BUSS_TYPE",cons=ConsType.CT001,type="String",len="6",desc="交易类型",memo="略")
    private String bussType;

    @ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="手机号码",memo="略")
    private String phoneNo;

    @ParamDesc(path="BUSI_INFO.SYSPLAT_ID",cons=ConsType.CT001,type="String",len="4",desc="平台标识号",memo="平台标识号 1-飞信 2-139邮箱 3-MM")
    private String sysplatId;
    
    @ParamDesc(path="BUSI_INFO.PROVINCE",cons=ConsType.CT001,type="String",len="4",desc="用户归属机构",memo="略")
    private String province;

    @ParamDesc(path="BUSI_INFO.SESSION_ID",cons=ConsType.QUES,type="String",len="32",desc="集团报文头业务流水号",memo="略")
    private String sessionId;

    @ParamDesc(path="BUSI_INFO.REQ_DATE",cons=ConsType.CT001,type="String",len="14",desc="请求时间",memo="请求时间格式：YYYYMMDDHH24MISS")
    private String reqDate;

    @ParamDesc(path="BUSI_INFO.SERV_ID",cons=ConsType.CT001,type="long",len="20",desc="用户标识",memo="略")
    private long servId;

    @ParamDesc(path="BUSI_INFO.PAY_ACCID",cons=ConsType.CT001,type="long",len="20",desc="支付帐户标识",memo="略")
    private long payAccid;

    @ParamDesc(path="BUSI_INFO.UNIT",cons=ConsType.CT001,type="int",len="4",desc="货币单位",memo="单位 0:人民币")
    private int unit;

    @ParamDesc(path="BUSI_INFO.CHARGE_SUM",cons=ConsType.CT001,type="long",len="14",desc="充值金额",memo="单位：分")
    private long chargeSum;
    

    /* (non-Javadoc)
     * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
    */
    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);

        setOptSeq(arg0.getStr(getPathByProperName("optSeq")));
        setBussType(arg0.getStr(getPathByProperName("bussType")));
        setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
        setSysplatId(arg0.getStr(getPathByProperName("sysplatId")));
        setProvince(arg0.getStr(getPathByProperName("province")));
        setSessionId(arg0.getStr(getPathByProperName("sessionId")));
        setReqDate(arg0.getStr(getPathByProperName("reqDate")));
        if(StringUtils.isNotEmpty(getPathByProperName("servId"))){
        	setServId(Long.parseLong(arg0.getObject(getPathByProperName("servId")).toString()));
        }
        if(StringUtils.isNotEmpty(getPathByProperName("payAccid"))){
        	setPayAccid(Long.parseLong(arg0.getObject(getPathByProperName("payAccid")).toString()));
        }
        if(StringUtils.isNotEmpty(getPathByProperName("unit"))){
        	setUnit(Integer.parseInt(arg0.getObject(getPathByProperName("unit")).toString()));
        }
        if(StringUtils.isNotEmpty(getPathByProperName("chargeSum"))){
        	setChargeSum(Long.parseLong(arg0.getObject(getPathByProperName("chargeSum")).toString()));
        }
        
    }

	public String getOptSeq() {
		return optSeq;
	}

	public void setOptSeq(String optSeq) {
		this.optSeq = optSeq;
	}

	/**
	 * @return the bussType
	 */
	public String getBussType() {
		return bussType;
	}

	/**
	 * @param bussType the bussType to set
	 */
	public void setBussType(String bussType) {
		this.bussType = bussType;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getSysplatId() {
		return sysplatId;
	}

	public void setSysplatId(String sysplatId) {
		this.sysplatId = sysplatId;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getReqDate() {
		return reqDate;
	}

	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	public long getServId() {
		return servId;
	}

	public void setServId(long servId) {
		this.servId = servId;
	}

	public long getPayAccid() {
		return payAccid;
	}

	public void setPayAccid(long payAccid) {
		this.payAccid = payAccid;
	}

	public long getChargeSum() {
		return chargeSum;
	}

	public int getUnit() {
		return unit;
	}

	public void setUnit(int unit) {
		this.unit = unit;
	}

	public void setChargeSum(long chargeSum) {
		this.chargeSum = chargeSum;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

}