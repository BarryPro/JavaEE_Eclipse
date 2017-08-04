package com.sitech.acctmgr.atom.impl.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.account.AccountEntity;
import com.sitech.acctmgr.atom.domains.account.ContractEntity;
import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.query.familyEntity;
import com.sitech.acctmgr.atom.domains.user.UserBrandEntity;
import com.sitech.acctmgr.atom.domains.user.UserExpireEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserRelEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SFeeQueryBalanceQueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SFeeQueryBalanceQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAccount;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.ICust;
import com.sitech.acctmgr.atom.entity.inter.IRemind;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.inter.feeqry.IFeeQuery;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


/**
 * Created by wangyla on 2016/7/21.
 */
@ParamTypes({
        @ParamType(c = SFeeQueryBalanceQueryInDTO.class, m = "balanceQuery", oc = SFeeQueryBalanceQueryOutDTO.class)
})
public class SFeeQuery extends AcctMgrBaseService implements IFeeQuery {
    private IUser user;
    private ICust cust;
    private IAccount account;
    private IRemainFee remainFee;
	private IRemind remind;
	private IBill bill;
    
    @Override
    public OutDTO balanceQuery(InDTO inParam) {
        SFeeQueryBalanceQueryInDTO inDTO = (SFeeQueryBalanceQueryInDTO) inParam;
		long awokeFee = 0;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        String mainFlag = inDTO.getMainFlag();
		if( StringUtils.isEmptyOrNull(mainFlag) ){
			mainFlag = "2";
		}       
        
        UserInfoEntity userInfo = user.getUserInfo(phoneNo);
        long idNo = userInfo.getIdNo();
        long contractNo = userInfo.getContractNo();

        UserBrandEntity brandInfo = user.getUserBrandRel(userInfo.getIdNo());

        UserExpireEntity expireInfo = user.getUserExpireInfo(userInfo.getIdNo());

        CustInfoEntity custInfo = cust.getCustInfo(userInfo.getCustId(), null);

        ContractInfoEntity conInfo = account.getConInfo(userInfo.getContractNo());

        OutFeeData feeInfo = remainFee.getConRemainFee(conInfo.getContractNo());
        long conRemainFee = feeInfo.getRemainFee();

        List<AccountEntity> accountList = getCollectionOrPackYearConList(userInfo.getIdNo());

		// TODO 需要补充底线费用的获取方式
        String hasLowest;
		long lowestFee = bill.getUnbillDxInfo(contractNo,idNo).get("DX_PAY_MONEY");

        hasLowest = lowestFee > 0 ? "Y" : "N";

		// 查询余额提醒阀值
		awokeFee = remind.qryAwokeFee(userInfo.getIdNo(), 0, "0");
		
		//增加主副卡未出账查询
		String mainPhoneNo = "";
		long mainUnibill = 0;
		String secPhoneNo = "";
		long secUnibill =0;
		List<familyEntity> familyList = new ArrayList<familyEntity>();
		if(mainFlag.equals("0")) {
			mainPhoneNo = phoneNo;
			
			long[] memRoleIds = {21098,21100,21105,21108};
			long cnt = user.getCntFamlily(idNo, memRoleIds);
												
			//流量伴侣卡业务
			UserRelEntity ure = user.getMateId(idNo, 0);
			if(ure==null&&cnt==0) {
				throw new BusiException(AcctMgrError.getErrorCode("8436", "00001"), "主副卡关系校验失败！");
			}
			if(ure!=null) {
				long slaveId = ure.getSlaveId();
				
				//查询副卡号码
				UserInfoEntity uie = user.getUserEntityByIdNo(slaveId, true);
				secPhoneNo = uie.getPhoneNo();
				
				//查询主卡未出账
				UnbillEntity ube = bill.getUnbillFee(contractNo, idNo, CommonConst.UNBILL_TYPE_BILL_TOT_PRE);
				mainUnibill = ube.getUnBillFee();

				//查询副卡未出账
				UnbillEntity ubeSlave = bill.getUnbillFee(contractNo, slaveId, CommonConst.UNBILL_TYPE_BILL_TOT_PRE);
				
				familyEntity fe= new familyEntity();
				fe.setSecPhone(secPhoneNo);
				fe.setSecUnBill(ubeSlave.getUnBillFee());
				familyList.add(fe);
			}
					
			//家庭业务
			List<Long> secList = user.getFamlilyIds(idNo);
			for(long secId:secList) {
				familyEntity fes= new familyEntity();
				UserInfoEntity uies = user.getUserEntityByIdNo(secId, true);
				 secPhoneNo =uies.getPhoneNo();
				 
				 UnbillEntity ubes = bill.getUnbillFee(contractNo, secId, CommonConst.UNBILL_TYPE_BILL_TOT_PRE);
				 secUnibill = ubes.getUnBillFee();
				 fes.setSecPhone(secPhoneNo);
				 fes.setSecUnBill(secUnibill);
				 familyList.add(fes);
			}
		}else if(mainFlag.equals("1")) {
			long mainId=0;
			long contractMain =0;
			
			long[] memRoleIds = {21097,21101,21109,21106};
			long cnt = user.getCntFamlily(idNo, memRoleIds);
			
			//流量伴侣卡
			UserRelEntity ure = user.getMateId(0, idNo);
			if(ure==null&&cnt==0) {
				throw new BusiException(AcctMgrError.getErrorCode("8436", "00001"), "主副卡关系校验失败！");
			}
			if(ure!=null) {
				mainId = ure.getMasterId();
				UserInfoEntity uieMain = user.getUserEntityByIdNo(mainId, true);
				mainPhoneNo =uieMain.getPhoneNo();
				contractMain = uieMain.getContractNo();

			}
			
			if(phoneNo.substring(0, 3).equals("207")||phoneNo.substring(0, 3).equals("209")) {
				//查询主卡号码
				mainId = user.getFamlilyMainId(idNo);
				UserInfoEntity uie = user.getUserEntityByIdNo(mainId, true);
				mainPhoneNo =uie.getPhoneNo();
				contractMain = uie.getContractNo();
			}
			
			OutFeeData feeMain = remainFee.getConRemainFee(contractMain);
			conRemainFee = feeMain.getRemainFee();
			
			UnbillEntity ube = bill.getUnbillFee(contractMain, idNo, CommonConst.UNBILL_TYPE_BILL_TOT_PRE);
			secUnibill = ube.getUnBillFee();
			
			familyEntity fe= new familyEntity();
			fe.setSecPhone(phoneNo);
			fe.setSecUnBill(secUnibill);
			familyList.add(fe);
		}

        SFeeQueryBalanceQueryOutDTO outDTO = new SFeeQueryBalanceQueryOutDTO();
        outDTO.setCustName(custInfo.getBlurCustName());
        outDTO.setExpireTime((expireInfo == null) ? "" : expireInfo.getExpireTime1());
		outDTO.setBeginFlag((expireInfo == null) ? "N" : expireInfo.getBeginFlag());
        outDTO.setContractName(conInfo.getBlurContractName());
        outDTO.setPayCode(conInfo.getPayCode());
        outDTO.setPayName(conInfo.getPayCodeName());
        outDTO.setBrandId(brandInfo.getBrandId());
        outDTO.setBrandName(brandInfo.getBrandName());
		outDTO.setPrepayFee(feeInfo.getPrepayFee()); // 总预存
        outDTO.setDelayFee(feeInfo.getDelayFee());
        outDTO.setOweFee(feeInfo.getOweFee());
        outDTO.setUnbillOwe(feeInfo.getUnbillFee());
        outDTO.setSpecPrepay(feeInfo.getSepcialFee());
        outDTO.setNormalPrepay(feeInfo.getPrepayFee() - feeInfo.getSepcialFee());
        outDTO.setRemainFee(conRemainFee);
        outDTO.setHasLowest(hasLowest);
        outDTO.setLowestFee(lowestFee);
        outDTO.setAccountList(accountList);
		outDTO.setAwokeFee(awokeFee);
		
		outDTO.setMainPhone(mainPhoneNo);
		outDTO.setMainUnBill(mainUnibill);
		outDTO.setFamilyList(familyList);
		
        log.debug("outDto=" + outDTO.toJson());

        return outDTO;
    }

    private List<AccountEntity> getCollectionOrPackYearConList(long idNo) {
        List<ContractEntity> conList = account.getConList(idNo);

        List<ContractEntity> outConList = new ArrayList<>();
        List<AccountEntity> accoutList = new ArrayList<>();

        for (ContractEntity conEnt : conList) {
            if (conEnt.getPayCode().equals(CommonConst.PAYCODE_COLLECTION) ||
                    conEnt.getAttType().equals(CommonConst.PAYATTRTYPE_PACKYEAR)) {

                OutFeeData feeTmp = remainFee.getConRemainFee(conEnt.getCon());
                long remainFeeTmp = feeTmp.getRemainFee();

                AccountEntity accoutEnt = new AccountEntity();
                accoutEnt.setContractNo(conEnt.getCon());
                accoutEnt.setRemainFee(remainFeeTmp);
                accoutEnt.setUnbillFee(feeTmp.getUnbillFee());
				if (conEnt.getPayCode().equals(CommonConst.PAYCODE_COLLECTION)) {
					accoutEnt.setAccountType("3");
				}
				if (conEnt.getAttType().equals(CommonConst.PAYATTRTYPE_PACKYEAR)) {
					accoutEnt.setAccountType("p");
				}
                accoutList.add(accoutEnt);
            }
        }

        return accoutList;
    }

    private long getLowestFee(long idNo) {
		// TODO 补充最低消费金额获取
        return 0;
    }
    

	public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
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

    public IRemainFee getRemainFee() {
        return remainFee;
    }

    public void setRemainFee(IRemainFee remainFee) {
        this.remainFee = remainFee;
    }

	public IRemind getRemind() {
		return remind;
	}

	public void setRemind(IRemind remind) {
		this.remind = remind;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

}
