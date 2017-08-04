package com.sitech.acctmgr.atom.entity.inter;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.cct.CctDynamicCreditInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditAdjEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditChgHisEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditDetailEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditInfoEntity;
import com.sitech.acctmgr.atom.domains.cct.CreditListEntity;
import com.sitech.acctmgr.atom.domains.cct.GrpCreditEntity;
import com.sitech.acctmgr.atom.domains.cct.GrpRedEntity;
import com.sitech.acctmgr.atom.domains.cct.UnStopHolidayEntity;

/**
 * Created by wangyla on 2016/5/10.
 */
public interface ICredit {

	/**
	 * 功能：获取用户有效期内的信誉信息
	 * 
	 * @param idNo
	 * @param cancelFlag
	 *            信誉生失效标识，取值：CommonConst.CREDIT_VALID、CommonConst.CREDIT_INVALID
	 * @return <p>
	 *         注意：返回值可能为空，需要特别注意对空值的处理
	 *         </p>
	 */
	CreditInfoEntity getCreditInfoByIdNo(long idNo, String cancelFlag);

	/**
	 * 功能：获取集团信用等级信息
	 * 
	 * @param unitId
	 *            集团编码
	 */
	GrpCreditEntity getGrpCredit(long unitId);

	/**
	 * 功能：判断是否为第一次办理集团信誉度调整
	 * 
	 * @param unitId
	 *            集团编码
	 */
	int getCntGrpCredit(long unitId);

	void saveGrpCredit(GrpCreditEntity gce);

	void updateGrpCredit(GrpCreditEntity gce);

	public Map<String, Object> getCreditInfo(long idNo);

	/**
	 * 功能：修改动态信用度
	 * 
	 * @param limit_owe
	 * @param credit_code
	 * @param id_no
	 * @param expireTime
	 * @return：
	 */
	public void uDnyCredit(CreditAdjEntity creditAdjEntity);

	/**
	 * 功能：申请动态信用度
	 * 
	 * @param limit_owe
	 * @param credit_code
	 * @param id_no
	 * @param expireTime
	 * @return
	 */
	public void applyDnyCredit(CreditAdjEntity creditAdjEntity);

	/**
	 * 功能：取消动态信用度
	 * 
	 * @param id_no
	 */
	public void cancleDnyCredit(CreditAdjEntity creditAdjEntity);

	public String getClass(Map<String, Object> inParam);

	public String getClassName(Map<String, Object> inParam);
	
	/**
	 * 名称：获取信用度信息
	 * 
	 * @param inParam
	 * @return
	 * @author
	 */
    public abstract Map<String, Object> qNoDateCreditInfo(Map<String, Object> inParam);
    
	/**
	 * 名称：取信用度明细
	 * 
	 * @param inParam
	 * @return
	 */
	public List<CreditDetailEntity> qCreditDetail(Map<String, Object> inParam);
	
	/**
	 * 取信誉度备份表数据
	 */
	public List<CreditChgHisEntity> qCreditchgHis(Long idNo);
	
	public void saveCreditInfo(Map<String, Object> inParam);
	
	public void saveCreditChgHis(Map<String, Object> inParam);
	
	/**
	 * 信誉度小表插入数据
	 * 
	 * @author xiongjy
	 */
	public void saveCreditInfoChg(Map<String, Object> inParam);
	
	/**
	 * 名称：修改信用度等级
	 * 
	 * @param creditgrade
	 *            修改后等级 lOGIN_NO PHONE_NO ID_NO CREDIT_CLASS SEND_FLAG IS_CREDIT REGION_ID
	 * @author liuhl_bj
	 */ 
	public abstract void uCreditGrade(Map<String, Object> inParam);
	
	int getCreditInfoCnt(Map<String, Object> inParam);
	
	CreditInfoEntity pQCreditInfoById(Map<String, Object> inParam);
	
	long qCodePointByCardType(Map<String, Object> inParam);
	
	public int cntCreditAdj(Long idNo);


	public CctDynamicCreditInfoEntity getDynamicCredit(long idNo);
	
	/**
	 * 名称：修改grp red信用度等级
	 * 
	 * @param idNo
	 *            contractNo unitId creditCode monthLength
	 */ 
	public void saveGrpRedList(Map<String, Object> inParam);
	
	/**
	 * 名称：获取集团红名单信息
	 * 
	 * @param idNo
	 *            unitId
	 */ 
	public GrpRedEntity getGrpRedList(Long unitId,Long idNo);
	
	/**
	 * 名称：操作节假日配置表
	 * @param  
	 */ 
	public void oprHolidayUnstop(Map<String, Object> inParam,String opType);
	
	/**
	 * 名称：操作节假日配置表信息
	 * @param  
	 */ 
	public List<UnStopHolidayEntity> getUnStopHoliday(String regionCode);


	/**
	 * 名称：查询信用度修改信息，老信用度和新信用度
	 * 
	 * @author liuhl_bj
	 * @param inMap
	 * @return
	 */
	CreditAdjEntity getCreditAdj(Map<String, Object> inMap);
	
	/**
	 * 名称：生日关怀配置表信息
	 * @param  
	 */ 
	public void saveKeyWordMap(String regionCode,String opType,String Note);
	
	/**
	 * 名称：查询生日关怀配置表信息
	 * @param  
	 */
	public String getKeyWordMap(String regionCode,String opCode);

}
