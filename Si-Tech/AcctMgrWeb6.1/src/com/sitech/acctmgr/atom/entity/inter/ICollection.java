package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.collection.CollBillAddEntity;
import com.sitech.acctmgr.atom.domains.collection.CollConDealEntity;
import com.sitech.acctmgr.atom.domains.collection.CollConDealRecdEntity;
import com.sitech.acctmgr.atom.domains.collection.CollFileDetailEntity;
import com.sitech.acctmgr.atom.domains.collection.CollectionConf;
import com.sitech.acctmgr.atom.domains.collection.CollectionDispEntity;
import com.sitech.acctmgr.atom.domains.cust.PostBankEntity;

/**
 * Created by wangyla on 2016/7/5.
 */
public interface ICollection {
    List<CollectionDispEntity> getCollectionOrderList
            (String disGroupId, int yearMonth, String begBank, String endBank, int begPrintNo, int endPrintNo, String provinceId,boolean noPrinted);

    /**
	 * 功能：查询帐户指定帐期的托收单明细信息
	 *
	 * @param contractNo
	 * @param billCycle
	 * @return
	 */
    CollectionDispEntity getBillDetByContract(Long contractNo, int billCycle);

    /**
	 * 功能：查询区县下托收配置信息
	 * 
	 * @param disGroupId
	 * @param enterCode
	 * @param feeCode
	 * @return
	 */
    List<CollectionConf> getCollConfInfo(String disGroupId,String enterCode, String feeCode);

    /**
	 * 功能：托收文件生成时，记录托收文件信息
	 * 
	 * @param fileName
	 *            托收文件名称
	 * @param yearMonth
	 *            托收帐期
	 * @param loginNo
	 *            操作工号
	 */
    void saveCollectionFileRecd(String fileName, int yearMonth, String loginNo);

    /**
	 * 功能：记录已生成托收文件的托收帐户信息
	 * 
	 * @param loginAccept
	 *            操作流水
	 * @param contractNo
	 *            托收帐户
	 * @param yearMonth
	 *            托收月份
	 * @param loginNo
	 *            操作工号
	 */
    void saveCollectionDealInfo(Long loginAccept, Long contractNo, int yearMonth, String loginNo);
    
    /**
	 * @Description: 判断托收帐户是否已打印过发票
	 * @author: wangyla
	 * @version:
	 * @createTime: 2015-7-30 下午8:02:14
	 * 
	 * @param
	 * @return Boolean true:has printed; false:not printed
	 */
	    
	public Boolean isCollConHasPrinted(long contractNo, int yearMonth);
	
	
	public PostBankEntity getPostBankInfo(long regionCode, String bankCode);
	
	public List<PostBankEntity> getBankInfoList(long regionCode, int pageNum, int pageSize);

	/**
	 * 功能：帐户补托收验证
	 * 
	 * @param contractNo
	 * @param yearMonth
	 * @param payFee
	 * @return
	 */
	int getCollBillAddCount(long contractNo, int yearMonth, long payFee);

	void saveCollBillAdd(CollBillAddEntity collBillAddEnt);
	
	/**
	 * 功能：检查托收账户是否已处理
	 * 
	 * @param contractNo
	 * @param yearMonth
	 * @return true：已处理 false：未处理
	 */
	boolean hasCollDealed(long contractNo, int yearMonth);
	
	/**
	 * 功能：托收文件明细信息入库
	 */
	void saveConTotalFileDetailInfo(CollFileDetailEntity collFileDetEnt);
	
	/**
	 * 功能：修改回执单处理状态
	 * 
	 * @param contractNo
	 * @param yearMonth
	 */
	void updateDealFlag(long contractNo,int yearMonth);
	
	/**
	 * 托收内容处理入库
	 * 
	 * @param collConDealEnt
	 */
	void saveCollConDeal(CollConDealEntity collDealEnt);

	/**
	 * 查询为处理的托收账户信息
	 * 
	 * @author liuhl_bj
	 * @param inMap
	 * @return
	 */
	List<Map<String, Object>> getUnDealConInfo(Map<String, Object> inMap);

	/**
	 * 托收单打印判断是否重打
	 * 
	 * @author liuhl_bj
	 * @param contractNo
	 * @param yearMonth
	 * @param printFlag
	 * @return
	 */
	boolean isRePrint(long contractNo, int yearMonth, int printFlag);

	/**
	 * 查询某账户的托收单明细
	 * 
	 * @author liuhl_bj
	 * 
	 * @param contractNo
	 * @param yearMonth
	 * @return
	 */
	CollectionDispEntity getCollBill(long contractNo, int yearMonth);
	
	/**
	 * 补托收文件生成入ACT_COLLCONDEAL_RECD表
	 * 对应老接口：s4426Cfm
	 * 
	 */
	void saveCollRecord(CollConDealRecdEntity CollConDealRecdEnt);
	
}
