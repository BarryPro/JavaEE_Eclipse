package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.jetty.util.log.Log;

import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoicePrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.SPreInvoicePrintOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.IPreInvoicePrint;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SPreInvoicePrintInDTO.class, oc = SPreInvoicePrintOutDTO.class, m = "print")
})

public class SPreInvoicePrint implements IPreInvoicePrint {

	private IRecord record;
	private IInvoice invoice;
	private IUser user;
	@Override
	public OutDTO print(InDTO inParam) {
		SPreInvoicePrintInDTO inDto = (SPreInvoicePrintInDTO) inParam;
		SPreInvoicePrintOutDTO outDto = new SPreInvoicePrintOutDTO();

		String returnCode = "";
		String returnMsg = "";

		int totalDate = inDto.getTotalDate();


		// 根据流水和缴费日期查询缴费记录
		Map<String, Object> inMap = new HashMap<String, Object>();

		if (inDto.getContractNo() > 0) {
			long contractNo = inDto.getContractNo();
			inMap.put("CONTRACT_NO", contractNo);
		}

		inMap.put("SUFFIX", totalDate / 100);
		if (StringUtils.isNotEmptyOrNull(inDto.getForeignSn())) {
			String foreignSn = inDto.getForeignSn();
			inMap.put("FOREIGN_SN", foreignSn);
		}
		if (inDto.getPaySn() > 0) {
			long paySn = inDto.getPaySn();
			inMap.put("PAY_SN", paySn);
		}
		Log.debug("参数：" + inMap);
		List<PayMentEntity> paymentList = record.getPayMentList(inMap);
		if (paymentList.size() == 0) {
			returnCode = "5A11";
			returnMsg = "此交易不存在";
			outDto.setReturnCode(returnCode);
			outDto.setReturnMsg(returnMsg);
			return outDto;
		}
		// 判断是否打印过发票，如果已打印过发票 2A07 本次交易已经打印发票
		// 判断是否打印过月结发票
		inMap.put("PAY_SN", paymentList.get(0).getPaySn());
		int printMonthFlag = invoice.isPrintMonthInvoice(inMap);
		if (printMonthFlag > 0) {
			returnCode = "2A07";
			returnMsg = "本次交易已经打印发票";
			outDto.setReturnCode(returnCode);
			outDto.setReturnMsg(returnMsg);
			return outDto;
		}
		inMap.put("SUFFIX", totalDate / 100 + "");
		// 判断是否打印过预存发票
		BalInvprintInfoEntity printInfo = invoice.qryInvoiceInfo(inMap);
		if (printInfo != null) {
			returnCode = "2A07";
			returnMsg = "本次交易已经打印发票";
			outDto.setReturnCode(returnCode);
			outDto.setReturnMsg(returnMsg);
			return outDto;
		}
		// 查询用户信息
		UserInfoEntity userInfo = user.getUserEntityByConNo(paymentList.get(0).getContractNo(), true);
		String phoneNo = paymentList.get(0).getPhoneNo();
		long custId = userInfo.getCustId();
		long idNo = userInfo.getIdNo();
		// 记录发票打印记录表
		BalInvprintInfoEntity balInvprintInfo = new BalInvprintInfoEntity();
		long printSn = invoice.getPrintSn();
		balInvprintInfo.setPrintSn(printSn);
		balInvprintInfo.setPrintArray(1);
		balInvprintInfo.setPhoneNo(phoneNo);
		balInvprintInfo.setCustId(custId);
		balInvprintInfo.setIdNo(idNo);
		balInvprintInfo.setContractNo(paymentList.get(0).getContractNo());
		balInvprintInfo.setInvType(CommonConst.YCFP_TYPE);
		balInvprintInfo.setState(CommonConst.NORMAL_STATUS);// 1:打印正常发票
		balInvprintInfo.setLoginNo(inDto.getLoginNo());
		balInvprintInfo.setGroupId(inDto.getGroupId());
		balInvprintInfo.setOpCode(inDto.getOpCode());
		balInvprintInfo.setTotalDate(DateUtils.getCurDay());
		balInvprintInfo.setInvCode(inDto.getInvCode());
		balInvprintInfo.setInvNo(inDto.getInvNo());
		balInvprintInfo.setPaySn(paymentList.get(0).getPaySn());
		balInvprintInfo.setTotalFee(paymentList.get(0).getPayFee());
		balInvprintInfo.setPrintFee(paymentList.get(0).getPayFee());
		balInvprintInfo.setTaxFee(0l);
		balInvprintInfo.setTaxRate(0d);
		balInvprintInfo.setPrintNum(1);
		balInvprintInfo.setRemark("预存发票打印");
		balInvprintInfo.setBeginYmd(totalDate + "");
		balInvprintInfo.setEndYmd(totalDate + "");
		balInvprintInfo.setBillCycle(totalDate / 100);
		balInvprintInfo.setPrintSeq(ValueUtils.intValue(1));

		List<BalInvprintInfoEntity> balInvprintInfoList = new ArrayList<BalInvprintInfoEntity>();
		balInvprintInfoList.add(balInvprintInfo);
		invoice.iBalInvprintInfo(balInvprintInfoList);

		// 更新print_flag
		invoice.updatePrintFlagByPre(paymentList.get(0).getPaySn(), printSn, paymentList.get(0).getPayType(), totalDate / 100, paymentList.get(0)
				.getContractNo());
		// 入营业员操作记录表
		LoginOprEntity loe = new LoginOprEntity();
		loe.setLoginGroup(inDto.getGroupId());
		loe.setLoginNo(inDto.getLoginNo());
		loe.setLoginSn(printSn);
		loe.setTotalDate(DateUtils.getCurDay());
		loe.setIdNo(idNo);
		loe.setPhoneNo(phoneNo);
		loe.setBrandId("xx");
		loe.setPayType("00");
		loe.setPayFee(0);
		loe.setOpCode(inDto.getOpCode());
		loe.setRemark(inDto.getLoginNo() + "打印预存发票");
		record.saveLoginOpr(loe);

		returnCode = "0000";
		returnMsg = "成功";
		outDto.setReturnCode(returnCode);
		outDto.setReturnMsg(returnMsg);
		return outDto;
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

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

}
