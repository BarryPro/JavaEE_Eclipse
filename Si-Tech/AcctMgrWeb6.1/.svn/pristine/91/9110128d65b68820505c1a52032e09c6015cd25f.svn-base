package com.sitech.acctmgr.atom.dto.pay;


import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
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
public class S2309CfmInDTO extends CommonInDTO{

	@ParamDesc(path = "BUSI_INFO.RELPATH", cons = ConsType.CT001, desc = "相对路径加文件名称", len = "100", type = "string", memo = "略")
	private String relPath;
	
	@ParamDesc(path = "BUSI_INFO.DOCUMENT_NAME", cons = ConsType.CT001, desc = "公文名", len = "300", type = "string", memo = "")
	protected String documentName;
	
	@ParamDesc(path = "BUSI_INFO.DOCUMENT_NO", cons = ConsType.CT001, desc = "公文号", len = "14", type = "string", memo = "略")
	protected String documentNo;
	
	@ParamDesc(path = "BUSI_INFO.SEND_DAY", cons = ConsType.CT001, desc = "赠费日", len = "14", type = "string", memo = "略")
	protected String sendDay;
	
	@ParamDesc(path = "BUSI_INFO.SUM_FEE", cons = ConsType.CT001, desc = "充值总金额", len = "2", type = "Long", memo = "")
	protected long sumFee;
	
	@ParamDesc(path = "BUSI_INFO.SUM_NUM", cons = ConsType.CT001, desc = "充值总用户数", len = "2", type = "Long", memo = "")
	protected long sumNum;
	
	@ParamDesc(path = "BUSI_INFO.BACK_RULE", cons = ConsType.CT001, desc = "返费规则", len = "10", type = "string", memo = "")
	protected String backRule;

	@ParamDesc(path = "BUSI_INFO.SHORT_PART1", cons = ConsType.CT001, desc = "短信内容1", len = "100", type = "string", memo = "略")
	protected String shortPart1;
	
	@ParamDesc(path = "BUSI_INFO.SHORT_PART2", cons = ConsType.CT001, desc = "短信内容2", len = "100", type = "string", memo = "略")
	protected String shortPart2;
	
	@ParamDesc(path = "BUSI_INFO.REMARK", cons = ConsType.CT001, desc = "备注", len = "100", type = "string", memo = "略")
	protected String remark;
	
	@ParamDesc(path = "BUSI_INFO.PAY_NOTE", cons = ConsType.CT001, desc = "营销代码", len = "100", type = "string", memo = "略")
	protected String payNote;
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		
		setRelPath(arg0.getStr(getPathByProperName("relPath")));
		setDocumentName(arg0.getStr(getPathByProperName("documentName")));
		setDocumentNo(arg0.getStr(getPathByProperName("documentNo")));
		this.sendDay = arg0.getStr(getPathByProperName("sendDay"));
		setSumFee(Long.parseLong(arg0.getStr(getPathByProperName("sumFee"))));
		setSumNum(Long.parseLong(arg0.getStr(getPathByProperName("sumNum"))));
		setBackRule(arg0.getStr(getPathByProperName("backRule")));
		setShortPart1(arg0.getStr(getPathByProperName("shortPart1")));
		setShortPart2(arg0.getStr(getPathByProperName("shortPart2")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		setPayNote(arg0.getStr(getPathByProperName("payNote")));
	}

	public String getSendDay() {
		return sendDay;
	}

	public void setSendDay(String sendDay) {
		this.sendDay = sendDay;
	}

	public String getRelPath() {
		return relPath;
	}

	public void setRelPath(String relPath) {
		this.relPath = relPath;
	}

	public String getDocumentName() {
		return documentName;
	}

	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	public String getDocumentNo() {
		return documentNo;
	}

	public void setDocumentNo(String documentNo) {
		this.documentNo = documentNo;
	}

	public long getSumFee() {
		return sumFee;
	}

	public void setSumFee(long sumFee) {
		this.sumFee = sumFee;
	}

	public long getSumNum() {
		return sumNum;
	}

	public void setSumNum(long sumNum) {
		this.sumNum = sumNum;
	}

	public String getBackRule() {
		return backRule;
	}

	public void setBackRule(String backRule) {
		this.backRule = backRule;
	}

	public String getShortPart1() {
		return shortPart1;
	}

	public void setShortPart1(String shortPart1) {
		this.shortPart1 = shortPart1;
	}

	public String getShortPart2() {
		return shortPart2;
	}

	public void setShortPart2(String shortPart2) {
		this.shortPart2 = shortPart2;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPayNote() {
		return payNote;
	}

	public void setPayNote(String payNote) {
		this.payNote = payNote;
	}
	

}
