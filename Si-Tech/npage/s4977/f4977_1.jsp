   <%
	/**
	 * Title: 产品新装
	 * Description: 宽带产品新装
	 * Copyright: Copyright (c) 2009/01/10
	 * Company: SI-TECH
	 * author：
	 * version 1.0 
	 */
%>
<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
%>
<%@ page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/s1104/ignoreIn.jsp" %>
<%@ include file="/npage/common/qcommon/print_include1.jsp"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.regex.*"%>

<%!
		/**
     * 在日期上增加数个整月
     */
    public static Date addMonthPub(Date date, int n) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, n);
        return cal.getTime();
    }
    
    /**
     * 使用参数Format格式化Date成字符串
     */
    public static String formatPub(Date date, String pattern) {
        String returnValue = "";

        if (date != null) {
            SimpleDateFormat df = new SimpleDateFormat(pattern);
            returnValue = df.format(date);
        }

        return (returnValue);
    }

%>
<%
    Calendar today =   Calendar.getInstance();  
    today.add(Calendar.MONTH,3);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
    String addThreeMonth = sdf.format(today.getTime());
    
    /*获取当前时间*/
    Date nowTime = new Date();
    /*当前时间增加12个月*/
    Date addMonthT = addMonthPub(nowTime,12);
    /*增加12个月之后的今天*/
    String addMonthTStr = formatPub(addMonthT,"yyyyMMdd");
    
    
    System.out.println("### gaopengSeeLog4977====addMonthTStr== = "+addMonthTStr);
    System.out.println("### addThreeMonth = "+addThreeMonth);
    
    String workNo = (String)session.getAttribute("workNo");
    String nopass = (String) session.getAttribute("password");/*操作员密码*/
    String orgCode = (String)session.getAttribute("orgCode");
    String strDistrictCode =orgCode.substring(2,4);
    String objectId=(String)session.getAttribute("groupId");
    String regionCode = orgCode.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
    System.out.println("---------------------groupId------------------------"+groupId);
    String num = WtcUtil.repNull(request.getParameter("num"));	
    System.out.println("---------------------num----------------------------"+num);
    String servBusiId = WtcUtil.repNull(request.getParameter("servBusiId"));	
    String custOrderId = WtcUtil.repNull(request.getParameter("custOrderId"));     
    String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    
    String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));
    String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
    String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));
    String closeId = request.getParameter("closeId");
    String prtFlag = request.getParameter("prtFlag");
    
    String blindAddCombo = WtcUtil.repNull(request.getParameter("blindAddCombo"));
    
    String brandID = "";
    String brandName= "";
    String offerId = WtcUtil.repNull(request.getParameter("offerId"));
    System.out.println("---------!!!!!!-------gaopeng------!!!!-----------offerId------!!!!-"+offerId);
    String offerName	= WtcUtil.repNull(request.getParameter("offerName"));
		
		System.out.println("---------------orderArrayId---------------------"+orderArrayId);     
		System.out.println("--------diling-------gCustId---------------------"+gCustId);
		System.out.println("---------------servOrderId---------------------"+servOrderId);     
		System.out.println("---------------closeId---------------------"+closeId);
		System.out.println("---------------prtFlag---------------------"+prtFlag);     
		System.out.println("---------------offerId---------------------"+offerId);     
		System.out.println("---------------offerName-------------------"+offerName);  
		System.out.println("---------------servBusiId---------------------"+servBusiId);     
    System.out.println("---------------custOrderId---------------------"+custOrderId);   
		System.out.println("---------------regionCode---------------------"+regionCode);
		String expDateOffset = "";
		String expDateOffsetUnit = "";
		String offerComments = "";
		String groupTypeId = "";
    
		String svcInstId = WtcUtil.repNull(request.getParameter("offerSrvId"));/*销售品实例*/    
		String prefix = "";
		String domainName = ""; 
		String userRegionName="";
		String user_type="";
		String ipAddType="";
		String bandWidth="";
		/* 拼接报文用 */
		String bandWidthMsg = "";
		String offExpSet = "";
	  String offExpSetUnit = "";	
		String offExpDate ="";
		String work_flow_no = WtcUtil.repNull(request.getParameter("work_flow_no"));
		String transJf      = WtcUtil.repNull(request.getParameter("transJf"));
    String transXyd     = WtcUtil.repNull(request.getParameter("transXyd"));
    String level4100    = WtcUtil.repNull(request.getParameter("level4100"));
    
    if(work_flow_no==null) work_flow_no = "";
    if(transJf==null) transJf = "";
    if(transXyd==null) transXyd = "";
    if(level4100==null) level4100 = "";
    
    System.out.println("mylog1---------------work_flow_no--------------"+work_flow_no);     
    System.out.println("mylog1---------------transJf-------------------"+transJf);     
    System.out.println("mylog1---------------transXyd------------------"+transXyd); 
    System.out.println("mylog1---------------level4100-----------------"+level4100); 
    
    String[] inParamsss1 = new String[2];
    inParamsss1[0] = "select b.offer_id,b.offer_name,b.offer_attr_type,b.offer_comments from product_offer_attr a,product_offer b where a.offer_attr_seq ='5070' and a.offer_id = b.offer_id and a.offer_attr_value='0' and b.eff_date<sysdate and b.exp_date>sysdate and b.offer_attr_type ='YnKB' and b.offer_id=:bofferid";
    inParamsss1[1] = "bofferid="+offerId;
    String is0flag="";
    //2013/07/11 9:33:40 gaopeng 关于协助配置齐齐哈尔公司购终端打折购宽带营销方案的函 start 查询 sDisBandOfferDic 表中 offer_id的数据，如果存在数据，则校验营销案流水的服务为sBandSaleChk
    String[] inParamsss2 = new String[2];
    /*
    inParamsss2[0] = "select count(1) from product_offer_attr  where offer_id = :bofferid  and offer_attr_seq in ('80009','80010')";//增加宽带系统冲值属性80010 hejwa(shiyong) add 
    inParamsss2[1] = "bofferid="+offerId;
    */
    inParamsss2[0] = 
	   "select count(1) "
		+"  from product_offer_attr a, product_offer b "
		+" where 1 = 1 "
		+"   and a.offer_id = b.offer_id "
		+"   and a.offer_attr_seq in ('80009', '80010') "
		+"   and a.offer_id not in "
		+"       (select a.offer_id "
		+"          from product_offer_attr a, product_offer b "
		+"         where 1 = 1 "
		+"           and a.offer_id = b.offer_id "
		+"           and a.offer_attr_value = '0' "
		+"           and a.offer_attr_seq in ('5070')) "
		+"   and a.offer_id = :bofferid ";
    inParamsss2[1] = "bofferid="+offerId;
    String is68flag="";
    
    /*2014/12/23 13:51:48 gaopeng 宽带开户项目 增加新的资费类型 铁通宽带自然月资费，参与营销案的*/
    String[] inParamsss3 = new String[2];
    inParamsss3[0] = "SELECT COUNT(1) from product_offer WHERE band_id=71  AND exp_date_offset_unit=6 AND  offer_id = :bofferid"; 
    inParamsss3[1] = "bofferid="+offerId;
    String isSSflag="";
    
    
    
    String[] inParamsss4 = new String[2];
    inParamsss4[0] = "SELECT COUNT(1) from dorderarraymsg b WHERE b.cust_order_id=:custOrderId AND  b.serv_busi_id = 40014"; 
    inParamsss4[1] = "custOrderId="+custOrderId;
    String isSS2flag="";
    
    String[] inParamsss5 = new String[2];
    inParamsss5[0] = "SELECT count(1) FROM product_offer where band_id = 67 and offer_attr_type = 'YnKB' and offer_id = :bofferid"; 
    inParamsss5[1] = "bofferid="+offerId;
    String ifUseIntegFlag="";
    String notessss="工号"+workNo+"对custid="+gCustId+"进行查询";
    
    String[] inParamsss6 = new String[2];
    inParamsss6[0] = "SELECT count(1) FROM product_offer WHERE offer_id = :bofferid and offer_attr_type = 'YnKB'"; 
    inParamsss6[1] = "bofferid="+offerId;
    String isSS6flag="";
    

  System.out.println("0yuan======================"+inParamsss1[0]+"---iofferid----"+inParamsss1[1]);
  System.out.println("6折或8折资费==========gaopeng2013/07/11 9:37:20============"+inParamsss2[0]+"---iofferid----"+inParamsss2[1]+"---offer_attr_seq---");
  System.out.println("宽带开户项目 铁通宽带自然月资费==========gaopeng2014/12/23 13:52:29============"+inParamsss3[0]+"---iofferid----"+inParamsss3[1]+"---offer_attr_seq---");

  %>
  
  <wtc:service name="sCustIdIccIdChk" outnum="30"
			routerKey="region" routerValue="<%=regionCode%>" retcode="rcssss" retmsg="rmssss" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=workNo%>"/>
			<wtc:param value = "<%=nopass%>"/>			
			<wtc:param value = ""/>
			<wtc:param value = ""/>
			<wtc:param value = "<%=notessss%>"/>	
			<wtc:param value = "<%=gCustId%>"/>	
		</wtc:service>
		<wtc:array id="rstcheckssss" scope="end" />
		
			
<%

if ( rcssss.equals("000000") )
{

}
else
{
%>
	<script>
		rdShowMessageDialog( "校验出错！错误代码:<%=rcssss%>，错误信息:<%=rmssss%>");
		removeCurrentTab();
	</script>
<%
}%>
  
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
			routerKey="region"  routerValue="<%=regionCode%>" id="sLoginAccept1"/>
  
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5ss" retmsg="retCode5ss" outnum="1">			
		<wtc:param value="<%=inParamsss5[0]%>"/>
		<wtc:param value="<%=inParamsss5[1]%>"/>
	</wtc:service>
	<wtc:array id="result5y" scope="end" />
		
 <%
	 if(result5y.length>0) {
	 	if("1".equals(result5y[0][0])){
	 	
	 		ifUseIntegFlag="yes";
	 		
	 	}else{
	 		
	 	}
	 	
	 }else{
	 	
	 }
    
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="3">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>
	</wtc:service>
	<wtc:array id="result0y" scope="end" />
		
 <%
	 if(result0y.length>0) {
	 /*2016/4/12 15:16:01 gaopeng 0元的包年资费不进行营销案流水校验了 原来在这里是进行 is0flag="true";*/
	 	is0flag="false";
	 }
	 System.out.println("is0flag======="+is0flag);
        
    String ModeName=offerName;
    String offerType = "";
    
%>

  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="3">     
  <wtc:param value="<%=inParamsss2[0]%>"/>
  <wtc:param value="<%=inParamsss2[1]%>"/>
  </wtc:service>
  <wtc:array id="result68y" scope="end" />
  <%
   if(!"0".equals(result68y[0][0])) {
    is68flag="yes";
   }
   System.out.println("is68flag======="+is68flag);
    
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="3">     
  <wtc:param value="<%=inParamsss3[0]%>"/>
  <wtc:param value="<%=inParamsss3[1]%>"/>
  </wtc:service>
  <wtc:array id="resultSSy" scope="end" />
  <%
   if(!"0".equals(resultSSy[0][0])) {
    isSSflag="yes";
   }
   System.out.println("isSSflag======="+isSSflag);
    
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4ss" retmsg="retMsg4ss" outnum="3">     
  <wtc:param value="<%=inParamsss4[0]%>"/>
  <wtc:param value="<%=inParamsss4[1]%>"/>
  </wtc:service>
  <wtc:array id="resultSS2y" scope="end" />
  <%
  /*返回0的时候*/
   if("0".equals(resultSS2y[0][0])) {
    isSS2flag="yes";
   }
   System.out.println("isSS2flag======="+isSS2flag+"---inParamsss4[0]---+inParamsss4[1]"+inParamsss4[0]+"--"+inParamsss4[1]);
    
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6ss" retmsg="retMsg6ss" outnum="1">     
  <wtc:param value="<%=inParamsss6[0]%>"/>
  <wtc:param value="<%=inParamsss6[1]%>"/>
  </wtc:service>
  <wtc:array id="resultSS6y" scope="end" />
  <%
  /*返回0的时候*/
  if("000000".equals(retCode6ss)){
	  isSS6flag=resultSS6y[0][0];
  }
   System.out.println("liangyl------------------------isSS6flag======="+isSS6flag);
    
%>

<wtc:service name="sGetDetailCode" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=offerId%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=opCode%>" />	
</wtc:service>
<wtc:array id="result_t33" scope="end"   />


	
<!-- 2016/8/5 9:22:39 gaopeng 关于协助开发HGU型光猫宽带客户提供策略系统改造的函 
	是否是家庭悦享和宽带大于50M的用户的校验服务
-->
<%
	boolean ifHappyMoreThan50M = false;
%>
<wtc:service name="sFamilyHappyChk" outnum="1" retmsg="msgHappy" retcode="codeHappy" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="" />
		<wtc:param value="01" />
		<wtc:param value="<%=opCode%>" />	
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=nopass%>" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="<%=offerId%>" />
</wtc:service>
<wtc:array id="result_Happy" scope="end"   />
	
<%
	if("000000".equals(codeHappy)){
		String vHappyFlag = result_Happy[0][0];
		if("1".equals(vHappyFlag)){
			ifHappyMoreThan50M = true;
		}else{
			ifHappyMoreThan50M = false;
		}
	}

%>	


	
 
<%

	System.out.println("gaopengSeeLog20160909====ifHappyMoreThan50M==="+ifHappyMoreThan50M);
	String is58_88flag = "0";
	String is58_88sql_str = "SELECT count(*) FROM product_offer_restrication  WHERE RESTRICATION_DOMAIN_TYPE = '10R' and offer_id = :offerId";
	String is58_88sql_prm = "offerId="+offerId;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4ss" retmsg="retMsg4ss" outnum="3">     
	  <wtc:param value="<%=is58_88sql_str%>"/>
	  <wtc:param value="<%=is58_88sql_prm%>"/>
	  </wtc:service>
	<wtc:array id="result58_88" scope="end" />
<%

	if(result58_88.length>0){
		is58_88flag = result58_88[0][0];
	}
%>
 
 	
<!--查询ip地址类型，带宽，用户类型，宽带账号生成规则,地市名称，销售品名称，销售品失效偏移量，销售品失效偏移单位-->		
<wtc:service name="sQKdAttr" routerKey="region" routerValue="<%=regionCode%>" outnum="11">
	<wtc:param value="" />
	<wtc:param value="01" />
	<wtc:param value="<%=opCode%>" />	
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=nopass%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=offerId%>" />
	<wtc:param value="<%=regionCode%>" />
</wtc:service>
<wtc:array id="result33" scope="end"/>	
<%
	if(retCode.equals("000000")){
		ipAddType= result33[0][0];
		user_type= result33[0][1];
		bandWidth= result33[0][2];
		prefix= result33[0][3];
		domainName= result33[0][4];
		userRegionName= result33[0][5];
		offerName =result33[0][6];
		offExpSet =result33[0][7];
		offExpSetUnit = result33[0][8];
		bandWidthMsg = result33[0][9];
		offerType = result33[0][10];
	  offExpDate = getExpDate(offExpSet,offExpSetUnit);
	  System.out.println("---------ipAddType---------------"+ipAddType);
	 	System.out.println("---------user_type----------------"+user_type);
	 	System.out.println("---------bandWidth----------------"+bandWidth);
	 	System.out.println("---------prefix----------------"+prefix);
	 	System.out.println("---------domainName----------------"+domainName);
	 	System.out.println("---------userRegionName----------------"+userRegionName);
	 	System.out.println("---------offerName----------------"+offerName);
	 	System.out.println("---------offExpSet----------------"+offExpSet);
	 	System.out.println("---------offExpSetUnit----------------"+offExpSetUnit);
	 	System.out.println("---------offExpDate----------------"+offExpDate);
	}else{
%>
<script>
	    rdShowMessageDialog("<%=retMsg%>!");
   	  parent.removeTab('<%=opCode%>');
</script>
<%}
	String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	System.out.println("当前时间是  "+dateStr2);
	String currTime = new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new Date());
	//String sqlStr="";
%>
<!--查询销售品信息-->
<%String regionCode_sPMQPrdOffer = (String)session.getAttribute("regCode");%>
<wtc:utype name="sPMQPrdOffer" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sPMQPrdOffer%>">	
	<wtc:uparam value="<%=offerId%>" type="LONG"/>
</wtc:utype>	
<%
	String errCode = String.valueOf(retVal.getValue(0));
	String errMsg = retVal.getValue(1);
	if(errCode.equals("0") && retVal.getUtype("2").getSize()>0){
		brandID = retVal.getValue("2.0");										
		brandName= retVal.getValue("2.1");	
		expDateOffset =	retVal.getValue("2.2");			
		expDateOffsetUnit = retVal.getValue("2.3");	
		offerComments = retVal.getValue("2.4").replaceAll("\\n"," ");	
		groupTypeId =	retVal.getValue("2.5");					
	}
%>
<!--产品的群组信息-->
<%String regionCode_sQOrderGrp = (String)session.getAttribute("regCode");%>
<wtc:utype name="sQOrderGrp" id="retGrpVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sQOrderGrp%>">	
	<wtc:uparam value="<%=custOrderId%>" type="STRING"/>
	<wtc:uparam value="<%=orderArrayId%>" type="STRING"/>
</wtc:utype>	
<%
	String returnCode = String.valueOf(retGrpVal.getValue(0));
	String returnMsg = retGrpVal.getValue(1);
	String groupIdStr = "";
	String groupNameStr = "";
	String groupType = "";
	if(returnCode.equals("0") && retGrpVal.getUtype("2").getSize()>0){
		for(int i=0;i<retGrpVal.getUtype("2").getSize();i++){
			groupIdStr = groupIdStr + retGrpVal.getValue("2."+i+".1")+",";
			groupNameStr = groupNameStr + retGrpVal.getValue("2."+i+".3")+",";
			if(retGrpVal.getValue("2."+i+".2").equals("180")){
				groupType = retGrpVal.getValue("2."+i+".2");
			}	
		}
	}	
%>
<!--查询订单子项辅助信息-->
<%String regionCode_sGetOrdAryData = (String)session.getAttribute("regCode");%>
<wtc:utype name="sGetOrdAryData" id="retOrdAryVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sGetOrdAryData%>">	
	<wtc:uparam value="<%=orderArrayId%>" type="STRING"/>
</wtc:utype>	
<%
	 String strArray="var ordArray; ";
	 returnCode = String.valueOf(retOrdAryVal.getValue(0));
	 returnMsg = retGrpVal.getValue(1);
	 System.out.println(" ===== f4977 ===== " + orderArrayId + " , " + returnCode + " | " + retOrdAryVal.getUtype("2").getSize());
	 if(returnCode.equals("0") && retOrdAryVal.getUtype("2").getSize()>0){
	 	strArray = CreatePlanerArray.createArray("ordArray",retOrdAryVal.getUtype("2").getSize()); 
%>
			<SCRIPT language=JavaScript>
				<%=strArray%>	
			</script>	 
<%	 	
		for(int i=0;i<retOrdAryVal.getUtype("2").getSize();i++){
		 	for(int j=0;j<retOrdAryVal.getUtype("2."+i).getSize();j++){
%>
			<SCRIPT language=JavaScript>
				ordArray[<%=i%>][<%=j%>] = "<%=retOrdAryVal.getUtype("2."+i).getValue(j)%>";
			</script>	 
<%		 	
			}
		}	
	}
%>

<!-- 获得赠送卡数量-->
<%
	String strCardSum="0";
	String strSql = "select card_sum from sInnetCard where region_code='"+regionCode+"' and district_code = '"+strDistrictCode+"' and op_code='"+opCode+"' and card_type='00' and sysdate between begin_time and end_time";
	System.out.println("strSql======================"+strSql);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=strSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultCard" scope="end" />	
	<%
	System.out.println("resultCard="+resultCard);
	  if(!retCode2.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode2%><br>服务信息:<%=retMsg2%>");
   	  parent.removeTab('<%=opCode%>');
	</script>
<%	
	}	
  if (resultCard.length > 0){
		strCardSum = (resultCard[0][0]).trim();
		if(strCardSum.compareTo("") == 0){
			strCardSum = "0";
		}  
	}
%>
<!--获得流水号-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 	
<%
System.out.println("-----------------------sysAcceptl---------------------------"+sysAcceptl);
%>	
<!--获得smcode和客户地址，证件号码信息-->
<%
String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
String sm_Code = "";
String smCodeSql = "SELECT  Sm_Code FROM Band where  Band_Id = "+brandID;
//String custInfoSql = "SELECT cust_address, id_iccid  FROM dcustdoc where cust_id ="+gCustId;
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=smCodeSql%></wtc:sql>
 	  </wtc:pubselect>
<wtc:array id="result_t1" scope="end"/> 	
  	<!-- 2013/07/23 14:12:23 gaopeng 关于BOSS系统查询客户资料相关功能优化的需求  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="40" >
      <wtc:param value="<%=sysAcceptl%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=nopass%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="根据cust_id:[<%=gCustId%>]进行查询"/>
      <wtc:param value="<%=gCustId%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="resultGetCust" scope="end" >
	</wtc:array>
<%	 	
if(result_t1.length>0&&result_t1[0][0]!=null)  sm_Code = result_t1[0][0];
System.out.println("----diling----sm_Code="+sm_Code);
String custIccid = "";
String custAddr = "";
if(resultGetCust.length>0){
	custAddr = resultGetCust[0][11];
	custIccid = resultGetCust[0][13];
	System.out.println("gaopeng -- custAddr = "+custAddr+"--custIccid="+custIccid);
}


String beizhussss=workNo+"进行工号和品牌是否可用性校验，品牌"+sm_Code;
%>
		<wtc:service name="sJTBroadChk" outnum="1"
			routerKey="region" routerValue="<%=regionCode%>" retcode="rcssss111" retmsg="rmssss111" >
			<wtc:param value = ""/>
			<wtc:param value = "01"/>
			<wtc:param value = "<%=opCode%>"/>
			<wtc:param value = "<%=workNo%>"/>
			<wtc:param value = "<%=nopass%>"/>			
			<wtc:param value = ""/>
			<wtc:param value = ""/>
			<wtc:param value = "<%=beizhussss%>"/>	
			<wtc:param value = "<%=sm_Code%>"/>	
		</wtc:service>
		<wtc:array id="rstche11111" scope="end" />
			
<%

if ( rcssss111.equals("000000") )
{

}
else
{
%>
	<script>
		rdShowMessageDialog( "校验失败！错误代码:<%=rcssss111%>，错误信息:<%=rmssss111%>");
		removeCurrentTab();
	</script>
<%
}






	/****
		ningtn 2012-6-20 09:52:34
		ADSL宽带改造
		如果是ADSL宽带，账号生成号码长度改为12位
		ADSL不需要预占
		diling update @ 2012/9/17 9:55:33
		如果是ADSL宽带，账号生成号码长度改为18位
		可以输入@和数字
		界面提示语显示为 "<=18位"
	*/
	String maxLengthSM = "11";
	String isNeedHold = "1";
	String vTypeFlag="0_9";
	String maxLengthSM_str = maxLengthSM+"位数字";
	/* 
   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
   * 新增省广电kg，备用品牌kh
   * houxuefeng要求kf  kg只输入数字，kh保持不变。2014/11/4 13:36:10   增加ki品牌和kf一致--20160218
   */
  /*
   * update 统一规范账号命名规则 for 关于协助修改宽带账号编码规则和宽带投诉处理时限的函@2015/4/13 
	 *	移动宽带 的账号编码规则修改为yd+“11至12”位数字；--kf
	 *	移动宽带（合作）的账号编码规则修改为yd+“11至12”位数字 --kg
	 *	哈！宽带 的账号编码规则修改为ysbn+“11至12”位数字； --ke 
	 *	中国移动铁通宽带 的账号编码规则修改为ttkd+“11至12”位数字； --kd
	 *	铁通宽带的账号编码规则修改为kdz+“11至16”位数字； --kh
   */
	if("kf".equals(sm_Code) || "kg".equals(sm_Code) || "ki".equals(sm_Code)){
		maxLengthSM = "12"; 
		maxLengthSM_str = maxLengthSM+">=11位";
		isNeedHold = "1";
	}
	/*2014/11/21 10:32:26 gaopeng kh品牌改为铁通自建 与kd一样的玩法*/
	else if("kh".equals(sm_Code)){ //铁通宽带
		//maxLengthSM = "11"; 
		//maxLengthSM_str = maxLengthSM+"位数字";
		maxLengthSM = "16"; 
		maxLengthSM_str = maxLengthSM+">=11位";
		vTypeFlag = "0_9";
		isNeedHold = "0";
	}
	else if("ke".equals(sm_Code)){
		maxLengthSM = "12"; 
		maxLengthSM_str = maxLengthSM+">=11位";
  	isNeedHold = "0";
  }
  else if("kd".equals(sm_Code)){
		maxLengthSM = "12"; 
		maxLengthSM_str = maxLengthSM+">=11位";
  }
  
	
	
	String[] gundongyueStr = new String[2];
	gundongyueStr[0] = "SELECT count(1) FROM product_offer_attr WHERE offer_id =:offerId and offer_attr_seq = 70009";
	gundongyueStr[1] = "offerId="+offerId;
	
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">			
	<wtc:param value="<%=gundongyueStr[0]%>"/>
	<wtc:param value="<%=gundongyueStr[1]%>"/>
</wtc:service>
<wtc:array id="gundongyueResult" scope="end" />

	 	
<%!
		String getExpDate(String offExpSet,String offExpSetUnit){
		String retExpDate = "";
		java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		java.text.SimpleDateFormat formatter1=new java.text.SimpleDateFormat("yyyyMMdd");   
		java.util.Calendar lastDate = java.util.Calendar.getInstance();   
		int offExpSetv = Integer.parseInt(offExpSet);
		if(offExpSetUnit.equals("6")){ 
			     lastDate.set(java.util.Calendar.DATE,1); 
		       lastDate.add(java.util.Calendar.MONTH,offExpSetv);
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("1")){ 
		       lastDate.add(java.util.Calendar.DATE,(offExpSetv)); 
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("2")){ 
		       lastDate.add(java.util.Calendar.YEAR,offExpSetv); 
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("0")){ 
			     lastDate.add(java.util.Calendar.MONTH,(offExpSetv)); 
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("7")){ 
			     lastDate.set(java.util.Calendar.DATE,1); 
			     lastDate.set(java.util.Calendar.MONTH,0); 
			     lastDate.set(java.util.Calendar.YEAR,2000); 
			     lastDate.add(java.util.Calendar.MONTH,offExpSetv);
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("3")){ 
			     lastDate.add(java.util.Calendar.MONTH,(offExpSetv*6)); 
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("4")){ 
			     lastDate.add(java.util.Calendar.MONTH,(offExpSetv*3)); 
		       retExpDate=formatter.format(lastDate.getTime()); 
		}else if(offExpSetUnit.equals("5")){ 
			     lastDate.add(java.util.Calendar.DATE,(offExpSetv+1)); 
		       retExpDate=formatter1.format(lastDate.getTime())+"000000";   
		}else{
			retExpDate = "20501231235959";
		}
		return retExpDate;
	}
%>	 	
<HTML><HEAD><TITLE><%=brandID%>-<%=brandName%></TITLE>

<!--这段css样式是用来设置切换标签的样式,,,如果有更好的切换标签来替换,,,请删除这段样式,不影响页面其他内容-->
	<style type="text/css">
 .but_set {
	background: url(../images_sx/icon_but.png) no-repeat right -41px;
	margin: 0px 5px;
	padding: 0px;
	height: 16px;
	cursor: pointer;
	float:left;
}
.but_set span {
	padding: 0px 5px 0px 20px;
	margin: 0px;
	white-space: nowrap;
	height: 16px;
	float:left;
	line-height:normal;
	color: #ffaa55;
	background: url(../images_sx/icon_but.png) no-repeat left -1px;
}

.text_long {
  overflow: hidden;
	white-space: nowrap;
  display: block;
	width: 100px;
  -o-text-overflow: ellipsis;
  text-overflow: ellipsis;
}	 
.but_set_on {
	border: none;
	background: url(../images_sx/icon_but.png) no-repeat right -60px;
	margin: 0px 5px;
	padding: 0px;
	height: 16px;
	width: auto;
	cursor: pointer;
	float:left;
}
.but_set_on span {
	padding: 0px 5px 0px 20px;
	margin: 0px;
	white-space: nowrap;
	height: 16px;
	float:left;
	line-height:normal;
	color: #1367ba;
	background: url(../images_sx/icon_but.png) no-repeat left -20px;
}
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") n
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right
      margin:
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	</style>
	
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/autocomplete_ms.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<script type="text/javascript" src="/npage/public/checkGroup.js" ></script>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
<script language="javascript" type="text/javascript" src="/npage/public/replaceWholeSpecialChar.js" ></script>
<!-- 销售品明细项样式 -->
<SCRIPT language=JavaScript>
var masterServId = "";
var offerId = "<%=offerId%>";	//销售品ID
var offerNodes;
var nodesHash = new Object(); //根据ID取销售品 产品节点
var groupHash = new Object(); //销售品Id=群组信息用于群组信息查看回显
var offerGroupHash = new Object(); //销售品Id=群组信息提交报文
var AttributeHash = new Object(); //销售品/产品Id=属性信息
var prodCompIdArray = [];									//附加产品构成信息
var KDTypeId = "0";
var snShow="0";
//-----销售品,产品类型说明----
var prodType = "O";
var majorProdType = "M";
var offerType = "10C";

var isOfferLoaded = false;  //是否已经加载销售品构成明细
var hasProdCompInfo=false;//是否有附加产品标志
//-----销售品树选择方式---------
var selOfferType = "";
var ordArrayHash = new Object();
var v_printAccept = "<%=sLoginAccept1%>";
<% String pdPhone = "0"; 
Pattern p = Pattern.compile("^1[34578](\\d{9}|\\d{10})$");
Matcher m = p.matcher(activePhone);
boolean isPhone = m.matches();

%>
$(document).ready(function () {
	 $("#ifMBH").val(1);
	   	ifMBHShow();
	   	$("#yuankuandaiTd1").hide();
	   	$("#yuankuandaiTd2").hide();
	
		if("<%=gCustId%>" == "0"){
			rdShowMessageDialog("客户ID异常,请联系管理员!");
			window.close();	
		}	
		
		if("<%=opCode%>" == "4977" ){ //4977宽带开户时判断证件类型
		//判断当前客户证件类型是否为“单位客户”下的证件类型
		var isExitCustFlag = "N";
		var userIdType = "";
		var myPacket = new AJAXPacket("/npage/portal/shoppingCar/ajax_isExitForCust.jsp","正在查询信息，请稍候......");
	  myPacket.data.add("g_CustId","<%=gCustId%>"); 
	  myPacket.data.add("opCode","<%=opCode%>");
	  core.ajax.sendPacket(myPacket,function(packet){
	  	var retCode=packet.data.findValueByName("retCode");
		  var retMsg=packet.data.findValueByName("retMsg");
		  var v_isExitCustFlag=packet.data.findValueByName("isExitCustFlag"); //当前客户下，用户是否存在
		  var v_userIdType=packet.data.findValueByName("userIdType"); //当前客户下，用户是否存在
		  if(retCode == "000000"){
		  	isExitCustFlag = v_isExitCustFlag;
		  	userIdType = v_userIdType;
		  	//alert(userIdType);
		  	//userIdType = "8";
		  	iccidtypequery=v_userIdType;
		 	}else{
		 		rdShowMessageDialog("查询此客户是否存在用户信息失败！错误代码:<%=retCode%><br>错误信息:<%=retMsg%>！",0);
				return  false;
		 	}
	  });
	  myPacket = null;	
	  //当为单位客户，实际使用人相关信息必填。证件类型即：营业执照、组织机构代码、单位法人证书和介绍信
	  if(userIdType == "8" || userIdType == "A" || userIdType == "B" || userIdType == "C"){ 
			$("#userType1").val("单位");
			$("#realUserInfo1").show();
			$("#realUserInfo2").show();
			$("#realUserInfo1").find("td:eq(3)").attr("colSpan","3");
			$("#realUserInfo2").find("td:eq(3)").attr("colSpan","3");
			/*实际使用人姓名*/
	  	document.all.realUserName.v_must = "1";
	  	/*经实际使用人地址*/
	  	document.all.realUserAddr.v_must = "1";
	  	/*实际使用人证件号码*/
	  	document.all.realUserIccId.v_must = "1";	
		}else{
			$("#realUserInfo1").hide();
			$("#realUserInfo2").hide();
		}
	}else{
		$("#realUserInfo1").hide();
		$("#realUserInfo2").hide();
	}
	
		
		if(typeof(ordArray) != "undefined"){
			for(var i=0;i<ordArray.length;i++){
				ordArrayHash[ordArray[i][1]] = ordArray[i][3];
				//alert("ordArray[i][1]|"+ordArray[i][1]+"\n"+"ordArray[i][3]|"+ordArray[i][3]);
				if(ordArray[i][1] == "20004"){
				 	selOfferType = ordArray[i][3];
				 	$("#innetType").val(selOfferType);
				}	
			}
		}
		else{
			rdShowMessageDialog("取销售品选择方式异常!");
			//window.close();		
		}

		//把组合产品中建的群组带到单一产品新装中
		if("<%=groupIdStr%>" != ""){
			$("#addGroupInfo").css("display","");
			var addGroupIdArray = "<%=groupIdStr%>".split(",");
			var addGroupNameArray = "<%=groupNameStr%>".split(",");
			for(var i=0;i<addGroupIdArray.length;i++){
				if(addGroupIdArray[i] != ""){
					$("#addGroupTd").append("<span><input type='checkbox' id='"+addGroupIdArray[i]+"' checked disabled >"+addGroupNameArray[i]+"</span>");
				}
				if($("#addGroupTd span").length%6 == 0){
					$("#addGroupTd").append("<br>");
				}
			}
		}
		$("#orderInfoDiv").bind("click",getOrderInfo);
		
		if("<%=groupTypeId%>" != "0"){
			$("#td_offerName").append("<input name='"+"<%=offerName%>"+"' type='button' onclick=\"showGroup('<%=offerId%>','<%=offerName%>','<%=groupTypeId%>')\"  value='群组' id='group_"+"<%=offerId%>"+"' _groupId='"+"<%=groupTypeId%>"+"' class='b_text but_groups' />");
			//$("#td_offerName :button[id^='group']").bind('click',showGroup);
		}
		 
		if(typeof(offerId) != "undefined" && offerId != ""){
			$("#div_offerComponent").append("<div id='offer_"+offerId+"'></div>"); //生成销售品构成展示区域
			getMajorProd();
			getOfferAttr();
			getOfferDetail();
  	  getOfferRel();
		}

		getMidPrompt("10442","<%=offerId%>","td_offerName");
		buttonShow();
		$("select:visible").attr("style","width:130px");
		Pz.busi.operBusi($('#tab_addprod input'),'groupTitle',true,3);
		/*如果是哈！宽带（ke）不用资源预占，并且提示*/
		if("<%=sm_Code%>" == "ke"){
			$("#yz_resource").attr("disabled","disabled");
			$("#sf_resource").attr("disabled","disabled");
			$("#keShowSpan").show();
		}
		
		if("kf" == "<%=sm_Code%>"){
			kdzdchange();
		}
		if("kf" == "<%=sm_Code%>"||"ki" == "<%=sm_Code%>"){
			go_checkSNShow();
		}
		
		document.all.contactCustName.value = document.all.userName122.value;
		if("<%=activePhone%>"!="index"){
			document.all.contactPhone.value ="<%=activePhone%>";
		}
		if("1"==$("#isse276",window.parent.parent.document).val()){
			returnResBack($("#se276diZhi",window.parent.parent.document).val());
			$("#ifMBH").val(0);
			ifMBHShow();
			//yzResource();
			$("#isse276",window.parent.parent.document).val("0");
			
		}
		<%
		if(isPhone){
			%>
			checkCfmLogin();
			<%
		}
		%>
		checkOpenkdFlag();
});



function set4977pwd1(){
//	$("input[name='cfmPwd']").val(document.all.userpwd.value);
}

function set4977pwd2(){
//	$("input[name='cfmPwdConfirm']").val(document.all.userpwdcfm.value);
}

/*2016/2/25 10:53:04 gaopeng 


start
*/

//实际使用人证件类型改变
function valiRealUserIdTypes(idtypeVal){
	if(idtypeVal.indexOf("0") != -1||idtypeVal.indexOf("D") != -1){ //身份证
		document.all.realUserIccId.v_type = "idcard";
		$("#scan_idCard_two2").css("display","");
		$("#scan_idCard_two22").css("display","");
		$("input[name='realUserName']").attr("class","InputGrey");
		$("input[name='realUserName']").attr("readonly","readonly");
		$("input[name='realUserAddr']").attr("class","InputGrey");
		$("input[name='realUserAddr']").attr("readonly","readonly");
		$("input[name='realUserIccId']").attr("class","InputGrey");
		$("input[name='realUserIccId']").attr("readonly","readonly");
		$("input[name='realUserName']").val("");
		$("input[name='realUserAddr']").val("");
		$("input[name='realUserIccId']").val("");
	}else{
		document.all.realUserIccId.v_type = "string";
		$("#scan_idCard_two2").css("display","none");
		$("#scan_idCard_two22").css("display","none");
		$("input[name='realUserName']").removeAttr("class");
		$("input[name='realUserName']").removeAttr("readonly");
		$("input[name='realUserAddr']").removeAttr("class");
		$("input[name='realUserAddr']").removeAttr("readonly");
		$("input[name='realUserIccId']").removeAttr("class");
		$("input[name='realUserIccId']").removeAttr("readonly");
	}
}


/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserName.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "客户名称";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "联系人姓名";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人姓名*/
	if(objType == 2){
		objName = "经办人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "实际使用人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.realUserIdType.value;
	}
	
	idTypeVal = $.trim(idTypeVal);
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*有临时、代办字样的都不行*/
		if(objValue.indexOf("临时") != -1 || objValue.indexOf("代办") != -1){
					rdShowMessageDialog(objName+"不能带有‘临时’或‘代办’字样！");
					
					nextFlag = false;
					return false;
			
		}
		
		/*客户名称、联系人姓名均要求“大于等于2个中文汉字”，外国公民护照除外（外国公民护照客户名称必须大于3个字符，不全为阿拉伯数字)*/
		
		/*如果不是外国公民护照*/
		if(idTypeText != "6"){
			/*原有的业务逻辑校验 只允许是英文、汉字、俄文、法文、日文、韩文其中一种语言！*/
			
			/*2014/08/27 16:14:22 gaopeng 哈分公司申请优化开户名称限制的请示 要求单位客户时，客户名称可以填写英文大小写组合 目前先搞成跟 idTypeText == "3" || idTypeText == "9" 一样的逻辑 后续问问可不可以*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"必须大于等于2个汉字！");
					nextFlag = false;
					return false;
				}
				 var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog(objName+"只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog(objName+"只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*获取含有中文汉字的个数以及'()（）'的个数*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^·|\.|\．*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//分别获取输入内容
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*先校验括号*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*括号的数量+汉字的数量 != 总数量时 提示错误信息(这里需要注意一点，中文括号也是中文。。。所以这里只进行英文括号的匹配个数，否则会匹配多个)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"必须输入中文或中文与括号的组合(括号可以为中文或英文括号“()（）”)！");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"必须大于等于2个中文汉字！");
							
							nextFlag = false;
							return false;
						}
					}
					/*原有逻辑
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"最多输入6个汉字！");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*如果是外国公民护照 校验 外国公民护照客户名称(后续添加了联系人姓名也同理(sunaj已确定))必须大于3个字符，不全为阿拉伯数字*/
		if(idTypeText == "6"){
			/*如果校验客户名称*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"不能全为阿拉伯数字!");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"必须大于三个字符!");
						
						nextFlag = false;
						return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog(objName+"只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog(objName+"只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
		
		
		
	}	
	return nextFlag;
}


/*
	2013/11/18 11:15:44
	gaopeng
	客户地址、证件地址、联系人地址校验方法
	“客户地址”、“证件地址”和“联系人地址”均需“大于等于8个中文汉字”
	（外国公民护照和台湾通行证除外，外国公民护照要求大于2个汉字，台湾通行证要求大于3个汉字）
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
		if(document.all.realUserAddr.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "证件地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "客户地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "联系人地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "联系人通讯地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "经办人联系地址";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "实际使用人联系地址";
		idTypeVal = document.all.realUserIdType.value;
	}
		
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*获取含有中文汉字的个数*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*如果既不是外国公民护照 也不是台湾通行证 */
		if(idTypeText != "6" && idTypeText != "5"){
			/*含有至少8个中文汉字*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"必须含有至少8个中文汉字！");
				/*赋值为空*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*外国公民护照 大于2个汉字*/
	if(idTypeText == "6"){
		/*大于2个中文汉字*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"必须含有大于2个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*台湾通行证 大于3个汉字*/
	if(idTypeText == "5"){
		/*含有至少3个文汉字*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"必须含有大于3个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	证件类型变更时，证件号码的校验方法
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserIccId.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var idTypeVal = "";
	if(objType == 0){
		var objName = "证件号码";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "经办人证件号码";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "实际使用人证件号码";
		idTypeVal = document.all.realUserIdType.value;
	}
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal;
		
		/*1、身份证及户口薄时，证件号码长度为18位*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"必须是18位！");
					
					nextFlag = false;
					return false;
			}
		}
		/*军官证 警官证 外国公民护照时 证件号码大于等于6位字符*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"必须大于等于六位字符！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为港澳通行证的，证件号码为9位或11位，并且首位为英文字母“H”或“M”(只可以是大写)，其余位均为阿拉伯数字。*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须是9位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"首字母必须是‘H’或‘M’！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母之后的所有信息*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"除首字母之外，其余位必须是阿拉伯数字！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为
			台湾通行证 
			证件号码只能是8位或11位
			证件号码为11位时前10位为阿拉伯数字，
			最后一位为校验码(英文字母或阿拉伯数字）；
			证件号码为8位时，均为阿拉伯数字
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须为8位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*8位时，均为阿拉伯数字*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
			}
			/*11位时，最后一位可以是英文字母或阿拉伯数字，前10位必须是阿拉伯数字*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"前十位必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"第11位必须为阿拉伯数字或英文字母！");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*组织机构代 证件号码大于等于9位，为数字、“-”或大写拉丁字母*/
		if(idTypeText == "A"){
			var m = /^([0-9\-A-Z]*)$/;
			var flag = m.test(objValue);
			if(!flag){
					rdShowMessageDialog(objName+"必须由数字、‘-’、或大写字母组成！");
					
					nextFlag = false;
					return false;
			}
			if(objValueLength < 9){
					rdShowMessageDialog(objName+"必须大于等于9位！");
					
					nextFlag = false;
					return false;
				
			}
		}
		/*营业执照 证件号码号码大于等于4位数字，出现其他如汉字等字符也合规*/
		if(idTypeText == "8"){
			var m = /^[0-9]+$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum < 4){
					rdShowMessageDialog(objName+"包含至少4个数字！");
					
					nextFlag = false;
					return false;
			}
			/*20131216 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 界面中的证件类型为“营业执照”时，要求证件号码的位数为15位字符*/
			if(objValueLength != 15){
					rdShowMessageDialog(objName+"必须为15个字符！");
					nextFlag = false;
					return false;
			}
		}
		/*法人证书 证件号码大于等于4位字符*/
		if(idTypeText == "B"){
			if(objValueLength < 4){
					rdShowMessageDialog(objName+"必须大于等于4位！");
					
					nextFlag = false;
					return false;
			}
			
		}


	}else if(opCode == "1993"){

	}
	return nextFlag;
}


function forKuoHao(obj){ //允许输入括号·.． 这几种副号
	var m = /^(\(?\)?\（?\）?)\·|\.|\．+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forEnKuoHao(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forHanZi1(obj)
  {
  	var m = /^[\u0391-\uFFE5]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		//showTip(obj,"必须输入汉字！");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  	return true;
  }
  
  //匹配由26个英文字母组成的字符串
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"必须为字母！");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  
  	return true;
  }
  
  
  function checkNameStr(code){
			/* gaopeng 2014/01/17 9:50:35 优先匹配括号 因为括号可能是中文也可能是英文，优先返回KH 保证逻辑不失误*/
				if(forKuoHao(code)) return "KH";//括号
		    if(forA2sssz1(code)) return "EH"; //英语
		    var re2 =new RegExp("[\u0400-\u052f]");
		    if(re2.test(code)) return "RU"; //俄文
		    var re3 =new RegExp("[\u00C0-\u00FF]");
		    if(re3.test(code)) return "FH"; //法文
		    var re4 = new RegExp("[\u3040-\u30FF]");
		    var re5 = new RegExp("[\u31F0-\u31FF]");
		    if(re4.test(code)||re5.test(code)) return "JP"; //日文
		    var re6 = new RegExp("[\u1100-\u31FF]");
		    var re7 = new RegExp("[\u1100-\u31FF]");
		    var re8 = new RegExp("[\uAC00-\uD7AF]");
		    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //韩国
		    if(forHanZi1(code)) return "CH"; //汉字
    
   }
/*2016/2/25 10:53:04 gaopeng 

end

*/



/*获得主产品*/
function getMajorProd()
{
	 	var packet1 = new AJAXPacket("../s1104/getMajorProd.jsp","请稍后...");
		packet1.data.add("offerId" ,offerId);
		core.ajax.sendPacketHtml(packet1,doGetMajorProd);
		packet1 =null;
}
function doGetMajorProd(data)
{
	  $("#offer_component").html(data);
	  
		var majorProductId = "";
		if(typeof(majorProductArr) != "undefined" && majorProductArr.length > 0)
		{
		 	majorProductId = majorProductArr[1];
		 	$("input[name='majorProductId']").val(majorProductArr[1]);
		 	
		  getMasterServType(majorProductId);
		  getProdAttr(majorProductId);
		  getProdCompInfo(majorProductId);
		  getProdCompRel(majorProductId);	  
		}
		else
		{
			rdShowMessageDialog("该销售品没有主产品信息!");
			window.close();
			return false;	
		}
}
/*获得销售品属性*/
function getOfferAttr()
{
		var packet1 = new AJAXPacket("../s1104/getOfferAttr.jsp","请稍后...");
		packet1.data.add("OfferId" ,offerId);
		core.ajax.sendPacketHtml(packet1,doGetOfferAttr);
		packet1 =null;
}
function doGetOfferAttr(data)
{
	$("#OfferAttribute").html(data);
	$("#OfferAttribute :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
}
/*获得附加销售品构成明细*/
function  getOfferDetail()
{
 		var packet = new AJAXPacket("../s1104/offerDetailQry_new.jsp","正在加载附加销售品构成明细，请稍后...");
		packet.data.add("offerId","<%=offerId%>"); 		
		packet.data.add("opCode","<%=opCode%>"); 		
		core.ajax.sendPacketHtml(packet,doGetHtml,true);
		packet =null;
}
function doGetHtml(data)
{
	$("#offer_component").html(data);
	if(typeof(baseClass) != "undefined"){
		offerNodes = baseClass;
		showInfo(offerNodes);		//生成销售品构成展示
		
		for(var i=0;i<offerNodes.item.length;i++)
		  {
		  	if(offerNodes.item[i].getType() == "role"){
		  		offerRoleID+=offerNodes.item[i].getId()+"#";
				}
		  }	
		  
		trea("<%=blindAddCombo%>");
		initInfo(offerNodes);		//初始化构成,必选 可选 默认选中	
		$("#div_offerComponent :checkbox").bind("click",fn);
		$("#div_offerComponent :button[id^='att']").bind('click', showAttribute);
		$("#div_offerComponent select").bind('change',setEffectTime);
		
		setShowHid();
	}
}
/*调整附加销售品时间，现在该函数没有触发*/
function setEffectTime()
{
	var addOfferId = this.id.substring(8);
	var effTime = nodesHash[addOfferId].begTime.substring(0,8);
	var expTime = nodesHash[addOfferId].expireTime.substring(0,8);
	if(this.value == 1){ //下月生效
		var spanType = "MM";
		var spanVal = 1;
		
		var newEffTime = setDateMove(effTime,spanType,spanVal,'yyyyMM')+"01";	//调整后的生效时间
		var newExpTime = setDateMove(expTime,spanType,spanVal,'yyyyMM')+"01";	//调整后的失效时间
		
		$("#effTime_"+addOfferId).text(newEffTime);
		$("#expTime_"+addOfferId).text(newExpTime);
		$("#effTime_"+addOfferId).attr("name",newEffTime+"000000");
		$("#expTime_"+addOfferId).attr("name",newExpTime+"000000");
	}else{
		$("#effTime_"+addOfferId).text(effTime);
		$("#expTime_"+addOfferId).text(expTime); 
		$("#effTime_"+addOfferId).attr("name",nodesHash[addOfferId].begTime);
		$("#expTime_"+addOfferId).attr("name",nodesHash[addOfferId].expireTime);
	}
}
/*销售品构成依赖关系*/
function getOfferRel() 
{
	var packet2 = new AJAXPacket("../s1104/getOfferRel.jsp","正在加载附加销售品构成依赖关系,请稍后...");
	packet2.data.add("offerId" ,offerId);
	core.ajax.sendPacketHtml(packet2,doGetOfferRel,true);
	packet2 =null;
}
function doGetOfferRel(data)
{
	$("#offer_component").html(data);
	isOfferLoaded = true;
}
/*获得主体服务类型*/
function getMasterServType(majorProductId)
{
	var packet1 = new AJAXPacket("../s1104/getMasterServType.jsp","请稍后...");
	packet1.data.add("majorProductId",majorProductId);
	core.ajax.sendPacket(packet1,doGetMasterServType);
	packet1 =null;
}
function doGetMasterServType(packet)
{
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var mastServerType = packet.data.findValueByName("mastServerType").trim();
	masterServId = packet.data.findValueByName("masterServId").trim();
	var serviceType = packet.data.findValueByName("serviceType").trim();
	if(error_code == "0"){
		if(typeof(mastServerType) != "undefined" && mastServerType != ""){
			if(mastServerType == KDTypeId){		
				$("#billModeCd").html("<option value='A'>预付费</option>");
			}
			$("#mastServerType").val(mastServerType);
			$("#serviceType").val(serviceType);
		}
	}
	else{
		rdShowMessageDialog(error_msg);
	}		
}
/*获得主产品属性*/
function  getProdAttr(majorProductId)
{
	var packet2 = new AJAXPacket("../s1104/getProdAttr.jsp","请稍后...");
	packet2.data.add("majorProductId" ,majorProductId);
	core.ajax.sendPacketHtml(packet2,doGetpordAttribute);
	packet2 =null;
}
function doGetpordAttribute(data)
{
	$("#prodAttribute").html(data);
	
	$("#prodAttribute :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
}
/*获得附属产品信息*/
function getProdCompInfo(majorProductId)
{
	var packet3 = new AJAXPacket("../s1104/getProdCompDet.jsp","请稍后...");
		packet3.data.add("groupId" ,"<%=groupId%>");
		packet3.data.add("majorProductId" ,majorProductId);
		packet3.data.add("offerId" ,offerId);
		core.ajax.sendPacket(packet3,doGetProdCompInfo);
		packet3 =null;
}
function doGetProdCompInfo(packet)
{
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var prodCompInfo = packet.data.findValueByName("prodCompInfo");

	if(error_code == "0"){
		if(typeof(prodCompInfo) != "undefined"){
			hasProdCompInfo=true;
			$("#tab_addprod").css("display","");
			var nodeIdStr = "";
			var nodeNameStr = "";
			var etFlagStr = "";
			var compRoleCdHash = new Object();
			$("#tab_addprod tr").append("<td><div id='items'><div class='item-col2 col-1'><div id='compProdInfoDiv'></div></div><div class='item-row2 col-2'><div class='title'><div id='title_zi'>已定购产品信息</div></div><div id='pro_component'></div></div></div></td>");
			
			$("#pro_component").append("<div id='prod_"+offerId+"'></div>"); 
		  $("#prod_"+offerId).after("<div id='pro_"+offerId+"' ></div>");
		  $("#pro_"+offerId).append("<table id='tab_pro' cellspacing=0></table>");
		  $("#tab_pro").append("<tr><th>产品名称</th><th>开始时间</th><th>结束时间</th><th>操作</th></tr>");
			
			for(var i=0;i<prodCompInfo.length;i++){
				if(typeof(compRoleCdHash[prodCompInfo[i][3]]) == "undefined"){	//生成角色栏
					$("#compProdInfoDiv").append("<div  name='compProdrole' id='"+prodCompInfo[i][3]+"' style='cursor:hand'><div class='title'><div id='title_zi'>附加产品</div></div></div><table cellspacing='0'><tr><td><div id='div_"+prodCompInfo[i][3]+"' style='font-family:\"宋体\";'></div></td></tr></table>");
					compRoleCdHash[prodCompInfo[i][3]] = "1";
				}	
			}
			
			for(var i=0;i<prodCompInfo.length;i++){
			    var tempStr = "";
			    if(i != 0){
			        tempStr = "&nbsp;";
			    }
					prodCompIdArray[i] = prodCompInfo[i][11];
					var relationType = prodCompInfo[i][9];
					var checkStr = "";
					var spaceStr = "";
				
					if(relationType == "0"){
					 	checkStr = "checked disabled";
					 	etFlagStr = etFlagStr + "0" + "|";
					}
				  else if(relationType == "2"){
						 	checkStr = "checked";		
						 	etFlagStr = etFlagStr + "2" + "|";
				  }
					if(relationType == "0" || relationType == "2"){
					    nodeIdStr = nodeIdStr + prodCompInfo[i][11]+"|";
					    nodeNameStr = nodeNameStr + prodCompInfo[i][2]+"|";
					}
				
					var strLen = fucCheckLength(prodCompInfo[i][2]);
					if(prodCompInfo[i][13] == "1"){
					    if(strLen<10){
	    				    var len = 10 - strLen;
	    				    for(var li=0;li<len;li++){
	        				        spaceStr = spaceStr + "&nbsp;";
	    				    }
	    				}
					}else{
	    				if(strLen<16){
	    				    var len = 16 - strLen;
	    				    for(var li=0;li<len;li++){
	        				        spaceStr = spaceStr + "&nbsp;";
	    				    }
	    				}
	    		}
					$("#div_"+prodCompInfo[i][3]).append(tempStr+"<span id='compSpan_"+prodCompInfo[i][11]+"'><input type='checkbox' onclick='showDetailProd2(\""+prodCompInfo[i][11]+"\",\""+prodCompInfo[i][2]+"\",this,1)' name='checkbox_"+prodCompInfo[i][2]+"' id='"+prodCompInfo[i][11]+"' _mutexNum='0' "+checkStr+" groupTitle='"+prodCompInfo[i][14]+"'  minNum='" + prodCompInfo[i][15] + "' maxNum='" + prodCompInfo[i][16] + "'  />"+prodCompInfo[i][2]+"</span>"+spaceStr);
					if(prodCompInfo[i][13] == "1"){
						$("#compSpan_"+prodCompInfo[i][11]).append("<input type='button' name='prod_"+prodCompInfo[i][2]+"' value='属性' id='att_"+prodCompInfo[i][11]+"' class='b_text' />");
					}
					if($("#div_"+prodCompInfo[i][3]+" span").length%3 == 0){	//多个换行
						$("#div_"+prodCompInfo[i][3]).append("<br>");	
					}
			}
			var nodeIdArr = nodeIdStr.split("|");
			var nodeNameArr = nodeNameStr.split("|");
			var etFlagArr = etFlagStr.split("|");

			for(var i=0;i<nodeIdArr.length-1;i++){
				  //alert("nodeIdArr["+i+"]|="+nodeIdArr[i]+"#nodeNameArr["+i+"]|="+nodeNameArr[i]);
			    showDetailProd2(nodeIdArr[i],nodeNameArr[i],"undefined",etFlagArr[i]);
    		}
		}
	$("#tab_addprod :checkbox").bind("click",checkProdRel);	//校验复合产品间关系
	$("#tab_addprod :button").bind("click",showAttribute);	//设定复合产品属性
	
	$("#tab_addprod div[name='compProdrole']").toggle(
		  function () {
		    $("#div_"+this.id).css("display","none");
		  },
		  function () {
		    $("#div_"+this.id).css("display","");
		  }
		); 
	}		
}
/*获得附属产品关系*/
function getProdCompRel(majorProductId)
{
	var packet2 = new AJAXPacket("../s1104/getProdCompRel.jsp","正在加载附属产品的依赖关系,请稍后...");
		packet2.data.add("majorProductId" ,majorProductId);
		core.ajax.sendPacketHtml(packet2,doGetProdCompRel);
		packet2 =null;
}
function  doGetProdCompRel(data)
{
	 $("#majorProdRel").html(data);
	 for(var i=0;i<prodCompIdArray.length;i++){
			initProdRel(prodCompIdArray[i]);
	 }	
}

var offerRoleID = "";

function setShowHid(){    /*销售品加载完成后 设置显示和隐藏*/
  
		var roleIdArray = offerRoleID.split("#");
		var tempEqtd1V = "";

		for(var i=0;i<roleIdArray.length;i++){
			tempEqtd1V = "";
			$("#tab_"+roleIdArray[i]+" :checkbox").each(function(){	//计算是否有选择
				 if(this.checked){
				 		tempEqtd1V = "1";
				 	}
		  });
		  
		  //roles_
		  if(roleIdArray[i]!=""){
					if(tempEqtd1V=="1"){
						 $("#"+roleIdArray[i]).attr("disabled",true);
						 $("#"+roleIdArray[i]).attr("checked",true);
						}else{
						$("#div_"+roleIdArray[i]).css("display","none");
						document.getElementById("chkbox_"+roleIdArray[i]).checked=false;		
					  }
			}		
		}
	}
	
/*附属产品的限制*/
function chkLimit1(id,iOprType)
{
	var retList="";
	var phoneNo="<%=svcInstId%>";
	var opCode="<%=opCode%>";
	var sendUrl = "../s1104/limitChk1.jsp";
	var senddata={};
	senddata["opCode"] = opCode;
	senddata["prodId"] = id;
	senddata["iOprType"] = iOprType;
	senddata["vQtype"] = "0";
	senddata["idNo"] = "<%=svcInstId%>";
	
		$.ajax({
			url: sendUrl,
		  type: "POST",
		  data: senddata,
		  async: false,//同步
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}
				else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}
				else{
				  alert("系统错误!");  				
				}
		  },
		  success: function(data)
		  {		   
		          retList = data;
		  }
		});
		senddata = null;
		return  retList;
}


/* 销售品限制*/
function chkLimit(id,iOprType)
{
	var retList="";
	var phoneNo="<%=svcInstId%>";
	var opCode="<%=opCode%>";
	var sendUrl = "../s1104/limitChk.jsp";
	var senddata={};
	senddata["opCode"] = opCode;
	senddata["prodId"] = id;
	senddata["iOprType"] = iOprType;
	senddata["vQtype"] = "0";
	senddata["idNo"] = "<%=svcInstId%>";
		$.ajax({
			url: sendUrl,
		  type: "POST",
		  data: senddata,
		  async: false,//同步
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}
				else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}
				else{
				  alert("系统错误!");  			
				}
		  },
		  success: function(data)
		  {		   
		          retList = data;
		  }
		});
		senddata = null;
		return  retList;
}

/*附加销售品的选择*/
function fn(){
  
	var retArr=chkLimit(this.id,"1").split("@");
	retCo=retArr[0].trim();
	retMg=retArr[1];
	if(retCo!="0" )
	{
		if(retCo=="110001"){
			 	if(rdShowConfirmDialog(retMg)!=1) 
			 			{
			     	 $("#"+this.id).attr('checked','check');
			     	 return false;
			 			}
		}else{
			  		rdShowMessageDialog(retMg);
			     	 $("#"+this.id).attr('checked','check');
			     	 return false;
		}
	}
	
	try{
		var v_Id = "div_"+this.id;
		
		checkRel(this);
		
		if(this.checked == true){
			$("#"+v_Id).css("display","");
			$("#expOffset_"+this.id).attr("disabled",false);	//将失效时间偏移量输入框置为可用
			$("#sel_"+this.id).attr("disabled",false);
			initInfo(nodesHash[this.id]);
		}
		else{
			$("#"+v_Id).css("display","none");	
			$("#expOffset_"+this.id).attr("disabled",true);	//将失效时间偏移量输入框置为不可用
			$("#sel_"+this.id).attr("disabled",true);
			nodesHash[this.id].cancelChecked(nodesHash[this.id]);
			$("#orderTr_"+nodesHash[this.id].getId()).remove();
		}
		
		checkOrderTab();
  }
	catch(E){
	 	  rdShowMessageDialog("正在加载销售品构成,请稍候....");
	 	  $("#pro_detail_"+this.id).remove();
	 	  return false;
	}

	if(this.h_groupId!=0&&this.checked == true&&typeof(this.h_groupId)!="undefined"){
			showGroup(this.id,this.h_offerName,this.h_groupId);
		}
}

function checkOrderTab(){
	var hasTrHash = new Object();
	$("#orderInfo tr:gt(0)").each(function(){
		var v_id = this.id.substring(8);
		hasTrHash[v_id] = 1;
		if($("#"+v_id).attr("checked") != true){
			$(this).remove();	
		}
	});	
	
	$("#div_offerComponent :checked").each(function(){
		if(nodesHash[this.id].getType() == offerType && typeof(hasTrHash[this.id]) =="undefined" ){
			var node = nodesHash[this.id];
			$("#tab_order").append("<tr id='orderTr_"+node.getId()+"'><td>"+node.getId()+"</td><td>"+node.getName()+"</td><td>"+node.begTime.substring(0,8)+"</td><td>"+node.expireTime.substring(0,8)+"</td><td>"+node.description+"</td></tr>");
		}			
	});	
}

function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n,t){
	
	if(n==1){
		document.all.changeSel.checked=true;
		document.all.changeSelh.checked=false;
		document.all.cfmOffer.style.display="none";
	}else{
			document.all.changeSel.checked=false;
		  document.all.changeSelh.checked=true;
			document.all.cfmOffer.style.display="";
	}
	for(var i=1;i<=t;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
		g('tbc_0'+i).style.display="none"
		
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='current';
	g('tbc_0'+n).style.display="block"
	
}	
//已订购附属产品的显示
function showDetailProd2(nodeId,nodeName,obj,etFlag){
		/*新增加的校验*/
	if(!clickListener($("#"+ nodeId +""),'groupTitle',true)){
		$("#"+ nodeId +"").attr("checked","");
		return false;
	}
	if(obj != undefined){
	    if(obj.checked == false){
	        $("#pro_detail_"+nodeId).remove();
	        return;
	    }
	}
  
  var packet = new AJAXPacket("../s1104/complexPro_ajax.jsp","请稍后...");//组合产品子产品展示
	packet.data.add("nodeId" ,nodeId);
	packet.data.add("nodeName" ,nodeName);
	packet.data.add("etFlag",etFlag);
	core.ajax.sendPacketHtml(packet,doGetHtml2);
	packet =null;
	
}
function doGetHtml2(data){
    eval(data);
}

function fucCheckLength(strTemp)  
{  
	var i,sum;  
	sum=0;  
	for(i=0;i<strTemp.length;i++)  
	{  
	 if ((strTemp.charCodeAt(i)>=0) && (strTemp.charCodeAt(i)<=255))  
	  sum=sum+1;  
	 else  
	  sum=sum+2;  
  }  
	return sum;  
} 
/*校验复合产品间关系*/
function checkProdRel(){
	checkProdCompRel(this);
	 var retArr=chkLimit1(this.id,"1").split("@");
     retCo=retArr[0].trim();
     retMg=retArr[1];
     if(retCo!="0")
     {
     	   rdShowMessageDialog(retMg);
     	   $("#"+this.id).attr('checked','check');
     	   $("#pro_detail_"+this.id).remove();
     	   return false;
     }
}
/*附加销售品的选择确认*/
function cfmOfferf(){
		if(g('tbc_01').style.display=="none") HoverLi(1,2); 
	}


function getByteLen(str){ 
    var byteLen=0, len=str.length; 
    
    if(str){
        for(var i=0; i<len; i++){ 
            if(str.charCodeAt(i) > 255){ 
                byteLen += 2; 
            }else{ 
                byteLen++; 
            } 
        }
        return byteLen; 
    } else{ 
        return 0; 
    }
}

/*2015/04/15 10:40:56 gaopeng 关于在CRM增加手机积分兑换宽带产品功能的需求 是否使用积分的显隐方法*/
function ifUseIntegralBtn(){
	var ifUseIntegral = $("#ifUseIntegral").attr("checked");
	if(ifUseIntegral == true){
		$("#IntegralFiled").show();
		
	}else{
		$("#IntegralFiled").hide();
	}
}

/*2015/04/15 10:40:56 gaopeng 关于在CRM增加手机积分兑换宽带产品功能的需求 获取当前可用积分的方法*/
function getIntegral(){
	
	var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
	
	if(ifUseIntegral){
	
		var iPhoneNo = $.trim($("#intePhoneNo").val());
		var iUserPwd = $.trim($("#intePassWord").val());
		
		if(iPhoneNo.length == 0){
			rdShowMessageDialog("请输入手机号码！",1);
			return false;
		}
		if(iUserPwd.length == 0){
			rdShowMessageDialog("请输入服务密码！",1);
			return false;
		}
		
		var getdataPacket = new AJAXPacket("/npage/public/fGetIntegral.jsp","正在获得数据，请稍候......");
		var iLoginAccept = sLoginAccept;
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=workNo%>";
		var iLoginPwd = "<%=nopass%>";
		
		
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd",iUserPwd);
		
		core.ajax.sendPacket(getdataPacket,doRetInte);
		getdataPacket = null;
	}
	
}
function doRetInte(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var inteCustName = packet.data.findValueByName("custName");
		var inteNumber = packet.data.findValueByName("integralNum");
		var maxIntegralNum = packet.data.findValueByName("maxIntegralNum");
		
		if(retCode == "000000"){
			rdShowMessageDialog("校验成功！",2);
			$("#intePhoneNo").attr("class","InputGrey");
			$("#intePhoneNo").attr("readonly","readonly");
			$("#intePassWord").attr("class","InputGrey");
			$("#intePassWord").attr("readonly","readonly");
			
			$("#inteCustName").val(inteCustName);
			$("#inteCustName").attr("class","InputGrey");
			$("#inteCustName").attr("readonly","readonly");
			$("#inteNumber").val(inteNumber);
			$("#inteNumber").attr("class","InputGrey");
			$("#inteNumber").attr("readonly","readonly");
			$("#maxIntegralNum").val(maxIntegralNum);
			
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			
		}
}

var globalMarkFlag = false;
function markIntegral(){
	
		var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
		
		/*2015/04/22 10:42:04 gaopeng 选中则赋值 否则为空*/
		var iPhoneNo = ifUseIntegral == true ? $.trim($("#intePhoneNo").val()):"";
		var iUserPwd = ifUseIntegral == true ? $.trim($("#intePassWord").val()):"";
		var inteUseNum = ifUseIntegral == true ? $.trim($("#inteUseNum").val()):"";
		var iKdNo = $.trim(document.all.phoneNo_h.value);
		var getdataPacket = new AJAXPacket("/npage/public/fMarkIntegral.jsp","正在获得数据，请稍候......");
		var iLoginAccept = $("#sysAcceptl").val();
		
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=workNo%>";
		var iLoginPwd = "<%=nopass%>";
		var ifUseI = ifUseIntegral == true ? "1":"0";
		
		
		
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd","");
		getdataPacket.data.add("iKDNo",iKdNo);
		getdataPacket.data.add("inteUseNum",inteUseNum);
		getdataPacket.data.add("ifUseI",ifUseI);
		
		core.ajax.sendPacket(getdataPacket,doRetInteMark);
		getdataPacket = null;
	
	
}
function doRetInteMark(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		
		
		if(retCode == "000000"){
			
			globalMarkFlag = true;
			
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			globalMarkFlag = false;
		}
}

var globalIngegralFlag = false;
/*公共方法 校验输入的积分值 必须是100的倍数 100积分抵扣1块钱*/
function checkIngegralNum(){
	var integralNumObj = $("#inteUseNum")[0];
	if(!checkElement(integralNumObj)){
		return false;
	}
	var integralNum = $.trim(integralNumObj.value);
	if(integralNum.length == 0){
		rdShowMessageDialog("请输入的积分值！",1);
		integralNumObj.value = "";
		
		return false;
	}
	if((Number(integralNum) % 100) != 0){
		rdShowMessageDialog("输入的积分值必须是100的倍数！",1);
		integralNumObj.value = "";
		
		return false;
	}
	/*抵扣的金额*/
	var integralMoney = Number(Number(integralNum) / 100);
	var maxIntegralNum = Number($.trim($("#maxIntegralNum").val()));
	if(integralMoney > maxIntegralNum){
		rdShowMessageDialog("抵扣金额不能超过最大金额！",1);
		integralNumObj.value = "";
		
		return false;
	}
	$("#intePrice").val(integralMoney);
	$("#intePrice").attr("class","InputGrey");
	$("#intePrice").attr("readonly","readonly");
	globalIngegralFlag = true;
	
}

function ifMBHShow(){
	var ifMBH = $("select[name='ifMBH']").find("option:selected").val();
	if(ifMBH == "1"){
		$("#ifMBH_show").hide();
		//yxdsShow();
		$("#jdhId").val("003903FF002100700000000000000000");
	}else{
		$("#ifMBH_show").hide();
		$("#jdhId").val("003903FF002100700000000000000000");
	}
}
function yxdsShow(){
	var yxds = $("select[name='yxds']").find("option:selected").val();
	if(yxds == "未来电视"){
		$("#jdhId").val("003903FF002100700000000000000000");
	}else if(yxds == "百事通"){
		$("#jdhId").val("003903FF002100700000000000000000");
	}
}
    
//确定
function mySub()
{
		            
		/*实际使用人姓名*/
	if(!checkElement(document.all.realUserName)){
		return false;
	}
	/*实际使用人联系地址*/
	if(!checkElement(document.all.realUserAddr)){
		return false;
	}
	/*实际使用人证件号码*/
	if(!checkElement(document.all.realUserIccId)){
		return false;
	}
	

	if(!checkCustNameFunc16New(document.all.realUserName,3,1)){
		return false;
	}

	if(!checkAddrFunc(document.all.realUserAddr,5,1)){
				return false;
		}

	if(!checkIccIdFunc16New(document.all.realUserIccId,3,1)){
						return false;
	}
		
		<%if(is0flag.equals("yes")) {%>	
			/*添加营销案*/
				if(viewModel.useMarket()){
					if(!viewModel.marketCheck()){
						rdShowMessageDialog("请先校验营销案流水",0);
						return false;    
					}
				}
		<%}%>
		
		<%if(!is58_88flag.equals("0")) {%>	
				if(viewModel.useMarket()){
		      if(!viewModel.marketCheck()){
		        rdShowMessageDialog("请先校验营销案流水",0);
		        return false;
		      }
		    } 
		<%}%>
		
		
		<%if(is68flag.equals("yes")) {%>  
		  /*添加营销案*/
		    if(viewModel.useMarket()){
		      if(!viewModel.marketCheck()){
		        rdShowMessageDialog("请先校验营销案流水",0);
		        return false;
		      }
		    }
		<%}%>
		
		<%if(isSSflag.equals("yes") && isSS2flag.equals("yes")) {%>  
		  /*添加营销案*/
		    if(viewModel.useMarket()){
		      if(!viewModel.marketCheck()){
		        rdShowMessageDialog("请先校验营销案流水",0);
		        return false;
		      }
		    }
		<%}%>
		if("kf" == "<%=sm_Code%>"){
			/*原宽带账号校验*/
			if(!checkElement($("#yuankuandaiNum")[0])){
				return false;
			}
			if($("#anzhuangFangshi").val()==""){
				 rdShowMessageDialog("请选择安装方式！",0);
			     return false;
			}
		}
		
    getAfterPrompt(); 
    
    /* zhouby add 增加客户名称长度的校验*/
    var zCustName = document.all.userName11.value;
    if(getByteLen(zCustName) > 40 && "<%=sm_Code%>" != "ki"){
        rdShowMessageDialog("用户名请不要超过20个汉字或40个字符！",0);
        return false;
    }
    
    if(!checksubmit(prodCfm))
    { 
      return false ;  
    }     
    if(!isOfferLoaded)
    {
      rdShowMessageDialog("正在加载销售品构成!");
      HoverLi(2,2);
      return false;  
    } 
    if($("#serviceType").val() == ""){
      rdShowMessageDialog("取服务类型出错!");
      return false;  
    }
    if( ($("#noPort").val() != "1") && 
        (document.all.isYzResource.value!="1") && 
        (document.all.isDoNoResource.value !="1")
        &&($("#isNeedHold").val() == "1")){
      rdShowMessageDialog("没有预占资源或不允许不预占资源办理!");
      return false;  
    }
    if(document.all.cfmLoginCheck.value!="1" ){
      rdShowMessageDialog("校验宽带登录账号失败!");
      return false;  
    }
    if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
        rdShowMessageDialog("联系号码不可以为空，请输入");
        document.all.contactPhone.focus();
        return false;
     }
     if(document.all.enter_addr.value==null || document.all.enter_addr.value==""){
      rdShowMessageDialog("安装地址不可以为空，请输入");
      document.all.enter_addr.focus();
      return false;
     }
     var zhengze = /[\~\`\^\,\=]+/g;
     if(zhengze.test(document.all.enter_addr.value)){
         rdShowMessageDialog("安装地址不可以包括 ~`^,=等特殊字符请修改!");
         document.all.enter_addr.focus();
         return false;
        }
     
      if(checkPwd2(document.all.cfmPwd,document.all.cfmPwdConfirm)==false)  return false;
      if(checkPwd1(document.all.userpwd,document.all.userpwdcfm)==false)  return false;   
    
     if(!forDate(document.all.appointvTime)){
        rdShowMessageDialog("预约上门时间格式不正确！");
        document.all.appointvTime.focus();
        return false;
     }
     if(forDate(document.all.appointvTime)){
        if($(document.getElementById("appointvTime")).val() < "<%=dateStr2%>")
        {
          rdShowMessageDialog("预约上门时间不能小于当前时间！");
          return false;
        }
        /*预约时间*/
        var appointvTime = Number($.trim($(document.getElementById("appointvTime")).val()));
        var addMonthTStr = Number("<%=addMonthTStr%>");
        if(appointvTime > addMonthTStr){
        	rdShowMessageDialog("预约上门时间不能超过当前时间+12个月！");
          return false;
        }
     }
     if("ki" == "<%=sm_Code%>"){
				document.all.kdZdFee.v_must = "1";
				if(!checkElement(document.all.kdZdFee)){
					//rdShowMessageDialog("请输入宽带终端费用！");
					return false;
				}
			}
     if("kf" == "<%=sm_Code%>"){
				document.all.kdZdFee.v_must = "1";
				if(!checkElement(document.all.kdZdFee)){
					//rdShowMessageDialog("请输入宽带终端费用！");
					return false;
				}
				var ifMBH = $("select[name='ifMBH']").find("option:selected").val();
				if(ifMBH == "1"){
					document.all.jdhId.v_must = "1";
					if(!checkElement(document.all.jdhId)){
						rdShowMessageDialog("请输入机顶盒ID！");
						return false;
					}
					if($.trim(document.all.jdhId.value).length != 32){
						rdShowMessageDialog("机顶盒ID必须为32位！");
						return false;
					}
					
				}
			}		 
     
      if(!checkForm()){
        return false;
      }
     //alert(1292);
     /*ke输入集团编号校验一下格式*/
     if($("#newSmCode").val() == "ke"){
      if(!checkElement(document.prodCfm.unitId)){
        return false;
      }
      var unitId = $("#unitId").val();
      //alert(unitId);
      if(unitId != ""){
        var getUnitId_Packet = new AJAXPacket("/npage/s4977/fCheckUnitId.jsp","正在校验请稍候......");
        getUnitId_Packet.data.add("unitId",unitId);
        core.ajax.sendPacket(getUnitId_Packet,doQryUnitIdBack);
        getUnitId_Packet = null;
        
        if($("#unitIdFlag").val() != "1"){
          return false;
        }
      }
     }
    var pordIdArr = new Array();
    var prodEffectDate = []; 
    var prodExpireDate = [];  
    var isMainProduct = []; 
    
    var offerIdArr = new Array();
    var offerNameArr = new Array();
    var offerEffectTime = new Array();
    var offerExpireTime = new Array();
    
    var sonParentArr = []; //存放销售品,产品间子~父关系
    var groupInstBaseInfo = "";       //群组信息
    var offer_productAttrInfo = ""; //销售品,产品属性串
 //   if(printSN){
  //  	go_checkSnUse();
  //  }
  //  if(checksnUse){
 //   	return false;
  //  }
    //压入主产品
    if(typeof(majorProductArr) != "undefined" && majorProductArr.length > 0){
      $("input[name='majorProductId']").val(majorProductArr[1]);
      sonParentArr.push($("input[name='majorProductId']").val()+"~"+offerId);
      pordIdArr.push($("input[name='majorProductId']").val());
      prodEffectDate.push("<%=currTime%>");
      prodExpireDate.push("20501231235959");
      isMainProduct.push(1);
    }
    else{
      rdShowMessageDialog("无主产品!"); 
      return false;
    }
    
    var addGroupIdArr= [];
    //组合产品过来时,可选群组信息
    $("#addGroupInfo :checked").each(function(){
      addGroupIdArr.push(this.id);
    });
    //备注信息
    if($("input[name='op_note']").val() == ""){
      $("input[name='op_note']").val("操作员"+"<%=workNo%>"+"对客户"+"<%=gCustId%>"+"进行宽带开户!"); 
    }
    //压入基本销售品
    sonParentArr.push(offerId+"~"+"0");
    offerIdArr.push(offerId);
    offerEffectTime.push("<%=currTime%>");  //生失效时间还没确定
    offerExpireTime.push("<%=offExpDate%>");
    //var mastServerType = $("#mastServerType").val();
    
    if(typeof(offerGroupHash[offerId]) != "undefined"){
        groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[offerId]+"^";
    } 
    
        //---------生成基本销售品属性信息----------
    var offerAttrStr = "";      //销售品属性串
    $("#OfferAttribute :input").not(":button,[type='hidden']").each(function(){
        offerAttrStr+=this.name.substring(2);
        offerAttrStr+="~";
        offerAttrStr+=$(this).val()+" $";
    });
    if(offerAttrStr != ""){
      offer_productAttrInfo += offerId+"|"+offerAttrStr+"^";
    }
    
    //$("input[name='offerAttrStr']").val(offerAttrStr);
    //---------生成主产品属性信息----------
    var productAttrStr = "";      //产品属性串
    
    $("#prodAttribute :input").not(":button,[type='hidden']").each(function(){
        productAttrStr+=this.name.substring(2);
        productAttrStr+="~";
        productAttrStr+=$(this).val()+" $";
    });
    
    if(productAttrStr != ""){
      offer_productAttrInfo += majorProductArr[1]+"|"+productAttrStr+"^";
    }
    //$("input[name='productAttrStr']").val(productAttrStr);
    
      var vFlag = true;
    //压入附加产品
    $("#tab_addprod :checked").each(function(){
        sonParentArr.push(this.id+"~"+offerId);
        pordIdArr.push(this.id);
      
        //if(document.getElementById("startDate_"+this.id)!=null&document.getElementById("stopDate_"+this.id)!=null){
        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-1){
                  rdShowMessageDialog("开始时间格式不正确,请重新输入!",0);
                  (document.getElementById("startDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-2){
                  rdShowMessageDialog("结束时间格式不正确,请重新输入!",0);
                  (document.getElementById("stopDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
              
        if($(document.getElementById("startDate_"+this.id)).val() < "<%=dateStr2%>"){
                  rdShowMessageDialog("开始时间应不小于当前时间,请重新输入!",0);
                  (document.getElementById("startDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
        if($(document.getElementById("stopDate_"+this.id)).val() <= "<%=dateStr2%>"){
                  rdShowMessageDialog("结束时间应大于当前时间,请重新输入!",0);
                  (document.getElementById("stopDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
              
        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==1 || $(document.getElementById("startDate_"+this.id)).val()==$(document.getElementById("stopDate_"+this.id)).val()){
                  rdShowMessageDialog("开始时间应小于结束时间,请重新输入!",0);
                  (document.getElementById("stopDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
              
        if($(document.getElementById("startDate_"+this.id)).val() > "<%=addThreeMonth%>"){
                  rdShowMessageDialog("开始时间必须是三个月内,请重新输入!",0);
                  (document.getElementById("startDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
        
        var effDate = "";
        var expDate = "";
        if($(document.getElementById("startDate_"+this.id)).val() == "<%=dateStr2%>"){
            effDate = "<%=currTime%>";
        }else{
            effDate = $(document.getElementById("startDate_"+this.id)).val() + "000000";
        }
        
        expDate = $(document.getElementById("stopDate_"+this.id)).val() + "235959";
        prodEffectDate.push(effDate);
        prodExpireDate.push(expDate);
                    
        isMainProduct.push(0);
      
        if(typeof(AttributeHash[this.id]) != "undefined"){    //装入附加产品的属性信息
          offer_productAttrInfo += AttributeHash[this.id];
        } 
    }); 
      
    if(!vFlag){
       return false;
    }
        
    $("#div_offerComponent :checked").each(function(){
      /*附加销售品中界面查询中没有查询产品
      if(this.name.substring(0,4)=="prod" && $("#"+nodesHash[this.id].parentOffer).attr("checked") == true && $("#effType_"+nodesHash[this.id].parentOffer).val() == "0"){  //只送立即生效的
        sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
        pordIdArr.push(this.id);
        prodEffectDate.push($("#effTime_"+nodesHash[this.id].parentOffer).attr("name"));
        prodExpireDate.push($("#expTime_"+nodesHash[this.id].parentOffer).attr("name"));
        isMainProduct.push(0);
        
        if(typeof(AttributeHash[this.id]) != "undefined"){    //装入产品，销售品的属性信息
          offer_productAttrInfo += AttributeHash[this.id];
        } 
        
        sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
        offerIdArr.push(this.id);
        offerEffectTime.push($("#effTime_"+this.id).attr("name"));
        
        offerExpireTime.push($("#expTime_"+this.id).attr("name"));
        
        if(typeof(offerGroupHash[this.id]) != "undefined"){ //装入销售品的群组信息
          groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[this.id]+"^";
        }
      }*/
      if(this.name.substring(0,4)=="offe"){     
        sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
        offerIdArr.push(this.id);
        offerEffectTime.push($("#effTime_"+this.id).attr("name"));
        
        offerExpireTime.push($("#expTime_"+this.id).attr("name"));
        
        if(typeof(AttributeHash[this.id]) != "undefined"){  //装入产品，销售品的属性信息
          offer_productAttrInfo += AttributeHash[this.id];
        } 
        
        if(typeof(offerGroupHash[this.id]) != "undefined"){ //装入销售品的群组信息
          groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[this.id]+"^";
        }
      }
    });
    $("input[name='offer_productAttrInfo']").val(offer_productAttrInfo);
    $("input[name='sonParentArr']").val(sonParentArr);
    $("input[name='addGroupIdArr']").val(addGroupIdArr);  
    
    $("input[name='productIdArr']").val(pordIdArr);
    $("input[name='prodEffectDate']").val(prodEffectDate);
    $("input[name='prodExpireDate']").val(prodExpireDate);
    $("input[name='isMainProduct']").val(isMainProduct);

		$("input[name='offerIdArr']").val(offerIdArr);
		$("input[name='offerEffectTime']").val(offerEffectTime);
		$("input[name='offerExpireTime']").val(offerExpireTime);
		$("input[name='groupInstBaseInfo']").val(groupInstBaseInfo);
		
		$("input[name='sys_note']").val("<%=workNo%>"+"对"+"<%=gCustId%>"+"进行了"+"<%=offerName%>"+"新装!");
		/* 使用新的密码加密 */
		encryptPwd();
		if($("#cfmPwdEncryptFlag").val() != "1"){
			rdShowMessageDialog("宽带密码没有加密，不可继续办理业务",0);
			return false;
		}
		/* 使用新的密码加密 */
		GetBroadUserNo();
		
		if(!yuanzhanghaoFlag){
			rdShowMessageDialog("原宽带账号错误 请修改!",0);
			return false;
		}
		
		
		if(document.all.isYzPhoneNo.value != "1")
		{
			rdShowMessageDialog("没有获取用户虚拟号码，不可继续办理业务",0);
			return false;
		}
		var path = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		
		var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
		if(ifUseIntegral){
			if(!globalIngegralFlag){
				 rdShowMessageDialog("请先校验服务密码，并输入抵扣积分！",0);
		     return false;
			}
		}
		/*如果为kf包年资费，记录，就算不选中使用积分也记录，只不过记录空*/
		if("<%=ifUseIntegFlag%>" == "yes"){
			markIntegral();
			if(!globalMarkFlag){
				
		    return false;
			}
		}
		
		
		
		//rdShowMessageDialog("开户业务免填单打印移至统一缴费后打印！");
		//if(rdShowConfirmDialog("请确认是否进行产品新装？")==1)
		//{	
				conf(path);
		//}else{
		//			$("#cfmBtn").attr("disabled",false);			
		//}
		
}
function go_checkSnUse(){
	var getUnitId_Packet = new AJAXPacket("fCheckSN.jsp","正在校验请稍候......");
    getUnitId_Packet.data.add("snNumber",$("#snNumber").val());
    core.ajax.sendPacket(getUnitId_Packet,do_checkSnUse);
    getUnitId_Packet = null;
}
var checksnUse=false;
function do_checkSnUse(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	if(retcode == "000000"){
		checksnUse=false;
	}else{
		checksnUse=true;
		rdShowMessageDialog(retmsg,0);
	}
}
    
function doQryUnitIdBack(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	var result = packet.data.findValueByName("result");
	if(retcode != "000000"){
		$("#unitIdFlag").val("0");
		rdShowMessageDialog(retmsg,0);
	}else{
		var countNum = result[0][0];
		if(Number(countNum) == 0){
			$("#unitIdFlag").val("0");
			rdShowMessageDialog("集团编号不是归属哈尔滨或不存在，请确认",0);
		}else{
			$("#unitIdFlag").val("1");
		}
	}
}
function encryptPwd(){
	var getEncryptPwd_Packet = new AJAXPacket("/npage/public/pubBroadEncrypt.jsp","密码加密，请稍候......");
	getEncryptPwd_Packet.data.add("encryptType","encrypt");
	getEncryptPwd_Packet.data.add("password",document.all.cfmPwd.value);
	core.ajax.sendPacket(getEncryptPwd_Packet,doEncryptPwdBack);
	getEncryptPwd_Packet = null;
}
function doEncryptPwdBack(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	var returnPwd = packet.data.findValueByName("returnPwd");
	if(retcode != "000000"){
		rdShowMessageDialog("密码加密失败",0);
		$("#cfmPwdEncryptFlag").val("0");
	}else{
		$("#cfmPwdEncrypt").val(returnPwd);
		$("#cfmPwdEncryptFlag").val("1");
	}
}
//营销案流水校验 2013/07/10 16:15:51 gaopeng
function marketCheckFunc(){
  var orderId = $("#marketAccept").val();
  if(orderId.trim() == ""){
    rdShowMessageDialog("请先输入营销案流水",0);
    return false;
  }
  var getMarketPacket = new AJAXPacket("marketCheck.jsp","正在校验，请稍候......");
  getMarketPacket.data.add("orderId",orderId);
  getMarketPacket.data.add("opCode","<%=opCode%>");
  getMarketPacket.data.add("offerId","<%=offerId%>");//hejwa add 新校验服务增加入参 2014年2月17日11:15:29
  core.ajax.sendPacket(getMarketPacket,doMarketCheckBack);
  getMarketPacket = null;
}
function doMarketCheckBack(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	var outDetailMsg = packet.data.findValueByName("outDetailMsg");
	/*判断结果(0为订单有效 1为订单无效)*/
	var outRlt = packet.data.findValueByName("outRlt");
	var outPhoneNo = packet.data.findValueByName("outPhoneNo");
	if(retcode == "000000"){
		if(outRlt == "0"){
			rdShowMessageDialog("校验通过,此营销案流水对应的手机号码为"+outPhoneNo+",请与用户核对并确认",2);
			$("#marketAccept").attr("readonly","readOnly");
			viewModel.marketCheck(true);
			$("#marketPhoneNo").val(outPhoneNo);
		}else{
			rdShowMessageDialog(outDetailMsg,0);
			viewModel.marketCheck(false);
		}
	}else{
		rdShowMessageDialog(retcode + ":" + retmsg,0);
		viewModel.marketCheck(false);
	}
}

function marketCheckFunc58_88(){
  var orderId = $("#marketAccept58_88").val();
  if(orderId.trim() == ""){
    rdShowMessageDialog("请先输入营销案流水",0);
    return false;
  }
  var getMarketPacket = new AJAXPacket("marketCheck58_88.jsp","正在校验，请稍候......");
  getMarketPacket.data.add("orderId",orderId);
  core.ajax.sendPacket(getMarketPacket,doMarketCheckFunc58_88);
  getMarketPacket = null;
}
function doMarketCheckFunc58_88(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	/*判断结果(0为订单有效 1为订单无效)*/
	var outPhoneNo = packet.data.findValueByName("outPhoneNo");
	if(retcode == "000000"){
			rdShowMessageDialog("校验通过,此营销案流水对应的手机号码为"+outPhoneNo+",请与用户核对并确认",2);
			$("#marketAccept58_88").attr("readonly","readOnly");
			viewModel.marketCheck(true);
			$("#marketPhoneNo_58_88").val(outPhoneNo);
			$("#marketBtn").attr("disabled","disabled");
	}else{
		rdShowMessageDialog(retcode + ":" + retmsg,0);
		viewModel.marketCheck(false);
	}
}


/*gaopeng 2013/07/11 15:18:55 关于协助配置齐齐哈尔公司购终端打折购宽带营销方案的函 6 8折营销案的校验方法 start*/
function marketCheckFunc68(){
  var orderId = $("#marketAccept").val();
  if(orderId.trim() == ""){
    rdShowMessageDialog("请先输入营销案流水",0);
    return false;
  }
  var getMarketPacket = new AJAXPacket("marketCheck68.jsp","正在校验，请稍候......");
  getMarketPacket.data.add("loginAccept","<%=sysAcceptl%>");
  getMarketPacket.data.add("offerId","<%=offerId%>");
  getMarketPacket.data.add("orderId",orderId);
  getMarketPacket.data.add("opCode","<%=opCode%>");
  getMarketPacket.data.add("loginAccept","<%=sysAcceptl%>");
  core.ajax.sendPacket(getMarketPacket,doMarketCheckBack68);
  getMarketPacket = null;
}
function doMarketCheckBack68(packet){
  var retcode = packet.data.findValueByName("retcode");
  var retmsg = packet.data.findValueByName("retmsg");
  var outPhoneNo = packet.data.findValueByName("outPhoneNo");
  
  if(retcode == "000000"){
      rdShowMessageDialog("校验通过,此营销案流水对应的手机号码为"+outPhoneNo+",请与用户核对并确认",2);
      $("#marketAccept").attr("readonly","readOnly");
      viewModel.marketCheck(true);
      $("#marketPhoneNo").val(outPhoneNo);
  }else{
    rdShowMessageDialog(retcode + ":" + retmsg,0);
    viewModel.marketCheck(false);
  }
}
/*gaopeng 2013/07/11 15:18:55 关于协助配置齐齐哈尔公司购终端打折购宽带营销方案的函 6 8折营销案的校验方法 end*/

function GetBroadUserNo()
{
	var getUserNo_Packet = new AJAXPacket("f1100_getBroadUserNo.jsp","正在获得宽带虚拟号码，请稍候......");
		getUserNo_Packet.data.add("retType","BroadUserNo");
		getUserNo_Packet.data.add("loginAccept","<%=sysAcceptl%>");
		getUserNo_Packet.data.add("chnSource","01");
		getUserNo_Packet.data.add("opCode","<%=opCode%>");
		getUserNo_Packet.data.add("loginNo","<%=workNo%>");
		getUserNo_Packet.data.add("loginPwd","<%=nopass%>");
		getUserNo_Packet.data.add("phoneNo","");
		getUserNo_Packet.data.add("userPwd","");
		getUserNo_Packet.data.add("region_code","<%=regionCode%>");
		getUserNo_Packet.data.add("band_id","<%=brandID%>");		
		core.ajax.sendPacket(getUserNo_Packet,doProcess1);
		getUserNo_Packet = null;
}
/**hejwa 宽带和营销业务一起坐免填单改造，每次点提交按钮取得打印流水，避免点确定后返回免填单内容有变化*/
var sLoginAccept = "";
function ajaxGetAccept(){
	$.ajax({
				url: '/npage/innet/ajaxGetPrintAccept.jsp',
				type: 'POST',
				data: '',
				async: false,
				error: function(data){
						if(data.status=="404"){
						  alert( "文件不存在!");
						}else if (data.status=="500"){
						  alert("文件编译错误!");
						}else{
						  alert("系统错误!");
						}
				},
				success: function(msg){
				  if(msg.trim()!=""){
				  	sLoginAccept = msg.trim();
				  }else{
						rdShowMessageDialog("取打印流水出错!");
				  }
				}
	});
}


function conf(path){
			var myPacket = new AJAXPacket("/npage/s1104/savePrintInfos.jsp","正在查询信息，请稍候......");
			myPacket.data.add("path",codeChg(path));
			myPacket.data.add("sOrderArrayId","<%=orderArrayId%>");
			myPacket.data.add("opcode","<%=opCode%>");
			myPacket.data.add("optype","0");
					
			core.ajax.sendPacket(myPacket,dosaveflag);
			myPacket = null;
			
	document.all.path.value = path;
	document.prodCfm.action="KDconfm_new.jsp?offeridkd=<%=offerId%>";
	window.onbeforeunload=null;
	document.prodCfm.submit();
}

	function dosaveflag(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		
		 if(retCode != "000000"){
			rdShowMessageDialog("存储免填单信息出错，错误代码:"+retCode+"，错误信息:"+retMsg,0);
		}

}

var retResultStr = "";
var retResultStr1 = "";
/*电子免填单打印*/
function showPrtDlg(printType,DlgMessage,submitCfm)
{   
	ajaxGetAccept();
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = sLoginAccept;
   var phone_no	= $("input[name='phoneNo_h']").val();
   
   var mode_code = document.all.offerIdArr.value;
   mode_code = mode_code.replace(/,/ig,"~");
   //同步提交到服务的流水
   $("#sysAcceptl").val(sLoginAccept);
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		accInfoStr += "|"+$("#accInfoHid5").val();
		iccidInfoStr = iccidInfoStr.replace(/\\/g,"|xg|");
		accInfoStr = accInfoStr.replace(/\\/g,"|xg|");
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   return path;

  }
  
function 	strcatDb(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4){
	var packet = new AJAXPacket("ajaxSavePrintCont.jsp","请稍后...");
			packet.data.add("sLoginAccept",sLoginAccept);
			packet.data.add("cust_info",cust_info);
			packet.data.add("opr_info",opr_info);
			packet.data.add("note_info1",note_info1);
			packet.data.add("note_info2",note_info2);
			packet.data.add("note_info3",note_info3);
			packet.data.add("note_info4",note_info4);
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doStrcat);
			packet1 =null;
			return "";
}
function doStrcat(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg  = packet.data.findValueByName("retMsg");
	
	if(retCode!="000000"){
		rdShowMessageDialog("免填单内容存储失败【"+retCode+"："+retMsg+"】");
		return;
	}
}  
/***其他函数中要用到的过滤函数**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
/*打印信息*/
function printInfo(printType)
{
		ajaxGetEPf('<%=offerId%>','');
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		var usernamezhanshi=$("#userName").val().trim();
		var usernamezhanshi1=$("#userName11").val().trim();
		var usernamezhanshi2=$("#userName22").val().trim();
		if(usernamezhanshi1==usernamezhanshi2) {
		}else {
		usernamezhanshi=usernamezhanshi1;
		}
	 
		cust_info += "宽带帐号："+$("#cfm_login").val()+"|";
		cust_info += "客户姓名："+usernamezhanshi+"|";
		cust_info += "证件号码："+"<%=custIccid%>"+"|";
		cust_info += "客户地址："+$("#enter_addr").val()+"|";
		
		var cTime = "<%=cccTime%>";
		
		opr_info+= "业务受理时间："+cTime+"|";
		opr_info+= "办理业务：宽带开户"+"  "+"操作流水："+sLoginAccept+"|";		
		opr_info+= "初装费： INSTALLFEE 元"+"|";
		/*2014/04/03 15:32:46 gaopeng 移动家庭客户宽带业务运营支撑系统需求 修改当品牌为移动宽带(kf)时，免填单处理 start*/
		/* 
	   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
	   * 新增省广电kg，备用品牌kh
	   */
		if("kf" == "<%=sm_Code%>" || "kg" == "<%=sm_Code%>" || "kh" == "<%=sm_Code%>" || "ki" == "<%=sm_Code%>"){
			var kdZdFee = $.trim($("#kdZdFee").val());
			if(kdZdFee.length != 0){
				opr_info+= "宽带终端费用： "+kdZdFee+" 元"+"|";
			}else{
				opr_info+= "宽带终端费用： 0 元"+"|";
			}
			if(("kf" == "<%=sm_Code%>" ||"ki" == "<%=sm_Code%>")&&printSN){
				opr_info+= "S/N码："+$("#snNumber").val()+"|";
			}
			
		}
		/*2014/04/03 15:32:46 gaopeng 移动家庭客户宽带业务运营支撑系统需求 修改当品牌为移动宽带(kf)时，免填单处理 end*/
		opr_info+= "宽带套餐预存款： PREMONEY 元"+"|";
		opr_info+= "套餐生效时间:宽带安装完毕后生效"+"|"; 
		
		var appointvTime_p = $("#appointvTime").val();
		var a_year       = appointvTime_p.substring(0,4);
		var a_month      = appointvTime_p.substring(4,6);
		var a_dayofMonth = appointvTime_p.substring(6,8);
		
		opr_info+="|您宽带的预约安装时间为"+a_year+"年"+a_month+"月"+a_dayofMonth+"日，请在当日保持手机畅通，等待我们的安装人员与您联系。|";
		
 		note_info1+=" "+"|";
 		
		if(document.all.newZOfferDesc.value!=""){
			note_info1+="主资费描述："+document.all.newZOfferDesc.value+"|";
		}else{
			note_info1+="主资费描述：<%=offerComments%>"+"|";
		}
		
		
		note_info2 += "备注：" + "|";
		
		/*2014/04/03 15:32:46 gaopeng 移动家庭客户宽带业务运营支撑系统需求 修改当品牌为移动宽带(kf)时，免填单处理 start*/
		/* 
	   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
	   * 新增省广电kg，备用品牌kh
	   */
		if("kf" == "<%=sm_Code%>" || "kg" == "<%=sm_Code%>" || "kh" == "<%=sm_Code%>" || "ki" == "<%=sm_Code%>"){
			note_info2 += "1、宽带安装前，移动公司将及时与您联系预约上门安装时间，请保证联系电话畅通。"+ "|";
			note_info2 += "2、当联系电话变动时，请及时与移动公司联系，以便于有新活动或服务到期时及时通知您。"+ "|";
			note_info2 += "3、如需帮助，请拨打服务热线：10086。"+ "|";
			/*如果资费是包年资费 并且品牌为kf   这里正好和需求关于在CRM增加手机积分兑换宽带产品功能的需求 一致
				终端费用也就只有kf能展示 
			*/
			if("<%=ifUseIntegFlag%>" == "yes"&&"<%=gundongyueResult[0][0]%>" == "0"){
				note_info2 += "4、包年主资费到期后自动变更为标准月资费。"+ "|";
			}
		}
		/*2014/04/03 15:32:46 gaopeng 移动家庭客户宽带业务运营支撑系统需求 修改当品牌为移动宽带(kf)时，免填单处理 end*/	
		else{
			note_info2 += "1、开户时选择的宽带套餐将于宽带安装完毕后生效，宽带安装完毕后，铁通公司将及时通知您可以开始使用宽带业务。" + "|";
			note_info3 += "2、销户时需机主本人持有效证件办理，办理退费的用户请提供大于等于退款金额的现金预存款发票（不包括参与预存款活动的发票）。如用户办理包年宽带套餐，申请提前取消包年业务，将按剩余预存款的30%交纳违约金。在包年有效期内若遇国家资费标准调整，按国家新的资费政策执行。宽带业务包年暂停期间费用照收，上网功能暂停，包年期限不延后。" + "|";
		}
		
		if("kf" == "<%=sm_Code%>"){
					var kdzdtypes = $("#kdZd").val();
		      if(kdzdtypes=="ONT") {		      
		        var fysqfs = $("#fysqfs").val();
							if(fysqfs=="0") {//押金
							note_info3 += "尊敬的用户，如您办理销户、撤单时，请携带ONT设备、押金发票及有效证件，到移动指定自有营业厅办理返还押金。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。" + "|";
							}        
          }			
		}
		
		/*2016/7/22 9:31:49 gaopeng 关于集团宽带产品BOSS二次开发的需求 
			3）宽带品牌为“集团宽带(ki)”并且宽带终端选择“ONT”并且“费用收取方式“为押金，
			则免填单信息的备注信息与kf一致，即：
			   “尊敬的用户，如您办理销户、撤单时，请携带ONT设备、押金发票及有效证件，
			   到移动指定自有营业厅办理返还押金。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。”
			4）宽带品牌为“集团宽带(ki)”并且宽带终端选择“ONT”并且“费用收取方式“为押金，
			需要额外单独打印一张收据，不打发票、无税。收据样张与kf一致。
			   宽带品牌为“集团宽带(ki)”并且宽带终端选择“ONT”并且“费用收取方式“为销售，
			   需要额外单独打印一张发票，发票样张、税率与kf一致。
		*/
		if("ki" == "<%=sm_Code%>"){
					var kdzdtypes = $("#kdZd").val();
		      if(kdzdtypes=="ONT") {		      
		        var fysqfs = $("#fysqfs").val();
							if(fysqfs=="0") {//押金
							note_info3 += "尊敬的用户，如您办理销户、撤单时，请携带ONT设备、押金发票及有效证件，到移动指定自有营业厅办理返还押金。宽带终端押金返还截止日期：用户离网后90天内（包括90天）。" + "|";
							}        
          }			
		}
		
		
		strcatDb(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);//将数据存入数据库，与营销业务一起时
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;	
}

/*到期资费查询*/
function ajaxGetEPf(offerIdv,offerId){
		var packet = new AJAXPacket("../s1270/ajaxGetEPf.jsp","请稍后...");
		packet.data.add("offerIdv",offerIdv);
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("xqJf",offerId);
		core.ajax.sendPacket(packet,doAjaxGetEPf1);
		packet = null;
}  
	
function doAjaxGetEPf1(packet){
		 retResultStr = packet.data.findValueByName("retResultStr");
		 
		 document.all.newZOfferECode.value = packet.data.findValueByName("newZOfferECode");//新申请主资费代码
		 document.all.newZOfferDesc.value = packet.data.findValueByName("newZOfferDesc"); //新申请主资费描述
		 document.all.dOfferId.value = packet.data.findValueByName("dOfferId"); //到期后执行资费Id
		 document.all.dOfferName.value = packet.data.findValueByName("dOfferName"); //到期后执行资费Name
		 document.all.dECode.value = packet.data.findValueByName("dECode"); //到期后二批代码
		 document.all.dOfferDesc.value = packet.data.findValueByName("dOfferDesc"); //到期后资费描述
}
/*可选资费的查询*/
function ajaxGetEPf1(tempNote_info2v){
		var packet = new AJAXPacket("../s1104/ajaxGetEPf.jsp","请稍后...");
		packet.data.add("tempNote_info2v",tempNote_info2v);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet,doAjaxGetEPf11);
		packet = null;
}  
	
function doAjaxGetEPf11(packet){
		 retResultStr1 = packet.data.findValueByName("retResultStr");
}		
		
		
/*function setLoginAccept(retVal){
	document.all.printAccept.value = retVal;
	releaseNumFlag = false;
	document.prodCfm.action="KDconfm_new.jsp";
	document.prodCfm.submit();
}*/

function check_o(obj){ 
	if(obj.checked == true){
		document.getElementById(obj.v_div).style.display = "";
	}else{
		document.getElementById(obj.v_div).style.display = "none";
	}	
}
 
function showGroup(offIdv,offerNamev,groupIdv){
	var offerId = offIdv;
	var offerName = offerNamev;
	var groupTypeId = groupIdv;
	
	var curDate = new Date().getTime();
	var h=10;
	var w=10;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	if(true){
		var ret=window.showModalDialog("../s1104/showGroup.jsp?opType=set&offerId="+offerId+"&offerName="+offerName+"&groupTypeId="+groupTypeId+"&brandID="+"<%=brandID%>"+"&curTime="+curDate+"&groutDesc="+document.all.groutDesc.value,"",prop);
		if(typeof(ret) != "undefined"){
			var retTemp =ret; 
			ret = ret.substring(0,ret.indexOf("#"));
			document.all.groutDesc.value =  retTemp.substring(retTemp.indexOf("#")+1,retTemp.length);
	
			groupHash[offerId]=ret.toString();	//将返回的群组信息对应offerId放入

			var offerGroupInfo = "";		//组装销售品的群组信息,格式:offerId,groupinfo1,groupinfo2,~
			offerGroupInfo += offerId;
			offerGroupInfo += "|";
			var temp = ret.toString().split("/");

			$.each(temp[0].split("$"),function(i,n){
				if(typeof(n) != "undefined"){
					if(i<6){											//前6个为群组基本信息,后面的为它的属性信息
						offerGroupInfo += n.split("~")[1];	
						offerGroupInfo += "$";	
					}
					else{
						offerGroupInfo += n.substring(2); //去除"s_",id~value
						offerGroupInfo += "$";
					}
				}	
			});
			offerGroupInfo += "/";	
			
			offerGroupInfo+=temp[1];
			offerGroupHash[offerId] = offerGroupInfo;
		}	
		else{
			rdShowMessageDialog("未设置群组！");	
			return false;
		}
	}
	else{
		var ret=window.showModalDialog("../s1104/showGroup.jsp?opType=look&offerId="+offerId+"&offerName="+offerName+"&groupInfo="+groupHash[offerId]+"&groupTypeId="+groupTypeId+"&groutDesc="+document.all.groutDesc.value,"",prop);
	
		if(typeof(ret) != "undefined"){
				var retTemp = ret;
				
				ret = ret.substring(0,ret.indexOf("#"));
				document.all.groutDesc.value =  retTemp.substring(retTemp.indexOf("#")+1,retTemp.length);
			groupHash[offerId]=ret;	//将返回的群组信息对就offerId放入
			
			var offerGroupInfo = "";		//组装销售品的群组信息,格式:offerId,groupinfo1,groupinfo2,~
			offerGroupInfo += offerId;
			offerGroupInfo += "|";
			var temp = ret.toString().split("/");
			$.each(temp[0].split("$"),function(i,n){
				if(typeof(n) != "undefined"){
					if(i<6){											//前6个为群组基本信息,后面的为它的属性信息
						offerGroupInfo += n.split("~")[1];	
						offerGroupInfo += "$";	
					}
					else{
						offerGroupInfo += n.substring(2); //去除"s_"
						offerGroupInfo += "$";
					}
				}	
			});
			offerGroupInfo += "/";	
			
			offerGroupInfo+=temp[1];
			offerGroupHash[offerId] = offerGroupInfo;
		}
	}	
}
 
function showAttribute(){
	var queryType = this.name.substring(0,4);
	var queryId = this.id.substring(4);
	var offerName = this.name.substring(4);
	var h=600;
	var w=800;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	if($(this).attr("class") == "but_property"){
		var ret=window.showModalDialog("../s1104/showAttr.jsp?queryId="+queryId+"&queryType="+queryType,"",prop);
		if(typeof(ret) != "undefined"){
			if(ret.split("|")[1].length == 1){
				rdShowMessageDialog("未设置属性！");	
				return false;
			}
			$(this).attr("class","but_property_on");
			AttributeHash[queryId]=ret;	//将返回的群组信息对应queryId放入
		}	
		else{
			rdShowMessageDialog("未设置属性！");	
			return false;
		}
	}
	else{
		var ret=window.showModalDialog("../s1104/showAttr.jsp?queryId="+queryId+"&queryType="+queryType+"&attrInfo="+AttributeHash[queryId],"",prop);
		if(typeof(ret) != "undefined"){
			AttributeHash[queryId]=ret;	//将返回的群组信息对就queryId放入
		}
	}	
}

/*用户密码一致校验*/
function checkPwd1(obj1,obj2)
{
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1==""){
			rdShowMessageDialog("请输入用户密码",0);
			obj1.focus();
			return false;
	}
		
	if(pwd1 != pwd2)
	{
		var message = "输入的密码不一致，请重新输入！";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
}
/*宽带账号密码一致校验*/
function checkPwd2(obj1,obj2)
{
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1==""){
			rdShowMessageDialog("请输入宽带账号密码",0);
			obj1.focus();
			return false;
	}		
	if(pwd1 != pwd2)
	{
		var message = "输入的密码不一致，请重新输入！";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
} 
//显示已选择销售品信息
function getOrderInfo()
{
	var odValue = document.all.orderInfoV.value;
	if(odValue=="0"){
		$("#orderInfo").css("display","");	
		document.all.orderInfoV.value="1";
	}
	else{
		document.all.orderInfoV.value="0";
		$("#orderInfo").css("display","none");	
	}
}
function buttonShow()
{
	
	if(document.all.isYzResource.value=="0")
	{	
		
    if(document.all.isGetAreaResource.value=="1")
		{
			document.all.yz_resource.disabled=false;
		}else if (document.all.isDoNoResource.value=="1")
		{
			document.all.yz_resource.disabled=true;
		}else if ((document.all.isDoNoResource.value !="1") && (document.all.isGetAreaResource.value!="1") )
		{
			document.all.query_res.disabled=false;
			document.all.yz_resource.disabled=true;
		}
		
		if($("#isNeedHold").val() == "1"){
			/*需要预占的*/
			document.all.yz_resource.disabled=false;
			document.all.sf_resource.disabled=true;
		}else{
			document.all.yz_resource.disabled=true;
			document.all.sf_resource.disabled=true;
		}
		
	}
	else{
			document.all.query_res.disabled=true;
      document.all.yz_resource.disabled=true;
      document.all.sf_resource.disabled=false;
	}
}
function idleResInfo()
{
	document.all.area_nameh.value=  "";
	document.all.area_codeh.value=  "";
	document.all.areaAddr.value=  "";	
	//document.all.bandWidth.value="";
	document.all.enter_type.value=  "";
	document.all.standardCode.value="";
	document.all.standardContent.value="";
	
	document.all.deviceType.value="";
	document.all.deviceCode.value="";
	document.all.model.value="";
	document.all.factory.value="";
  document.all.ipAddress.value="";
  document.all.deviceInAddress.value="";
  document.all.portType.value="";
  document.all.portCode.value="";
  document.all.cctId.value="";
  document.all.cctName.value="";
  
}
/*宽带小区查询*/
function queryResource()
{ 
	 idleResInfo();
   if(document.all.isYzResource.value!="1"){
   
   var smcodess="<%=sm_Code%>";
  
   
		      var path ="../se276/queryResource.jsp?opCode="+"<%=opCode%>"+"&smCode="+smcodess;
		      window.open(path,'小区资源查询','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    }else{	 
    		yzResource();//释放资源 	
    }
} 

String.prototype.replaceAll4977 = function(reallyDo, replaceWith, ignoreCase) {
　 if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);
} else {
return this.replace(reallyDo, replaceWith);
}
} 

function returnResBack(retInfo)
{
	var resPre=retInfo.substr(0,2);
	
	var resContent=retInfo.substr(2,retInfo.length-1);
	
	
  /*2016/8/3 11:15:06 gaopeng 获取标准地址 小区名称 取最终选择的地址内容*/
	document.all.area_nameh.value=  oneTok(resContent, "|", 7);
	
	document.all.enter_addr.value	=document.all.area_nameh.value.replaceAll4977("/","");
	
	document.all.area_codeh.value=  oneTok(resContent, "|", 2);
	document.all.areaAddr.value=  oneTok(resContent, "|", 3);	
	//document.all.bandWidth.value=oneTok(resContent, "|", 4);
	document.all.enter_type.value=  oneTok(resContent, "|", 5);
	//alert(document.all.enter_type.value);
	document.all.standardCode.value=oneTok(resContent, "|", 6);//addressCode地址编码
	//alert("addressCode地址编码是："+oneTok(resContent, "|", 6));
	document.all.standardContent.value=oneTok(resContent, "|", 7);
	document.all.deviceType.value=oneTok(resContent, "|", 8);
  document.all.deviceCode.value=oneTok(resContent, "|", 9);
  document.all.model.value=oneTok(resContent, "|", 10);
  document.all.factory.value=oneTok(resContent, "|", 11);
	document.all.ipAddress.value=oneTok(resContent, "|", 12);
	document.all.deviceInAddress.value=oneTok(resContent, "|", 13);
	//alert(deviceInAddress);
	var deviceInAddress = document.all.deviceInAddress.value;
	document.all.deviceInAddress.value = codeChg(deviceInAddress);
	document.all.portType.value=oneTok(resContent, "|", 14);
	document.all.portCode.value=oneTok(resContent, "|", 15);
	document.all.cctId.value=oneTok(resContent, "|", 16);
	document.all.partnerCode.value=oneTok(resContent, "|", 17);
	
	
	
	/*2014/04/03 11:17:27 gaopeng 获取 归属类别 承载方式*/
	document.all.belongCategory.value=oneTok(resContent, "|", 18);
	document.all.bearType.value=oneTok(resContent, "|", 19);
	
	/*2014/09/05 10:12:39 gaopeng 宽带资费展现及终端管理等七项系统支撑优化需求
		当资源查询的承载方式为“有线”，则宽带终端的值为“ONT”
		当资源查询的承载方式为“无线”，则宽带终端的值为“CPE”
		只有“移动宽带(kf)”才展示宽带终端和宽带终端费用，并且必选。其他品牌不展示这两个选项。
	*/
	var bearTypeA = document.all.bearType.value;
	
	if("kf" == "<%=sm_Code%>"){
		/*有线*/
		if(bearTypeA == "0"){
			$("select[name='kdZd']").find("option").each(function(){
				var thisVAL = $(this).val();
				if(thisVAL == "ONT"){
					$(this).attr("selected","selected");
				}
				
			});
		}
		/*无线*/
		else if(bearTypeA == "1"){
			$("select[name='kdZd']").find("option").each(function(){
				var thisVAL = $(this).val();
				if(thisVAL == "CPE"){
					$(this).attr("selected","selected");
				}
				
			});
			
		}
		
		kdzdchange();
		
		
	}
	
	document.all.propertyUnit.value=oneTok(resContent, "|", 20);
	
	document.all.distKdCode.value=oneTok(resContent, "|", 21);
	document.all.nearInfo.value=oneTok(resContent, "|", 22);
	/* 4977宽带开户小区资费查询增加广电限制：接入类型为移动宽带，且小区建设性质为广电，则不需进行资源预占@2014/5/29 16:39:50 */
	/*2014/11/19 10:52:43 铁通融合项目 gaopeng 修改 只用小区建设性质判断即可，kg和ke和kh均不用预占
		kg=3 ke=4 kh=5
		2015/01/08 11:11:09 gaopeng 3 4 5 6(三方)的时候 不进行资源预占
	*/
	if( document.all.propertyUnit.value.trim() == "3" || document.all.propertyUnit.value.trim() == "4" ){
		$("#isNeedHold").val("0");
		document.all.yz_resource.disabled=true;
	}
	/*2016/5/31 10:22:02 gaopeng 关于铁通宽带客户迁移支撑系统改造补充需求的函 
		小区建设性质 为5 5-铁通（铁通自有）  6 6-三方(移动自建)
		接入类型为 “2/FTTH”和“3/FTTB”时 需要预占
		其他情况不需要预占
	*/
	if(document.all.propertyUnit.value.trim() == "5" || document.all.propertyUnit.value.trim() == "6"){
		/*接入类型为 “2/FTTH”和“3/FTTB”时 需要预占*/
		if(document.all.enter_type.value == "2" || document.all.enter_type.value == "3"){
			$("#isNeedHold").val("1");
			document.all.yz_resource.disabled=false;
			
		}else{
			$("#isNeedHold").val("0");
			document.all.yz_resource.disabled=true;
		}
	}
	
	/*
	alert(oneTok(resContent, "|", 18)+"---"+oneTok(resContent, "|", 19));
	*/
/*alert(document.all.cctId.value+"--"+document.all.partnerCode.value);*/
	var pkt = new AJAXPacket("ajaxGetPartnerName.jsp","请稍后...");
	pkt.data.add("partnerCode",document.all.partnerCode.value);
	pkt.data.add("iSmCode","<%=sm_Code%>");
	core.ajax.sendPacket(pkt,doPartnertName);
	pkt = null;	
	
	
	//document.all.cctId.value="001";
	if(document.all.cctId.value != ""){
	    var packet = new AJAXPacket("ajaxGetCctName.jsp","请稍后...");
			packet.data.add("cctId",document.all.cctId.value);
			core.ajax.sendPacket(packet,doAjaxGetCctName);
			packet = null;
	} 
	document.all.isGetAreaResource.value="1";
	if (resPre =="3%"){
			$("#noPort").val("1");
  }else if (resPre =="4%"){
    	$("#noPort").val("0");
    	buttonShow();
  	}
	if($("#isNeedHold").val()=="1"){
		yzResource();
	}
}

function doPartnertName(packet)
{
	var retCode = packet.data.findValueByName("ptRtCode");
	var retMsg = packet.data.findValueByName("ptRtMsg");
	if(retCode == "000000")
	{
		var ptName = packet.data.findValueByName("ptName");
		document.all.partnerName.value=ptName;	
	}
	else
	{
		rdShowMessageDialog(retMsg,0);
		removeCurrentTab();
	}
}

function doAjaxGetCctName(packet)
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMessage");
  var cctName = packet.data.findValueByName("cctName");
  if(retCode == "000000")
  {
  	document.all.cctName.value=cctName;	
  }
  else
  {
  	rdShowMessageDialog(retMsg,0);
  }
}
function oneTok(str,tok,loc)
{
   var temStr=str;
	 var temLoc;
	 var temLen;
   for(ii=0;ii<loc-1;ii++)
	 {
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	 }
	 if(temStr.indexOf(tok)==-1)
	    return temStr;
	 else
      return temStr.substring(0,temStr.indexOf(tok));
}

function sfResource(){
	var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "正在校验，请稍候......");
	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
	myPacket.data.add("customerCode",document.all.cfm_login.value);/*用户编号*/
	myPacket.data.add("productType","12");/*产品类型*/
	myPacket.data.add("opCode", "<%=opCode%>");
	myPacket.data.add("yzFlag", "2");
	/*2013/3/1 星期五 9:09:16 gaopeng FTTH需求，增加参数 addressCode 地址编码*/
	myPacket.data.add("addressCode", document.all.standardCode.value);
	core.ajax.sendPacket(myPacket,doSfResource);
	myPacket = null;
}
function doSfResource(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retContentArr = new Array();
	var retContent = packet.data.findValueByName("retContent");
	var retContentT = ""+retContent;
	var iType = packet.data.findValueByName("iType");
	if(retCode=="000000"){
		//有些输入框可编辑
		document.all.userName11.readOnly=false;
		document.all.contactPhone.readOnly=false;
		document.all.contactCustName.readOnly=false;
		document.all.cfm_loginF.readOnly=false;
		document.all.enter_addr.readOnly=false;
		document.all.cfmPwd.readOnlly=false;
		document.all.cfmPwdConfirm.readOnlly=false;
		//有些按钮能用
		document.all.isYzResource.value="0";
		rdShowMessageDialog("资源释放成功",2);
		buttonShow();
	}else{
		retContentArr = retContentT.split("=");
 		if(retContentArr.length > 3){
 			rdShowMessageDialog("错误信息："+retContentArr[3]+"！",0);
 		}else{
 			rdShowMessageDialog("错误信息：资源释放失败！",0);
 		}
 		return false;
	}
}

function yzResource()
{
	  if(document.all.isGetAreaResource.value=="0"){
		       rdShowMessageDialog("没有选择资源，请选择资源");
		       return false;
		}
		if(document.all.cfmLoginCheck.value=="0"){
				rdShowMessageDialog("没有宽带登陆账号不可以预占资源",0);
				return false;
		}
		if(document.all.contactCustName.value==null || document.all.contactCustName.value=="" || document.all.contactCustName.value=="0"){
		  	rdShowMessageDialog("联系人不可以为空，请输入");
		  	document.all.contactCustName.focus();
		  	return false;
		 }
		if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
		  	rdShowMessageDialog("联系号码不可以为空，请输入");
		  	document.all.contactPhone.focus();
		  	return false;
		 }
		 if(document.all.enter_addr.value==null || document.all.enter_addr.value==""){
			rdShowMessageDialog("安装地址不可以为空，请输入");
			document.all.enter_addr.focus();
			return false;
		 }
			
		  if(checkPwd2(document.all.cfmPwd,document.all.cfmPwdConfirm)==false)	return false;
		  
		  if(!checkForm()){
				return false;
			}
/*预占接口 2013/2/26 星期二 16:27:36 gaopeng*/	

				   var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "正在校验，请稍候......");
				   myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
						myPacket.data.add("customerCode",document.all.cfm_login.value);/*用户编号*/
						myPacket.data.add("productType","12");/*产品类型*/
						myPacket.data.add("yzFlag", "0");
						myPacket.data.add("opCode", "<%=opCode%>");
						/*2013/3/1 星期五 9:09:16 gaopeng FTTH需求，增加参数 addressCode 地址编码*/
						myPacket.data.add("addressCode", document.all.standardCode.value);
						/*2014/11/10 10:07:13 gaopeng 修改资源预占接口*/
						myPacket.data.add("enterType", document.all.enter_type.value);
						myPacket.data.add("propertyUnit", document.all.propertyUnit.value);
						core.ajax.sendPacket(myPacket,doYzResource);
						myPacket = null;
	
} 
function doYzResource(packet)
{
	//alert("进入回调函数");
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  //alert("retCode==="+retCode+"---retMsg=="+retMsg);
	var retContentArr = new Array();
  var retContent = packet.data.findValueByName("retContent");
  var retContentT = ""+retContent;
  var iType = packet.data.findValueByName("iType");
	//alert(retCode+"--返回代码");
	       if(retCode=="000000"){	//表示调用服务成功
	       	 var retValue=retContent.split(",");
	         var retContent=retValue[2].split("=");
	         if(retContent[1]=="0"){//判断是否预占成功
	       	    //有些输入框不可编辑
							document.all.userName11.readOnly=true;
							//document.all.contactPhone.readOnly=true;
							//document.all.contactCustName.readOnly=true;
							document.all.cfm_loginF.readOnly=true;
							//document.all.enter_addr.readOnly=true;
							//document.all.cfmPwd.readOnlly=true;
							//document.all.cfmPwdConfirm.readOnlly=true;
							//有些按钮不能用
							document.all.isYzResource.value="1";  
							//rdShowMessageDialog("资源预占成功",2);
							buttonShow();
		       }else{
		       		retContentArr = retContentT.split("=");
		       		if(retContentArr.length > 3){
		       			rdShowMessageDialog("错误信息："+retContentArr[3]+"！",0);
		       		}else{
		       			rdShowMessageDialog("错误信息：资源预占失败！",0);
		       		}
		       		return false;
		       }     
	       }
	       else {                                       
	       	 rdShowMessageDialog(retMsg,0); 
	       	 document.all.isYzResource.value="0"; 
	       	 return false;
	       }
	
	/**
	else if(iType=="2"){
	        if(retCode=="000000" ){	 
			         var retValue=retContent.split(",");
			         var retContent=retValue[2].split("=");
			         if(retContent[1]=="0"){   
								idleResInfo();
			    	    //有些输入框可编辑
				       	document.all.userName11.readOnly=false;
				       	document.all.contactPhone.readOnly=false;
				       	document.all.contactCustName.readOnly=false;
				       	document.all.cfm_loginF.readOnly=false;
				       	document.all.enter_addr.readOnly=false;
				       	document.all.cfmPwd.readOnly =false;
				       	document.all.cfmPwdConfirm.readOnly =false;		       	 
				       	document.all.isGetAreaResource.value="0";
				    	  document.all.isYzResource.value="0"; 
				    	  rdShowMessageDialog("资源释放成功",1);
				    	   buttonShow();
			         }else{
			    	      rdShowMessageDialog("资源释放失败",0); 
			         } 
	         }else{ 
	         	 rdShowMessageDialog(retMsg,0);  
	         	 document.all.isYzResource.value="1"; 
	         }
	}*/
}
/*生成宽带账号，并进行验证*/
function checkCfmLogin()
{
		if(checkElement(document.all.cfm_loginF)){
			if(document.all.cfm_loginF.value.trim().length == 0)
			{
				rdShowMessageDialog("账号生成号码不可为空",0); 
			}else{
			  /*begin diling add for 当宽带品牌为“新时速(kf)[目前改为移动宽带，并且最多为8-10个汉字]”时,可以输入@和数字和字母@2012/9/17 */
			  /* 
			   * 关于协助开发省广电合作宽带话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
			   * 新增省广电kg，备用品牌kh
			   * houxuefeng要求kf  kg只输入数字，kh保持不变。2014/11/4 13:36:05
			   */
			   /*update 统一规范账号命名规则 for 关于协助修改宽带账号编码规则和宽带投诉处理时限的函@2015/4/13 */
			  if("kf"=="<%=sm_Code%>" || "kg"=="<%=sm_Code%>" || "ke"=="<%=sm_Code%>" || "kd"=="<%=sm_Code%>" || "kh"=="<%=sm_Code%>" || "ki"=="<%=sm_Code%>"){
			    var reg =/^[0-9]*$/;
          if(reg.test(document.all.cfm_loginF.value.trim()) == false){
            rdShowMessageDialog("账号生成号码内容由数字组成！");
            return false;
          }
          var loginKf = document.all.cfm_loginF.value.trim();
          if("kh"=="<%=sm_Code%>"){
          	if(loginKf.length < 11  || loginKf.length > 16){
	          	rdShowMessageDialog("账号生成号码为11-16个数字！");
	            return false;
	          }
          }else{
          	//if(loginKf.length < 8  || loginKf.length > 10){
	          if(loginKf.length < 11  || loginKf.length > 12){
	          	rdShowMessageDialog("账号生成号码为11-12个数字！");
	            return false;
	          }
          }
			  }
			  /*
			  2014/11/21 10:33:30 gaopeng 宽带项目 去掉kh校验，与kd保持一致
			  else if("kh"=="<%=sm_Code%>"){
			    var reg =/^[0-9a-zA-Z\@]*$/;
          if(reg.test(document.all.cfm_loginF.value.trim()) == false){
            rdShowMessageDialog("账号生成号码内容由数字、@、字母其中的一项或多项组成！");
            return false;
          }
          var loginKf = document.all.cfm_loginF.value.trim();
          if(loginKf.length < 8  || loginKf.length > 10){
          	rdShowMessageDialog("账号生成号码为8-10个字符！");
            return false;
          }
			  }
			  */
			  /*end diling add @2012/9/17 */
				  var cfm_login= document.all.cfm_loginF.value;
			    cfm_login="<%=prefix%>"+cfm_login+"<%=domainName%>";
				  var getUserId_Packet = new AJAXPacket("f1100_checkCfmLogin.jsp","正在获得宽带账号，请稍候......");
					getUserId_Packet.data.add("retType","CfmLoginK");
					getUserId_Packet.data.add("region_code","<%=regionCode%>");
					getUserId_Packet.data.add("cfm_login",cfm_login);
					core.ajax.sendPacket(getUserId_Packet,doProcess1);
					getUserId_Packet = null;
		  }
		}    
}
 
function doProcess1(packet)
{
   var retType = packet.data.findValueByName("retType");
   var retCode = packet.data.findValueByName("retCode");
   var retMessage = packet.data.findValueByName("retMessage");
   if(retType=="CfmLoginK"){//校验宽带账号
    	if(retCode=="000000"){
    			//rdShowMessageDialog("该账号可以使用",2);
    			document.all.cfmLoginCheck.value="1";
    			document.all.cfm_login.value="<%=prefix%>"+document.all.cfm_loginF.value+"<%=domainName%>";
    			$("input[type=password][name=cfmPwd]").val(document.all.cfm_login.value.substring((document.all.cfm_login.value.length-6)));
    			$("input[type=password][name=cfmPwdConfirm]").val(document.all.cfm_login.value.substring((document.all.cfm_login.value.length-6)));
    		}else{
    			rdShowMessageDialog("该账号不可用！",0);
    			document.all.cfmLoginCheck.value="0";
    		}
    } else if(retType=="BroadUserNo"){//获取服务号码
	    	if(retCode=="000000"){
	    			var phoneNo_h = packet.data.findValueByName("phoneNo_h");  
	    			document.all.phoneNo_h.value = phoneNo_h;
	    			document.all.isYzPhoneNo.value = "1";
	    		}else{
	    			rdShowMessageDialog("获取虚拟号码错误 " + retCode + retMessage,0);
	    			document.all.isYzPhoneNo.value = "0";
	    		}
    }
}
function ignoreThis(){
	if(rdShowConfirmDialog("请确认是否取消该业务？ 确认后，业务将被删除")==1){
		var packet1 = new AJAXPacket("../s1104/ignoreThis.jsp","请稍后...");
				packet1.data.add("sOrderArrayId","<%=orderArrayId%>");
				core.ajax.sendPacket(packet1,doIgnoreThis,true);
				packet1 =null;
			}
}
	
function doIgnoreThis(packet){
		var errorCode = packet.data.findValueByName("retrunCode");
		var returnMsg = packet.data.findValueByName("returnMsg");
		if(errorCode == "0"){
				rdShowMessageDialog("忽略成功",2);
				goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
			}else{
				rdShowMessageDialog("忽略失败:"+returnMsg,0);
				}
			
}
window.onbeforeunload=function LeaveWin()
{     
			if(document.all.isYzResource.value=="1")
			{ 
				 sfResource();
			}
}

function checkForm(){
	/*
		表单提交前，字段类型验证
		由于发接口平台，做比较全面的限制。
		账号：数字+英文字母+@符(只有kf品牌可以输入字母和@符)
		密码：数字
		联系人：中文
		联系电话：数字
		安装地址：英文字母+数字+中文+-() (中划线和小括号)
		施工要求：英文字母+数字+中文
		预约时间：数字
	*/
	var m;
	var flag = false;
	/*账号：数字+英文字母+@符(不同品牌是否允许输入字母和@已有限制，这里不再做)*/
	var cfmLoginFVal = document.all.cfm_loginF.value;
	if(cfmLoginFVal != ""){
		m = /^[0-9a-zA-Z@]+$/;
		flag = m.test(cfmLoginFVal);
		if(!flag){
			rdShowMessageDialog("账号只允许输入字母数字和@符");
			return false;
		}
	}
	
	/*密码：数字*/
	var pswd = document.all.userpwd.value;
	if(pswd != ""){
		m = /^[0-9]+$/;
		flag = m.test(pswd);
		if(!flag){
			rdShowMessageDialog("用户密码只允许输入数字");
			return false;
		}
	}
	var cfmPwd = document.all.cfmPwd.value;
	if(cfmPwd != ""){
		m = /^[0-9]+$/;
		flag = m.test(cfmPwd);
		if(!flag){
			rdShowMessageDialog("宽带密码只允许输入数字");
			return false;
		}
	}
	
	/*联系人：中文*/
	var contactCustName = document.all.contactCustName.value;
	if(contactCustName != ""){
		m = /^[\u0391-\uFFE5]+$/;
		var flag = m.test(contactCustName);
		if(!flag){
			rdShowMessageDialog("联系人只允许输入中文");
			return false;
		}
	}
	
	/*联系电话：数字*/
	var contactPhone = document.all.contactPhone.value;
	if(contactPhone != ""){
		m = /^[0-9]+$/;
		var flag = m.test(contactPhone);
		if(!flag){
			rdShowMessageDialog("联系电话只允许输入数字");
			return false;
		}
	}
	
	/*安装地址：英文字母+数字+中文+-() (中划线和小括号)*/
	var enter_addr = document.all.enter_addr.value;
	if(enter_addr != ""){
		m = /^[\u0391-\uFFE5a-zA-Z0-9\-\(\)]+$/;
		var flag = m.test(enter_addr);
		if(!flag){
			rdShowMessageDialog("安装地址只允许输入中文、字母、数字、-、()");
			return false;
		}
	}
	
	/*施工要求：英文字母+数字+中文
	var construct_request = document.all.construct_request.value;
	if(construct_request != ""){
		m = /^[\u0391-\uFFE5a-zA-Z0-9]+$/;
		var flag = m.test(construct_request);
		if(!flag){
			rdShowMessageDialog("施工要求只允许输入中文、字母、数字");
			return false;
		}
	}
	*/
	/*预约时间：数字*/
	var appointvTime = document.all.appointvTime.value;
	if(appointvTime != ""){
		m = /^[0-9]+$/;
		var flag = m.test(appointvTime);
		if(!flag){
			rdShowMessageDialog("预约时间只允许输入数字");
			return false;
		}
	}
	
	return true;
}


function kdzdchange(){
		var kdzdtypes = $("#kdZd").val();
		if(kdzdtypes=="ONT") {		    
		    $("#fysqfsdisplay1").show();
		    $("#fysqfsdisplay2").show();
		    $("#kdzdfydisplay").removeAttr("colSpan");
		    FEEsqfs();
		}else {
		    $("#fysqfsdisplay1").hide();
		    $("#fysqfsdisplay2").hide();
		    $("#kdzdfydisplay").attr("colSpan","3");		
		    $("#kdZdFee").removeAttr("v_minvalue");
		    $("#kdZdFee").removeAttr("v_maxvalue");
		    $("#kdZdFee").removeAttr("readonly");
		    $("#kdZdFee").removeAttr("class");
		    $("#yjfwxianshi").hide();
		}
}
var printSN=false;
function showSN(){
	var kdZd = $("#kdZd").val();
	var fysqfs = $("#fysqfs").val();
	if(snShow=="2"&&kdZd=="ONT"&&(fysqfs=="0"||fysqfs=="1")){
		$("#sntitletd").show();
		$("#sntexttd").show();
		$("#snNumber").attr("v_must","1");
		printSN=true;
	}
	else{
		$("#sntitletd").hide();
		$("#sntexttd").hide();
		$("#snNumber").val("");
		$("#snNumber").attr("v_must","0");
		printSN=false;
	}
}

function FEEsqfs() {
		var fysqfs = $("#fysqfs").val();
		if(fysqfs=="0") {//押金
		$("#kdZdFee").attr("v_minvalue","50");	
		$("#kdZdFee").attr("v_maxvalue","200");	
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").show();
		
		}else if(fysqfs=="1") {//销售
		$("#kdZdFee").removeAttr("v_minvalue");
		$("#kdZdFee").removeAttr("v_maxvalue");
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").hide();
		
		
		}else {//自备
		$("#kdZdFee").removeAttr("v_minvalue");
		$("#kdZdFee").removeAttr("v_maxvalue");
		$("#kdZdFee").val("0");	
		$("#kdZdFee").attr("readonly","readonly");
		$("#kdZdFee").attr("class","InputGrey");
		$("#yjfwxianshi").hide();
		
		}
		
}
var intKaihufangshi=0;
var yuanzhanghaoFlag=true;

function checkOpenkdFlag(){
	yuanzhanghaoFlag=true;
	
	$("#isNeedHold").val("<%=isNeedHold%>");
	if($("#openkdFlag").val()=="1"||$("#openkdFlag").val()=="4"||$("#openkdFlag").val()=="5"){
		intKaihufangshi=0;
		$("#yuankuandaiTd1").show();
		$("#yuankuandaiTd2").show();
		$("#yuankuandaiNum").attr("v_must","1");
	}
	else if($("#openkdFlag").val()=="2"){
		intKaihufangshi=1;
		$("#yuankuandaiTd1").show();
		$("#yuankuandaiTd2").show();
		$("#yuankuandaiNum").attr("v_must","1");
	}
	else if($("#openkdFlag").val()=="7"){
		$("#yuankuandaiTd1").hide();
		$("#yuankuandaiTd2").hide();
		$("#yuankuandaiNum").attr("v_must","0");
		$("#isNeedHold").val("0");
	}
	else{
		$("#yuankuandaiTd1").hide();
		$("#yuankuandaiTd2").hide();
		$("#yuankuandaiNum").attr("v_must","0");
	}
}

function checkOpenkdFlag1(){
	$("#isNeedHold").val("<%=isNeedHold%>");
	$("#yuankuandaiTd1").hide();
	$("#yuankuandaiTd2").hide();
	$("#yuankuandaiNum").attr("v_must","0");
	if($("#openkdFlag").val()=="8"){
		$("#isNeedHold").val("0");
	}
	buttonShow();
}

function go_checkYuanzhanghao(){
	var packet = new AJAXPacket("ajaxCheckyuanzhanghao.jsp","请稍后...");
	packet.data.add("iLognAccept","<%=sysAcceptl%>");
	packet.data.add("iChnSource","01");
	packet.data.add("iOpCode","<%=opCode%>");
	packet.data.add("iLoginNo","<%=workNo%>");
	packet.data.add("iLoginPwd","<%=nopass%>");
	packet.data.add("iPhoneNo","");
	packet.data.add("iUserPwd","");
	packet.data.add("iQueryType",intKaihufangshi+"");//
	packet.data.add("iCfmLoginOld",$("#yuankuandaiNum").val());//
	core.ajax.sendPacket(packet,do_checkYuanzhanghao);
	packet =null;
}

function do_checkYuanzhanghao(packet){
	var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code=="000000"){//调用服务失败
    	yuanzhanghaoFlag=true;
		return;
    }else{//操作失败
    	rdShowMessageDialog(error_code+":"+error_msg);
    	yuanzhanghaoFlag=false;
    	return false;
    }
}

function go_checkSNShow(){
	var packet = new AJAXPacket("ajaxCheckSnShow.jsp","请稍后...");
	packet.data.add("iLognAccept","<%=sysAcceptl%>");
	packet.data.add("iChnSource","01");
	packet.data.add("iOpCode","<%=opCode%>");
	packet.data.add("iLoginNo","<%=workNo%>");
	packet.data.add("iLoginPwd","<%=nopass%>");
	packet.data.add("iPhoneNo","<%=sm_Code%>");
	packet.data.add("iUserPwd","");
	core.ajax.sendPacket(packet,do_checkSNShow);
	packet =null;
}

function do_checkSNShow(packet){
	var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code=="000000"){
    	snShow=packet.data.findValueByName("vFlag");
    	//snShow="2";
    	showSN();
		return;
    }else{//操作失败
    	snShow="1";
    	showSN();
    	return false;
    }
}

</SCRIPT>

</HEAD>
<BODY>
<DIV id=operation>
<FORM name="prodCfm" action="" method="post" width="100%"><!-- operation_table -->
<input type="hidden"  id="isYzResource" name="isYzResource"  value="0" >
<input type="hidden"  id="isBaoNian" name="isBaoNian"  value="<%=isSS6flag%>" >
<%@ include file="/npage/include/header.jsp" %>	
<div id="Operation_table">
	<div class="title">
		<div id="title_zi">客户信息</div>
</div>


<div id="custInfo">
<%@ include file="/npage/common/qcommon/bd_0002.jsp" %>
</div>

		<div id="tabsJ">
			<ul>
				<li class="current" id="tb_1"><input type='radio' name='changeSel' value='selBasic' checked onclick="HoverLi(1,2);">基本销售品&nbsp;</li>
				<li id="tb_2"><input type='radio' name='changeSelh' value='selStruc' onclick="HoverLi(2,2);">销售品构成</li>
			</ul>
		</div>

		<!-- 基本销售品 开始-->
		<div class="dis" id="tbc_01">
				<div id=tb_01>
						<div class=input>
								<div id=baseInfo></div>
								<div class="title">
									<div id="title_zi">销售品信息</div>
								</div>	
								<table cellSpacing=0>
								  <tr>
								    <td class="blue" width=17%>品牌</td>
								  	<td width=33%><%=brandName%>  
								  		<input type="hidden" name="orderInfoV" value="0" />
								  		<input class=b_text id="orderInfoDiv"  type=button value=查看已选择附加销售品信息 /></td>
								    <td class="blue"  width=17%>销售品名称</td>
								    <td id="td_offerName"><%=(offerId+"-->"+offerName)%> </TD>
									</tr>
									<tr>
								    <td class="blue">描述</Td>
								    <td colspan="3"><%=offerComments%></TD>
								  </tr>
								</table>  
								<div id="OfferAttribute"></div><!--销售品属性--></div>
								<div class="list" id="orderInfo" style="display:none">
										<div class=title><div id="title_zi">已选择附加销售品信息</div>
								</div>
            		<div style="overflow-y:scroll;overflow-x:hidden;height:130px">	   	
				            <table cellSpacing=0 id="tab_order">
												<tr>
											    <th>销售品ID</td><th>销售品名称</td><th>生效时间</td><th>失效时间</td><th>描述</td>
												</tr>
										</table>	
								</div>
						</div>

						<div class="input" style="display:none"  id="addGroupInfo">
								<table cellSpacing=0 style="display:none">
									<tr>
								    <td class="blue" style="width:100px">可加群组</td>
								    <td id="addGroupTd"></td>
									</tr>
								</table>	
						</div>

						<div class="input" id="userinfo">
								<br>
								<div class="title">
								<div id="title_zi">基本信息</div>
								</div>
								<div id="userBaseInfo">
								<%@ include file="include/fKDUserBaseInfo.jsp" %>
								</div>
						</div>
				</div>

				<div class="title">
					<div id="title_zi">资源信息</div>
				</div>	
				<table cellSpacing=0 id="serviceNoInfo">	
				    <tr>
			        
			        <td colspan=6 align="center">     
			          <input type="button" class="b_text" name="query_res" value="小区资源查询" onClick="queryResource()" >
			          <input type="button" class="b_text" name="yz_resource" id="yz_resource" value="资源预占" onClick="yzResource()">
			          <input type="button" class="b_text" name="sf_resource" id="sf_resource" value="资源释放" onClick="sfResource()">
			          <input type="hidden" name="yxds" value="百事通">
			          <span id="keShowSpan" style="color:red;display:none;">广电宽带无需资源预占和资源释放</span>
			          <%if("1".equals(isNeedHold)) {%>
			          <span  style="color:red;">“预占释放”按钮可点击时，不进行宽带开户请点击“资源释放”，不要直接关闭界面。</span>
			          <%}%>
			        </td>     
			      </tr>
			      <tr>  
								<td class="blue">账号生成号码</td>
								<td  width="21%">
								<%/*diling update for 如果是ADSL宽带，去掉 v_type="0_9" ，可以输入@和数字，并且位数最多是18位。@2012/9/17 */%>
								
								<input type="text" value="<%=isPhone?activePhone:""%>" name="cfm_loginF" v_type="<%=vTypeFlag%>" maxlength="<%=maxLengthSM%>" class ="required" onblur="checkCfmLogin(this)">
								<font class="orange"><=<%=maxLengthSM_str%></font>
								</td>
								<td class="blue">宽带登陆账号</td>
								<td width="20%"> <input type="text" name="cfm_login"  id="cfm_login"  maxlength="25"  readOnly></td>
								<td class="blue"  width="8%">联系人</td>
								<td><input type="text" name="contactCustName" id="contactCustName" class="required" maxlength="15" value=""> <font class="orange">*</font>  </td>
			      </tr>
			      <tr>
								<td width="12%" class="blue"><div align="left">宽带账号密码</div></td>
								<td width="12%"><input name="cfmPwd" type="password" onKeyPress="return isKeyNumberdot(0)" class="button"  maxlength="8" onFocus="showNumberDialog(document.all.cfmPwd) " pwdlength="8"><font class="orange">*</font> </td>
								<td width="12%" class="blue"><div align="left">宽带账号密码校验</div></td>
								<td width="12%" colspan="3"><input  name="cfmPwdConfirm" type="password" onKeyPress="return isKeyNumberdot(0)"  class="button" prefield="cfmPwd" filedtype="pwd" maxlength="8" onFocus="showReNumberDialog(document.all.cfmPwdConfirm)" pwdlength="8"><font class="orange">*宽带登陆密码默认为登录账号后6位</font> </td>
								
						</tr>
						<tr>
						<td class="blue" width="8%">联系电话</td>
								<td colspan="7"><input type="text" name="contactPhone" id="contactPhone" class="required andCellphone" value=""> <font class="orange">*</font> </td>
						</tr>
			      <tr>
			        <td class="blue">安装地址</td>
			        <td colspan="3"><input type="text" name="enter_addr" id="enter_addr" size=80 value="" maxlength="100"><font class="orange">*</font></td>
			        <td class="blue" data-bind="visible:smCode()=='ke'">集团编号</td>
			        <td data-bind="visible:smCode()=='ke'">
			        	<input type="text" name="unitId" id="unitId" 
			        	 maxlength="10" v_type="0_9" onblur = "checkElement(this)" />
			        </td>
			      </tr>  
			      <tr>
			        <td class="blue">小区名称</td>
			        <td> 	
			        	<input type="text"  name="area_nameh"  readonly >   	
			        </td>
			      	<td class="blue">电信局名称</td>
			      	<td>
			      		<input type="text" name="cctName"   readonly>
			      	</td>
			        <td class="blue">接入方式</td>
			        <td><input type="text" name="enter_type" maxlength="25" size=20 value=""  readonly></td>       
			     	</tr>
			      <tr>
					<tr>
						<td class="blue">合作方名称</td>
			        	<td colspan='5' >
			        		<input type="text" name="partnerName" maxlength="25" 
			        			size=20  readonly class='InputGrey'></td>       
			     	</tr>
			     	
			     	<% if("ki".equals(sm_Code)){%>
			     	<tr>
								<td class="blue">宽带终端</td>
			        	<td>
			        		<select name = "kdZd" id="kdZd" onchange="kdzdchange();showSN();">
			        			<option value="ONT">ONT</option>
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue" id="fysqfsdisplay1">费用收取方式</td>
			        	<td id="fysqfsdisplay2">
			        		<select id ="fysqfs" name = "fysqfs" onchange="FEEsqfs();showSN();">
			        			<option value="0">押金</option>
			        			<option value="1">销售</option>	
			        			<option value="2">自备</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	
			        	<td class="blue">宽带终端费用</td>
			        	<td id="kdzdfydisplay" >
			        		<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must ="0" v_type="money" class='forMoney required'/>
			        		<font class="orange">*</font><span style="display:none" id="yjfwxianshi">押金范围50-200元</span>       
			        	</td> 
			        	
			     	</tr>
			     	<tr>
						<td class="blue" id="sntitletd">S/N码</td>
			        	<td id="sntexttd">
			        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="50" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
			        	</td>
			        	<td class="blue">开户方式</td>
			        	<td>
			        		<select id ="openkdFlag" name = "openkdFlag" onchange="checkOpenkdFlag1()">
			        			<option value="7">普通宽带</option>
				        		<option value="8">高校宽带</option>
			        		<select>
			        		<font class="orange">*</font>
			        	</td>
			        	<td></td>
			        	<td></td>
			     	</tr>
			     	
			     	<%}%>
			     	
			     	<!-- 2014/09/05 10:20:57 gaopeng 宽带资费展现及终端管理等七项系统支撑优化需求  -->
			     	<% if("kf".equals(sm_Code)){%>
			     	<tr>
								<td class="blue">宽带终端</td>
			        	<td>
			        		<select name = "kdZd" id="kdZd" onchange="kdzdchange();showSN();">
			        			<option value="ONT">ONT</option>
			        			<option value="CPE">CPE</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue" id="fysqfsdisplay1">费用收取方式</td>
			        	<td id="fysqfsdisplay2">
			        		<select id ="fysqfs" name = "fysqfs" onchange="FEEsqfs();showSN();">
			        			<option value="0">押金</option>
			        			<!-- <option value="1">销售</option> -->
			        			<option value="2">自备</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	
			        	<td class="blue">宽带终端费用</td>
			        	<td id="kdzdfydisplay" >
			        		<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must ="0" v_type="money" class='forMoney required'/>
			        		<font class="orange">*</font><span style="display:none" id="yjfwxianshi">押金范围50-200元</span>       
			        	</td> 
			        	
			     	</tr>
			     	<tr>
						<td class="blue" id="sntitletd">S/N码</td>
			        	<td id="sntexttd">
			        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="50" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
			        	</td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			     	</tr>
			     	<tr>
			     		<td class="blue" >开户方式</td>
			        	<td>
			        		<select id ="openkdFlag" name = "openkdFlag" onchange="checkOpenkdFlag()">
			        			<%if(!"52914".equals(offerId)){
			        				%><option value="0">正常开户</option>
				        			<option value="1">光改迁移(kh->kf)</option>
				        			<option value="2">协同迁移(kd->kf)</option>
				        			<option value="4">铁通既有(ADSL/XDSL)</option>
				        			<option value="5">铁通既有(FTTH/FTTB)</option><%
			        			} %>
								<%if("52914".equals(offerId)){
			        			%><option value="3">校园开户</option><%
								} %>
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue" >是否安装IMS固话</td>
			        	<td>
			        		<select id="anzhuangFangshi" name="anzhuangFangshi">
			        			<option value="" selected="selected">-请选择-</option>
								<option value="00">是</option>
								<!-- <option value="01">加装</option> -->
								<option value="02">否</option>
							</select>
							<font class="orange">*&nbsp;&nbsp;如果宽带开户和IMS固话开户一起办理，则选择”是“</font>
			        	</td>
			        	<td class="blue" id="yuankuandaiTd1">原宽带账号</td>
			        	<td id="yuankuandaiTd2">
			        		<input type="text" id="yuankuandaiNum" name="yuankuandaiNum" v_must="0" onblur="go_checkYuanzhanghao()">
			        		<font class="orange">*</font>
			        	</td>
			     	</tr>
		     		<tr>
							<td class="blue">是否安装魔百合</td>
		        	<td colspan = "3">
		        		<select id="ifMBH" name = "ifMBH" onchange="ifMBHShow();">
		        			<option value="0" selected>否</option>	
		        			<option value="1" >是</option>
		        		<select>
		        			<font class="orange">*</font>
		        			<font class="red">如果宽带开户和魔百和营销案一起办理，请选择“是”，否则请选择“否”</font>
		        	</td>
		        	<td></td><td></td>
			     	</tr>
			     	<tr id="ifMBH_show" style="display:none">
			     		<td class="blue" style="display:none">有线电视</td>
		        	<td style="display:none">
		        		<select name = "yxds" onchange="yxdsShow();">
		        			<option value="百事通" >百事通</option>
		        			<option value="未来电视">未来电视</option>	
		        		<select>
		        			<font class="orange">*</font>
		        	</td>
		        	<td class="blue">机顶盒ID</td>
		        	<td colspan="3">
		        		<input type="text" name="jdhId" size="60"  id="jdhId" value="" v_must ="0" maxlength="32" />
		        		<font class="orange">*</font>      
		        	</td> 
			     	</tr>
			     	
			     	<%}%>
			     	<!-- 2016/4/5 15:12:35  gaopeng  -->
			     	<% if("kd".equals(sm_Code)){%>
			     	<tr>
							<td class="blue">是否安装魔百合</td>
		        	<td colspan = "3">
		        		<select name = "ifMBH" onchange="ifMBHShow();">
		        			<option value="0" selected>否</option>	
		        			<option value="1" >是</option>
		        		<select>
		        			<font class="orange">* 如果宽带开户和魔百和营销案一起办理，请选择“是”，否则请选择“否”</font>
		        	</td>
			     	</tr>
			     	<tr id="ifMBH_show" style="display:none">
			     		<td class="blue" style="display:none">有线电视</td>
		        	<td style="display:none">
		        		<select name = "yxds" onchange="yxdsShow();">
		        			<option value="百事通" >百事通</option>
		        			<option value="未来电视">未来电视</option>	
		        		<select>
		        			<font class="orange">*</font>
		        	</td>
		        	<td class="blue">机顶盒ID</td>
		        	<td colspan="3">
		        		<input type="text" name="jdhId" size="60"  id="jdhId" value="" v_must ="0" maxlength="32" />
		        		<font class="orange">*</font>      
		        	</td> 
			     	</tr>
			     	<%}%>
			      <tr>
			        <td class="blue">施工要求</td>
			        <td colspan=3>
			        	<%if(!ifHappyMoreThan50M){
			        		%>
			        		<select name="construct_request">
				        		<option value="HGU光猫非Wi-Fi" selected>HGU光猫非Wi-Fi</option>
				        		<option value="SFU光猫">SFU光猫</option>
				        		<option value="用户自备光猫">用户自备光猫</option>
			        		</select>
			        		<%
			        	}else{
			        	%>
			        	<select name="construct_request">
			        		<option value="HGU光猫Wi-Fi" selected>HGU光猫Wi-Fi</option>
			        		<option value="SFU光猫">SFU光猫</option>
			        		<option value="用户自备光猫">用户自备光猫</option>
			        	</select>
			        	<%	
			        	}
			        	%>
			        </td> 
			        <td class="blue">施工单派发时间</td>
				      <td><input type="text" name="appointvTime"  maxlength="8" id="appointvTime"  v_format="yyyyMMdd" class="required" value=""><font class="orange">(格式YYYYMMDD)</font><br/><font class="red">此时间请与用户确认后填写</font></td>	
			      </tr>  
					  <tr>
					   	<td class="blue">用户号码</td>
					    <td><input readonly type="text" name="phoneNo_h" size="20" maxlength="20" >
					    <input type="hidden" name="cust_attr" value="0">
					    </td>
              <%if(is68flag.equals("yes")) {%>
					    <td class="blue">
					    	<div style="display:none">
					    		<input type="checkbox" id="joinMarket" name="joinMarket"
					    		data-bind="checked:useMarket"/>
					    	</div>
                参与营销案
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept" name="marketAccept"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo" name="marketPhoneNo" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="校验" onclick="marketCheckFunc68()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <!-- 2013/07/24 9:58:30 gaopeng  加入一个参与营销案的状态 1为打折宽带，0为0元资费的宽带。 -->
                 <input type="hidden" id="joinType" name="joinType" value="1"/>
              </td>
              <%}else if(isSSflag.equals("yes") && isSS2flag.equals("yes")){ %>
              <td class="blue">
					    	<div style="display:none">
					    		<input type="checkbox" id="joinMarket" name="joinMarket"
					    		data-bind="checked:useMarket"/>
					    	</div>
                参与营销案
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept" name="marketAccept"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo" name="marketPhoneNo" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="校验" onclick="marketCheckFunc68()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <!-- 2013/07/24 9:58:30 gaopeng  加入一个参与营销案的状态 1为打折宽带(或铁通自然月宽带)，0为0元资费的宽带。 -->
                 <input type="hidden" id="joinType" name="joinType" value="1"/>
              </td>
              <%}
              
              else if(is0flag.equals("yes")) {
                 
              %>
                <td class="blue">
                <div style="display:none">
                  <input type="checkbox" id="joinMarket" name="joinMarket"
                  data-bind="checked:useMarket"/>
                </div>
                参与营销案
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept" name="marketAccept"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo" name="marketPhoneNo" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="校验" onclick="marketCheckFunc()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <input type="hidden" id="joinType" name="joinType" value="0"/>
              </td>
              <%
              }else if(!is58_88flag.equals("0")) {
                 
              %>
                <td class="blue">
                <div style="display:none">
                  <input type="checkbox" id="joinMarket58_88" name="joinMarket58_88"
                  data-bind="checked:useMarket"/>
                </div>
                参与营销案
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept58_88" name="marketAccept58_88"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo_58_88" name="marketPhoneNo_58_88" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="校验" onclick="marketCheckFunc58_88()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <input type="hidden" id="joinType" name="joinType" value="0"/>
              </td>
              <%
              }%>
              
          </tr>
          <!--2015/04/14 14:16:50 gaopeng 关于在CRM增加手机积分兑换宽带产品功能的需求 新增是否使用积分的公共页面 
          	如果band_id为67 也就是smcode为kf 并且为ynkb也就是包年资费的时候，展示以下信息
          -->
          <%if("yes".equals(ifUseIntegFlag)){%>
          	<%@include file="/npage/public/integralInfo.jsp"%>
          <%}%>
        </table>

				<div class="input" id="productInfo">
						<br>
						<div class="title">
						<div id="title_zi">产品信息</div>
			 		  </div>

						<div id="majorProdRel"></div> 

						<div id="prodAttribute"></div> <!--产品属性-->

						<table cellSpacing=0 id="tab_addprod" style="display:none">
						  <tr> 
						  </tr>
						</table>
				</div>

				<%@ include file="/npage/common/qcommon/bd_0007.jsp" %>	<!--sys_note op_note-->

				<div id="people_info">
						<div class=input>
							<table cellSpacing=0>
								<tr>
									<td class="blue">
										<input type="checkbox" value="5" name="contact_type" v_div="vouch" onclick="check_o(this)">担保人&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="servsla_info" v_div="servsla" onclick="check_o(this)">服务SLA信息&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>	
						</table>
						</div>

						<div id="vouch" style="display:none">
						    <%@ include file="/npage/common/qcommon/bd_0008.jsp" %>
						</div>
						<div id="servsla" style="display:none">
						    <%@ include file="/npage/common/qcommon/bd_0019.jsp" %>
						</div> 
				</div>

		</div>
</DIV> 

<!-- 基本销售品 结束-->
<!-- 附加销售品 开始-->
<DIV class="undis" id="tbc_02" style="display:none">
	
		<div class="title">
		<div id="title_zi">附加销售品</div>
	  </div>
	  <table cellSpacing=0 id="adddiscount">
	  </table>
		<div id="offer_component"></div> 
		<div id="div_offerComponent"></div> 

</DIV>
<!-- 附加销售品 结束-->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=sysAcceptl%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table cellSpacing=0>
	<tr id="footer">
				<td align="center"> 
						<INPUT class=b_foot_long id="cfmBtn" onClick="mySub()" type=button value=确定&打印 />
						<INPUT class=b_foot_long id="cfmOffer" onClick="cfmOfferf()" type=button value=销售品选择确认  style="display:none" />
						<INPUT class=b_foot onclick="ignoreThis()" type=button value=忽略> 
						<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=取消> 
			  </td>
	</tr>
</table>
<input type="hidden" name="offerId" value="<%=offerId%>" />
<input type="hidden" name="majorProductId"/>
<input type="hidden" name="assureId" value="0"/><!--客户担保人标识-->
<input type="hidden" name="assureNum" value="0"/><!--已担保人数量-->
<input type="hidden" name="custOrderId" value="<%=custOrderId%>"/>
<input type="hidden" name="orderArrayId" value="<%=orderArrayId%>"/>
<input type="hidden" name="servOrderId" value="<%=servOrderId%>"/>
<input type="hidden" name="servBusiId" value="<%=servBusiId%>"/>
<input type="hidden" name="gCustId" value="<%=gCustId%>"/>
<input type="hidden" name="opCode" value="<%=opCode%>"/>
<input type="hidden" name="opName" value="<%=opName%>"/>
<!--<input type="hidden" name="addrId" value="" />-->
<input type="hidden" name="brandId" value="<%=brandID%>" />
<input type="hidden" name="offerType" value="<%=offerType%>" />
<input type="hidden" name="prtFlag" value="<%=prtFlag%>"/>
<input type="hidden" name="regionCode" value="<%=regionCode%>"/>
<input type="hidden" name="mastServerType" id="mastServerType" />
<input type="hidden" name="serviceType" id="serviceType" />
<input type="hidden" name="printAccept" id="printAccept" />
<!--<input type="hidden" name="selByWay" id="selByWay" />-->
<input type="hidden" name="innetType" id="innetType" />
<input type="hidden" name="workNo" value="<%=workNo%>"/>
<input type="hidden" name="closeId" value="<%=closeId%>"/>
<input type="hidden" name="newSmCode" id="newSmCode" value="<%=sm_Code%>"/>
<input type="hidden" name="unitIdFlag" id="unitIdFlag" value="1"/>
<!--销售品信息-->
<input type="hidden" name="offerIdArr"/>
<input type="hidden" name="offerEffectTime"/>
<input type="hidden" name="offerExpireTime"/>
<!--产品信息-->
<input type="hidden" name="sonParentArr"/>
<input type="hidden" name="productIdArr" />
<input type="hidden" name="prodEffectDate"/>
<input type="hidden" name="prodExpireDate"/>
<input type="hidden" name="isMainProduct"/>
<input type="hidden" name="offer_productAttrInfo"/><!--属性信息-->

<!--群组信息-->
<input type="hidden" name="groupInstBaseInfo"/>
<input type="hidden" name="addGroupIdArr"/><!--组合产品过来的可选群组-->

<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>" /> <!--流水-->

<input type="hidden" name="groutDesc" id="groutDesc" value="" />
<input type="hidden" name="offId" id="offId" value="<%=offerId%>" /><!--宽带属性查询参数-->

<input type="hidden" name="newZOfferECode"/>
<input type="hidden" name="newZOfferDesc"/>                         
<input type="hidden" name="dOfferId"/>
<input type="hidden" name="dOfferName"/>
<input type="hidden" name="dECode"/>
<input type="hidden" name="dOfferDesc"/>
<input type="hidden" name="path"/> 

<input type="hidden" name= "largess_card_sum" value="<%=strCardSum%>"> <!-- 入网赠送充值卡的数量级-->
<!--<input type="hidden" name="groupId" value="<%=groupId%>"/>-->

<input type="hidden" id="work_flow_no" name="work_flow_no" value="<%=work_flow_no%>"/>
<input type="hidden" id="level4100" name="level4100" value="<%=level4100%>"/>
<input type="hidden" id="transJf" name="transJf" value="<%=transJf%>"/>
<input type="hidden" id="transXyd" name="transXyd" value="<%=transXyd%>"/>
<!--<input type="hidden" name="smCodeh"  value="kd"/>-->
<!--预占资源信息-->
<input type="hidden" name="area_codeh"  value=""/> 
<input type="hidden" name="areaAddr"  value=""/>
<input type="hidden" name="bandWidth"  value="<%=bandWidth%>"  >
<input type="hidden" name="bandWidthMsg"  value="<%=bandWidthMsg%>"  >
<input type="hidden"  name="standardContent"  value="" >
<input type="hidden"  name="standardCode" value="" >

<input type="hidden" name="deviceType"  value=""/>
<input type="hidden" name="deviceCode"  value=""/>
<input type="hidden" name="model"  value=""/>
<input type="hidden" name="factory"  value=""/>
<input type="hidden" name="ipAddress"  value=""/>
<input type="hidden" name="deviceInAddress"  value=""/>
<input type="hidden" name="portType"  value=""/>
<input type="hidden" name="portCode"  value=""/>
<input type="hidden" name="cctId"   value="" >
<input type="hidden" name="partnerCode"   value="" >
<input type="hidden" name="belongCategory" value=""><!--归属类别 2014/04/03 11:10:26 gaopeng-->
<input type="hidden" name="bearType" value=""><!--承载方式 2014/04/03 11:10:28 gaopeng-->
<input type="hidden" name="propertyUnit" value=""><!--小区建设性质 2014/5/29 15:31:14-->
<input type="hidden" name="distKdCode" value=""><!--小区编码 2014/5/29 15:27:10-->
<input type="hidden" name="nearInfo" value=""><!--小区接入情况 2014/5/29 15:27:10-->
<input type="hidden" name="cfmPwdEncrypt" id="cfmPwdEncrypt" />
<input type="hidden" name="cfmPwdEncryptFlag" id="cfmPwdEncryptFlag" value="0" />
<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" >
<input type="hidden"  id="cfmLoginCheck" name="cfmLoginCheck"  value="0" >
<input type="hidden"  id="isYzPhoneNo" name="isYzPhoneNo"  value="0" >
<input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
<input type="hidden"  id="noPort" name="noPort"  value="0" >
<!---- 是否需要预占    0不需要     1需要 --->
<input type="hidden"  id="isNeedHold" name="isNeedHold"  value="<%=isNeedHold%>" >
<!--资源所属所属地市-->
 
<input type="hidden" name="regionId"  value=""/>

<input type="hidden" name="ipAddType"  value="<%=ipAddType%>"/>


<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
<frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
</DIV>
</BODY>
<script language="javascript">
	var viewModel = {
		smCode:ko.observable("<%=sm_Code%>"),
		useMarket:ko.observable(true),
		marketCheck:ko.observable(false)
	}
	ko.applyBindings(viewModel);
</script>
<%@ include file="/npage/public/hwObject.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</HTML>
