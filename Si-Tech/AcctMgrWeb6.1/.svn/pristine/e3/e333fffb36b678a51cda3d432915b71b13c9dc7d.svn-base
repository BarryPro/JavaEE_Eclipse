package com.sitech.acctmgr.atom.impl.invoice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.sitech.acctmgr.atom.busi.invoice.inter.IInvPrint;
import com.sitech.acctmgr.atom.busi.pay.inter.IPayManage;
import com.sitech.acctmgr.atom.domains.invoice.BaseInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.invoice.PreInvoiceDispEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.SPrintBankPrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SPrintBankPrintOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.IPrintBank;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SPrintBankPrintInDTO.class, m = "print", oc = SPrintBankPrintOutDTO.class) })
public class SPrintBank extends AcctMgrBaseService implements IPrintBank {
	private IInvPrint invPrint;
	private IInvoice invoice;
	private IUser user;
	private IPayManage payManage;
	private IRecord record;
	@Override
	public OutDTO print(InDTO inParam) {
		SPrintBankPrintInDTO inDto = (SPrintBankPrintInDTO) inParam;

		String phoneNo = inDto.getPhoneNo();
		String opCode = inDto.getOpCode();
		int totalDate = inDto.getTotalDate();
		long paySn = 0;
		if (inDto.getPaySn() > 0) {
			paySn = inDto.getPaySn();
		}
		if (StringUtils.isNotEmpty(inDto.getForeignSn())) {
			List<Map<String, Object>> paySnList = payManage.getPaySnByForeign(inDto.getForeignSn(), totalDate / 100 + "");
			if (paySnList.size() == 0) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", "01001"), "外部流水交费记录不存在");
			}
			Map<String, Object> paySnMap = paySnList.get(0);
			paySn = ValueUtils.longValue(paySnMap.get("PAY_SN"));
		}

		int userFlag = inDto.getUserFlag();
		boolean isPrint = false;
		// 根据phoneNo查询用户信息
		long contractNo = 0;
		if (inDto.getContractNo() > 0) {
			contractNo = inDto.getContractNo();
		}

		if (userFlag == CommonConst.IN_NET) {
			UserInfoEntity userInfo = user.getUserEntity(0l, phoneNo, contractNo, true);
			phoneNo = userInfo.getPhoneNo();
			contractNo = userInfo.getContractNo();
		} else {
			List<UserDeadEntity> userDeadInfoList = user.getUserdeadEntity(phoneNo, inDto.getIdNo(), contractNo);
			UserDeadEntity userDead = userDeadInfoList.get(0);
			phoneNo = userDead.getPhoneNo();
			contractNo = userDead.getContractNo();
		}

		Map<String, Object> inMap = new HashMap<String, Object>();

		// int printseq = 1;
		String loginNo = inDto.getLoginNo();
		String groupId = inDto.getGroupId();
		String proviceId = inDto.getProvinceId();
		// String invNo = inDto.getInvNo();
		// String invCode = inDto.getInvCode();
		// // 判断是第几次打印
		// for (int yearmonth = totalDate / 100; yearmonth <= DateUtils.getCurYm(); yearmonth = DateUtils.addMonth(yearmonth, 1)) {
		// Map<String, Object> getSeqInMap = new HashMap<String, Object>();
		// getSeqInMap.put("PAY_SN", paySn);
		// getSeqInMap.put("SUFFIX", yearmonth);
		// BalInvprintInfoEntity balInvprintInfo = invoice.qryInvoiceInfo(getSeqInMap);
		// if (balInvprintInfo == null) {
		// continue;
		// }
		// printseq = balInvprintInfo.getPrintSeq();
		// inMap.put("SUFFIX", yearmonth);
		// inMap.put("PRINT_FLAG", 1);
		// break;
		// }
		// inMap.put("PRINT_SEQ", printseq);
		inMap.put("CONTRACT_NO", contractNo);
		inMap.put("USER_FLAG", userFlag);
		inMap.put("OP_CODE", opCode);
		inMap.put("LOGIN_NO", loginNo);
		inMap.put("GROUP_ID", groupId);
		inMap.put("PROVICE_ID", proviceId);
		// inMap.put("INV_NO", invNo);
		// inMap.put("INV_CODE", invCode);
		inMap.put("BILL_CYCLE", totalDate / 100);
		inMap.put("PAY_SN", paySn);
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("IS_PRINT", isPrint);
		inMap.put("NEED_XMLSTR", false);
		long printSn = invoice.getPrintSn();
		inMap.put("PRINT_SN", printSn);
		Map<String, Object> outMap = new HashMap<String, Object>();
		outMap = invPrint.printPreInvoice(inMap);
		BaseInvoiceDispEntity baseInvDisp = (BaseInvoiceDispEntity) outMap.get("BASE_INV_DISP");
		PreInvoiceDispEntity preInvDisp = (PreInvoiceDispEntity) outMap.get("PRE_INV_DISP");
		log.debug("baseInvDisp" + baseInvDisp + ">>>>preInvDisp" + preInvDisp);
		// List<PrintBankEntity> lineList = new ArrayList<PrintBankEntity>();

		Map<String, Object> treeMap = new TreeMap<String, Object>();
		treeMap.put("LINE_A", "           ");
		treeMap.put("LINE_B", "          " + preInvDisp.getPayDate());
		treeMap.put("LINE_C", "防伪码:           ");
		treeMap.put("LINE_D", "           ");
		treeMap.put("LINE_E",
				"工    号：" + baseInvDisp.getLoginNo() + "         操作流水：" + baseInvDisp.getLoginAccept() + "   业务名称：" + baseInvDisp.getOpName());
		treeMap.put("LINE_F", "           ");
		treeMap.put("LINE_G", "客户名称：" + baseInvDisp.getCustName());
		treeMap.put("LINE_H", "           ");
		treeMap.put("LINE_I", "手机号码：" + baseInvDisp.getPhoneNo() + "协议号码：" + baseInvDisp.getContractNo() + "      支票号码：" + preInvDisp.getCheckNo());
		treeMap.put("LINE_J", "           ");
		treeMap.put("LINE_K", "合计金额：(大写)" + ValueUtils.transYuanToChnaBig(ValueUtils.transFenToYuan(preInvDisp.getPrintFee()))
				+ "                          (小写)￥" + ValueUtils.transFenToYuan(preInvDisp.getPrintFee()));
		treeMap.put("LINE_L", "           ");
		treeMap.put("LINE_M", "(项目)           ");

		treeMap.put("LINE_N", "           原话费余额:  " + ValueUtils.transFenToYuan(preInvDisp.getBalanceFee() - preInvDisp.getPrintFee()));
		treeMap.put(
				"LINE_O",
				"           本次交话费：现金: " + ValueUtils.transFenToYuan(preInvDisp.getCashMoney()) + " 支票:"
				+ ValueUtils.transFenToYuan(preInvDisp.getCheckMoney()));
		treeMap.put("LINE_P", "           话费余额:" + ValueUtils.transFenToYuan(preInvDisp.getBalanceFee()));
		treeMap.put("LINE_Q", "           未出帐话费:" + ValueUtils.transFenToYuan(preInvDisp.getUnbillFee()));
		treeMap.put("LINE_R", "           当前可用余额 " + ValueUtils.transFenToYuan(preInvDisp.getRemainFee()));
		treeMap.put("LINE_S", "           ");
		treeMap.put("LINE_T", "           ");
		treeMap.put("LINE_U", "           " + baseInvDisp.getRemark());
		treeMap.put("LINE_V", "           ");
		treeMap.put("LINE_W", "开票：" + baseInvDisp.getLoginName() + "收款：                        复核：");

		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(printSn);
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setIdNo(0);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("xx");
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode("1351");
		loe.setRemark("银行打印凭证");
		record.saveLoginOpr(loe);

		SPrintBankPrintOutDTO outDto = new SPrintBankPrintOutDTO();
		outDto.setLineMap(treeMap);
		return outDto;
	}

	public IInvPrint getInvPrint() {
		return invPrint;
	}

	public void setInvPrint(IInvPrint invPrint) {
		this.invPrint = invPrint;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IPayManage getPayManage() {
		return payManage;
	}

	public void setPayManage(IPayManage payManage) {
		this.payManage = payManage;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

}
