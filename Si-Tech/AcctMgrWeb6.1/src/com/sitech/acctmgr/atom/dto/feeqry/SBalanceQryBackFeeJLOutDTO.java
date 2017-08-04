package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.ModeBackEntity;
import com.sitech.acctmgr.atom.domains.query.NotBackBalanceEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
public class SBalanceQryBackFeeJLOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2981462794156048953L;

	@ParamDesc(path = "BACK_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "可退金额", memo = "略")
	private long backFee = 0;
	@ParamDesc(path = "BACK_PREPAY", cons = ConsType.CT001, type = "long", len = "20", desc = "可退预存", memo = "略")
	private long backPrepay = 0;
	@ParamDesc(path = "NO_BACK_PREPAY", cons = ConsType.CT001, type = "long", len = "20", desc = "不可退预存", memo = "略")
	private long noBackPrepay = 0;
	@ParamDesc(path = "BACK_DEPOSIT", cons = ConsType.CT001, type = "long", len = "20", desc = "可退押金", memo = "略")
	private long backDeposit = 0;
	@ParamDesc(path = "NO_BACK_DEPOSIT", cons = ConsType.CT001, type = "long", len = "20", desc = "不可退押金", memo = "略")
	private long noBackDeposit = 0;
	@ParamDesc(path = "NO_BACK_PREPAY_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "不可退预存列表", memo = "略")
	private List<NotBackBalanceEntity> noBackBalList = new ArrayList<NotBackBalanceEntity>();

	@ParamDesc(path = "MODE_BACK_TOTAL_FEE", cons = ConsType.CT001, type = "long", len = "20", desc = "可退套餐费总金额", memo = "略")
	private long modeBackTotalFee = 0;

	@ParamDesc(path = "MODE_BACK_FEE", cons = ConsType.STAR, type = "compx", len = "1", desc = "可退套餐费列表", memo = "略")
	private List<ModeBackEntity> modeBackFeeList = new ArrayList<ModeBackEntity>();

	@Override
	public MBean encode() {
		MBean mBean = new MBean();
		mBean.setRoot(getPathByProperName("backFee"), backFee);
		mBean.setRoot(getPathByProperName("backPrepay"), backPrepay);
		mBean.setRoot(getPathByProperName("noBackPrepay"), noBackPrepay);
		mBean.setRoot(getPathByProperName("backDeposit"), backDeposit);
		mBean.setRoot(getPathByProperName("noBackDeposit"), noBackDeposit);
		mBean.setRoot(getPathByProperName("noBackBalList"), noBackBalList);
		mBean.setRoot(getPathByProperName("modeBackTotalFee"), modeBackTotalFee);
		mBean.setRoot(getPathByProperName("modeBackFeeList"), modeBackFeeList);
		return mBean;
	}

	/**
	 * @return the backFee
	 */
	public long getBackFee() {
		return backFee;
	}

	/**
	 * @param backFee
	 *            the backFee to set
	 */
	public void setBackFee(long backFee) {
		this.backFee = backFee;
	}

	/**
	 * @return the backPrepay
	 */
	public long getBackPrepay() {
		return backPrepay;
	}

	/**
	 * @param backPrepay
	 *            the backPrepay to set
	 */
	public void setBackPrepay(long backPrepay) {
		this.backPrepay = backPrepay;
	}

	/**
	 * @return the noBackPrepay
	 */
	public long getNoBackPrepay() {
		return noBackPrepay;
	}

	/**
	 * @param noBackPrepay
	 *            the noBackPrepay to set
	 */
	public void setNoBackPrepay(long noBackPrepay) {
		this.noBackPrepay = noBackPrepay;
	}

	/**
	 * @return the backDeposit
	 */
	public long getBackDeposit() {
		return backDeposit;
	}

	/**
	 * @param backDeposit
	 *            the backDeposit to set
	 */
	public void setBackDeposit(long backDeposit) {
		this.backDeposit = backDeposit;
	}

	/**
	 * @return the noBackDeposit
	 */
	public long getNoBackDeposit() {
		return noBackDeposit;
	}

	/**
	 * @param noBackDeposit
	 *            the noBackDeposit to set
	 */
	public void setNoBackDeposit(long noBackDeposit) {
		this.noBackDeposit = noBackDeposit;
	}

	public List<NotBackBalanceEntity> getNoBackBalList() {
		return noBackBalList;
	}

	public void setNoBackBalList(List<NotBackBalanceEntity> noBackBalList) {
		this.noBackBalList = noBackBalList;
	}

	public long getModeBackTotalFee() {
		return modeBackTotalFee;
	}

	public void setModeBackTotalFee(long modeBackTotalFee) {
		this.modeBackTotalFee = modeBackTotalFee;
	}

	public List<ModeBackEntity> getModeBackFeeList() {
		return modeBackFeeList;
	}

	public void setModeBackFeeList(List<ModeBackEntity> modeBackFeeList) {
		this.modeBackFeeList = modeBackFeeList;
	}

}
