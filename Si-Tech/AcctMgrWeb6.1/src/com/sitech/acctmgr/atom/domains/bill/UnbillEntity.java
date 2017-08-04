package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.balance.BalanceEntity;
import com.sitech.acctmgr.atom.domains.balance.SpecBalaceEntity;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.util.ArrayList;
import java.util.List;

public class UnbillEntity {
	
	@JSONField(name="ID_NO")
	@ParamDesc(path="ID_NO",cons=ConsType.CT001,type="long",len="20",desc="用户ID",memo="略")
	private long idNo = 0;
	
	@JSONField(name="PERPAY_FEE")
	@ParamDesc(path="PERPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="预存",memo="略")
	private long prepayFee = 0;
	
	@JSONField(name="GPREPAY_FEE")
	@ParamDesc(path="GPREPAY_FEE",cons=ConsType.CT001,type="long",len="20",desc="专款预存",memo="略")
	private long gprepayFee = 0;
	
	@JSONField(name="BALANCE_TOTAL")
	@ParamDesc(path="BALANCE_TOTAL",cons=ConsType.CT001,type="long",len="20",desc="未冲销原始预存",memo="同步到账务时的未冲销预存")
	private long balanceTotal = 0;
	
	@JSONField(name="UNBILL_FEE")
	@ParamDesc(path="UNBILL_FEE",cons=ConsType.CT001,type="long",len="20",desc="内存欠费",memo="略")
	private long unBillFee = 0;
	
	@JSONField(name="SHOULD_PAY")
	@ParamDesc(path="SHOULD_PAY",cons=ConsType.CT001,type="long",len="20",desc="应缴费",memo="略")
	private long shouldPay = 0;
	
	@JSONField(name="FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE",cons=ConsType.CT001,type="long",len="20",desc="优惠费",memo="略")
	private long favourFee = 0;
	
	@JSONField(name="PAYED_PREPAY")
	@ParamDesc(path="PAYED_PREPAY",cons=ConsType.CT001,type="long",len="20",desc="预存划拨",memo="略")
	private long payedPrepay = 0;
	
	@JSONField(name="PAYED_LATER")
	@ParamDesc(path="PAYED_LATER",cons=ConsType.CT001,type="long",len="20",desc="缴费冲销",memo="略")
	private long payedLater = 0;
	
	@JSONField(name="SPECIAL_LIST")
	@ParamDesc(path="SPECIAL_LIST",cons=ConsType.STAR,type="compx",len="1",desc="专款列表",memo="略")
	private List<BalanceEntity> specialActBookList = new ArrayList<>();
	
	@JSONField(name="ACCT_BOOK_LIST")
	@ParamDesc(path="ACCT_BOOK_LIST",cons=ConsType.STAR,type="compx",len="1",desc="生效状态的账本列表",memo="略")
	private List<BalanceEntity> acctBookList = new ArrayList<BalanceEntity>();
	
	@JSONField(name="ACCT_BOOK_EFF_LIST")
	@ParamDesc(path="ACCT_BOOK_EFF_LIST",cons=ConsType.STAR,type="compx",len="1",desc="未生效账本列表",memo="略")
	private List<BalanceEntity> acctBookEffList = new ArrayList<>();
	
	@JSONField(name="ACCT_BOOK_EXP_LIST")
	@ParamDesc(path="ACCT_BOOK_EXP_LIST",cons=ConsType.STAR,type="compx",len="1",desc="已失效账本列表",memo="略")
	private List<BalanceEntity> acctBookExpList = new ArrayList<>();
	
	@JSONField(name="ACCT_BOOK_ALL_LIST")
	@ParamDesc(path="ACCT_BOOK_ALL_LIST",cons=ConsType.STAR,type="compx",len="1",desc="全部账本列表",memo="略")
	private List<BalanceEntity> acctBookAllList = new ArrayList<>();
	
	@JSONField(name="UNBILL_LIST")
	@ParamDesc(path="UNBILL_LIST",cons=ConsType.STAR,type="compx",len="1",desc="内存欠费列表",memo="略")
	private List<BillEntity> unBillList = new ArrayList<>();
	
	@JSONField(name="PAYOWE_LIST")
	@ParamDesc(path="PAYOWE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="内存已冲销列表",memo="略")
	private List<BillEntity> payedOweList = new ArrayList<>();
	
	@JSONField(name="IS_ONLINE")
	@ParamDesc(path="IS_ONLINE",cons=ConsType.CT001,type="boolean",len="20",desc="在线离网开关",memo="true:在线  false:离线")
	private boolean isOnline = false;

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public long getPrepayFee() {
		return prepayFee;
	}

	public void setPrepayFee(long prepayFee) {
		this.prepayFee = prepayFee;
	}

	public long getGprepayFee() {
		return gprepayFee;
	}

	public void setGprepayFee(long gprepayFee) {
		this.gprepayFee = gprepayFee;
	}

	public long getUnBillFee() {
		return unBillFee;
	}

	public void setUnBillFee(long unBillFee) {
		this.unBillFee = unBillFee;
	}

	public long getShouldPay() {
		return shouldPay;
	}

	public void setShouldPay(long shouldPay) {
		this.shouldPay = shouldPay;
	}

	public long getFavourFee() {
		return favourFee;
	}

	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}

	public long getPayedPrepay() {
		return payedPrepay;
	}

	public void setPayedPrepay(long payedPrepay) {
		this.payedPrepay = payedPrepay;
	}

	public long getPayedLater() {
		return payedLater;
	}

	public void setPayedLater(long payedLater) {
		this.payedLater = payedLater;
	}

	public List<BalanceEntity> getSpecialActBookList() {
		return specialActBookList;
	}

	public void setSpecialActBookList(List<BalanceEntity> specialActBookList) {
		this.specialActBookList = specialActBookList;
	}

	public List<BalanceEntity> getAcctBookList() {
		return acctBookList;
	}

	public void setAcctBookList(List<BalanceEntity> acctBookList) {
		this.acctBookList = acctBookList;
	}

	public List<BillEntity> getUnBillList() {
		return unBillList;
	}

	public void setUnBillList(List<BillEntity> unBillList) {
		this.unBillList = unBillList;
	}

	public List<BillEntity> getPayedOweList() {
		return payedOweList;
	}

	public void setPayedOweList(List<BillEntity> payedOweList) {
		this.payedOweList = payedOweList;
	}

	public List<BalanceEntity> getAcctBookEffList() {
		return acctBookEffList;
	}

	public void setAcctBookEffList(List<BalanceEntity> acctBookEffList) {
		this.acctBookEffList = acctBookEffList;
	}

	public List<BalanceEntity> getAcctBookExpList() {
		return acctBookExpList;
	}

	public void setAcctBookExpList(List<BalanceEntity> acctBookExpList) {
		this.acctBookExpList = acctBookExpList;
	}

	
	public List<BalanceEntity> getAcctBookAllList() {
		return acctBookAllList;
	}

	public void setAcctBookAllList(List<BalanceEntity> acctBookAllList) {
		this.acctBookAllList = acctBookAllList;
	}

	public long getBalanceTotal() {
		return balanceTotal;
	}

	public void setBalanceTotal(long balanceTotal) {
		this.balanceTotal = balanceTotal;
	}
	

	public boolean isOnline() {
		return isOnline;
	}

	public void setOnline(boolean isOnline) {
		this.isOnline = isOnline;
	}

	@Override
	public String toString() {
		return "UnbillEntity{" +
				"idNo=" + idNo +
				", prepayFee=" + prepayFee +
				", gprepayFee=" + gprepayFee +
				", balanceTotal=" + balanceTotal +
				", unBillFee=" + unBillFee +
				", shouldPay=" + shouldPay +
				", favourFee=" + favourFee +
				", payedPrepay=" + payedPrepay +
				", payedLater=" + payedLater +
				", specialActBookList=" + specialActBookList +
				", acctBookList=" + acctBookList +
				", acctBookEffList=" + acctBookEffList +
				", acctBookExpList=" + acctBookExpList +
				", acctBookAllList=" + acctBookAllList +
				", unBillList=" + unBillList +
				", payedOweList=" + payedOweList +
				", isOnline=" + isOnline +
				'}';
	}

}
