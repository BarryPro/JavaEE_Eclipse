package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.LoginEntity;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.PayMentEntity;
import com.sitech.acctmgr.atom.domains.query.PayCardEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.STopPayPrtQryInDTO;
import com.sitech.acctmgr.atom.dto.query.STopPayPrtQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.ILogin;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.ITopPayPrtQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = STopPayPrtQryInDTO.class, m = "query", oc = STopPayPrtQryOutDTO.class)

})
public class STopPayPrtQry extends AcctMgrBaseService implements ITopPayPrtQry {

	private IRecord record;
	private IInvoice invoice;
	private IUser user;
	private ILogin login;

	@Override
	public OutDTO query(InDTO inParam) {
		STopPayPrtQryInDTO inDto = (STopPayPrtQryInDTO) inParam;
		STopPayPrtQryOutDTO outDto = new STopPayPrtQryOutDTO();
		outDto.setHomeProv("451");
		// 根据外部流水和时间查询缴费记录
		String foreignSn = inDto.getForeignSn();
		int totalDate = inDto.getTotalDate();

		// 查询用户信息
		String phoneNo = inDto.getPhoneNo();
		UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
		if (userInfo == null) {
			outDto.setSreturncode("2A11");
			outDto.setSreturnmsg("该用户不存在");
			return outDto;
		}
		String loginNo = inDto.getLoginNo();
		LoginEntity loginInfo = login.getLoginInfo(loginNo, inDto.getProvinceId());
		if (loginInfo == null) {
			outDto.setSreturncode("2A08");
			outDto.setSreturnmsg("crm端返回失败");
			return outDto;
		}
		// 查询工号信息

		Map<String, Object> inMap = new HashMap<String, Object>();
		// inMap.put("FOREIGN_SN", foreignSn);
		inMap.put("SUFFIX", totalDate);
		// 老系统数据：根据外部流水从bal_paycard_recd
		List<PayCardEntity> payCardList = record.getPayCardList(foreignSn, 0l, "");
		List<PayMentEntity> paymentList = new ArrayList<>();
		if (payCardList != null) {
			for (PayCardEntity payCard : payCardList) {
				long paySn = payCard.getPaySn();
				inMap.put("PAY_SN", paySn);
				List<PayMentEntity> paymentListTmp = record.getPayMentList(inMap);
				paymentList.addAll(paymentListTmp);
			}
		} else {
			inMap.put("FOREIGN_SN", foreignSn);
			List<PayMentEntity> paymentListTmp = record.getPayMentList(inMap);
			paymentList.addAll(paymentListTmp);
		}
		if (paymentList.size() == 0 || paymentList == null) {
			outDto.setSreturncode("4A00");
			outDto.setSreturnmsg("缴费记录不存在");
			return outDto;
		}

		// PayMentEntity paymentInfo = paymentList.get(0);
		List<BalInvprintInfoEntity> balInvoicePrint = new ArrayList<BalInvprintInfoEntity>();
		for (PayMentEntity paymentInfo : paymentList) {
			inMap.put("PAY_SN", paymentInfo.getPaySn());
			for (int yearMonth = totalDate; yearMonth <= DateUtils.getCurYm(); yearMonth = DateUtils.addMonth(yearMonth, 1)) {
				inMap.put("YEAR_MONTH", yearMonth);
				List<BalInvprintInfoEntity> balInvoicePrintTmp = invoice.getInvoInfoByInvNo(inMap);
				if (balInvoicePrintTmp != null) {
					balInvoicePrint.addAll(balInvoicePrintTmp);
					break;
				}
			}
		}
		// 查询该笔流水有没有打印过
		// long paySn = paymentInfo.getPaySn();

		int printFlag = balInvoicePrint.size();
		if (printFlag == 0) {
			outDto.setSreturncode("2A06");
			outDto.setSreturnmsg("发票未打印");
		} else {
			outDto.setSreturncode("2A07");
			outDto.setSreturnmsg("发票已打印");
			outDto.setAcctDate(balInvoicePrint.get(0).getTotalDate() + "");
		}
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

	public ILogin getLogin() {
		return login;
	}

	public void setLogin(ILogin login) {
		this.login = login;
	}

}
