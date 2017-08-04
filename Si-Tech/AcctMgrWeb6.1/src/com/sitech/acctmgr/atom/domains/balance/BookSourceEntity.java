package com.sitech.acctmgr.atom.domains.balance;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 * 
 * @author
 * 
 *         对应bal_booksource_YYYYMM表
 *
 */
@SuppressWarnings("serial")
public class BookSourceEntity implements Serializable
{
	private long sequence;
	private long paySn;

	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(
		path = "CONTRACT_NO",
		cons = ConsType.CT001,
		len = "",
		type = "long",
		desc = "账户号码",
		memo = ""
	)

	private long contractNo;
	private long userNo;
	private long balanceId;

	@JSONField(name = "PAY_TYPE")
	@ParamDesc(
		path = "PAY_TYPE",
		cons = ConsType.CT001,
		len = "",
		type = "string",
		desc = "收入类型",
		memo = ""
	)

	private String payType;

	@JSONField(name = "PAY_FEE")
	@ParamDesc(
		path = "PAY_FEE",
		cons = ConsType.CT001,
		len = "",
		type = "long",
		desc = "费用",
		memo = ""
	)

	private long payFee;
	/**
	 * 0:交纳预存 1:回退预存 2:交纳分月划拨预存 3:回退分月划拨预存 4:退预存 5:转出预存
	 */
	private String status;
	private String groupId;
	private String loginNo;

    private String loginName;
	private String opTime;
	private String effTime;
	private String expTime;

	@JSONField(name = "PAY_ATTR")
	private String payAttr;

	@JSONField(name = "PAY_NAME")

	@ParamDesc(
		path = "PAY_NAME",
		cons = ConsType.CT001,
		len = "",
		type = "string",
		desc = "交费类型",
		memo = ""
	)

	private String payName;

	@JSONField(name = "REMARK")

	@ParamDesc(
		path = "REMARK",
		cons = ConsType.CT001,
		len = "",
		type = "string",
		desc = "备注",
		memo = ""
	)

	private String remark;

	@JSONField(name = "ID_NO")

	@ParamDesc(
		path = "ID_NO",
		cons = ConsType.CT001,
		len = "",
		type = "long",
		desc = "用户id",
		memo = ""
	)
	
	private long idNo;
	
	
	
	public long getIdNo() {
		return idNo;
	}


	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

	public long getSequence()
	{
		return sequence;
	}

	public void setSequence(long sequence)
	{
		this.sequence = sequence;
	}

	public long getPaySn()
	{
		return paySn;
	}

	public void setPaySn(long paySn)
	{
		this.paySn = paySn;
	}

	public long getContractNo()
	{
		return contractNo;
	}

	public void setContractNo(long contractNo)
	{
		this.contractNo = contractNo;
	}

	public long getUserNo()
	{
		return userNo;
	}

	public void setUserNo(long userNo)
	{
		this.userNo = userNo;
	}

	public long getBalanceId()
	{
		return balanceId;
	}

	public void setBalanceId(long balanceId)
	{
		this.balanceId = balanceId;
	}

	public String getPayType()
	{
		return payType;
	}

	public void setPayType(String payType)
	{
		this.payType = payType;
	}

	public long getPayFee()
	{
		return payFee;
	}

	public void setPayFee(long payFee)
	{
		this.payFee = payFee;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getGroupId()
	{
		return groupId;
	}

	public void setGroupId(String groupId)
	{
		this.groupId = groupId;
	}

	public String getLoginNo()
	{
		return loginNo;
	}

	public void setLoginNo(String loginNo)
	{
		this.loginNo = loginNo;
	}

	public String getOpTime()
	{
		return opTime;
	}

	public void setOpTime(String opTime)
	{
		this.opTime = opTime;
	}

	public String getEffTime()
	{
		return effTime;
	}

	public void setEffTime(String effTime)
	{
		this.effTime = effTime;
	}

	public String getExpTime()
	{
		return expTime;
	}

	public void setExpTime(String expTime)
	{
		this.expTime = expTime;
	}

	public String getPayAttr()
	{
		return payAttr;
	}

	public void setPayAttr(String payAttr)
	{
		this.payAttr = payAttr;
	}

	public String getPayName()
	{
		return payName;
	}

	public void setPayName(String payName)
	{
		this.payName = payName;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "BookSourceEntity{" +
				"sequence=" + sequence +
				", paySn=" + paySn +
				", contractNo=" + contractNo +
				", userNo=" + userNo +
				", balanceId=" + balanceId +
				", payType='" + payType + '\'' +
				", payFee=" + payFee +
				", status='" + status + '\'' +
				", groupId='" + groupId + '\'' +
				", loginNo='" + loginNo + '\'' +
				", loginName='" + loginName + '\'' +
				", opTime='" + opTime + '\'' +
				", effTime='" + effTime + '\'' +
				", expTime='" + expTime + '\'' +
				", payAttr='" + payAttr + '\'' +
				", payName='" + payName + '\'' +
				", remark='" + remark + '\'' +
				", idNo=" + idNo +
				'}';
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (sequence ^ (sequence >>> 32));
		return result;
	}

	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookSourceEntity other = (BookSourceEntity) obj;
		if (sequence != other.sequence)
			return false;
		return true;
	}

}
