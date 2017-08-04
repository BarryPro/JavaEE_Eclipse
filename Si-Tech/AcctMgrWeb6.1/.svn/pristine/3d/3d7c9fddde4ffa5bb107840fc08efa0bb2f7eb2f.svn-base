package com.sitech.acctmgr.atom.impl.acctmng;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.AccountListEntity;
import com.sitech.acctmgr.atom.domains.account.ContractDeadInfoEntity;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserdetaildeadEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SConUserRelInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SConUserRelOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.acctmng.IConUserRel;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/23.
 */
@ParamTypes({
		@ParamType(m = "queryOnLine", c = SConUserRelInDTO.class, oc = SConUserRelOutDTO.class, routeKey = "10", routeValue = "phone_no", busiComId = "构件id", srvCat = "查询", srvCnName = "在网用户帐务关系查询", srvVer = "V10.8.126.0", srvDesc = "帐务关系查询服务", srcAttr = "协助", srvLocal = "否", srvGroup = "否"),
		@ParamType(m = "queryOffLine", c = SConUserRelInDTO.class, oc = SConUserRelOutDTO.class),
		@ParamType(m = "queryOnLineIncBalance", c = SConUserRelInDTO.class, oc = SConUserRelOutDTO.class, routeKey = "10", routeValue = "phone_no", busiComId = "构件id", srvCat = "查询", srvCnName = "在网用户帐务关系查询", srvVer = "V10.8.126.0", srvDesc = "帐务关系查询服务带余额", srcAttr = "协助", srvLocal = "否", srvGroup = "否") })
public class SConUserRel extends AcctMgrBaseService implements IConUserRel {
	private IUser user;
	private IAccount account;
	private IRemainFee remainFee;
	private ICust cust;
	private IControl control;

	@Override
	public OutDTO queryOnLine(InDTO inParam) {
		SConUserRelInDTO inDTO = (SConUserRelInDTO) inParam;
		long tbegin = System.currentTimeMillis();
		log.debug("inDto=" + inDTO.getMbean());
		String phoneNo = inDTO.getPhoneNo();

		UserInfoEntity userEnt = user.getUserEntity(null, phoneNo, null, true);
		long idNo = userEnt.getIdNo();
		String curDate = String.format("%8d", DateUtils.getCurDay());

		List<AccountListEntity> outConList = new ArrayList<>();
		List<ContractEntity> conList = account.getConList(idNo);
		for (ContractEntity conEnt : conList) {
			AccountListEntity accountEnt = new AccountListEntity();
			accountEnt.setContractNo(conEnt.getCon());
			ContractInfoEntity conInfoEnt = account.getConInfo(conEnt.getCon());
			accountEnt.setContractName(conInfoEnt.getBlurContractName());
			accountEnt.setContracttName(conInfoEnt.getContractattTypeName());
			accountEnt.setOrderName(conEnt.getBillOrder() == 99999999 ? "默认帐户" : "代付帐户");
			accountEnt.setPayName(conEnt.getPayCodeName());
			String effDate = conEnt.getEffDate().substring(0, 8);
			String expDate = conEnt.getExpDate().substring(0, 8);
			accountEnt.setEffDate(effDate);
			accountEnt.setExpDate(expDate);
			accountEnt.setIdNo(idNo);
			String statusName = (DateUtils.compare(curDate, effDate, DateUtils.DATE_FORMAT_YYYYMMDD) >= 0 && DateUtils.compare(curDate, expDate,
					DateUtils.DATE_FORMAT_YYYYMMDD) < 0) ? "生效" : "失效";
			accountEnt.setStatusName(statusName);

			outConList.add(accountEnt);
		}

		SConUserRelOutDTO outDTO = new SConUserRelOutDTO();
		outDTO.setConList(outConList);
		outDTO.setCnt(outConList.size());

		log.debug(outDTO.toJson());
		long tend = System.currentTimeMillis();
		log.info("耗时：" + (tend - tbegin) + " ms");

		return outDTO;
	}

	@Override
	public OutDTO queryOffLine(InDTO inParam) {
		SConUserRelInDTO inDTO = (SConUserRelInDTO) inParam;
		log.debug("inDto=" + inDTO.getMbean());
		// 获取入参信息
		String phoneNo = inDTO.getPhoneNo();

		// 获取用户信息
		List<UserDeadEntity> userDeadEntList = user.getUserdeadEntity(phoneNo, null, null);
		List<AccountListEntity> outList = new ArrayList<>(); // 定义出参列表

		for (UserDeadEntity userDeadEnt : userDeadEntList) {

			AccountListEntity accEnt = new AccountListEntity();
			long idNo = userDeadEnt.getIdNo();
			long custId = userDeadEnt.getCustId();
			long contractNo = userDeadEnt.getContractNo();

			CustInfoEntity custEnt = cust.getCustInfo(custId, null);
			String custName = custEnt.getCustName();
			String blurCustName = custEnt.getBlurCustName();

			ContractDeadInfoEntity conInfoEnt = account.getConDeadInfo(contractNo);
			String payName = conInfoEnt.getPayCodeName();
			String payType = "默认账户";

			accEnt.setIdNo(idNo);
			accEnt.setCustId(custId);
			accEnt.setPayName(payName);
			accEnt.setOrderName(payType);
			accEnt.setBlurCustName(blurCustName);
			accEnt.setContractNo(contractNo);
			accEnt.setCustName(custName); // 解密后客户名称

			accEnt.setContractName(conInfoEnt.getBlurContractName());
			accEnt.setContracttName(conInfoEnt.getContractattTypeName());

			UserdetaildeadEntity udde = user.getUserdetailDeadEntity(idNo);
			log.info("udde.getRunTime()=====" + udde.getRunTime());
			accEnt.setRunTime(udde.getRunTime().substring(0, 8));

			accEnt.setOpenTime(userDeadEnt.getOpenTime().substring(0, 8));

			outList.add(accEnt);
		}

		// 出参信息
		SConUserRelOutDTO outDTO = new SConUserRelOutDTO();
		outDTO.setConList(outList);
		outDTO.setCnt(outList.size());

		log.debug(outDTO.toJson());

		return outDTO;
	}

	@Override
	public OutDTO queryOnLineIncBalance(InDTO inParam) {
		SConUserRelInDTO inDTO = (SConUserRelInDTO) inParam;
		log.debug("inDto=" + inDTO.getMbean());
		long tbegin = System.currentTimeMillis();
		String phoneNo = inDTO.getPhoneNo();

		UserInfoEntity userEnt = user.getUserEntity(null, phoneNo, null, true);
		long idNo = userEnt.getIdNo();
		String curDate = String.format("%8d", DateUtils.getCurDay());

		List<AccountListEntity> outConList = new ArrayList<>();
		List<ContractEntity> conList = account.getConList(idNo);
		for (ContractEntity conEnt : conList) {
			AccountListEntity accountEnt = new AccountListEntity();
			accountEnt.setContractNo(conEnt.getCon());
			ContractInfoEntity conInfoEnt = account.getConInfo(conEnt.getCon());
			accountEnt.setContractName(conInfoEnt.getBlurContractName());
			accountEnt.setContracttName(conInfoEnt.getContractattTypeName());
			accountEnt.setOrderName(conEnt.getBillOrder() == 99999999 ? "默认帐户" : "代付帐户");
			accountEnt.setPayName(conEnt.getPayCodeName());
			String effDate = conEnt.getEffDate().substring(0, 8);
			String expDate = conEnt.getExpDate().substring(0, 8);
			accountEnt.setEffDate(effDate);
			accountEnt.setExpDate(expDate);
			String statusName = (DateUtils.compare(curDate, effDate, DateUtils.DATE_FORMAT_YYYYMMDD) >= 0 && DateUtils.compare(curDate, expDate,
					DateUtils.DATE_FORMAT_YYYYMMDD) < 0) ? "生效" : "失效";
			accountEnt.setStatusName(statusName);

			OutFeeData conFeeData = remainFee.getConRemainFee(conEnt.getCon());
			accountEnt.setPrepayFee(conFeeData.getPrepayFee());
			accountEnt.setRemainFee(conFeeData.getRemainFee());
			accountEnt.setUnBillFee(conFeeData.getUnbillFee());
			accountEnt.setOweFee(conFeeData.getOweFee());

			outConList.add(accountEnt);
		}

		SConUserRelOutDTO outDTO = new SConUserRelOutDTO();
		outDTO.setConList(outConList);
		outDTO.setCnt(outConList.size());

		log.debug(outDTO.toJson());
		long tend = System.currentTimeMillis();
		log.info("耗时：" + (tend - tbegin) + " ms");

		return outDTO;
	}

	@Override
	public OutDTO queryAll(InDTO inParam) {
		return null;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IRemainFee getRemainFee() {
		return remainFee;
	}

	public void setRemainFee(IRemainFee remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the cust
	 */
	public ICust getCust() {
		return cust;
	}

	/**
	 * @param cust
	 *            the cust to set
	 */
	public void setCust(ICust cust) {
		this.cust = cust;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control
	 *            the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}
}
