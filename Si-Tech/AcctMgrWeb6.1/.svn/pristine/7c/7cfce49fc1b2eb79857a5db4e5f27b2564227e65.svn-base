package com.sitech.acctmgr.atom.busi.invoice;

import java.io.BufferedReader;
import java.io.Reader;
import java.sql.Clob;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.jcf.core.exception.BusiException;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class PrintModelUtil{

	public static Map<String, String> printModelMap; // 存放发票模板
	public static Map<String, String> printModelRelaMap; // 存放模板模板号
	private static IInvoice invoice = null;
	private static PrintModelUtil instance = null;
	
	public static PrintModelUtil getInstance() {
		return instance;
	}
	public static void setInstance(PrintModelUtil instance) {
		PrintModelUtil.instance = instance;
	}
	public PrintModelUtil(IInvoice invoice){
		//invoice = new Invoice();
		printModelMap = new ConcurrentHashMap<String, String>();			
		printModelRelaMap = new ConcurrentHashMap<String, String>();
		this.invoice = invoice; 
		init();
	}
	public static PrintModelUtil getInstance(IInvoice invoice) {
		instance =new PrintModelUtil(invoice); 
	    return instance;
	 }
	
	/* 加载发票模板和发票模板号键值对 */
	private static void init(){
		//initPrintModelRela();
		//initPrintModel();
	}

	/* 初始化发票模板ID Map */
	public static void initPrintModelRela(){
		String sPrintModelID = "";
		String sOpCode = "";
		String sPrintType= "";
		List<Map<String,Object>> printModelIdList = invoice.getAllPrintModelId();
		
		for(Map<String,Object> printModelIdMap:printModelIdList){
			sPrintModelID = printModelIdMap.get("PRINT_MODEL_ID").toString();
			sOpCode = printModelIdMap.get("OP_CODE").toString();
			sPrintType = printModelIdMap.get("PRINT_TYPE").toString();
			printModelRelaMap.put(sOpCode+"_"+sPrintType, sPrintModelID);
		}
		
	}
	
	/* 查询刷新发票模板号配置表 */
	public static String refreshPrintModelRela(String sOpCode,String sPrintType){
		String sModelId = invoice.getPrintModelId(sOpCode, sPrintType);
		if(sModelId==null){
			throw new BusiException(AcctMgrError.getErrorCode("8000", "01010"), "没有找到对应模块的发票模版号[" + sOpCode + sPrintType + "]!");
		}
		printModelRelaMap.put(sOpCode+"_"+sPrintType, sModelId);
		return sModelId;
	}
	
	/* 查询刷新发票模板配置表 */
	public static String refreshPrintModel(String sModelID){
		String xmlStr="";
		Clob clob = null;
		Reader io = null;
		BufferedReader br = null;
		System.out.println("sModelID="+sModelID);
		Map<String,Object> outParam = invoice.getPrintModel(sModelID);
		if(outParam==null){
			throw new BusiException(AcctMgrError.getErrorCode("8000", "01005"), "查询发票模板号出错！");
		}
		
		try{
			clob = (Clob)outParam.get("MODEL_DATA");
			if(clob!=null){
				io = clob.getCharacterStream();
				br = new BufferedReader(io);
				
				String tempStr = br.readLine();
				while(tempStr!=null){
					xmlStr += tempStr;
					tempStr = br.readLine();
				}
				br.close();
				io.close();
			}else{
				throw new BusiException(AcctMgrError.getErrorCode("8000", "01005"), "查询发票模板号出错！");
			}
			printModelMap.put(sModelID, xmlStr);
		}catch(Exception e ){
			e.printStackTrace();
		}finally{
			try {
				if(br!=null){
					br.close();
				}
				if(io!=null){
					io.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return xmlStr;
	}
}
