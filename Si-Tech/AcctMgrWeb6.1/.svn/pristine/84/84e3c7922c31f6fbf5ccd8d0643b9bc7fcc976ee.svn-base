package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.balance.TransFeeEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.PayInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.S3101QryInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S3101QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAgent;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.invoice.I3101;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = S3101QryInDTO.class, m = "query", oc = S3101QryOutDTO.class) })
public class S3101 extends AcctMgrBaseService implements I3101 {
	private IAgent agent;
	private IRecord record;
	private ICust cust;
	private IUser user;
	private IControl control;
	private IInvoice invoice;

	@Override
	public OutDTO query(InDTO inParam) {
		S3101QryInDTO inDto = (S3101QryInDTO) inParam;
		int beginYm = 0;
		int endYm = 0;
		int yearMonth = 0;
		int beginDate = 0;
		int endDate = 0;
		// int sum = 0;
		Map<String, Object> inMap = new HashMap<String, Object>();

		String phoneNo = inDto.getPhoneNo();
		int qryType = inDto.getQryType();
		// int pageNum = inDto.getPageNum();
		if (StringUtils.isNotEmptyOrNull(inDto.getYearMonth()) && inDto.getYearMonth() > 0) {
			yearMonth = inDto.getYearMonth();
		}
		if (StringUtils.isNotEmptyOrNull(inDto.getBeginDate()) && inDto.getBeginDate() > 0) {
			beginDate = inDto.getBeginDate();
			inMap.put("BEGIN_DATE", beginDate);
		}
		if (StringUtils.isNotEmptyOrNull(inDto.getEndDate()) && inDto.getEndDate() > 0) {
			endDate = inDto.getEndDate();
			inMap.put("END_DATE", endDate);
		}

		if (qryType == 0) {
			beginYm = yearMonth;
			endYm = yearMonth;
			inMap.remove("BEGIN_DATE");
			inMap.remove("END_DATE");
		} else {
			beginYm = beginDate / 100;
			endYm = endDate / 100;

		}

		// 查询空中充值代理商账户
		long agentCon = agent.getAgentCon(phoneNo);

		// 判断服务号码是否为空中充值号码
		boolean flag = agent.isKcAgentPhone(phoneNo, agentCon + "");
		if (!flag) {
			throw new BusiException(AcctMgrError.getErrorCode("3101", "00000"), "该用户不是空中充值代理商用户");
		}
		// 根据转出号码和年月查询转账记录
		inMap.put("PHONENO_OUT", phoneNo);
		inMap.put("STATUS", "0");
		inMap.put("OP_TYPE", "KcAgentTrans");
		List<PayInfoEntity> paymentList = new ArrayList<PayInfoEntity>();
		for (int ym = beginYm; ym <= endYm; ym = DateUtils.addMonth(ym, 1)) {
			inMap.put("SUFFIX", ym + "");
			List<TransFeeEntity> transFeeList = record.getTransInfo(inMap);
			if (transFeeList == null || transFeeList.size() == 0) {
				// throw new BusiException(AcctMgrError.getErrorCode("3101", "00001"),"未查询到转账记录");
				continue;
			}
			for (TransFeeEntity transFee : transFeeList) {
				PayInfoEntity payment = new PayInfoEntity();
				// 根据转入账户的服务号码查询客户名称
				UserInfoEntity userInfo = user.getUserEntityByPhoneNo(transFee.getPhonenoIn(), true);
				CustInfoEntity custInfo = cust.getCustInfo(userInfo.getCustId(), "");
				payment.setCustName(custInfo.getCustName());

				payment.setPhoneNo(transFee.getPhonenoIn());
				payment.setContractNo(transFee.getContractnoIn());
				payment.setLoginAccept(transFee.getTransSn());
				payment.setPayMoney(transFee.getTransFee());
				payment.setOpTime(transFee.getOpTime());
				payment.setTotalDate(transFee.getTotalDate() + "");

				// 查询是否打印过
				int printFlag = invoice.getPrintFlag(transFee.getTransSn(), ym, transFee.getContractnoIn());
				payment.setPrintFlag(printFlag);
				paymentList.add(payment);
			}
		}
		S3101QryOutDTO outDto = new S3101QryOutDTO();
		outDto.setPayInfoList(paymentList);
		return outDto;
	}

	public IAgent getAgent() {
		return agent;
	}

	public void setAgent(IAgent agent) {
		this.agent = agent;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

}
