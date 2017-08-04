package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IInvPrint;
import com.sitech.acctmgr.atom.busi.pay.inter.IPreOrder;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.invoice.InvNoOccupyEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.VirtualGrpEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8241PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8241PrintOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8241QryInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8241QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8241;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;

/**
 * 名称：集团打印发票
 * 
 * @author liuhl_bj
 *
 */
@ParamTypes({ @ParamType(c = S8241QryInDTO.class, oc = S8241QryOutDTO.class, m = "query"),
		@ParamType(c = S8241PrintInDTO.class, oc = S8241PrintOutDTO.class, m = "print") })
public class S8241 extends AcctMgrBaseService implements I8241 {
	private IUser user;
	private IRecord record;
	private IInvoice invoice;
	private IInvPrint invPrint;
	private IControl control;
	private IAccount account;
	private IPreOrder preOrder;
	private IGroup group;

	@Override
	public OutDTO query(InDTO inParam) {
		S8241QryInDTO inDto = (S8241QryInDTO) inParam;
		long unitId = inDto.getUnitId();
		int beginDate = inDto.getBeginDate();
		int endDate = inDto.getEndDate();

		Map<String, Object> inMap = new HashMap<String, Object>();
		// 根据unit_id查询账号和服务号码
		List<VirtualGrpEntity> virtualList = user.getVirtualGrpList(unitId, "");
		if (virtualList == null || virtualList.size() == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("8241", "00001"), "查询虚拟集团信息失败或者此虚拟集团下无用户");
		}
		String unitName = virtualList.get(0).getUnitName();
		List<Long> virturalConList = new ArrayList<Long>();
		// 获取查询缴费记录的账号列表
		for (VirtualGrpEntity virtualGrp : virtualList) {
			virturalConList.add(ValueUtils.longValue(virtualGrp.getGrpContractNo()));
		}

		List<PayMentEntity> paymentList = new ArrayList<>();
		inMap.put("BEGIN_TIME", beginDate + "");
		inMap.put("END_TIME", endDate + "");
		// 查询可打印的op_code
		long codeClass = 1200;
		List<PubCodeDictEntity> pubCodeList = control.getPubCodeList(codeClass, "", "", "");
		List<String> opCodeList = new ArrayList<String>();
		for (PubCodeDictEntity pubCode : pubCodeList) {
			opCodeList.add(pubCode.getCodeId());
		}
		inMap.put("OP_CODE_LIST", opCodeList);

		inMap.put("REMARK", "手机支付企业缴话费%");
		inMap.put("STATUS", "0");
		inMap.put("ACCPERT_PAYTYPE", "Y");
		// 查询不可打印发票的pay_type
		codeClass = 1108;
		List<PubCodeDictEntity> payTypeListTmp = control.getPubCodeList(codeClass, "", "", "");

		for (int ym = beginDate / 100; ym <= endDate / 100; ym = DateUtils.addMonth(ym, 1)) {
			// 根据查询时间和查询未打印的缴费记录，获取可打印的缴费金额
			inMap.put("SUFFIX", ym);
			inMap.put("CONTRACT_NO_LIST", virturalConList);

			List<PayMentEntity> paymentListTmp = record.getPayMentList(inMap);
			for (PayMentEntity payment : paymentListTmp) {
				if (payTypeListTmp.contains(payment.getPayType())) {
					continue;
				}
				if (invoice.isPhonePay(payment.getYearMonth() + "", "T1001008", "TRANS_CODE", payment.getPaySn())) {
					continue;
				}
				paymentList.add(payment);
			}
		}

		log.debug(paymentList + "*************");

		List<VirtualGrpEntity> outList = new ArrayList<VirtualGrpEntity>();
		int curYm=DateUtils.getCurYm();
		for (PayMentEntity payment : paymentList) {
			// 判断该笔流水是否打印过月结发票，打印过月结发票，不展示
			inMap = new HashMap<String, Object>();
			inMap.put("SUFFIX", payment.getYearMonth());
			inMap.put("PAY_SN", payment.getPaySn());
			int printedMonth = invoice.isPrintMonthInvoice(inMap);
			// 判断该笔流水是否打印过发票，打印过不展示
			log.debug("查询是否打印过预存发票的入参：" + inMap);
			int printedPre = invoice.isPrintPreInvoice(inMap);
			int flag=0;
			for (int yearMonth = payment.getYearMonth(); yearMonth <= curYm; yearMonth = DateUtils.addMonth(yearMonth, 1)) {
				flag = invoice.getPrintFlag(payment.getPaySn(), payment.getYearMonth(), payment.getContractNo());
				if (flag > 0) {
					break;
				}
			}
			if (printedMonth > 0 || printedPre > 0 || flag > 0) {
				continue;
			}
			// 获取账户名称
			long contractNo = payment.getContractNo();
			ContractInfoEntity conInfo = account.getConInfo(contractNo);
			String contractName = conInfo.getContractName();

			VirtualGrpEntity virtualGrp = new VirtualGrpEntity();
			virtualGrp.setPaySn(payment.getPaySn());
			virtualGrp.setGrpContractNo(payment.getContractNo() + "");
			virtualGrp.setGrpPhoneNo(payment.getPhoneNo());
			virtualGrp.setOpTime(payment.getOpTime());
			virtualGrp.setPayFee(payment.getPayFee());
			virtualGrp.setContractName(contractName);
			outList.add(virtualGrp);
		}

		S8241QryOutDTO outDto = new S8241QryOutDTO();
		outDto.setVirtualList(outList);
		outDto.setUnitName(unitName);
		outDto.setUnitId(unitId + "");
		return outDto;
	}

	@Override
	public OutDTO print(InDTO inParam) {
		S8241PrintInDTO inDto = (S8241PrintInDTO) inParam;
		log.debug("inDto=" + inDto.getMbean());
		String invCode = inDto.getInvCode();
		String invNo = inDto.getInvNo();
		int beginDate = inDto.getBeginDate();
		int endDate = inDto.getEndDate();
		int beginYm = beginDate / 100;
		int endYm = endDate / 100;
		String opCode = inDto.getOpCode();
		String groupId = inDto.getGroupId();
		String loginNo = inDto.getLoginNo();
		String unitName = inDto.getUnitName();
		long unitId = inDto.getUnitId();
		String printItem = inDto.getPrintItem();

		List<VirtualGrpEntity> virtualGrpList = inDto.getVirtualGrpList();

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("INV_CODE", invCode);
		inMap.put("INV_NO", invNo);
		inMap.put("BEGIN_DATE", beginDate);
		inMap.put("BEGIN_YM", beginYm);
		inMap.put("END_DATE", endDate);
		inMap.put("END_YM", endYm);
		inMap.put("OP_CODE", opCode);
		inMap.put("LOGIN_NO", loginNo);
		inMap.put("GROUP_ID", groupId);
		inMap.put("VIRTUALGRP_LIST", virtualGrpList);
		inMap.put("UNIT_ID", unitId);
		inMap.put("UNIT_NAME", unitName);
		inMap.put("PROVICE_ID", inDto.getProvinceId());
		inMap.put("PRINT_FEE", inDto.getPrintFee());
		inMap.put("PRINT_ITEM", inDto.getPrintItem());
		inMap.put("UNIT_NAME", inDto.getUnitName());
		inMap.put("PRINT_ITEM", inDto.getPrintItem());
		inMap.put("OP_CODE", inDto.getOpCode());
		inMap.put("PRINT_SEQ", 1);
		inMap.put("PRINT_ITEM", printItem);
		long printSn = invoice.getPrintSn();
		inMap.put("PRINT_SN", printSn);
		inMap.put("Header", inDto.getHeader());
		InvNoOccupyEntity invNoOccupy = invPrint.printGrpInvoice(inMap);

		// 记录工号操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(printSn);
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setIdNo(0);
		loe.setBrandId("xx");
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode(inDto.getOpCode());
		loe.setRemark("集团打印发票");
		record.saveLoginOpr(loe);

		// 同步CRM统一接触
		ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
		Map<String, Object> oprCnttMap = new HashMap<String, Object>();
		oprCnttMap.put("Header", inDto.getHeader());
		oprCnttMap.put("PAY_SN", printSn);
		oprCnttMap.put("LOGIN_NO", inDto.getLoginNo());
		oprCnttMap.put("GROUP_ID", inDto.getGroupId());
		oprCnttMap.put("OP_CODE", inDto.getOpCode());
		oprCnttMap.put("REGION_ID", cgre.getRegionCode());
		oprCnttMap.put("OP_NOTE", "集团打印发票");
		oprCnttMap.put("TOTAL_FEE", 0);
		oprCnttMap.put("CUST_ID_TYPE", "1");
		oprCnttMap.put("CUST_ID_VALUE", "99999999999");
		// 取系统时间
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		oprCnttMap.put("OP_TIME", sCurTime);
		preOrder.sendOprCntt(oprCnttMap);

		S8241PrintOutDTO outDto = new S8241PrintOutDTO();
		outDto.setInvNoOccupy(invNoOccupy);
		return outDto;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IInvPrint getInvPrint() {
		return invPrint;
	}

	public void setInvPrint(IInvPrint invPrint) {
		this.invPrint = invPrint;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IPreOrder getPreOrder() {
		return preOrder;
	}

	public void setPreOrder(IPreOrder preOrder) {
		this.preOrder = preOrder;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

}
