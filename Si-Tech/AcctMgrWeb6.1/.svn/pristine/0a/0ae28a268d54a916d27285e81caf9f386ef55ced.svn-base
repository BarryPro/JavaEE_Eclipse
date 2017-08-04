package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.adj.SpInfoEntity;
import com.sitech.acctmgr.atom.domains.prod.PdPrcInfoEntity;
import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;
import com.sitech.acctmgr.atom.domains.prod.UserPdPrcInfoEntity;
import com.sitech.acctmgr.atom.domains.query.ProductOfferUpEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;

/**
 * 
 * <p>
 * Title: 订购资料类
 * </p>
 * <p>
 * Description: 查询订购资料的属性信息
 * </p>
 * <p>
 * Copyright: Copyright (c) 2016
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author zhangbine
 * @version 1.0
 * 
 */
public interface IProd {

	/**
	 * 功能：查询用户订购的主订价信息
	 * 
	 * @param inIdNo
	 * @param throwsFlag
	 *            取不出主定价是否抛出异常，true:抛出，false：不抛出
	 * @return
	 */
	UserPrcEntity getUserPrcidInfo(Long inIdNo, boolean throwsFlag);

	/**
	 * 名称：查询用户主产品资费信息
	 * 
	 * @param inIdNo
	 *            用户标识ID
	 * @return 若未取到用户的主订价信息，则抛出异常
	 * @author zhangbine
	 */
	UserPrcEntity getUserPrcidInfo(Long inIdNo);

	/**
	 * 功能：获取产品资费信息
	 * 
	 * @param prodPrcId
	 * @return
	 */
	PdPrcInfoEntity getPdPrcInfo(String prodPrcId);

	/**
	 * 功能：查询用户的订购的资费
	 * 
	 * @param idNo
	 * @param valid
	 *            true:返回生效的；false：返回全部
	 * @return
	 */
	List<UserPrcEntity> getPdPrcId(long idNo, boolean valid);

	/**
	 * 功能：获取用户订购资费ID
	 * 
	 * @param idNo
	 *            用户标识
	 * @param prcType
	 *            取值0：主订价资费；1：附加订价资费；null：全部订购的资费
	 * @param prcId
	 *            若非空，则返回此订价资费的列表
	 * @param validFlag
	 *            "true" : 生效, "false" or null ：全部
	 * @return
	 */
	List<UserPrcEntity> getPdPrcId(long idNo, String prcType, String prcId, String validFlag);

	/**
	 * 功能：获取产品资费ID
	 * 
	 * @param idNo
	 * @param prcType
	 *            0：主订价资费，1：附加订价资费
	 * @return
	 */
	List<UserPrcEntity> getPdPrcId(long idNo, String prcType);

	/**
	 * 功能：查询主资费信息
	 * 
	 * @author liuhl
	 * @param inMap
	 * @return
	 */
	List<UserPdPrcInfoEntity> getPdPrcInfo(Map<String, Object> inMap);

	/**
	 * 功能：查询资费明细信息
	 * 
	 * @author liuhl
	 * @param inMap
	 * @return
	 */
	List<UserPdPrcDetailInfoEntity> getPdPrcDetailInfo(Map<String, Object> inMap);

	/**
	 * 功能：判断该资费是否为某一资费
	 * 
	 * @author liuhl
	 * @param inMap
	 * @return
	 */
	int getIsPointPrc(Map<String, Object> inMap);
	
	/**
	 * 功能：查询用户SP业务
	 * 
	 * @author liuyc_billing
	 * @param inMap
	 * @return
	 */
	List<SpInfoEntity> qUserSPPdPrcInfo(Map<String, Object> inMap);

	
	/**
	 * 功能：取单品宽带资费
	 * 
	 * @author suzj
	 * @param phoneNo
	 * @return
	 */
	String getExpenses(String phoneNo);

	/**
	 * 功能：判定用户是否订购了某资费
	 * 
	 * @param idNo
	 * @param prcId
	 *            待判定的订价资费
	 * @return
	 */
	boolean hasPrcid(Long idNo, String prcId);

	/**
	 * 功能：查询用户订购的流量套餐名称列表<br>
	 * 注：其他人应该用不上
	 * 
	 * @author wangyla
	 * @param idNo
	 * @return
	 */
	List<String> getGprsPrcNameList(Long idNo);

	/**
	 * 功能：获取资费对应的属性值
	 * 
	 * @param prcId
	 * @param attrId
	 * @return
	 */
	String getPrcAttrValue(String prcId, String attrId);

	/**
	 * 功能：取用户订购的资费列表，含预约生效
	 * 
	 * @param idNo
	 * @return
	 */
	List<UserPrcEntity> getValidPrcList(Long idNo);

	/**
	 * 取用户订购的主资费列表，含预约生效
	 * 
	 * @param idNo
	 * @param prcType
	 * @param prcId
	 * @param validFlag
	 * @param includeOrder
	 * @return
	 */
	List<UserPrcEntity> getPdPrcId(long idNo, String prcType, String prcId, String validFlag, String includeOrder);

	/**
	 * 功能：判定资费是否为指定类型资费；暂用于神州行判断
	 * @param classId
	 * @param prcId
     * @return
     */
	boolean isClassPrcId(String classId, String prcId);

	/**
	 * 功能：获取已办理优惠套餐的数量
	 * 
	 * @param idNo
	 * @param status
	 *            取值：3 -- 70元套餐；2 -- 50元套餐； 1 -- 30元套餐
	 * @return
	 */
	int getFavCount(Long idNo, String status);

	/**
	 * 取用户订购的主资费列表，含预约生效
	 * 
	 * @param prcId
	 * @return
	 */
	String getPdById(String prcId);
	
	/**
	 * 获取用户产品资费升级信息
	 * @param upId
	 * @param phoneNo
	 * @param totalDate
	 * @return
	 */
	ProductOfferUpEntity getProductUpInfo(String upId, String phoneNo, int totalDate);
	
	/**
	 * 删除产品资费升级信息
	 * @param upId
	 * @param phoneNo
	 * @param totalDate
	 */
	void delProductOfferUpInfo(String upId, String phoneNo, int totalDate);
	
	/**
	 * 删除记录前入PRODUCT_OFFER_UP_HIS表
	 * @param upId
	 * @param phoneNo
	 * @param totalDate
	 */
	void saveProductOfferUpInfo(String upId, String phoneNo, int totalDate);

	/**
	 * 功能：获取用户订购资费的生失效时间，相同资费，取最小开始时间和最大结束时间
	 * @param  goodsInsId
     * @return
     */
	Map<String, String> getPrcValidInfo(long goodsInsId);
}
