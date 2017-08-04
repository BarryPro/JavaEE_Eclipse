package com.sitech.acctmgr.atom.domains.collection;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 托收单展示实体 Created by wangyla on 2016/7/5.
 */
public class CollectionDispEntity implements Serializable {
    private static final long serialVersionUID = -1L;

    @JSONField(name = "BILL_CYCLE")
	@ParamDesc(path = "BILL_CYCLE", cons = ConsType.CT001, len = "6", desc = "托收帐期", type = "int", memo = "略")
    private int billCycle;

    @JSONField(name = "BEGIN_YMD")
	@ParamDesc(path = "BEGIN_YMD", cons = ConsType.CT001, len = "6", desc = "帐期开始日", type = "string", memo = "略")
	private String beginYmd;

    @JSONField(name = "END_YMD")
	@ParamDesc(path = "END_YMD", cons = ConsType.CT001, len = "6", desc = "帐期结束日", type = "string", memo = "略")
	private String endYmd;

    @JSONField(name = "CONTRACT_NO")
	@ParamDesc(path = "CONTRACT_NO", cons = ConsType.CT001, len = "18", desc = "帐户号码", type = "long", memo = "略")
	private long contractNo;

    @JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path = "CONTRACT_NAME", cons = ConsType.CT001, len = "100", desc = "帐户名称", type = "string", memo = "略")
    private String contractName;

    @JSONField(name = "PAYEE_CONTRACT_NAME")
	@ParamDesc(path = "PAYEE_CONTRACT_NAME", cons = ConsType.CT001, len = "100", desc = "收款人帐户名称", type = "string", memo = "略")
    private String payeeContractName;

    @JSONField(name = "PRINT_NO")
	@ParamDesc(path = "PRINT_NO", cons = ConsType.CT001, len = "5", desc = "打印单号", type = "int", memo = "略")
    private int printNo;

    @JSONField(name = "PRINT_DATE")
	@ParamDesc(path = "PRINT_DATE", cons = ConsType.CT001, len = "8", desc = "打印日期", type = "string", memo = "略")
    private String printDate;

    @JSONField(name = "ACCOUNT_NO")
	@ParamDesc(path = "ACCOUNT_NO", cons = ConsType.CT001, len = "100", desc = "托收银行帐户", type = "string", memo = "略")
    private String accountNo;

    @JSONField(name = "PAYEE_ACCOUNT_NO")
	@ParamDesc(path = "PAYEE_ACCOUNT_NO", cons = ConsType.CT001, len = "100", desc = "收款人银行帐户", type = "string", memo = "略")
    private String PayeeAccountNo;

    @JSONField(name = "BANK_CODE")
	@ParamDesc(path = "BANK_CODE", cons = ConsType.CT001, len = "12", desc = "银行代码", type = "string", memo = "略")
    private String bankCode;

    @JSONField(name = "BANK_NAME")
	@ParamDesc(path = "BANK_NAME", cons = ConsType.CT001, len = "100", desc = "银行名称", type = "string", memo = "略")
    private String bankName;

    @JSONField(name = "PAYEE_BANK_NAME")
	@ParamDesc(path = "PAYEE_BANK_NAME", cons = ConsType.CT001, len = "60", desc = "收款人银行名称", type = "string", memo = "略")
    private String payeeBankName;

    @JSONField(name = "PHONE_NO")
	@ParamDesc(path = "PHONE_NO", cons = ConsType.CT001, len = "40", desc = "服务号码", type = "string", memo = "略")
    String phoneNo;

    @JSONField(name = "PAY_FEE")
	@ParamDesc(path = "PAY_FEE", cons = ConsType.CT001, len = "14", desc = "托收费用", type = "long", memo = "略")
    private long payFee;

    @JSONField(name = "MEAL_FEE")
	@ParamDesc(path = "MEAL_FEE", cons = ConsType.CT001, len = "14", desc = "月租费", type = "long", memo = "略")
    private long mealFee;

    @JSONField(name = "SPE_FEE")
	@ParamDesc(path = "SPE_FEE", cons = ConsType.CT001, len = "14", desc = "特服费", type = "long", memo = "略")
    private long specFee;

    @JSONField(name = "LOCAL_CALL_FEE")
	@ParamDesc(path = "LOCAL_CALL_FEE", cons = ConsType.CT001, len = "14", desc = "市话费", type = "long", memo = "略")
    private long localCallFee;

    @JSONField(name = "LONGDIS_FEE")
	@ParamDesc(path = "LONGDIS_FEE", cons = ConsType.CT001, len = "14", desc = "长途费", type = "long", memo = "略")
    private long longDisFee;

    @JSONField(name = "ROAM_FEE")
	@ParamDesc(path = "ROAM_FEE", cons = ConsType.CT001, len = "14", desc = "漫游费", type = "long", memo = "略")
    private long roamFee;

    @JSONField(name = "MSG_FEE")
	@ParamDesc(path = "MSG_FEE", cons = ConsType.CT001, len = "14", desc = "信息费", type = "long", memo = "略")
    private long msgFee;

    @JSONField(name = "IP_FEE")
	@ParamDesc(path = "IP_FEE", cons = ConsType.CT001, len = "14", desc = "IP话费", type = "long", memo = "略")
    private long ipFee;

    @JSONField(name = "PZ_FEE")
	@ParamDesc(path = "PZ_FEE", cons = ConsType.CT001, len = "14", desc = "频占费", type = "long", memo = "略")
    private long pzFee;

    @JSONField(name = "OTHER_FEE")
	@ParamDesc(path = "OTHER_FEE", cons = ConsType.CT001, len = "14", desc = "其他费", type = "long", memo = "略")
    private long otherFee;

    @JSONField(name = "VIDEO_PHONE_FEE")
	@ParamDesc(path = "VIDEO_PHONE_FEE", cons = ConsType.CT001, len = "14", desc = "可视电话费", type = "long", memo = "略")
    private long videoPhoneFee = 0;

	@JSONField(name = "FEE11")
	@ParamDesc(path = "FEE11", cons = ConsType.CT001, len = "14", desc = "预存划拨", type = "long", memo = "略")
	private long fee11 = 2222;

    @JSONField(name = "PRINT_TIMES")
	@ParamDesc(path = "PRINT_TIMES", cons = ConsType.QUES, len = "2", desc = "打印次数", type = "int", memo = "")
    private int printTimes;

    @JSONField(name = "PRINT_FLAG")
	@ParamDesc(path = "PRINT_FLAG", cons = ConsType.QUES, len = "2", desc = "打印标志", type = "int", memo = "")
    private int printFlag;
    
	@JSONField(name = "BIG_MONEY")
	@ParamDesc(path = "BIG_MONEY", cons = ConsType.QUES, len = "2", desc = "大写", type = "int", memo = "")
	private String bigMoney;

	@JSONField(name = "PAY_NUM")
	@ParamDesc(path = "PAY_NUM", cons = ConsType.QUES, len = "2", desc = "托收数量", type = "int", memo = "")
	private long payNum;

	public long getFee11() {
		return fee11;
	}

	public void setFee11(long fee11) {
		this.fee11 = fee11;
	}

	public long getPayNum() {
		return payNum;
	}

	public void setPayNum(long payNum) {
		this.payNum = payNum;
	}

	public String getBigMoney() {
		return bigMoney;
	}

	public void setBigMoney(String bigMoney) {
		this.bigMoney = bigMoney;
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

    public String getBeginYmd() {
        return beginYmd;
    }

    public void setBeginYmd(String beginYmd) {
        this.beginYmd = beginYmd;
    }

    public String getEndYmd() {
        return endYmd;
    }

    public void setEndYmd(String endYmd) {
        this.endYmd = endYmd;
    }

    public long getContractNo() {
        return contractNo;
    }

    public void setContractNo(long contractNo) {
        this.contractNo = contractNo;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public String getPayeeContractName() {
        return payeeContractName;
    }

    public void setPayeeContractName(String payeeContractName) {
        this.payeeContractName = payeeContractName;
    }

    public int getPrintNo() {
        return printNo;
    }

    public void setPrintNo(int printNo) {
        this.printNo = printNo;
    }

    public String getPrintDate() {
        return printDate;
    }

    public void setPrintDate(String printDate) {
        this.printDate = printDate;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getPayeeAccountNo() {
        return PayeeAccountNo;
    }

    public void setPayeeAccountNo(String payeeAccountNo) {
        PayeeAccountNo = payeeAccountNo;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getPayeeBankName() {
        return payeeBankName;
    }

    public void setPayeeBankName(String payeeBankName) {
        this.payeeBankName = payeeBankName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public long getPayFee() {
        return payFee;
    }

    public void setPayFee(long payFee) {
        this.payFee = payFee;
    }

    public long getMealFee() {
        return mealFee;
    }

    public void setMealFee(long mealFee) {
        this.mealFee = mealFee;
    }

    public long getSpecFee() {
        return specFee;
    }

    public void setSpecFee(long specFee) {
        this.specFee = specFee;
    }

    public long getLocalCallFee() {
        return localCallFee;
    }

    public void setLocalCallFee(long localCallFee) {
        this.localCallFee = localCallFee;
    }

    public long getLongDisFee() {
        return longDisFee;
    }

    public void setLongDisFee(long longDisFee) {
        this.longDisFee = longDisFee;
    }

    public long getRoamFee() {
        return roamFee;
    }

    public void setRoamFee(long roamFee) {
        this.roamFee = roamFee;
    }

    public long getMsgFee() {
        return msgFee;
    }

    public void setMsgFee(long msgFee) {
        this.msgFee = msgFee;
    }

    public long getIpFee() {
        return ipFee;
    }

    public void setIpFee(long ipFee) {
        this.ipFee = ipFee;
    }

    public long getPzFee() {
        return pzFee;
    }

    public void setPzFee(long pzFee) {
        this.pzFee = pzFee;
    }

    public long getOtherFee() {
        return otherFee;
    }

    public void setOtherFee(long otherFee) {
        this.otherFee = otherFee;
    }

    public long getVideoPhoneFee() {
        return videoPhoneFee;
    }

    public void setVideoPhoneFee(long videoPhoneFee) {
        this.videoPhoneFee = videoPhoneFee;
    }

    public int getPrintTimes() {
        return printTimes;
    }

    public void setPrintTimes(int printTimes) {
        this.printTimes = printTimes;
    }

    @Override
    public String toString() {
        return "CollectionDispEntity{" +
                "billCycle=" + billCycle +
                ", beginYmd='" + beginYmd + '\'' +
                ", endYmd='" + endYmd + '\'' +
                ", contractNo=" + contractNo +
                ", contractName='" + contractName + '\'' +
                ", payeeContractName='" + payeeContractName + '\'' +
                ", printNo=" + printNo +
                ", printDate='" + printDate + '\'' +
                ", accountNo='" + accountNo + '\'' +
                ", PayeeAccountNo='" + PayeeAccountNo + '\'' +
                ", bankCode='" + bankCode + '\'' +
                ", bankName='" + bankName + '\'' +
                ", payeeBankName='" + payeeBankName + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", payFee=" + payFee +
                ", mealFee=" + mealFee +
                ", specFee=" + specFee +
                ", localCallFee=" + localCallFee +
                ", longDisFee=" + longDisFee +
                ", roamFee=" + roamFee +
                ", msgFee=" + msgFee +
                ", ipFee=" + ipFee +
                ", pzFee=" + pzFee +
                ", otherFee=" + otherFee +
                ", videoPhoneFee=" + videoPhoneFee +
                ", printTimes=" + printTimes +
                '}';
    }
}
