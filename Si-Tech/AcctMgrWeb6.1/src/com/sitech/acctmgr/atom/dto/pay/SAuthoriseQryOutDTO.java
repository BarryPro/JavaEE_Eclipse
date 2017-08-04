package com.sitech.acctmgr.atom.dto.pay;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 退预存款  </p>
 * <p>Description:  将String入参解析成MBean格式 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class SAuthoriseQryOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5670498975685900472L;

	@JSONField(name="AUTHER_FLAG")
	@ParamDesc(path="AUTHER_FLAG",cons=ConsType.CT001,type="string",len="1",desc="是否调用审批接口",memo="1-调用，0-不调用")
	protected String autherFlag;
	
	@JSONField(name="APPROVE_STATUS")
	@ParamDesc(path="APPROVE_STATUS",cons=ConsType.CT001,type="string",len="1",desc="审批状态",memo="APPROVE_STATUS  空表示没有申请单 2表示审批中  3 表示审批通过 5 表示申请单被驳回")
	protected String approveStatus;
	@JSONField(name="APPROVE_FLAG")
	@ParamDesc(path="APPROVE_FLAG",cons=ConsType.CT001,type="string",len="1",desc="审批标识",memo="0-需要审批  1-不需要审批")
	protected String approveFlag;
	@JSONField(name="APPLY_ID")
	@ParamDesc(path="APPLY_ID",cons=ConsType.CT001,type="string",len="20",desc="申请单号",memo="略")
	protected String apply_Id;
	@JSONField(name="FLOW_ID")
	@ParamDesc(path="FLOW_ID",cons=ConsType.CT001,type="string",len="20",desc="审批流程编号",memo="略")
	protected String flowId;
	@JSONField(name="APPBUSI_CODE")
	@ParamDesc(path="APPBUSI_CODE",cons=ConsType.CT001,type="string",len="18",desc="业务级别授权审批时传对应的业务编号",memo="略")
	protected String appbusiCode;
	@JSONField(name="FUNCTION_CODE")
	@ParamDesc(path="FUNCTION_CODE",cons=ConsType.CT001,type="string",len="4",desc="功能OPCODE",memo="略")
	protected String functionCode;
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="string",len="14",desc="服务号码",memo="略")
	protected String phoneNo;	
	@JSONField(name="APPLY_LOGIN")
	@ParamDesc(path="APPLY_LOGIN",cons=ConsType.CT001,type="string",len="10",desc="申请工号",memo="略")
	protected String applyLogin;	
	@JSONField(name="GROUP_ID")
	@ParamDesc(path="GROUP_ID",cons=ConsType.CT001,type="string",len="10",desc="申请工号所在营业厅编码",memo="略")
	protected String groupId;	
	@JSONField(name="APPLY_CONTENT") 
	@ParamDesc(path="APPLY_CONTENT",cons=ConsType.CT001,type="string",len="4098",desc="BLOB压缩报文",memo="略")
	protected String applyContent;	
	 
 
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("autherFlag"), autherFlag);
		result.setRoot(getPathByProperName("approveStatus"), approveStatus);
		result.setRoot(getPathByProperName("approveFlag"), approveFlag);
		result.setRoot(getPathByProperName("apply_Id"), apply_Id);
		result.setRoot(getPathByProperName("flowId"), flowId);
		result.setRoot(getPathByProperName("appbusiCode"), appbusiCode);
		result.setRoot(getPathByProperName("functionCode"), functionCode);
		result.setRoot(getPathByProperName("phoneNo"), phoneNo);
		result.setRoot(getPathByProperName("applyLogin"), applyLogin);
		result.setRoot(getPathByProperName("groupId"), groupId);
		result.setRoot(getPathByProperName("applyContent"), applyContent);
		return result;		
	}


	/**
	 * @return the approveFlag
	 */
	public String getApproveFlag() {
		return approveFlag;
	}


	/**
	 * @param approveFlag the approveFlag to set
	 */
	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}


	/**
	 * @return the approveStatus
	 */
	public String getApproveStatus() {
		return approveStatus;
	}


	/**
	 * @param approveStatus the approveStatus to set
	 */
	public void setApproveStatus(String approveStatus) {
		this.approveStatus = approveStatus;
	}


	/**
	 * @return the apply_Id
	 */
	public String getApply_Id() {
		return apply_Id;
	}


	/**
	 * @param apply_Id the apply_Id to set
	 */
	public void setApply_Id(String apply_Id) {
		this.apply_Id = apply_Id;
	}


	/**
	 * @return the flowId
	 */
	public String getFlowId() {
		return flowId;
	}


	/**
	 * @param flowId the flowId to set
	 */
	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}


	/**
	 * @return the appbusiCode
	 */
	public String getAppbusiCode() {
		return appbusiCode;
	}


	/**
	 * @param appbusiCode the appbusiCode to set
	 */
	public void setAppbusiCode(String appbusiCode) {
		this.appbusiCode = appbusiCode;
	}


	/**
	 * @return the functionCode
	 */
	public String getFunctionCode() {
		return functionCode;
	}


	/**
	 * @param functionCode the functionCode to set
	 */
	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode;
	}


	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}


	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	/**
	 * @return the applyLogin
	 */
	public String getApplyLogin() {
		return applyLogin;
	}


	/**
	 * @param applyLogin the applyLogin to set
	 */
	public void setApplyLogin(String applyLogin) {
		this.applyLogin = applyLogin;
	}


	/**
	 * @return the groupId
	 */
	public String getGroupId() {
		return groupId;
	}


	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}


	/**
	 * @return the applyContent
	 */
	public String getApplyContent() {
		return applyContent;
	}


	/**
	 * @param applyContent the applyContent to set
	 */
	public void setApplyContent(String applyContent) {
		this.applyContent = applyContent;
	}


	/**
	 * @return the autherFlag
	 */
	public String getAutherFlag() {
		return autherFlag;
	}


	/**
	 * @param autherFlag the autherFlag to set
	 */
	public void setAutherFlag(String autherFlag) {
		this.autherFlag = autherFlag;
	}

 
}
