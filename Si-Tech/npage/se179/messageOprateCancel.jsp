<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="org.json.*"%>

<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@ page import="com.sitech.crmpd.core.exception.BusiAppException"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.xml.IXMLReader"%>
<%@ page import="com.sitech.crmpd.core.xml.impl.StAXReaderFactory"%>
<%@ page import="com.sitech.crmpd.core.xml.impl.Unmarshalling"%>
<%Date start = new Date(); %>
<%!
static Logger logger = Logger.getLogger("messageOprateOder.jsp");

public class SaleXml2Utype {
	 
	  //utype类型
	  public String STRING="STRING";
	  public String LONG="LONG";
	  public String INT="INT";
	  public String DOUBLE="DOUBLE";
	  
	  //营销domain_type,P：资费 S：积分 Z：资源 F：费用 FQ：银行卡分期付款；PH：手机凭证
	  public String DOMAIN_TYPE_P="P";
	  public String DOMAIN_TYPE_S="S";
	  public String DOMAIN_TYPE_Z="Z";
	  public String DOMAIN_TYPE_F="F";
	  public String DOMAIN_TYPE_FQ="FQ";
	  public String DOMAIN_TYPE_PH="PH";
	  public String DOMAIN_TYPE_SP = "SP";
	 
	  public String NO_KEY_VALUE="N/A";//如果mapbean没有找到key，一般都是返回N/A
		
	  public SaleXml2Utype(){		
	  }
		
	  public UType chgXml2Utype(String inStr) throws BusiAppException {
	 
		//1.xml转成mapbean
		SaleXml2Utype xml2utype=new SaleXml2Utype();
		MapBean mapbean=xml2utype.xml2mapbean(inStr);
			
		String curTime=mapbean.getString("REQUEST_INFO.OPR_INFO.OP_TIME");
		/***
		UType CustInfoRequest = new UType();
		
		UType MsgHeader = new UType();
		CustInfoRequest.setUe(MsgHeader);//定义完就直接set，避免忘记。
		
		String MsgType="0";
		String RecordType="0";
		String Version="0";
		MsgHeader.setUe(STRING, MsgType);
		MsgHeader.setUe(STRING, RecordType);
		MsgHeader.setUe(STRING, Version);
		
		CustInfoRequest.setUe(MsgBody);
		***/
		
		
		UType MsgBody = new UType();
		
		
		//---------------OprInfo------------------
		UType OprInfo = new UType();
		MsgBody.setUe(OprInfo);//定义完就直接set，避免忘记。
		
		String LoginAccept=mapbean.getString("REQUEST_INFO.OPR_INFO.LOGINACCEPT");
		logger.info("----------------LoginAccept="+LoginAccept);
		String OpCode=mapbean.getString("REQUEST_INFO.OPR_INFO.OP_CODE");
		String LoginNo=mapbean.getString("REQUEST_INFO.OPR_INFO.LOGIN_NO");
		String LoginPwd=mapbean.getString("REQUEST_INFO.OPR_INFO.LOGIN_PWD");
		String IpAddress=mapbean.getString("REQUEST_INFO.OPR_INFO.IP_ADDRESS");
		String OprGroupId=mapbean.getString("REQUEST_INFO.OPR_INFO.GROUP_ID");
		String OpTime=curTime;
		String RegionCode=mapbean.getString("REQUEST_INFO.OPR_INFO.REGION_ID");
		String OpNote=mapbean.getString("REQUEST_INFO.OPR_INFO.SYS_NOTE");
		String SiteId=mapbean.getString("REQUEST_INFO.OPR_INFO.GROUP_ID");
		String ObjectId=mapbean.getString("REQUEST_INFO.OPR_INFO.GROUP_ID");
		String ActClass=mapbean.getString("REQUEST_INFO.OPR_INFO.ACTION_TYPE");
		String ActId=mapbean.getString("REQUEST_INFO.OPR_INFO.ACTION_ID");
		String MeansId=mapbean.getString("REQUEST_INFO.OPR_INFO.MEANS_ID");
		
		OprInfo.setUe(LONG, LoginAccept);
		OprInfo.setUe(STRING, OpCode);
		OprInfo.setUe(STRING, LoginNo);
		OprInfo.setUe(STRING, LoginPwd);
		OprInfo.setUe(STRING, IpAddress);
		OprInfo.setUe(STRING, OprGroupId);
		OprInfo.setUe(STRING, OpTime);
		OprInfo.setUe(STRING, RegionCode);
		OprInfo.setUe(STRING, OpNote);
		OprInfo.setUe(STRING, SiteId);
		OprInfo.setUe(STRING, ObjectId);
		OprInfo.setUe(STRING, ActClass);
		OprInfo.setUe(STRING, ActId);
		OprInfo.setUe(STRING, MeansId);
			
		UType PrintInfo = new UType();
		OprInfo.setUe(PrintInfo);
		
		  String AactionName=mapbean.getString("REQUEST_INFO.PRINT_INFO.ACTION_NAME");
		  String CustName=mapbean.getString("REQUEST_INFO.PRINT_INFO.CUST_NAME");
		  String PhoneNo=mapbean.getString("REQUEST_INFO.PRINT_INFO.PHONE_NO");
		  String PrintFlag=mapbean.getString("REQUEST_INFO.PRINT_INFO.PRINT_FLAG");
		  String PayMoneyBig=mapbean.getString("REQUEST_INFO.PRINT_INFO.PAY_MONEYBIG");
		  String PayMoneySmall=mapbean.getString("REQUEST_INFO.PRINT_INFO.PAY_MONEYSMALL");
		  String PaySpecialBig=mapbean.getString("REQUEST_INFO.PRINT_INFO.PAY_SPECIALBIG");
		  String PaySpecailSmall=mapbean.getString("REQUEST_INFO.PRINT_INFO.PAY_SPECIALSMALL");
		  String ResourceBrand=mapbean.getString("REQUEST_INFO.PRINT_INFO.RESOURCEBRAND");
		  String ResourceModel=mapbean.getString("REQUEST_INFO.PRINT_INFO.RESOURCE_MODEL");
		  String IMEICode=mapbean.getString("REQUEST_INFO.PRINT_INFO.IMEI_CODE");
		  String LoginName=mapbean.getString("REQUEST_INFO.PRINT_INFO.LOGIN_NAME");
		  PrintInfo.setUe(STRING, AactionName);
		  PrintInfo.setUe(STRING, CustName);
		  PrintInfo.setUe(STRING, PhoneNo);
		  PrintInfo.setUe(STRING, PrintFlag);
		  PrintInfo.setUe(STRING, PayMoneyBig);
		  PrintInfo.setUe(STRING, PayMoneySmall);
		  PrintInfo.setUe(STRING, PaySpecialBig);
		  PrintInfo.setUe(STRING, PaySpecailSmall);
		  PrintInfo.setUe(STRING, ResourceBrand);
		  PrintInfo.setUe(STRING, ResourceModel);
		  PrintInfo.setUe(LONG, IMEICode);
		  PrintInfo.setUe(STRING, LoginName);
		  
			UType payStages = new UType();
			OprInfo.setUe(payStages);
		   	
			List busiInfoNodeList=mapbean.getList("REQUEST_INFO.BUSIINFO_LIST.BUSIINFO");
			int busiInfoNodeSize=busiInfoNodeList.size();
			String domainType="";
			MapBean busiInfoMap=null;
			for(int i=0;i<busiInfoNodeSize;i++){
				busiInfoMap=new MapBean( (Map)busiInfoNodeList.get(i) );
				domainType= busiInfoMap.getString("DOMAIN_TYPE");
				if(domainType.toUpperCase().equals(DOMAIN_TYPE_FQ)){//分期付款
					//判断是否有分期付款STAGES_PAY节点，如果没有，就是默认值0
					Object stagesPayNode=busiInfoMap.getValue("BUSI_MODEL.STAGES_PAY");
					if(null!=stagesPayNode && !stagesPayNode.equals(NO_KEY_VALUE)){
						  String stagesPayType=busiInfoMap.getString("BUSI_MODEL.STAGES_PAY.STAGES_PAY_TYPE");
						  String payBank=busiInfoMap.getString("BUSI_MODEL.STAGES_PAY.PAY_BANK");
						  String payMonths=busiInfoMap.getString("BUSI_MODEL.STAGES_PAY.PAY_MONTH");
						  String monthRate=busiInfoMap.getString("BUSI_MODEL.STAGES_PAY.MONTH_RATE");
						  payStages.setUe(STRING, stagesPayType);
						  payStages.setUe(STRING, payBank);
						  payStages.setUe(STRING, payMonths);
						  payStages.setUe(STRING, monthRate);					
					}else{
						  payStages.setUe(STRING, "0");
						  payStages.setUe(STRING, "0");
						  payStages.setUe(STRING, "0");
						  payStages.setUe(STRING, "0");						
					}
					break;//只需要处理分期付款的数据
				}			
			} //end for.
		
		//oldLoginAccept 取消使用，订购不用，给个固定值0。
		String oldLoginAccept=mapbean.getString("REQUEST_INFO.OPR_INFO.OLD_LOGINACCEPT");
		if(null!=oldLoginAccept && !NO_KEY_VALUE.equals(oldLoginAccept)  ){
			OprInfo.setUe(STRING, oldLoginAccept);
		}else{
			OprInfo.setUe(STRING, "0");
		}
		
		OprInfo.setUe(STRING, mapbean.getString("REQUEST_INFO.OPR_INFO.SERVICE_NO") );//MainPhone
		
		//---------------CustOrder------------------
		UType CustOrder = new UType();
		MsgBody.setUe(CustOrder);
		
		UType CustOrderMsg = new UType();
		CustOrder.setUe(CustOrderMsg);
		  String CustOrderId=mapbean.getString("REQUEST_INFO.OPR_INFO.CUSTORDERID");
		  CustOrderMsg.setUe(STRING, CustOrderId);
		
		
		UType OrderArrayList = new UType();
		CustOrder.setUe(OrderArrayList);
		
		  //OrderArrayListContainer是一个0~n的节点类型，shiyonga说实际业务就是一个节点，因此，放到循环外面处理。
		  UType OrderArrayListContainer = new UType();
		  OrderArrayList.setUe(OrderArrayListContainer);
		  
		    UType OrderArrayMsg = new UType();
		    OrderArrayListContainer.setUe(OrderArrayMsg);
		      String OrderArrayId=mapbean.getString("REQUEST_INFO.OPR_INFO.ORDERARRAYID");
		      OrderArrayMsg.setUe(STRING,OrderArrayId);//OrderArrayId
		  
		  
		    UType ServOrderList = new UType();
		    OrderArrayListContainer.setUe(ServOrderList);
		
		for(int i=0;i<busiInfoNodeSize;i++){
			busiInfoMap=new MapBean( (Map)busiInfoNodeList.get(i) );
			domainType = busiInfoMap.getString("DOMAIN_TYPE");
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ domainType = "+domainType);

			  /**
			   sunliang和shiyonga:
			   满足以下条件之一就压ServOrderListContainer数据：
			   1.有BUSI_MODEL节点，并且必须有子节点数据
			   2.sunliang:对于费用节点，在BUSIINFO节点下没有BUSI_MODEL，而直接是ORDER_LINE_FEELIST节点，并且必须有子节点数据
			  */
			  
			  boolean busiModeFlag=false;
			  List tmpList=new ArrayList();
			  Object objtest=busiInfoMap.getValue("BUSI_MODEL");
			  if(null!=objtest && objtest instanceof Map ){
			    this.xmlElement((Map) objtest, tmpList);
			    if(tmpList.size()>0){
			    	busiModeFlag=true;
			    	logger.info("----------------BUSI_MODEL node has child node-----------,DOMAIN_TYPE="+domainType);
			    }
			  }
			  
			  //boolean busiModeFlag=this.hasChildNode(busiInfoMap, "BUSI_MODEL");
			  boolean feeListFlag=this.hasChildNode(busiInfoMap, "ORDER_LINE_FEELIST");
			  if(true == busiModeFlag || true == feeListFlag){
			      //ServOrderListContainer是一个0~n的节点类型
			      UType ServOrderListContainer = new UType();
			      ServOrderList.setUe(ServOrderListContainer);
			      
			        UType ServOrderMsg = new UType();
			        ServOrderListContainer.setUe(ServOrderMsg);
			          ServOrderMsg.setUe(STRING, "");//ServOrderId
			          ServOrderMsg.setUe(STRING, "0");//ServOrderNo
			          ServOrderMsg.setUe(STRING, "0");//ServOrderChangeId
			          ServOrderMsg.setUe(LONG, busiInfoMap.getString("ID_NO"));//IdNo
			          logger.info("ID_NO="+busiInfoMap.getString("ID_NO"));
			          ServOrderMsg.setUe(STRING, busiInfoMap.getString("PHONE_NO"));//ServiceNo
			          logger.info("PHONE_NO="+busiInfoMap.getString("PHONE_NO"));
			          ServOrderMsg.setUe(INT, "0");//DispathRule
			          ServOrderMsg.setUe(INT, "0");//DecomposeRule
			          ServOrderMsg.setUe(LONG, "0");//AddressId
			          ServOrderMsg.setUe(INT, "110");//OrderStatus
			          ServOrderMsg.setUe(STRING, curTime);//StateDate
			          ServOrderMsg.setUe(INT, "3");//StateReasonId
			          ServOrderMsg.setUe(STRING, busiInfoMap.getString("SERVICE_OFFER_ID"));//ServBusiId
			          ServOrderMsg.setUe(STRING, "N");//FinishFlag
			          ServOrderMsg.setUe(STRING, "0");//FinishTime 以前是N
			          ServOrderMsg.setUe(STRING, curTime);//FinishLimitTime
			          ServOrderMsg.setUe(STRING, curTime);//WarningTime
			          ServOrderMsg.setUe(INT, "1");//DealLevel
			          ServOrderMsg.setUe(STRING, "0");//PayStatus
			          ServOrderMsg.setUe(STRING, "0");//BackFlag
			          ServOrderMsg.setUe(INT, "0");//ExceptionTimes
			          ServOrderMsg.setUe(INT, "1");//ServOrderSeq
			          ServOrderMsg.setUe(STRING, "Y");//IsPreCreateStatus
			          ServOrderMsg.setUe(STRING, "0");//ContactPerson
			          ServOrderMsg.setUe(STRING, busiInfoMap.getString("PHONE_NO"));//ContactPhone
			      
			      
			        UType ServOrderDataList = new UType();
			        ServOrderListContainer.setUe(ServOrderDataList);
			        
			        System.out.println("#########################################feeListFlag###########="+feeListFlag);
			        if(true == feeListFlag){
			        //费用节点 拼税率
				          String markPrict = busiInfoMap.getString("MARKET_PRICE");
				          if(null!=markPrict && !NO_KEY_VALUE.equals(markPrict) && !markPrict.trim().equals("")){
				        	  UType ServOrderData = new UType();
					          ServOrderData.setUe(LONG, "30025");
					          ServOrderData.setUe(INT, "0");
					          ServOrderData.setUe(STRING, markPrict);	          
				        	  ServOrderDataList.setUe(ServOrderData);
				          }	
				            System.out.println("#########################################终端拼接税额 30025="+markPrict);
				          String taxPerCent=busiInfoMap.getString("TAX_PERCENT");
				          if(null!=taxPerCent && !NO_KEY_VALUE.equals(taxPerCent) && !taxPerCent.trim().equals("")){
				        	  UType ServOrderData = new UType();
					          ServOrderData.setUe(LONG, "30026");
					          ServOrderData.setUe(INT, "0");
					          ServOrderData.setUe(STRING, taxPerCent);
				        	  ServOrderDataList.setUe(ServOrderData);
				          }	
				          	System.out.println("#########################################终端拼接税额222222 30026="+taxPerCent);
				          String taxFee=busiInfoMap.getString("TAX_FEE");
				          if(null!=taxFee && !NO_KEY_VALUE.equals(taxFee) && !taxFee.trim().equals("")){
				        	  UType ServOrderData = new UType();
					          ServOrderData.setUe(LONG, "30027");
					          ServOrderData.setUe(INT, "0");
					          ServOrderData.setUe(STRING, taxFee);
				        	  ServOrderDataList.setUe(ServOrderData);
				          }
				          	System.out.println("#########################################终端拼接税额333333 30027="+taxFee);
			        }
			        
			        
			          //对应utype的扩展属性的数据，目前放在BUSI_MODEL.DATA_LIST中
			          Object obj=busiInfoMap.getValue("BUSI_MODEL.DATA_LIST");
			          if(null!=obj && obj instanceof Map ){
				          //ServOrderData是一个0~n的节点类型
				          
				          String ClassValue="";	          
				          String ClassCode="";		          
				          ClassValue=busiInfoMap.getString("BUSI_MODEL.DATA_LIST.RESOURCE_MONTH_PAY");
				          if(null!=ClassValue && !NO_KEY_VALUE.equals(ClassValue) && !ClassValue.trim().equals("")){
				        	  ClassCode="30000";
				        	  UType ServOrderData = new UType();
				        	  ServOrderDataList.setUe(ServOrderData);
					          ServOrderData.setUe(LONG, ClassCode);//ClassCode
					          ServOrderData.setUe(INT, "0");//ArraySeq,目前填写0
					          ServOrderData.setUe(STRING, ClassValue);//ClassValue			          
				          }		          
				          
				          ClassValue=busiInfoMap.getString("BUSI_MODEL.DATA_LIST.CHK_LENGTH");
				          if(null!=ClassValue && !NO_KEY_VALUE.equals(ClassValue) && !ClassValue.trim().equals("")){
				        	  ClassCode="30001";
				        	  UType ServOrderData = new UType();
				        	  ServOrderDataList.setUe(ServOrderData);
					          ServOrderData.setUe(LONG, ClassCode);//ClassCode
					          ServOrderData.setUe(INT, "0");//ArraySeq,目前填写0
					          ServOrderData.setUe(STRING, ClassValue);//ClassValue			          
				          }		
				          ClassValue=busiInfoMap.getString("BUSI_MODEL.DATA_LIST.RESOURCE_UNDEADLINE");
				          if(null!=ClassValue && !NO_KEY_VALUE.equals(ClassValue) && !ClassValue.trim().equals("")){
				        	  ClassCode="30002";
				        	  UType ServOrderData = new UType();
				        	  ServOrderDataList.setUe(ServOrderData);
					          ServOrderData.setUe(LONG, ClassCode);//ClassCode
					          ServOrderData.setUe(INT, "0");//ArraySeq,目前填写0
					          ServOrderData.setUe(STRING, ClassValue);//ClassValue			          
				          }
				          if(domainType.toUpperCase().equals(DOMAIN_TYPE_FQ)){
				          	  	List spList = busiInfoMap.getList("GSP_INFO");
				          	  	if(!NO_KEY_VALUE.equals(spList.get(0))){
					  				for(int spIndex=0;spIndex<spList.size();spIndex++){
					  					MapBean spMap = new MapBean((Map)spList.get(spIndex));
					  					if(spMap != null){
						  					String spStr = spMap.getString("GSP_STR");
						  					if(NO_KEY_VALUE.equals(spStr)){
						  						continue;
						  					}
						  					ClassCode="30003";
						  					UType ServOrderData = new UType();
						  					ServOrderData.setUe(LONG, ClassCode);
						  					ServOrderData.setUe(INT, spIndex+"");
						  					ServOrderData.setUe(STRING, spStr);
						  					ServOrderDataList.setUe(ServOrderData);
					  					}
					  				}
				          	  	}
				          	  	
				          		  ClassValue = busiInfoMap.getString("BUSI_MODEL.DATA_LIST.SCORE_VALUE");
						          if(null!=ClassValue && !NO_KEY_VALUE.equals(ClassValue) && !ClassValue.trim().equals("")){
						        	  UType ServOrderData = new UType();
						        	  ServOrderDataList.setUe(ServOrderData);
							          ServOrderData.setUe(LONG, "30038");//ClassCode
							          ServOrderData.setUe(INT, "0");//ArraySeq,目前填写0
							          ServOrderData.setUe(STRING, ClassValue);//ClassValue
							          System.out.println("=======================================--30038-***************ClassValue"+ClassValue);	
						          }
						          ClassValue=busiInfoMap.getString("BUSI_MODEL.DATA_LIST.GIFT_CODE");
						          if(null!=ClassValue && !NO_KEY_VALUE.equals(ClassValue) && !ClassValue.trim().equals("")){
						        	  UType ServOrderData = new UType();
						        	  ServOrderDataList.setUe(ServOrderData);
							          ServOrderData.setUe(LONG, "30039");//ClassCode
							          ServOrderData.setUe(INT, "0");//ArraySeq,目前填写0
							          ServOrderData.setUe(STRING, ClassValue);//ClassValue
							          System.out.println("=========================================-30039--***************ClassValue"+ClassValue);	
						          }
						          ClassValue=busiInfoMap.getString("BUSI_MODEL.DATA_LIST.PLANT_FLAG");
						          if(null!=ClassValue && !NO_KEY_VALUE.equals(ClassValue) && !ClassValue.trim().equals("")){
						        	  UType ServOrderData = new UType();
						        	  ServOrderDataList.setUe(ServOrderData);
							          ServOrderData.setUe(LONG, "30040");//ClassCode
							          ServOrderData.setUe(INT, "0");//ArraySeq,目前填写0
							          ServOrderData.setUe(STRING, ClassValue);//ClassValue
							          System.out.println("=========================================-30040--***************ClassValue"+ClassValue);	
						          }
				          	  	
				          	  	
				          	  	
				          }
			          }
			          
			          System.out.println("#########################################SP业务 domainType="+domainType);
			          if(domainType.toUpperCase().equals(DOMAIN_TYPE_SP)){
			          	  	List spList = busiInfoMap.getList("BUSI_MODEL.SP_INFO");
			          	   System.out.println("#########################################SP业务 spList.size()="+spList.size());
			          	 System.out.println("#########################################SP业务 spList.get(0)="+spList.get(0));
			          	  	if(!NO_KEY_VALUE.equals(spList.get(0))){
				  				for(int spIndex=0;spIndex<spList.size();spIndex++){
				  					MapBean spMap = new MapBean((Map)spList.get(spIndex));
				  					if(spMap != null){
					  					String spCode = spMap.getString("SP_CODE");
					  					String busiCode = spMap.getString("BUSI_CODE");
					  					String startDate = spMap.getString("START_DATE");
					  					String endDate = spMap.getString("END_DATE");
					  					String boxId = spMap.getString("BOX_ID");
					  					System.out.println("#########################################SP业务 spCode="+spCode);
					  					System.out.println("#########################################SP业务 busiCode="+busiCode);
					  					System.out.println("#########################################SP业务 startDate="+startDate);
					  					System.out.println("#########################################SP业务 endDate="+endDate);
					  					System.out.println("#########################################SP业务 boxId="+boxId);
					  					if(NO_KEY_VALUE.equals(spCode)){
					  						continue;
					  					}
					  					if(null!=spCode && !spCode.trim().equals("")){
						  					UType ServOrderData = new UType();
						  					ServOrderData.setUe(LONG, "30021");
						  					ServOrderData.setUe(INT, spIndex+"");
						  					ServOrderData.setUe(STRING, spCode);
						  					ServOrderDataList.setUe(ServOrderData);
					  					}
					  					if(null!=busiCode && !busiCode.trim().equals("")){
						  					UType ServOrderData = new UType();
						  					ServOrderData.setUe(LONG, "30022");
						  					ServOrderData.setUe(INT, spIndex+"");
						  					ServOrderData.setUe(STRING, busiCode);
						  					ServOrderDataList.setUe(ServOrderData);
					  					}
					  					if(null!=startDate && !startDate.trim().equals("")){
						  					UType ServOrderData = new UType();
						  					ServOrderData.setUe(LONG, "30023");
						  					ServOrderData.setUe(INT, spIndex+"");
						  					ServOrderData.setUe(STRING, startDate);
						  					ServOrderDataList.setUe(ServOrderData);
					  					}
					  					if(null!=endDate && !endDate.trim().equals("")){
						  					UType ServOrderData = new UType();
						  					ServOrderData.setUe(LONG, "30024");
						  					ServOrderData.setUe(INT, spIndex+"");
						  					ServOrderData.setUe(STRING, endDate);
						  					ServOrderDataList.setUe(ServOrderData);
					  					}
					  					if(null!=boxId && !boxId.trim().equals("")){
						  					UType ServOrderData = new UType();
						  					ServOrderData.setUe(LONG, "40000");
						  					ServOrderData.setUe(INT, spIndex+"");
						  					ServOrderData.setUe(STRING, boxId);
						  					ServOrderDataList.setUe(ServOrderData);
					  					}
					  					
				  					}
				  				}
			          	  	}
			          }
			          
			        UType ServOrderSlaList = new UType();   
			        ServOrderListContainer.setUe(ServOrderSlaList);          
				    
			        UType ServOrderBookingMsg = new UType();
			        ServOrderListContainer.setUe(ServOrderBookingMsg); 
			        
			        UType ServOrderExcpInfo = new UType();
			        ServOrderListContainer.setUe(ServOrderExcpInfo);
			          ServOrderExcpInfo.setUe(STRING, "0");//SrvOrderExcpId
			          ServOrderExcpInfo.setUe(INT, "1");//ExcpType
			          ServOrderExcpInfo.setUe(STRING, "0");//ExcpReason
			          ServOrderExcpInfo.setUe(STRING, "OK");//HandleResult
			          ServOrderExcpInfo.setUe(STRING, "0");//HandleLogin
			        
			        
			        UType DeductionIntegralBusiList = new UType();
			        ServOrderListContainer.setUe(DeductionIntegralBusiList);
			        
			          if(domainType.toUpperCase().equals(DOMAIN_TYPE_S)){//积分
			        	  obj=busiInfoMap.getValue("BUSI_MODEL.DEDUCTION_INTEGRAL_BUSI_LIST.DEDUCTION_INTEGRAL_BUSI_INFO");
			          
			          	System.out.println("@@@@@@@"+obj);
			        	  if(null!=obj && obj instanceof List){
			        		  System.out.println("!!!!!!!!!!!!");
			        		//DeductionIntegralBusi是一个0~n的节点类型
			        		List scoreList=(List) obj;
			        		int scoreSize=scoreList.size();
			        		MapBean scoreMap=null;
			        		for(int score_i=0;score_i<scoreSize;score_i++){
			        			scoreMap=new MapBean( (Map)scoreList.get(score_i) );
						        UType DeductionIntegralBusi = this.setScoreNode(scoreMap);
						        DeductionIntegralBusiList.setUe(DeductionIntegralBusi);	        			
			        		}
			        			
			        	  }else if(null!=obj && obj instanceof Map){
			        		  System.out.println("#######");
					        MapBean scoreMap=new MapBean( (Map)obj );
					        System.out.println("#######"+scoreMap);
					        UType DeductionIntegralBusi = this.setScoreNode(scoreMap);
					        DeductionIntegralBusiList.setUe(DeductionIntegralBusi);
					        
			        	  } 
			         
			          }
			        
			        UType ServsFeeList = new UType();
			        ServOrderListContainer.setUe(ServsFeeList);
			        if(domainType.toUpperCase().equals(DOMAIN_TYPE_F)){//费用。注意:没有BUSI_MODEL节点。
			        	  obj=busiInfoMap.getValue("ORDER_LINE_FEELIST.ORDER_LINE_FEE");
			        	  if(null!=obj && obj instanceof List){
			        		//servFeeLineContainer是一个0~n的节点类型
			        		List feeList=(List) obj;
			        		int feeSize=feeList.size();
			        		MapBean feeMap=null;
			        		for(int fee_i=0;fee_i<feeSize;fee_i++){
			        			feeMap=new MapBean( (Map)feeList.get(fee_i) );
						        UType servFeeLineContainer = this.setFeeNode(feeMap);
						        ServsFeeList.setUe(servFeeLineContainer);	        			
			        		}
			        			
			        	  }else if(null!=obj && obj instanceof Map){
					        MapBean feeMap=new MapBean( (Map)obj );
					        UType servFeeLineContainer = this.setFeeNode(feeMap);
					        ServsFeeList.setUe(servFeeLineContainer);			        
			        	  }	        	
			        }
		 
			        UType ResSellInfoList = new UType();
			        ServOrderListContainer.setUe(ResSellInfoList);
			        if(domainType.toUpperCase().equals(DOMAIN_TYPE_Z)){//资源：促销品,终端
			        	  obj=busiInfoMap.getValue("BUSI_MODEL.RES_INFO_LIST.RES_INFO");
			        	  if(null!=obj && obj instanceof List){
			        		//ResInfoContainer是一个0~n的节点类型
			        		List resList=(List) obj;
			        		int resSize=resList.size();
			        		MapBean resMap=null;
			        		for(int res_i=0;res_i<resSize;res_i++){
			        			resMap=new MapBean( (Map)resList.get(res_i) );
						        UType ResInfoContainer = this.setResNode(resMap);
						        ResSellInfoList.setUe(ResInfoContainer);	        			
			        		}
			        			
			        	  }else if(null!=obj && obj instanceof Map){
					        MapBean resMap=new MapBean( (Map)obj );
					        UType ResInfoContainer = this.setResNode(resMap);
					        ResSellInfoList.setUe(ResInfoContainer);			        
			        	  }	 	        	
			        }
		 
			        UType phoneCertList = new UType();
			        ServOrderListContainer.setUe(phoneCertList); 
			        if(domainType.toUpperCase().equals(DOMAIN_TYPE_PH)){//手机凭证发放
			        	  obj=busiInfoMap.getValue("BUSI_MODEL.PHONE_CERT");
			        	  if(null!=obj && obj instanceof List){
			        		//phoneCertContainer是一个0~n的节点类型
			        		List phoneList=(List) obj;
			        		int phoneSize=phoneList.size();
			        		MapBean phoneMap=null;
			        		for(int phone_i=0;phone_i<phoneSize;phone_i++){
			        			phoneMap=new MapBean( (Map)phoneList.get(phone_i) );
						        UType phoneCertContainer = this.setPhoneNode(phoneMap);
						        phoneCertList.setUe(phoneCertContainer);	        			
			        		}
			        			
			        	  }else if(null!=obj && obj instanceof Map){
					        MapBean phoneMap=new MapBean( (Map)obj );
					        UType phoneCertContainer = this.setPhoneNode(phoneMap);
					        phoneCertList.setUe(phoneCertContainer);			        
			        	  }	 	        	
			        }
			        
			  } //end BUSI_MODEL 
	 
		}//end for.         
		
	 
		//---------------Customer------------------
		UType Customer = new UType();
		MsgBody.setUe(Customer);
		
		  UType CustDoc = new UType();
		  Customer.setUe(CustDoc);
		    UType CustDocBaseInfo = new UType();
		    CustDoc.setUe(CustDocBaseInfo);
		      CustDocBaseInfo.setUe(LONG, mapbean.getString("REQUEST_INFO.OPR_INFO.CUST_ID"));
		     
		  UType UserInfoList = new UType();
		  Customer.setUe(UserInfoList);
		  
		  String phone_no="",havePhoneNoStr="";
		  int index=-1;
	 
		  
		  for(int i=0;i<busiInfoNodeSize;i++){
		    busiInfoMap=new MapBean( (Map)busiInfoNodeList.get(i) );
			domainType= busiInfoMap.getString("DOMAIN_TYPE");
			
			  phone_no=busiInfoMap.getString("PHONE_NO");
			  index=havePhoneNoStr.indexOf(","+phone_no+",");
			  if(index==-1){//用户信息是不能重复的 
				UType UserInfo = new UType();
				UserInfoList.setUe(UserInfo);
				  
				  UType UserBaseInfo = new UType();
				  UserInfo.setUe(UserBaseInfo);
				  UserBaseInfo.setUe(STRING, phone_no );//ServiceNo
				  UserBaseInfo.setUe(LONG, busiInfoMap.getString("ID_NO") );//UserId			  
				  UserBaseInfo.setUe(STRING, busiInfoMap.getString("BRAND_ID") );//Brand
				  UserBaseInfo.setUe(STRING, "" );//UserNo
				  UserBaseInfo.setUe(STRING, busiInfoMap.getString("GROUP_ID") );//GroupId
				  UserBaseInfo.setUe(LONG, busiInfoMap.getString("CUST_ID") );//UseCustId
					
			  
			  havePhoneNoStr=havePhoneNoStr+","+phone_no+",";
			  logger.info("----------------havePhoneNoStr="+havePhoneNoStr);
			  
			
			  //如果是资费，还需要处理其他节点，否则，其他节点都是空值。
			  if(domainType.toUpperCase().equals(DOMAIN_TYPE_P)){
			    UType DiscountInfoList = new UType();
			    UserInfo.setUe(DiscountInfoList);
			    
				//判断是否有PRODPRC节点
				Object prodprcNode=busiInfoMap.getValue("BUSI_MODEL.PRODPRC_LIST.PRODPRC");
				if(null!=prodprcNode && !prodprcNode.equals(NO_KEY_VALUE)){
					  List prodprcNodeList=busiInfoMap.getList("BUSI_MODEL.PRODPRC_LIST.PRODPRC");
					  
					  int prodprcNodeSize=prodprcNodeList.size();
					  MapBean prodprcMap=null;
					  for(int prodprcNode_i=0;prodprcNode_i<prodprcNodeSize;prodprcNode_i++){
						  prodprcMap=new MapBean( (Map)prodprcNodeList.get(prodprcNode_i) );
					      //DiscountInfoListContainer是一个0~n的节点类型
					      UType DiscountInfoListContainer = new UType();
					      DiscountInfoList.setUe(DiscountInfoListContainer);
					      
					        UType DiscountInfo = new UType();
					        DiscountInfoListContainer.setUe(DiscountInfo);
					          DiscountInfo.setUe(STRING, prodprcMap.getString("OPERATE_TYPE"));//OperatorFlag
					          DiscountInfo.setUe(STRING, prodprcMap.getString("DISCOUNTPLANINSTID"));//DiscountPlanInstId
					          DiscountInfo.setUe(STRING, prodprcMap.getString("ORDER"));//Order
					          DiscountInfo.setUe(STRING, prodprcMap.getString("CUSTAGREEMENTID"));//CustAgreementId
					          DiscountInfo.setUe(STRING, prodprcMap.getString("STATUS"));//Status
					          DiscountInfo.setUe(STRING, prodprcMap.getString("DEVELOP_NO"));//DevelopLoginNo
					          DiscountInfo.setUe(STRING, busiInfoMap.getString("GROUP_ID") );//ChannelId
					          DiscountInfo.setUe(STRING, prodprcMap.getString("PEI_FEE_CODE"));//DiscountPlanId
					          DiscountInfo.setUe(STRING, prodprcMap.getString("EFF_DATE"));//EffectTime
					          DiscountInfo.setUe(STRING, prodprcMap.getString("EXP_DATE"));//ExpireTime
					          DiscountInfo.setUe(STRING, prodprcMap.getString("DISCOUNTPLANINSTID"));//ParentInstId
					          DiscountInfo.setUe(STRING, prodprcMap.getString("CURLEVEL"));//CurLevel
					      
					      
					        UType DiscountAttrList = new UType();
					        DiscountInfoListContainer.setUe(DiscountAttrList);
					          //DiscountAttr是一个0~n的节点类型，但是目前营销案此节点也就一个，因此，不需要循环处理了。
					          
					          //小区代码为空，就不拼DiscountAttr节点了
					          String distriFeeCode=prodprcMap.getString("DISTRI_FEE_CODE").trim();
					          if( !distriFeeCode.equals("") ){
					        	  UType DiscountAttr = new UType();
					        	  DiscountAttrList.setUe(DiscountAttr);
					        	  //shiyonga要求的转换。
					        	  String operateType=prodprcMap.getString("OPERATE_TYPE");
					        	  if(operateType.equals("3")){
					        		  operateType="2";
					        	  }else{
					        		  operateType="1";
					        	  }
					        	  
					        	  DiscountAttr.setUe(STRING, operateType);//OperatorFlag
					        	  DiscountAttr.setUe(STRING, "");//AttrType
					        	  DiscountAttr.setUe(STRING, "60001");//AttrCode
					        	  DiscountAttr.setUe(STRING, prodprcMap.getString("DISTRI_FEE_CODE"));//AttrValue 
					        	  DiscountAttr.setUe(STRING, "");//AttrRemark 
					        	  DiscountAttr.setUe(STRING, prodprcMap.getString("STATUS"));//StateCd  
					        	  DiscountAttr.setUe(STRING, prodprcMap.getString("EFF_DATE"));//effDate  
					        	  DiscountAttr.setUe(STRING, prodprcMap.getString("EXP_DATE"));//expDate  
					        	
					          }

					        //GroupInstInfo 先拼一个空节点吧，后续待处理【TBD】
						    UType GroupInstInfo = new UType();
						    DiscountInfoListContainer.setUe(GroupInstInfo);
					      
					        UType DiscountParamList = new UType();
					        DiscountInfoListContainer.setUe(DiscountParamList);//DiscountParamList目前是空节点
					      
					     
					    
					  } //end for BUSI_MODEL.PRODPRC_LIST.PRODPRC.				
				} //end if.
				
				  UType UserRelaInfoList = new UType();
				UserInfo.setUe(UserRelaInfoList);//UserRelaInfoList目前是空节点  
				  UType ProductList = new UType();
			    UserInfo.setUe(ProductList);//ProductList目前是空节点  
				  UType UserResList = new UType();
				UserInfo.setUe(UserResList);//UserResList目前是空节点  
				  UType BusiFeeFactorList = new UType();
			    UserInfo.setUe(BusiFeeFactorList);//BusiFeeFactorList目前是空节点  
			        
			  }else{//非资费
			      UType DiscountInfoList = new UType();
				UserInfo.setUe(DiscountInfoList);//DiscountInfoList目前是空节点
				  UType UserRelaInfoList = new UType();
				UserInfo.setUe(UserRelaInfoList);//UserRelaInfoList目前是空节点  
				  UType ProductList = new UType();
			    UserInfo.setUe(ProductList);//ProductList目前是空节点  
				  UType UserResList = new UType();
				UserInfo.setUe(UserResList);//UserResList目前是空节点  
				  UType BusiFeeFactorList = new UType();
			    UserInfo.setUe(BusiFeeFactorList);//BusiFeeFactorList目前是空节点  			  
			  }

			}//end if.判断不重复.
			  
	      }//end for.
		 
		return MsgBody;	
	  }
		
	  
	  /**
	   * 设置手机凭证节点值
	   * @param resMap
	   * @return
	   */
	  private UType setPhoneNode(MapBean resMap){
		  UType phoneCertContainer = new UType();
		  
		  phoneCertContainer.setUe(STRING, resMap.getString("FROMNODE"));//FromNode
		  phoneCertContainer.setUe(STRING, resMap.getString("PASSWD"));//passWd
		  phoneCertContainer.setUe(STRING, resMap.getString("REQTRANSNO"));//reqTransNo
		  phoneCertContainer.setUe(STRING, resMap.getString("REQTIME"));//reqTime
		  phoneCertContainer.setUe(STRING, resMap.getString("MACODE"));//maCode
		  phoneCertContainer.setUe(STRING, resMap.getString("MANAME"));//maName
		  phoneCertContainer.setUe(STRING, resMap.getString("PHONENO"));//phoneNo
		  phoneCertContainer.setUe(STRING, resMap.getString("USERID"));//userId
		  phoneCertContainer.setUe(STRING, resMap.getString("BAGSFLAG"));//bagsFlag
		  phoneCertContainer.setUe(STRING, resMap.getString("BAGSCODE"));//bagsCode
		  phoneCertContainer.setUe(STRING, resMap.getString("BAGSNAME"));//bagsName
		  phoneCertContainer.setUe(STRING, resMap.getString("IFEXCHTIMES"));//ifExchTimes
		  phoneCertContainer.setUe(STRING, resMap.getString("VALIDITY"));//validity
		  phoneCertContainer.setUe(STRING, resMap.getString("GOODSCOUNT"));//goodsCount
		  phoneCertContainer.setUe(STRING, resMap.getString("GOODSINFO"));//goodsInfo
		  phoneCertContainer.setUe(STRING, resMap.getString("BUSCOUNT"));//busCount
		  phoneCertContainer.setUe(STRING, resMap.getString("BUSINFO"));//busiInfo
		  phoneCertContainer.setUe(STRING, resMap.getString("OPERID"));//operId
		  phoneCertContainer.setUe(STRING, resMap.getString("ORGID"));//orgId
		  phoneCertContainer.setUe(STRING, resMap.getString("IFTOKEN"));//ifToken
	 
		  return phoneCertContainer;
	  }
	  
	  /**
	   * 设置资源节点值
	   * @param resMap
	   * @return
	   */
	  private UType setResNode(MapBean resMap){
	      UType ResInfoContainer = new UType();
		  
	      ResInfoContainer.setUe(STRING, resMap.getString("IMEI_CODE"));//ImeiCode
	      ResInfoContainer.setUe(DOUBLE, resMap.getString("SALE_PRICE"));//SalePrice
	      ResInfoContainer.setUe(STRING, resMap.getString("SALE_NOTE"));//SaleNote
	      ResInfoContainer.setUe(STRING, resMap.getString("SALE_CODE"));//SaleCode
	      ResInfoContainer.setUe(STRING, resMap.getString("GIFT_SOURCE"));//GiftSource
	      ResInfoContainer.setUe(STRING, resMap.getString("GIFT_NO"));//GiftNo
	      ResInfoContainer.setUe(STRING, resMap.getString("GIFT_MODEL"));//GiftModel
	      ResInfoContainer.setUe(STRING, resMap.getString("RES_BUSI_TYPE"));//ResBusiType
	      String is_phone = "N/A".equals(resMap.getString("IS_PHONE"))?"":resMap.getString("IS_PHONE");
	      ResInfoContainer.setUe(STRING, is_phone);//isPhone
	      ResInfoContainer.setUe(STRING, "");//FactorOne
	      ResInfoContainer.setUe(STRING, "");//FactorTwo
	      ResInfoContainer.setUe(STRING, "");//FactorThree
	      ResInfoContainer.setUe(STRING, "");//FactorFour
	      ResInfoContainer.setUe(STRING, "");//FactorFive
	      ResInfoContainer.setUe(STRING, "");//6
	      ResInfoContainer.setUe(STRING, "");//7
	      ResInfoContainer.setUe(STRING, "");//8
	      ResInfoContainer.setUe(STRING, "");//9
	      ResInfoContainer.setUe(STRING, "");//10
	      ResInfoContainer.setUe(STRING, "");//11
	      ResInfoContainer.setUe(STRING, "");//12
	      ResInfoContainer.setUe(STRING, "");//13
	      ResInfoContainer.setUe(STRING, "");//14
	      ResInfoContainer.setUe(STRING, "");//15
	      	  
		  return ResInfoContainer;
	  }
	  /**
	   * 设置费用节点值
	   * @param feeMap
	   * @return
	   */
	  private UType setFeeNode(MapBean feeMap){
		  UType servFeeLineContainer = new UType();
		  
		  servFeeLineContainer.setUe(STRING, feeMap.getString("RECEIVE_FEE_TYPE"));//ReceiveFeeType
		  servFeeLineContainer.setUe(STRING, feeMap.getString("RECEIVE_ACC_TYPE"));//ReceiveAccType
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FEE_TYPE"));//FeeType
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FEE_CODE"));//FeeCode
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_ONE"));//FactorOne
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWO"));//FactorTwo
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_THREE"));//FactorThree
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_FOUR"));//FactorFour
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_FIVE"));//FactorFour
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_SIX"));//FactorSix
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_SEVEN"));//FactorSeven
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_EIGHT"));//FactorEight
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_NINE"));//FactorNine 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TEN"));//FactorTen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_ELEVEN"));//FactorEleven 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWELVE"));//FactorTwelve 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_THIRTEEN"));//FactorThirteen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_FOURTEEN"));//FactorForteen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_FIFTEEN"));//FactorFifteen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_SIXTEEN"));//FactorSixteen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_SEVENTEEN"));//FactorSeventeen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_EIGHTEEN"));//FactorEighteen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_NINETEEN"));//FactorEineteen 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTY"));//FactorTwenty 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYONE"));//FactorTwentyOne 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYTWO"));//FactorTwentyTwo 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYTHREE"));//FactorTwentyThree 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYFOUR"));//FactorTwentyFour 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYFIVE"));//FactorTwentyFive 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYFSIX"));//FactorTwentySix 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYFSEVEN"));//FactorTwentySeven 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYFEIGHT"));//FactorTwentyEight 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_TWENTYFNINE"));//FactorTwentyNine 
		  servFeeLineContainer.setUe(STRING, feeMap.getString("FACTOR_THRITY"));//FactorThirty 
		  servFeeLineContainer.setUe(LONG, feeMap.getString("SHOULD_PAY"));//ShouldPay 
		  servFeeLineContainer.setUe(LONG, feeMap.getString("BUSI_SHOULD"));//BusiShould 
		  return servFeeLineContainer;	  
	  }
	  
	  /**
	   * 设置积分节点值
	   * @param scoreMap
	   * @return
	   */
	  private UType setScoreNode(MapBean scoreMap){
		  System.out.println("#######*******************");
	      UType DeductionIntegralBusi = new UType();

	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("SCORE_TYPE"));//scoreType
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("SCORE_VALUE"));//scoreValue
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("RES_NUM"));//resNum
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("CON_MONEY"));//conMoney
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("FACTOR_ONE"));//factorOne
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("FACTOR_TWO"));//factorTwo
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("FACTOR_THREE"));//factorThree
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("FACTOR_FOUR"));//factorFour
	      DeductionIntegralBusi.setUe(STRING, scoreMap.getString("FACTOR_FIVE"));//factorFive
	      return DeductionIntegralBusi;
	  }
	  
	  /**
	   * 判断某个节点下是否还有子节点
	   * @param mapBean
	   * @param nodeStr
	   * @return
	   */
	  private boolean hasChildNode(MapBean mapBean, String nodeStr){
		  boolean flag=false;
		  
		  Object obj=mapBean.getValue(nodeStr);
		  if(null!=obj && obj instanceof Map ){
			  Map m=(Map) obj;
			  if(!m.isEmpty()){
				  flag = true;
			  }else{
				  flag = false;
			  }
		  }
		  
		  return flag;
	  }

	  
	  /**
	   * 主要使用在递归判断是否有元素节点
	   * @param cmap
	   * @param result
	   */
	  private void xmlElement(Map cmap, List result)  
	  {
	  
	  	Iterator it = cmap.entrySet().iterator();
	  	while (it.hasNext()) 
	  	{
	  	   Map.Entry entry = (Map.Entry) it.next();
	  	   String key = (String)entry.getKey();
	  	   Object value = entry.getValue();
	   	   
		   if(key.indexOf("_attribute")!=-1){//表明是元素节点
	  	     result.add("1");
	  	     break;
	  	   }
			 
	  	   if(value instanceof Map)
	  	   {
	  		 xmlElement((Map)value,result);  
	  	   }
	  	   else if(value instanceof List)
	  	   {
	 
	              List list = (List)value;              
	              int size = list.size();
	              
	              for(int i=0; i<size; i++)
	              {
	                if(list.get(i) instanceof Map)
	              	{
	                  xmlElement((Map)list.get(i),result);                  		    
	              	}
	              	
	              } 
	  	   }  	   

	  	}
			
		}
	  
		/**
		 * 将xml转换成mapbean
		 * @throws BusiAppException 
		 * @throws IOException 
		 */
	  private MapBean xml2mapbean(String inXml) throws BusiAppException{	
	    	IXMLReader xmlReader=null;
	    	MapBean  mapbean = new MapBean();

	    	Map map = new HashMap(13); 
			InputStream is = new ByteArrayInputStream( inXml.getBytes() );
			xmlReader = StAXReaderFactory.getInstance().createReader(is);
		 	Unmarshalling context = new Unmarshalling(xmlReader );		  		  
			context.parseXML(map);     	
			mapbean = new MapBean(map);	
	 	    	
			return mapbean;
	  }
		
}
 
%>

<%	
String cancelInfoOp = request.getParameter("cancelInfo")==null?"":request.getParameter("cancelInfo");
String BUSI_ID = (String)request.getParameter("BUSI_ID");
String ID_NO = (String)request.getParameter("ID_NO");
String PHONE_NO = (String)request.getParameter("PHONE_NO");
String LOGIN_NO = (String)request.getParameter("LOGIN_NO");
String GROUP_ID = (String)request.getParameter("GROUP_ID");
String OP_CODE = (String)request.getParameter("OP_CODE");
String CANCEL_TYPE = (String)request.getParameter("CANCEL_TYPE");
JSONObject jsonObj=new JSONObject(cancelInfoOp);
String jsonXML = (String)JSONML.toString(jsonObj);
System.out.println("+++++++++++++++++++++++++++++++++++++cancelInfoOp:"+cancelInfoOp);
System.out.println("+++++++++++++++++++++++++++++++++++++CANCEL_TYPE:"+CANCEL_TYPE);
System.out.println("+++++++++++++++++++++++++++++++++++++cancelInfoJsonXml:"+jsonXML);


			String regionCode = (String)session.getAttribute("regCode");
			String XML_STR="<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\" ?>"+jsonXML;
			UType custInfoUtype=new SaleXml2Utype().chgXml2Utype(XML_STR);
			
%>

<s:service name="WsMktTableOperate">
				<s:param name="ROOT">
				 		<s:param name="BUSI_ID" type="string" value="<%=BUSI_ID %>" />
						<s:param name="ACTION_ID" type="string" value="" />
						<s:param name="ID_NO" type="string" value="<%=ID_NO %>" />
						<s:param name="PHONE_NO" type="string" value="<%=PHONE_NO %>" />
				 		<s:param name="LOGIN_NO " type="string" value="<%=LOGIN_NO %>" />
						<s:param name="GROUP_ID" type="string" value="<%=GROUP_ID %>" />
						<s:param name="CHN_CODE" type="string" value="0" />
						<s:param name="OP_CODE" type="string" value="<%=OP_CODE %>" />
						<s:param name="OPERATE_TABLE" type="string" value="mk_actrecord_info" />
						<s:param name="OPERATE_TYPE" type="string" value="update" />
						<s:param name="OPERATE_COLUMN" type="string" value="cancel_type" />
						<s:param name="COLUMN_VALUES" type="string" value="<%=CANCEL_TYPE %>" />
						<s:param name="CONDITION_COLUMN" type="string" value="busi_id" />
						<s:param name="CONDITION_VALUES" type="string" value="<%=BUSI_ID %>" />
				</s:param>
</s:service>

<%
	String rtnCode = result.getString("RETURN_CODE");
	String rtnMsg = result.getString("RETURN_MSG");	
	System.out.println("-----------WsMktTableOperate rtnCode="+rtnCode);
	System.out.println("-----------WsMktTableOperate rtnMsg="+rtnMsg);
	System.out.println("-----------custInfoUtype =-===="+custInfoUtype);
	 /* rtnCode = "0001";
	rtnMsg = "rtnMsg";  */
	if("000000".equals(rtnCode)){

%>
 
   			<wtc:utype name="sMarketExecCfm" id="retVal"  routerKey="region" routerValue="<%=regionCode%>" >
				<wtc:uparams name="ctrlInfo" iMaxOccurs="1">
					<wtc:uparam value="0" type="string"/>
				</wtc:uparams> 
				<wtc:uparams name="batchDataList" iMaxOccurs="1">
					<wtc:uparams name="batchData" iMaxOccurs="-1">
						<wtc:uparam value="0" type="long"/>
						<wtc:uparam value="0" type="string"/>
						<wtc:uparam value="0" type="string"/>
					</wtc:uparams> 
				</wtc:uparams> 			
				<wtc:uparam value="<%=custInfoUtype%>" type="UTYPE"/> 
			</wtc:utype>  
<%

/* 			String RETURN_CODE = "000001";
			String RETURN_MSG = "jkl;";   */

			String RETURN_CODE =String.valueOf(retVal.getValue(0));//返回的retCode为LONG类型；
			String RETURN_MSG =String.valueOf(retVal.getValue(1)); 
			
			System.out.println("-----------utype retrunCode="+RETURN_CODE);
			System.out.println("-----------utype returnMsg="+RETURN_MSG);
			//if(!"0".equals(RETURN_CODE)){
				
	%>		
			<s:service name="WsMktCancelInter">
				<s:param name="ROOT">
					 <s:param name="REQUEST_INFO">
				 		<s:param name="BUSI_ID" type="string" value="<%=BUSI_ID %>" />
						<s:param name="ACTION_ID" type="string" value="" />
						<s:param name="ID_NO" type="string" value="<%=ID_NO %>" />
						<s:param name="PHONE_NO" type="string" value="<%=PHONE_NO %>" />
				 		<s:param name="LOGIN_NO " type="string" value="<%=LOGIN_NO %>" />
						<s:param name="LOGIN_NAME" type="string" value="" />
						<s:param name="GROUP_ID" type="string" value="<%=GROUP_ID %>" />
						<s:param name="CHN_CODE" type="string" value="0" />
						<s:param name="OP_CODE" type="string" value="<%=OP_CODE %>" />
						<s:param name="CANCEL_XML" type="string" value="<%=jsonXML %>" />
					</s:param>
				</s:param>
			</s:service>
		<%
		//}
		%>		

	    var response = new AJAXPacket();
		var RETURN_CODES = "<%=RETURN_CODE%>";
		var RETURN_MSGS = "<%=RETURN_MSG%>";
		response.data.add("RETURN_CODE",RETURN_CODES);
		response.data.add("RETURN_MSG",RETURN_MSGS);
		core.ajax.receivePacket(response); 
<%
	}else{
%>
		var response = new AJAXPacket();
		response.data.add("RETURN_CODE","<%=rtnCode %>");
		response.data.add("RETURN_MSG","<%=rtnMsg %>");
		core.ajax.receivePacket(response); 
<%
	}
%>
