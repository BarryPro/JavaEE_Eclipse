package com.sitech.acctmgr.atom.impl.invoice;

//import com.sitech.acctmgr.atom.busi.intface.IBusiMsgSnd;
import java.util.List;

import com.sitech.acctmgr.atom.domains.invoice.InvoInfoEntity;
import com.sitech.acctmgr.atom.dto.invoice.S8056ZfRelatedInvoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8056ZfRelatedInvoOutDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8056qryRelatedInvoInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8056qryRelatedInvoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.invoice.I8056ZfInvo;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


@ParamTypes({ @ParamType(c = S8056qryRelatedInvoInDTO.class, m = "qryRelatedInvo", oc = S8056qryRelatedInvoOutDTO.class),
		@ParamType(c = S8056ZfRelatedInvoInDTO.class, m = "zfRelatedInvo", oc = S8056ZfRelatedInvoOutDTO.class) })
public class S8056RelatedInvo extends AcctMgrBaseService implements I8056ZfInvo {

	protected IInvoice invoice;


	@Override
	public OutDTO qryRelatedInvo(InDTO inparam) {
		// TODO Auto-generated method stub

		S8056qryRelatedInvoInDTO inArg = (S8056qryRelatedInvoInDTO) inparam;
		S8056qryRelatedInvoOutDTO outArg = new S8056qryRelatedInvoOutDTO();

		/** 查询于此缴费相关的所有发票 **/
		List<InvoInfoEntity> invList = invoice.getInvOfRelatePaySn(inArg.getPaySn(), inArg.getPayYM(), inArg.getContractNo());

		outArg.setInvList(invList);
		outArg.setCount(invList.size());
		log.debug("outArg=" + outArg.toJson());
		return outArg;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.inter.invoice.I8056ZfInvo#zfRelatedInvo(com.sitech.jcfx.dt.in.InDTO) */
	@Override
	public OutDTO zfRelatedInvo(InDTO inParam) {
		// TODO Auto-generated method stub

		S8056ZfRelatedInvoInDTO inArg = (S8056ZfRelatedInvoInDTO) inParam;
		S8056ZfRelatedInvoOutDTO outArg = new S8056ZfRelatedInvoOutDTO();
		System.out.println("222444" + inArg.getInvList());
		invoice.dealWriteoffForZf(inArg.getInvList(), inArg.getPayYm());
		System.out.println("2224445555" + inArg.getInvList());
		if (inArg.getQryType() == 2) {
			// move the certain information into history table , update the state of original information
			// 已经历史表，然后修改状态为‘p’
			System.out.println("222" + inArg.getInvList());
			long printSn = inArg.getInvList().get(0).getPrintSn();
			int qryMon = inArg.getInvList().get(0).getBillCyle();
			invoice.oprVirtualBloc(printSn, qryMon, inArg.getLoginNo());
		}

		log.debug("outArg" + outArg.toJson());
		return outArg;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

}
