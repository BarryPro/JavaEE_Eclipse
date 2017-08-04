package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 第三方缴费签约关系设置签约入参DTO  </p>
 * <p>Description: 		  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8297SignInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.BUSI_TYPE",cons=ConsType.CT001,type="String",len="5",desc="业务类型",memo="业务类型：1001:手机支付自动缴话费签约关系.  1002:银行卡自动缴话费签约关系(联动优势).1003:支付宝签约关系")
	private String busiType;
	
	@ParamDesc(path="BUSI_INFO.SIGN_SN",cons=ConsType.CT001,type="String",len="40",desc="签约流水",memo="略")
	private String signSn;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_TIME",cons=ConsType.QUES,type="String",len="14",desc="签约时间",memo="外部签约时间，可空，格式为YYYYMMDDHHMISS")
	private String signTime;//外部缴费时间，可空，格式为YYYYMMDDHHMISS
	
	@ParamDesc(path="BUSI_INFO.SIGN_FIELD",cons=ConsType.PLUS,type="complex",len="1",desc="签约属性",memo="不同签约类型传入不容的属性编码和属性值")
	private	List<FieldEntity> signFieldList = new ArrayList<FieldEntity>();

	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.QUES,type="String",len="100",desc="备注",memo="略")
	private String opNote;
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setBusiType(arg0.getStr(getPathByProperName("busiType")));
		setSignSn(arg0.getStr(getPathByProperName("signSn")));
		setSignTime(arg0.getStr(getPathByProperName("signTime")));
		
		List<Map<String, Object>> signFieldList = (List<Map<String, Object>>)arg0.getList(getPathByProperName("signFieldList"));
		for(Map<String, Object> payTmp : signFieldList){
    		String jsonStr = JSON.toJSONString(payTmp);
    		this.signFieldList.add(JSON.parseObject(jsonStr, FieldEntity.class));
		}
		
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
		
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
	 * @return the busiType
	 */
	public String getBusiType() {
		return busiType;
	}

	/**
	 * @param busiType the busiType to set
	 */
	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}

	/**
	 * @return the signSn
	 */
	public String getSignSn() {
		return signSn;
	}

	/**
	 * @param signSn the signSn to set
	 */
	public void setSignSn(String signSn) {
		this.signSn = signSn;
	}

	/**
	 * @return the signTime
	 */
	public String getSignTime() {
		return signTime;
	}

	/**
	 * @param signTime the signTime to set
	 */
	public void setSignTime(String signTime) {
		this.signTime = signTime;
	}

	/**
	 * @return the signFieldList
	 */
	public List<FieldEntity> getSignFieldList() {
		return signFieldList;
	}

	/**
	 * @param signFieldList the signFieldList to set
	 */
	public void setSignFieldList(List<FieldEntity> signFieldList) {
		this.signFieldList = signFieldList;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}
