package com.sitech.acctmgrint.atom.busi.intface.sqldeal;

import com.sitech.acctmgrint.atom.busi.intface.cfgcache.DataBaseCache;
import com.sitech.acctmgrint.common.AcctMgrError;
import com.sitech.acctmgrint.common.BaseBusi;
import com.sitech.acctmgrint.common.IntControl;
import com.sitech.acctmgrint.common.constant.InterBusiConst;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.sql.SqlParameter;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcf.json.JSONObject;
import com.thoughtworks.xstream.mapper.Mapper.Null;

import org.apache.commons.lang.StringUtils;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SqlDeal extends BaseBusi implements ISqlDeal {

	protected DataBaseCache  dataBaseCache;
	protected CallBaseServ   callServ;

	/**
	 * Title  获取主服务、附加服务参数值列表
	 * @param inMap(SVC_ID,MAIN_ACTION_ID,SVC_TYPE)
	 * @param inSqlMap
	 * @return
	 */
	public List<Map<String, Object>> getSvcAttrBySvcIdAndActionId(Map<String, Object> inDataMap, 
										Map<String, Object> inSqlMap, Map<String, Object> inPubData) {
		
		int iGrpType = 0;
		String sDataValue = "";
		String sPrptyStr = "";
		String sPrptyNodeTmp = "";
		
		log.debug("-------------------getsvcattrinfo stt--------"+inDataMap.toString());
		
		/*return List*/
		List<Map<String, Object>> listRetMaps = new ArrayList<Map<String, Object>>();
		Map<String, Object> tmpMap = null;
		log.debug("-------------------getsvcattrinfo stt--------"+inDataMap.toString());

		/*取得in_bssvc_attrgroup_rel a,IN_BSGROUPATTR_REL b 两表联合后的配置信息*/
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();		
		//取缓存数据，如没有，则在数据库中取得
		resultList = dataBaseCache.getDestTabCfgList("IN_BSSVC_ATTRGROUP_REL", 
				inDataMap.get("SVC_ID").toString()
				+"#"+inDataMap.get("MAIN_ACTION_ID").toString()
				+"#"+inDataMap.get("SVC_TYPE").toString());
		if (resultList == null || resultList.size() == 0)
			resultList = baseDao.queryForList("in_bssvc_attrgroup_rel_INT.qGrpAttrInfoBySvcId", inDataMap);
		for (Map<String, Object> retMap : resultList) {
			
			//20151217 volte项目新增判断
			Object def_val = retMap.get("DEFAULE_VALUE");
			log.debug("def_val="+def_val);
			if (inPubData.get("VOLTE_FLAG").equals("N")) {
				if (null != def_val && def_val.toString().startsWith("VOLTE")) {
					continue;					
				}
			} else {
				//VOLTE用户
				if (!inPubData.get("OLD_NEW_RUN").equals("JA"))
					if (null != def_val && def_val.toString().endsWith("J")) {
						continue;
					}
			}
				
			
			sDataValue = "";
			tmpMap = new HashMap<String, Object>();
			log.debug("---------getsvcattrinfo for retMap="+retMap.toString());
			iGrpType = Integer.valueOf(retMap.get("GRP_TYPE").toString());
			log.debug("---------getsvcattrinfo for iGrpType="+iGrpType);
			switch (iGrpType) {
			case 1:/*单条参数值*/
				sDataValue = getDataValueBySourceId(inPubData, retMap.get("ATTR_NEW_VALUE").toString(), inSqlMap);
				log.debug("---------getsvcattrinfo for sDataValue="+sDataValue);
				if (sDataValue.equals("")) {
					log.debug("---------get data is null,please check!");
					continue;
				} else {
					tmpMap.put(InterBusiConst.FWKT_ODR_ID,     retMap.get("ATTR_VALUE"));//"Id"
					tmpMap.put(InterBusiConst.FWKT_ODR_NAME,   retMap.get("ATTR_NAME"));//"Name"
					tmpMap.put(InterBusiConst.FWKT_ODR_NEWVAL, sDataValue);//"NewVal"
					tmpMap.put(InterBusiConst.FWKT_ODR_OLDVAL, sDataValue);//"OldVal"				
				}
				break;
			case 2:/*多条参数*/
				log.debug("------konglj test----iGrpTYpe="+iGrpType);
				break;
			default:
				log.debug("Here has one error,Please check! GRP_TYPE=" + iGrpType);
				return null;
			}
			log.debug("-------------konglj test---tmpMap="+tmpMap.toString());
			
			/*录入List*/
			listRetMaps.add(tmpMap);
		}/*for END*/
		
		return listRetMaps;
	}
	
	/**
	 * Title  获取其他节点参数值列表
	 * @param inMap(SVC_ID,MAIN_ACTION_ID,SVC_TYPE)
	 * @param inSqlMap
	 * @return
	 */
	public Map<String, Object> getOtherNodeParam(Map<String, Object> inDataMap, 
										Map<String, Object> inSqlMap, Map<String, Object> inPubData) {

		Map<String, Object> outMap = new HashMap<String, Object>();
	
		//获取所有的参数
		List<Map<String, Object>> resultList = dataBaseCache.getDestTabCfgList("IN_BSSVC_ATTRGROUP_REL", 
				inDataMap.get("SVC_ID").toString()
				+"#"+inDataMap.get("MAIN_ACTION_ID").toString()
				+"#"+inDataMap.get("SVC_TYPE").toString());
		
		if (resultList == null || resultList.size() == 0){ //如没有缓存数据，则在数据库中取得
			resultList = baseDao.queryForList("in_bssvc_attrgroup_rel_INT.qGrpAttrInfoBySvcId", inDataMap);
		}
		
		//循环参数,取出参数值
		for (Map<String, Object> retMap : resultList) {			
			String sDataValue = getDataValueBySourceId(inPubData, retMap.get("ATTR_NEW_VALUE").toString(), inSqlMap);
			if (sDataValue.equals("")) {
				log.debug("---------get data is null,please check!");
				continue;
			} else {
				outMap.put(retMap.get("ATTR_NAME").toString(), sDataValue);				
			}
		}
		
		return outMap;
	}
	
	public String getDataValueBySourceId(Map<String, Object> inData, String sInDataSourceId, Map<String, Object> inSqlMap) {
		
		int iSrcType = 0;
		String sDataValue = "";
		Map<String, Object> inMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		log.debug("--datasource_id--="+sInDataSourceId);
		resultList = dataBaseCache.getDestTabCfgList("IN_BSDATASOURCE_DICT", sInDataSourceId);
		if (resultList == null || resultList.size() == 0) {
			inMap.put("DATASOURCE_ID", Integer.parseInt(sInDataSourceId));
			resultList = (List<Map<String, Object>>)baseDao.queryForList("in_bsdatasource_dict_INT.qDataSrcInfoByDataSrcId", inMap);
		}
		if (resultList.size() == 0) {
			log.debug("get the datasource_id failed,please check!");
			return "NULL";
		}
		log.debug("-------------konglj test--getvaluebysrcid--stt---"+resultList.toString());
		log.debug("-------------konglj test--getvaluebysrcid--stt---inData="+inData.toString());
		
		for (Map<String, Object> resultMap : resultList) {
			
			Map<String, Object> outDBMap = new HashMap<String, Object>();
			iSrcType = Integer.valueOf(resultMap.get("SRC_TYPE").toString());
			switch(iSrcType) {
			case 2:
				sDataValue = getMapData(inData, resultMap);
				break;
			case 3:
				outDBMap = getDBdataValue(resultMap, inSqlMap, inData);
				if(outDBMap.get("DB_RST") != null){
					sDataValue = outDBMap.get("DB_RST").toString();
				}				
				break;
			case 1:
				sDataValue = resultMap.get("DATA_EXP").toString();
				break;
			case 5:
				outDBMap = getDBdataValue(resultMap, inSqlMap, inData);
				String key_value = outDBMap.get("DB_RST").toString();
				//若run_flag=Y,取基础域KI_NO(inter.p配置文件FWKT_JTOA_CALLSERVER=1可控制)
				if (key_value.equals("N")) {
					sDataValue = "";
				} else if (!key_value.equals("")) {
					String[] arrKeyVal = key_value.split("~");
					if (inData.get(arrKeyVal[0]) != null) {
						sDataValue = inData.get(arrKeyVal[0]).toString();
					} else {
						Map<String, Object> inParam = new HashMap<String, Object>();
						inParam.put("IMSI", arrKeyVal[1]);//IMSI
						inParam.put("CUR_RUN_CODE", inData.get("CUR_RUN_CODE"));
						inParam.put("LOGIN_NO", inData.get("LOGIN_NO"));
						log.debug("--调基础域接口入参："+inParam.toString());
						try {
							Map<String, Object> out_data = callServ.qryUserKIInfo((Map<String, Object>)inData.get("HEADER"), inParam);
							sDataValue = out_data.get(arrKeyVal[0]).toString();
							
							//其他重基础域取出的值放入inData公共参数Map.
							inData.putAll(out_data);
						} catch (Exception e) {
							e.printStackTrace();
							StackTraceElement[] stackArr = e.getStackTrace();
				            for (StackTraceElement element : stackArr){
				                log.error(element.toString());
				            }
							log.error("--调基础域接口失败"+e.toString());
							throw new BusiException(AcctMgrError.getErrorCode(
									inData.get("OP_CODE").toString(), "11118"),
									"FWKT|调用基础域接口失败，预拆恢复失败，建议执行换卡操作!! ERRINFO=["
											+e.toString()+"]");
						}
						log.debug("--调基础域接口出参："+sDataValue);
					}
				}
				break;
			case 6:
				outDBMap = getDBdataValue(resultMap, inSqlMap, inData);
				Object db_value = outDBMap.get("DB_RST");
				if (!db_value.equals("")) {
					Map<String, Object> db_map = (Map<String, Object>) JSONObject.fromObject(db_value);
					if (db_map.size() == 0) {
						sDataValue = "";
					} else {
						log.debug("--调基础域基本接口入参："+db_map.toString());
						inData.putAll(db_map);
						try {
							sDataValue = callServ.callArrService((Map<String, Object>)inData.get("HEADER"),
									inData);
							
						} catch (Exception e) {
							e.printStackTrace();
							StackTraceElement[] stackArr = e.getStackTrace();
				            for (StackTraceElement element : stackArr){
				                log.error(element.toString());
				            }
							log.error("--调基础域基本接口失败"+e.toString());
							throw new BusiException(AcctMgrError.getErrorCode(
									inData.get("OP_CODE").toString(), "11118"),
									"FWKT|调用基础域基本接口失败，CPE限速取参数失败!! ERRINFO=["
											+e.toString()+"]");
						}
						log.debug("--调基础域接口基本出参："+sDataValue);
					}
				}
				break;
			case 4: //哈希取值后解密
				outDBMap = getDBdataValue(resultMap, inSqlMap, inData);
				sDataValue = decryptData(outDBMap.get("DB_RST").toString());
				break;
			default:
				log.debug("getDataValues:The param iSrcType is error,Please Check!");
				return "NULL";
			}/*switch END*/
			
			/*是否已取得datasourceid值，若非空，则退出FOR循环*/
			if (!sDataValue.equals("")) {
				log.debug("getDataValues:sDataValue=" + sDataValue);
				break;
			}

		}/*for END*/
		
		return sDataValue;
	}
	
	/**
	 * Title  只存取一行参数列(Map) 或 一个结果
	 * @param inParamExpMap
	 * @param inSqlMap
	 * @param outDBdataMap
	 * @return
	 */
	public Map<String, Object> getDBdataValue(Map<String, Object> inParamExpMap, Map<String, Object> inSqlMap,
												 Map<String, Object> inDataMap) {
		
		int iDataNum = 0;
		String sExeSql = "";
		String sParamType = "";
		Map<String, Object> outDBdataMap = new HashMap<String, Object>();
		Map<String, Object> mapData = null;

		/*预处理SQL,输入绑定变量*/
		sExeSql = this.predealSqlStatement(inParamExpMap.get("DATA_EXP").toString(), inSqlMap, inDataMap);
		if (sExeSql.equals("")) {
			log.error("predeal the SQL failed,please check!");
			return null;
		}
		log.debug("sExeSql="+sExeSql);
		
		SqlFind sqlFind = (SqlFind) inSqlMap.get("SQL_FIND");
		Connection conn = (Connection) inSqlMap.get("SQL_CONNECT");
		try {
			
			/*执行 sSqlDataBuf 处理数据*/
			iDataNum = 0;
			sParamType = inSqlMap.get("PARAM_TYPE").toString();
			if (sParamType.equals("MULTI_MAP")) {
				sqlFind.setListElementAsMap(true);
				//得到执行语句集合
				List<Map> lstRet = sqlFind.findList(conn, sExeSql);
				if (lstRet == null || lstRet.size() == 0) {
					outDBdataMap.put("DB_RST", "");
					return outDBdataMap;
				}
				for (Map<String, Object> tmpMap : lstRet) {
					if(tmpMap.size() != 0) {
						//outDBdataMap.putAll(tmpMap);
						Set<String> key_set = tmpMap.keySet();
						for (String key : key_set) {
							outDBdataMap.put("DB_RST", tmpMap.get(key));
							break;
						}
						break;//只取一行						
					} else {
						outDBdataMap.put("DB_RST", "");
					}
				}
			} else {
				//只有一个结果值的时候
				String strTmp = sqlFind.findString(conn, sExeSql);
				if (strTmp == null)
					strTmp = "";
				outDBdataMap.put("DB_RST", strTmp);//DB_RST
			}
		
		} catch(Exception e){
			log.error(e.getMessage());
//			throw new BusiException(AcctMgrError.getErrorCode(
//					inDataMap.get("OP_CODE").toString(), "11118"),
//					"FWKT|query datasource error,please check!! ERRINFO=["
//							+inParamExpMap.toString()+"=="+outDBdataMap.toString()+"]");
		}
		return outDBdataMap;
	}

	/**
	 * Title 服务开通拼参数时，取Map对应key值
	 * @param inDataIdMap
	 * @return
	 */
	private String getMapData(Map<String, Object> inPubData, Map<String, Object> inDataIdMap) {
		String key = inDataIdMap.get("DATA_EXP").toString().toUpperCase();
		if (inPubData.get(key) != null)
			return inPubData.get(key).toString();
		else return "";
	}
	
	/**
	 * Title: 服务开通SQL预处理,替换绑定变量方法
	 * Description: 处理配置语句中$(ID_NO,-2,2)$、$(100,-2,2)$、'$(900233)$'、'$(PHONE_NO)$'<char[41]>四类数据
	 * 				(注意配置表中，去掉如<LONG>,<char[41]>参数类型，可修改为#ID_NO:LONG#)
	 * @param inParamExpMap
	 * @param inParamMap
	 * @return
	 */
	@Override
	public String predealSqlStatement(String inPreSql,
			Map<String, Object> inSqlMap, Map<String, Object> inData) {
		
		String sDataExp = inPreSql;
		String sXmlHead = "";
		String sValType = "";
		String sSpiltData = "";
		String sSpiltValue = "";
		String sSpiltValueTmp = "";
		String sSpiltReplace = "";
		int iFirstIndex = 0;//'$'
		int iLastIndex = 0; //'$'
		int iSpilt = 0;
		char cClasify;
		SqlFind outSqlFind = new SqlFind();

		//Connection conn = (Connection) inSqlMap.get("SQL_CONNECT");
		
		while (true) {
		
			iFirstIndex = sDataExp.indexOf("$(");
			iLastIndex = sDataExp.indexOf(")$", iFirstIndex + 1) + 1;
			if (-1 == iFirstIndex || -1 == iLastIndex) {
				break;
			}

			sXmlHead = sXmlHead + sDataExp.substring(0, iFirstIndex);
			
			sSpiltReplace = sDataExp.substring(iFirstIndex, iLastIndex + 1);/*如：$(900233)$、$(ID_NO)$*/
			sSpiltData = sDataExp.substring(iFirstIndex + 2, iLastIndex - 1).trim().toUpperCase();/*如：900233*/
			log.debug("---split data:sSpiltReplace="+sSpiltReplace 
					              +" sSpiltData="+sSpiltData);

			cClasify = sSpiltData.charAt(0);
			iSpilt = sSpiltReplace.indexOf(',');
			if (iSpilt == -1) {
				/*处理处理'$(PHONE_NO)$'<char[41]>和'$(900233)$'类变量*/
				if (cClasify >= 'A' && cClasify <= 'Z') {
					log.debug("-----konglj test--sSpiltDatasss="+sSpiltData+"indata"+inData.toString());
					if(inData.get(sSpiltData) != null){
						sSpiltValue = inData.get(sSpiltData).toString();
					} else {
						break;
					}					
					log.debug("-----presql---splitval="+sSpiltValue);
					
					/*过滤 <LONG>,<char[10]>类型。20150513修改，拷贝crm类型，无<LONG>配置*/
					//iSmalIndex = sDataExp.indexOf('<', iLastIndex);
					//iOffSet = sDataExp.indexOf('>', iLastIndex) - iSmalIndex;
					//sValType = sDataExp.substring(iSmalIndex + 1, iSmalIndex + 5);

				} else if (cClasify >= '0' && cClasify <= '9') {
					sSpiltValue = getDataValueBySourceId(inData, sSpiltData, inSqlMap);
					//sValType = "CHAR";
				}
				log.debug("-------konglj gtest--sSpiltValue="+sSpiltValue);

			} else {
				/*处理$(ID_NO,-2,2)$和 $(100,-2,2)$类变量。 不拼入动态SQL,直接替换值*/
				String sSplit[] = StringUtils.split(sSpiltData, ',');
				if (cClasify >= 'A' && cClasify <= 'Z') {
					sSpiltValueTmp = inData.get(sSplit[0]).toString();
					sSpiltValue = sSpiltValueTmp.substring(Integer.parseInt(sSplit[1]), Integer.parseInt(sSplit[2]));

				} else if (cClasify >= '0' && cClasify <= '9') {
					sSpiltValueTmp = getDataValueBySourceId(inData, sSplit[0], inSqlMap);
					sSpiltValue = sSpiltValueTmp.substring(Integer.parseInt(sSplit[1]), Integer.parseInt(sSplit[2]));
				}
			}
			
			//动态sql,记录参数值
			outSqlFind.addParam(new SqlParameter(sSpiltData, SqlTypes.VARCHAR, sSpiltValue));
			/*if (sValType.equalsIgnoreCase("CHAR"))
				outSqlFind.addParam(new SqlParameter(sSpiltData, SqlTypes.VARCHAR, sSpiltValue));
			else if (sValType.equalsIgnoreCase("LONG"))
				outSqlFind.addParam(new SqlParameter(sSpiltData, SqlTypes.JLONG, Long.parseLong(sSpiltValue)));
			else {
				return null;
			}*/
			
			sXmlHead = sXmlHead.concat("?");
			sDataExp = sDataExp.substring(iLastIndex + 1);
			
		}/*while END*/
		if (!sDataExp.trim().equals(""))
			sXmlHead = sXmlHead + sDataExp;
		inSqlMap.put("SQL_FIND", outSqlFind);
		
		return sXmlHead;
	}

	/**
	 * 解密方法
	 * @param encrypt_data
	 * @return
	 */
	public String decryptData(String encrypt_data) {

		if (encrypt_data == null || encrypt_data.equals(""))
			return "";
		
		String decrypt_data = "";
		try {
			decrypt_data = IntControl.pubEncryptData(encrypt_data, 1);
		} catch (Exception e) {
			decrypt_data = IntControl.pubNomalEncryptData(encrypt_data, 1, 0);
		}
		return decrypt_data;
	}
	
	////////////////get/set////////////
	private CallBaseServ getCallServ() {
		return callServ;
	}

	public void setCallServ(CallBaseServ callServ) {
		this.callServ = callServ;
	}

	public DataBaseCache getDataBaseCache() {
		return dataBaseCache;
	}
	public void setDataBaseCache(DataBaseCache dataBaseCache) {
		this.dataBaseCache = dataBaseCache;
	}
	
}
