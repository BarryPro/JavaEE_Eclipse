package com.sitech.acctmgr.atom.impl.invoice;

//import com.sitech.acctmgr.atom.busi.intface.IBusiMsgSnd;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.invoice.InvInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8056QryInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8056QryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I8056ZFInvoice;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


@ParamTypes({ @ParamType(c = S8056QryInDTO.class, m = "query", oc = S8056QryOutDTO.class) })
public class S8056ZFInvoice extends AcctMgrBaseService implements I8056ZFInvoice {

	private IInvoice invoice;

	@Override
	public OutDTO query(InDTO inParam) {
		S8056QryInDTO inDto = (S8056QryInDTO) inParam;
		long paySn = inDto.getPaySn();
		int totalDate = inDto.getTotalDate();
		long contractNo = inDto.getContractNo();

		int printYm = 0;
		int flag = 0;// 是否打印过虚拟集团发票
		String invNo = "";
		String invCode = "";
		List<InvInfoEntity> invInfoList = new ArrayList<InvInfoEntity>();
		// 判断是否打印过预开发票或者集团发票
		Map<String, Object> outMap = invoice.getGrpPreInfo(contractNo, 0, paySn);
		if (outMap != null) {
			printYm = ValueUtils.intValue(outMap.get("OP_TIME").toString().substring(0, 4));
			flag = 4;
		}else{
			// 判断是否打印过预存发票
			outMap = invoice.getPrintInfo(paySn, totalDate / 100, contractNo);
			if (outMap != null) {
				invNo = outMap.get("INV_NO").toString();
				invCode = outMap.get("INV_CODE").toString();
				printYm = ValueUtils.intValue(outMap.get("YEAR_MONTH").toString());
				InvInfoEntity invInfo = new InvInfoEntity();
				invInfo.setInvCode(invCode);
				invInfo.setInvNo(invNo);
				invInfo.setPrintYm(printYm);
				invInfo.setInvType("PM3001");
				invInfoList.add(invInfo);
				flag=2;
			}else{
				// 判断是否打印了月结发票或者增值税发票
				outMap = invoice.getMonthInvoice(paySn, totalDate / 100, contractNo);
				if (ValueUtils.intValue(outMap.get("PRINT_TAX")) != 0) {
					// 打印过增值税发票
					flag = 3;
				}
				if (ValueUtils.intValue(outMap.get("PRINT_MONTH")) != 0) {
					// 打印过月结发票
					flag = 1;
				}
				List<Map<String, Object>> infoMapList = (List<Map<String, Object>>) outMap.get("INV_LIST");
				if (infoMapList.size() > 0) {
					for (Map<String, Object> invInfoMap : infoMapList) {
						InvInfoEntity invInfo = new InvInfoEntity();
						invInfo.setInvCode(invInfoMap.get("INV_CODE").toString());
						invInfo.setInvNo(invInfoMap.get("INV_NO").toString());
						invInfo.setPrintYm(ValueUtils.intValue(invInfoMap.get("PRINT_TIME").toString()));
						invInfo.setInvType(invInfoMap.get("INV_TYPE").toString());
						invInfoList.add(invInfo);
					}
				}
				

			}
		}
		S8056QryOutDTO outDto = new S8056QryOutDTO();
		outDto.setInvInfo(invInfoList);
		outDto.setPrintType(flag);
		return outDto;
	}

	@Override
	public OutDTO cfm(InDTO inDto) {
		// TODO Auto-generated method stub
		return null;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

}
