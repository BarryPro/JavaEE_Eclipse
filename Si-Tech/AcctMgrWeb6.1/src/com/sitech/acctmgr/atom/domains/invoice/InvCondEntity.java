package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@SuppressWarnings("serial")
public class InvCondEntity implements Serializable {

	/**
	 * 
	 */
	public InvCondEntity() {
		// TODO Auto-generated constructor stub
	}
	
	public static InvCondEntity  getInstanse(){
		return new InvCondEntity();
	}
	
	@JSONField(name="INV_MON")
	@ParamDesc(path="INV_MON",cons=ConsType.QUES,type="int",len="10",desc="查询月份",memo="略")
	private int invMon;
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.QUES,type="long",len="20",desc="账户号",memo="略")
	private long contractNo;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号",memo="略")
	private String phoneNo;
	
	@JSONField(name="OWE_FEE")
	@ParamDesc(path="OWE_FEE",cons=ConsType.QUES,type="long",len="10",desc="费用",memo="略")
	private long oweFee;
	
	@JSONField(name="PAY_SN")
	@ParamDesc(path="PAY_SN",cons=ConsType.QUES,type="long",len="20",desc="缴费流水",memo="略")
	private long paySn;
	
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.QUES,type="long",len="20",desc="用户ID",memo="略")
	private long idNo;
	
	
	
	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public long getPaySn() {
		return paySn;
	}

	public void setPaySn(long paySn) {
		this.paySn = paySn;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getOweFee() {
		return oweFee;
	}

	public void setOweFee(long oweFee) {
		this.oweFee = oweFee;
	}

	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}

	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public int getInvMon() {
		return invMon;
	}

	public void setInvMon(int invMon) {
		this.invMon = invMon;
	}

	@Override
	public String toString() {
		return "InvCondEntity [invMon=" + invMon + ", contractNo=" + contractNo
				+ ", phoneNo=" + phoneNo + ", oweFee=" + oweFee + ", paySn="
				+ paySn + ", idNo=" + idNo + "]";
	}

	
	
	
}
