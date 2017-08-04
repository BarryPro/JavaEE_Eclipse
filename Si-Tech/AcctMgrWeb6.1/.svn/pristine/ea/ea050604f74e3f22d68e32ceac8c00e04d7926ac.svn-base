package com.sitech.acctmgr.atom.dto.invoice.eleInvoice;
 
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * @author liuhl_bj
 *
 */
public class SEleInvoicePushInDTO extends CommonInDTO {

    
	private static final long serialVersionUID = 1L;

	@ParamDesc(path = "BUSI_INFO.CHN_SOURCE", cons = ConsType.CT001, type = "string", len = "", desc = "渠道标识", memo = "略")
	private String chnSource;
	
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.CT001, type = "string", len = "", desc = "服务号码", memo = "略")
	private String phoneNo;

	@ParamDesc(path = "BUSI_INFO.OP_NOTE", cons = ConsType.CT001, type = "string", len = "", desc = "操作备注", memo = "略")
	private String opNote;

	@ParamDesc(path = "BUSI_INFO.OP_TIME", cons = ConsType.CT001, type = "string", len = "", desc = "操作时间", memo = "略")
	private String opTime;

	@ParamDesc(path = "BUSI_INFO.INV_CODE", cons = ConsType.CT001, type = "string", len = "", desc = "发票代码", memo = "略")
	private String invCode;

	@ParamDesc(path = "BUSI_INFO.INV_NO", cons = ConsType.CT001, type = "string", len = "", desc = "发票号码", memo = "略")
	private String invNo;

	@ParamDesc(path = "BUSI_INFO.REQUEST_SN", cons = ConsType.CT001, type = "string", len = "", desc = "发票请求流水", memo = "略")
	private String requestSn;

	@ParamDesc(path = "BUSI_INFO.REPORT_TIME", cons = ConsType.CT001, type = "string", len = "", desc = "开具时间", memo = "YYYYMMDD")
	private String reportTime;

	@ParamDesc(path = "BUSI_INFO.PUSH_TYPE", cons = ConsType.CT001, type = "string", len = "", desc = "推送方式", memo = "略")
	private String pushType;


    @Override
    public void decode(MBean arg0) {
        super.decode(arg0);
		chnSource = arg0.getStr(getPathByProperName("chnSource"));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		opNote = arg0.getStr(getPathByProperName("opNote"));
		opTime=arg0.getStr(getPathByProperName("opTime"));
		invCode = arg0.getStr(getPathByProperName("invCode"));
		invNo = arg0.getStr(getPathByProperName("invNo"));
		requestSn = arg0.getStr(getPathByProperName("requestSn"));
		reportTime = arg0.getStr(getPathByProperName("reportTime"));
		pushType = arg0.getStr(getPathByProperName("pushType"));
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

	public String getChnSource() {
		return chnSource;
	}

	public void setChnSource(String chnSource) {
		this.chnSource = chnSource;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getInvCode() {
		return invCode;
	}

	public void setInvCode(String invCode) {
		this.invCode = invCode;
	}

	public String getInvNo() {
		return invNo;
	}

	public void setInvNo(String invNo) {
		this.invNo = invNo;
	}

	public String getRequestSn() {
		return requestSn;
	}

	public void setRequestSn(String requestSn) {
		this.requestSn = requestSn;
	}

	public String getReportTime() {
		return reportTime;
	}

	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}

	public String getPushType() {
		return pushType;
	}

	public void setPushType(String pushType) {
		this.pushType = pushType;
	}
    
}
