package com.sitech.acctmgr.atom.dto.adj;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   补收确认入参DTO</p>
 * <p>Description:   对缴费确认入参进行解析成MBean，并检验入参的正确性</p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8010CfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = -456306388359625935L;


	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long contractNo;
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.QUES,type="String",len="1024",desc="备注",memo="略")
	protected String remark ;
	@ParamDesc(path="BUSI_INFO.BILL_MONTH",cons=ConsType.CT001,type="String",len="6",desc="补收年月",memo="略")
	protected String billMonth;
	@ParamDesc(path="BUSI_INFO.TOTAL_PAY",cons=ConsType.CT001,type="long",len="14",desc="补收金额",memo="略")
	protected long inTotalPay;
	@ParamDesc(path="BUSI_INFO.PAY_DETAIL",cons=ConsType.CT001,type="String",len="1024",desc="补收账目项窜",memo="略")
	protected String payDetail;
	@ParamDesc(path="BUSI_INFO.DEAL_TYPE",cons=ConsType.CT001,type="String",len="40",desc="送费类型",memo="略")
	protected String dealType;
	@ParamDesc(path="BUSI_INFO.BALANCE_TYPE",cons=ConsType.CT001,type="String",len="40",desc="送费明细",memo="略")
	protected String balanceType;
	
 
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		setBillMonth(arg0.getStr(getPathByProperName("billMonth")));
		setRemark(arg0.getStr(getPathByProperName("remark")));
		setPayDetail(arg0.getStr(getPathByProperName("payDetail")));
		setDealType(arg0.getStr(getPathByProperName("dealType")));
		setBalanceType(arg0.getStr(getPathByProperName("balanceType")));
		setInTotalPay(Long.parseLong(arg0.getObject(getPathByProperName("inTotalPay")).toString()));
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8010";
		}
		findSameAcctItem(getPayDetail());
	}
	
	
	//验证是否有相同的补收账目项
	public void findSameAcctItem(String payAcctItemDetail){
		
		List list=new ArrayList();
		int detailLen = payAcctItemDetail.trim().length(); // 获取字符串长度

		// 字符串格式验证
		if ("#".equals(payAcctItemDetail.substring(detailLen - 1))) {
		
				// 字符串拆分
				String[] arrayDetail = StringUtils.split(payAcctItemDetail, "#");

				for (int i = 0; i < arrayDetail.length; i++) {

					if (-1 == arrayDetail[i].indexOf("|")) {
						break;
					}

					String[] feeDetail = StringUtils.split(arrayDetail[i], "|");

					if (2 != feeDetail.length) {
						break;
					}

					String acctItemCode = feeDetail[0]; // 账目项
					list.add(acctItemCode);
				}
		}

	

		for (int i = 0; i < list.size();i++) {
				int beginIndex=list.indexOf(list.get(i));
				int endIndex=list.lastIndexOf(list.get(i));
				if (beginIndex != endIndex) {
					 throw new BaseException(AcctMgrError.getErrorCode("8010", "00007"),"不能补收相同账目项！");
			}
		}
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


	/**
	 * @return the remark
	 */

	public String getRemark() {
		return remark;
	}


	/**
	 * @param remark the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}


	/**
	 * @return the billMonth
	 */
	public String getBillMonth() {
		return billMonth;
	}


	/**
	 * @param billMonth the billMonth to set
	 */
	public void setBillMonth(String billMonth) {
		this.billMonth = billMonth;
	}


	/**
	 * @return the inTotalPay
	 */
	public long getInTotalPay() {
		return inTotalPay;
	}


	/**
	 * @param inTotalPay the inTotalPay to set
	 */
	public void setInTotalPay(long inTotalPay) {
		this.inTotalPay = inTotalPay;
	}


	/**
	 * @return the payDetail
	 */
	public String getPayDetail() {
		return payDetail;
	}


	/**
	 * @param payDetail the payDetail to set
	 */
	public void setPayDetail(String payDetail) {
		this.payDetail = payDetail;
	}
 
	public String getDealType() {
		return dealType;
	}


	public void setDealType(String dealType) {
		this.dealType = dealType;
	}


	public String getBalanceType() {
		return balanceType;
	}


	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}



	 
	
}
