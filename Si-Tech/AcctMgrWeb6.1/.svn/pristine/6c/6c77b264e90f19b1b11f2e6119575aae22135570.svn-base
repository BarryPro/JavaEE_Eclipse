package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.bill.GrpOweEntity;
import com.sitech.acctmgr.atom.dto.feeqry.S8177InDTO;
import com.sitech.acctmgr.atom.dto.feeqry.S8177OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.feeqry.I8177;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 *
 * <p>
 * Title: 集团客户欠费查询
 * </p>
 * <p>
 * Description: 集团客户欠费查询
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author liuhl_bj
 * @version 1.0
 */

@ParamTypes({ @ParamType(c = S8177InDTO.class, oc = S8177OutDTO.class, m = "query") })
public class S8177 extends AcctMgrBaseService implements I8177 {
	private ICust cust;
	private IAccount account;
	private IBill bill;

	@Override
	public final OutDTO query(InDTO inParam) {

		S8177InDTO inDto = (S8177InDTO) inParam;
		long contractNo = inDto.getContractNo();
		String qryType = inDto.getQryType();
		String unitId = inDto.getUnitId();
		String yearMonth = inDto.getYearMonth();

		List<ContractInfoEntity> contractInfoList = new ArrayList<ContractInfoEntity>();

		List<GrpOweEntity> grpOwelist = new ArrayList<GrpOweEntity>();

		// qryType 0:按照集团编码查询 1：按照账号查询
		if (qryType.equals("0")) {
			// 1.根据客户ID查询账户列表
			contractInfoList = account.getGrpConInfo(Long.parseLong(unitId), 0l, 0l);

		} else {
			contractInfoList = account.getGrpConInfo(0l, 0l, contractNo);
		}

		log.debug("账号列表：" + contractInfoList);
		for (ContractInfoEntity contractInfo : contractInfoList) {

			long contractNoTmp = contractInfo.getContractNo();

			String contractName = contractInfo.getBlurContractName();

			GrpOweEntity grpOweEntity = new GrpOweEntity();
			grpOweEntity.setContractName(contractName);
			grpOweEntity.setContractNo(contractNoTmp);

			// 3.查询账单
			Map<String, Long> unpayMap = bill.getSumUnpayInfo(contractNoTmp, 0l, Integer.parseInt(yearMonth));
			long unpayOwe = unpayMap.get("OWE_FEE");
			grpOweEntity.setOweFee(unpayOwe);
			if (unpayOwe > 0) {
				grpOweEntity.setStatusName("未缴");
			} else {
				grpOweEntity.setStatusName("已缴");
			}

			grpOwelist.add(grpOweEntity);
		}

		S8177OutDTO outDto = new S8177OutDTO();
		outDto.setBillList(grpOwelist);

		return outDto;
	}

	public ICust getCust() {
		return cust;
	}

	public void setCust(ICust cust) {
		this.cust = cust;
	}

	public IAccount getAccount() {
		return account;
	}

	public void setAccount(IAccount account) {
		this.account = account;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

}
