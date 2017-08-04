package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.List;

import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SOweQueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SOweQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.IOweQuery;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
 @ParamType(m = "query", c = SOweQueryInDTO.class, oc = SOweQueryOutDTO.class)
})
public class SOweQuery extends AcctMgrBaseService implements IOweQuery {
	private IBill bill;
	private IUser user;
	@Override
	public OutDTO query(InDTO inParam) {
		SOweQueryInDTO inDto = (SOweQueryInDTO) inParam;

		long idNo = inDto.getIdNo();
		// 获取账户信息
		UserInfoEntity userInfo = user.getUserEntityByIdNo(idNo, true);
		long contractNo = userInfo.getContractNo();
		List<BillEntity> billList=bill.getUnpayOweOnBillCycle(contractNo, idNo);
		SOweQueryOutDTO outDto = new SOweQueryOutDTO();
		outDto.setOutList(billList);
		return outDto;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}
	
}
