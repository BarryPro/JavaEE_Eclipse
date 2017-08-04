package com.sitech.acctmgr.atom.impl.invoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.invoice.inter.IElecInvoice;
import com.sitech.acctmgr.atom.domains.invoice.BalInvprintInfoEntity;
import com.sitech.acctmgr.atom.domains.invoice.elecInvoice.EleInvoiceInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceDownLoadInDTO;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceDownLoadOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceIssueInDTO;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceIssueOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoicePushInDTO;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceQueryInDto;
import com.sitech.acctmgr.atom.dto.invoice.eleInvoice.SEleInvoiceQueryOutDto;
import com.sitech.acctmgr.atom.entity.inter.IBase;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.invoice.IEleInvoice;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = SEleInvoiceQueryInDto.class, oc = SEleInvoiceQueryOutDto.class, m = "query"),
		@ParamType(c = SEleInvoiceDownLoadInDTO.class, oc = SEleInvoiceDownLoadOutDTO.class, m = "downLoad"),
		@ParamType(c = SEleInvoiceIssueInDTO.class, oc = SEleInvoiceIssueOutDTO.class, m = "issue") })
public class SEleInvoice extends AcctMgrBaseService implements IEleInvoice {

	private IInvoice invoice;
	private IBase base;
	private IElecInvoice elecInvoice;

	@Override
	public OutDTO query(InDTO inParam) {
		SEleInvoiceQueryInDto inDto = (SEleInvoiceQueryInDto) inParam;

		String phoneNo = inDto.getPhoneNo();
		long contractNo = inDto.getContractNo();
		String requestSn = inDto.getRequestSn();
		String invCode = inDto.getInvCode();
		String invNo = inDto.getInvNo();
		int beginDate = inDto.getBeginDate();
		int endDate = inDto.getEndDate();
		int queryType = inDto.getQueryType();
		String invType = inDto.getInvType();
		
		Map<String, Object> inMap = new HashMap<String, Object>();

		inMap.put("PHONE_NO", phoneNo);
		if (contractNo > 0) {
			inMap.put("CONTRACT_NO", contractNo);
		}

		inMap.put("REQUEST_SN", requestSn);
		inMap.put("INV_CODE", invCode);
		inMap.put("INV_NO", invNo);
		if (beginDate > 0) {
			inMap.put("BEGIN_DATE", beginDate);
		}
		if (endDate > 0) {
			inMap.put("END_DATE", endDate);
		}
		inMap.put("INV_TYPE", invType);
		
		int beginYm=beginDate/100;
		int endYm=endDate/100;

		List<EleInvoiceInfoEntity> eleInvoiceList = new ArrayList<EleInvoiceInfoEntity>();
		for (int suffix = beginYm; suffix <= endYm; suffix = DateUtils.addMonth(suffix, 1)) {
			inMap.put("SUFFIX", suffix);
			// 获取电子发票打印信息
			List<BalInvprintInfoEntity> invPrintInfoListTmp = invoice.qryInvoiceInfoList(inMap);
			// 如果是集团打印发票 8241和8290，按照服务号码和账户号码查询时排除
			if (StringUtils.isNotEmptyOrNull(phoneNo) || StringUtils.isNotEmptyOrNull(contractNo)) {
				for (BalInvprintInfoEntity printInfo : invPrintInfoListTmp) {
					Map<String, Object> invMap = new HashMap<>();
					invMap.put("INV_NO", printInfo.getInvNo());
					invMap.put("INV_CODE", printInfo.getInvCode());
					invMap.put("YEAR_MONTH", suffix);
					List<BalInvprintInfoEntity> tmp= invoice.getInvoInfoByInvNo(invMap);
					if (tmp.size() > 1) {
						continue;
					}
					EleInvoiceInfoEntity eleInvoiceInfo = new EleInvoiceInfoEntity();
					eleInvoiceInfo.setInvCode(printInfo.getInvCode());
					eleInvoiceInfo.setInvCode(printInfo.getInvCode());
					eleInvoiceInfo.setInvType(printInfo.getInvType());
					eleInvoiceInfo.setRequestSn(printInfo.getRequestSn());
					eleInvoiceInfo.setOpTime(printInfo.getOpTime());
					eleInvoiceInfo.setLoginAccept(printInfo.getPrintSn() + "");
					eleInvoiceInfo.setState(printInfo.getState());
					eleInvoiceInfo.setLoginNo(printInfo.getLoginNo());
					eleInvoiceInfo.setPrintFee(printInfo.getPrintFee());
					// 获取操作名称
					String functionName = base.getFunctionName(printInfo.getOpCode());
					eleInvoiceInfo.setOpName(functionName);
					eleInvoiceList.add(eleInvoiceInfo);
				}
			}
		}

		SEleInvoiceQueryOutDto outDto = new SEleInvoiceQueryOutDto();
		outDto.setEleInvoiceList(eleInvoiceList);
		return outDto;
	}

	@Override
	public OutDTO downLoad(InDTO inParam) {
		SEleInvoiceDownLoadInDTO inDTO = (SEleInvoiceDownLoadInDTO) inParam;
		SEleInvoiceDownLoadOutDTO outDTO = new SEleInvoiceDownLoadOutDTO();

		String invReqSn = inDTO.getInvReqSn();
		String phoneNo = inDTO.getPhoneNo();
		String fileType = inDTO.getFileType(); // 默认为0. 0 原始PDF文件 1 黑白PDF文件 2 PNG图片

		String fileStr = elecInvoice.getInvFile(invReqSn, phoneNo, fileType);

		// 输出
		outDTO.setPdfFile(fileStr);
		log.debug("====download_data：" + outDTO.toJson());
		return outDTO;
	}

	@Override
	public OutDTO invPush(InDTO inParam) {
		SEleInvoicePushInDTO inDto = (SEleInvoicePushInDTO) inParam;
		String phoneNo = inDto.getPhoneNo();
		String pushType = inDto.getPushType();
		String requestSn = inDto.getRequestSn();
		String date = inDto.getReportTime();
		String pushChnSource = inDto.getChnSource();
		// 如果为20开头或者长度不为11，不发送短信
		if (phoneNo.length() != 11 && phoneNo.substring(0, 2).equals("20")) {
			pushType = "0";
		}
		String url = "http://hl.10086.cn/fpxz";
		// 根据requestSn查询chnSource;
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("YEAR_MONTH", date.substring(0, 6));
		inMap.put("REQUEST_SN", requestSn);

		List<BalInvprintInfoEntity> invPrintEnt = invoice.getInvoInfoByInvNo(inMap);
		if (invPrintEnt.size() == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("0000", ""), "未找到开具记录！");
		}
		if (pushType.equals("sms")) {
			elecInvoice.sendSms(phoneNo, url, invPrintEnt.get(0).getChnSource(), requestSn, invPrintEnt.get(0).getOpTime());
		}
		// 发送邮箱

		return null;
	}

	@Override
	public OutDTO issue(InDTO inParam) {
		SEleInvoiceIssueInDTO inDTO = (SEleInvoiceIssueInDTO) inParam;
		SEleInvoiceIssueOutDTO outDto = new SEleInvoiceIssueOutDTO();

		return outDto;
	}
	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IBase getBase() {
		return base;
	}

	public void setBase(IBase base) {
		this.base = base;
	}

	public IElecInvoice getElecInvoice() {
		return elecInvoice;
	}

	public void setElecInvoice(IElecInvoice elecInvoice) {
		this.elecInvoice = elecInvoice;
	}


}
