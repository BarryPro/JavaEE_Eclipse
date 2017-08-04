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
public class InvPayInfoEntity implements Serializable{

	/**
	 * 
	 */
	public InvPayInfoEntity() {
		// TODO Auto-generated constructor stub
	}
	
	//账期
	@JSONField(name="BILL_CYCLE")
	@ParamDesc(path="BILL_CYCLE",cons=ConsType.CT001,type="int",len="10",desc="账期月",memo="略")
	private int billCycle;
	
	//账户姓名
	@JSONField(name="CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="账户姓名",memo="略")
	private String contractName;
	
	//账户号
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="20",desc="账户号",memo="略")
	private long contractNo;
	
	//用户ID
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="20",desc="用户ID",memo="略")
	private long idNo;
	
	
	
	//缴费日期
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="int",len="10",desc="缴费日期",memo="略")
	private int totalDate;
	
	//缴费金额
		@JSONField(name="PAY_FEE")
		@ParamDesc(path="PAY_FEE",cons=ConsType.QUES,type="long",len="10",desc="缴费金额",memo="单位是：分")
		private long payFee;
			
		//缴费流水
		@JSONField(name="PAY_SN")
		@ParamDesc(path="PAY_SN",cons=ConsType.QUES,type="long",len="20",desc="缴费流水",memo="略")
		private long paySn;
			
		//缴费时间
		@JSONField(name="PAY_TIME")
		@ParamDesc(path="PAY_TIME",cons=ConsType.QUES,type="String",len="20",desc="缴费时间",memo="略")
		private String payTime;
		
		//打印标志
		@JSONField(name="PRINT_FLAG")
		@ParamDesc(path="PRINT_FLAG",cons=ConsType.QUES,type="int",len="3",desc="打印标志",memo="0:未打印发票,1:打印月结发票,2:打印预存发票,3:打印增值税转票")
		private int printFlag;
		
		//打印标志
		@JSONField(name="PAY_METHOD")
		@ParamDesc(path="PAY_METHOD",cons=ConsType.QUES,type="String",len="50",desc="缴费方式",memo="")
		private String payMethod;
		
		
		public String getPayMethod() {
			return payMethod;
		}

		public void setPayMethod(String payMethod) {
			this.payMethod = payMethod;
		}

		public long getPayFee() {
			return payFee;
		}

		public void setPayFee(long payFee) {
			this.payFee = payFee;
		}

		public long getPaySn() {
			return paySn;
		}

		public void setPaySn(long paySn) {
			this.paySn = paySn;
		}

		public String getPayTime() {
			return payTime;
		}

		public void setPayTime(String payTime) {
			this.payTime = payTime;
		}

		public int getPrintFlag() {
			return printFlag;
		}

		public void setPrintFlag(int printFlag) {
			this.printFlag = printFlag;
		}

	public int getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(int billCycle) {
		this.billCycle = billCycle;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}


	public int getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "InvPayInfoEntity [billCycle=" + billCycle + ", contractName="
				+ contractName + ", contractNo=" + contractNo + ", idNo="
				+ idNo + ", totalDate=" + totalDate + ", payFee=" + payFee
				+ ", paySn=" + paySn + ", payTime=" + payTime + ", printFlag="
				+ printFlag + "]";
	}

	
	
	
}
