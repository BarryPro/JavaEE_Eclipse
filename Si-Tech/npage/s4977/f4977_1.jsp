   <%
	/**
	 * Title: ��Ʒ��װ
	 * Description: �����Ʒ��װ
	 * Copyright: Copyright (c) 2009/01/10
	 * Company: SI-TECH
	 * author��
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
     * ��������������������
     */
    public static Date addMonthPub(Date date, int n) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, n);
        return cal.getTime();
    }
    
    /**
     * ʹ�ò���Format��ʽ��Date���ַ���
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
    
    /*��ȡ��ǰʱ��*/
    Date nowTime = new Date();
    /*��ǰʱ������12����*/
    Date addMonthT = addMonthPub(nowTime,12);
    /*����12����֮��Ľ���*/
    String addMonthTStr = formatPub(addMonthT,"yyyyMMdd");
    
    
    System.out.println("### gaopengSeeLog4977====addMonthTStr== = "+addMonthTStr);
    System.out.println("### addThreeMonth = "+addThreeMonth);
    
    String workNo = (String)session.getAttribute("workNo");
    String nopass = (String) session.getAttribute("password");/*����Ա����*/
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
    
		String svcInstId = WtcUtil.repNull(request.getParameter("offerSrvId"));/*����Ʒʵ��*/    
		String prefix = "";
		String domainName = ""; 
		String userRegionName="";
		String user_type="";
		String ipAddType="";
		String bandWidth="";
		/* ƴ�ӱ����� */
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
    //2013/07/11 9:33:40 gaopeng ����Э���������������˾���ն˴��۹����Ӫ�������ĺ� start ��ѯ sDisBandOfferDic ���� offer_id�����ݣ�����������ݣ���У��Ӫ������ˮ�ķ���ΪsBandSaleChk
    String[] inParamsss2 = new String[2];
    /*
    inParamsss2[0] = "select count(1) from product_offer_attr  where offer_id = :bofferid  and offer_attr_seq in ('80009','80010')";//���ӿ��ϵͳ��ֵ����80010 hejwa(shiyong) add 
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
    
    /*2014/12/23 13:51:48 gaopeng ���������Ŀ �����µ��ʷ����� ��ͨ�����Ȼ���ʷѣ�����Ӫ������*/
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
    String notessss="����"+workNo+"��custid="+gCustId+"���в�ѯ";
    
    String[] inParamsss6 = new String[2];
    inParamsss6[0] = "SELECT count(1) FROM product_offer WHERE offer_id = :bofferid and offer_attr_type = 'YnKB'"; 
    inParamsss6[1] = "bofferid="+offerId;
    String isSS6flag="";
    

  System.out.println("0yuan======================"+inParamsss1[0]+"---iofferid----"+inParamsss1[1]);
  System.out.println("6�ۻ�8���ʷ�==========gaopeng2013/07/11 9:37:20============"+inParamsss2[0]+"---iofferid----"+inParamsss2[1]+"---offer_attr_seq---");
  System.out.println("���������Ŀ ��ͨ�����Ȼ���ʷ�==========gaopeng2014/12/23 13:52:29============"+inParamsss3[0]+"---iofferid----"+inParamsss3[1]+"---offer_attr_seq---");

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
		rdShowMessageDialog( "У������������:<%=rcssss%>��������Ϣ:<%=rmssss%>");
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
	 /*2016/4/12 15:16:01 gaopeng 0Ԫ�İ����ʷѲ�����Ӫ������ˮУ���� ԭ���������ǽ��� is0flag="true";*/
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
  /*����0��ʱ��*/
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
  /*����0��ʱ��*/
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


	
<!-- 2016/8/5 9:22:39 gaopeng ����Э������HGU�͹�è����ͻ��ṩ����ϵͳ����ĺ� 
	�Ƿ��Ǽ�ͥ����Ϳ������50M���û���У�����
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
 
 	
<!--��ѯip��ַ���ͣ������û����ͣ�����˺����ɹ���,�������ƣ�����Ʒ���ƣ�����ƷʧЧƫ����������ƷʧЧƫ�Ƶ�λ-->		
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
	System.out.println("��ǰʱ����  "+dateStr2);
	String currTime = new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new Date());
	//String sqlStr="";
%>
<!--��ѯ����Ʒ��Ϣ-->
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
<!--��Ʒ��Ⱥ����Ϣ-->
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
<!--��ѯ�����������Ϣ-->
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

<!-- ������Ϳ�����-->
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
   	  rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode2%><br>������Ϣ:<%=retMsg2%>");
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
<!--�����ˮ��-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 	
<%
System.out.println("-----------------------sysAcceptl---------------------------"+sysAcceptl);
%>	
<!--���smcode�Ϳͻ���ַ��֤��������Ϣ-->
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
  	<!-- 2013/07/23 14:12:23 gaopeng ����BOSSϵͳ��ѯ�ͻ�������ع����Ż�������  -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCodeGetCust" retmsg="errMsgGetCust"  outnum="40" >
      <wtc:param value="<%=sysAcceptl%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=nopass%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="����cust_id:[<%=gCustId%>]���в�ѯ"/>
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


String beizhussss=workNo+"���й��ź�Ʒ���Ƿ������У�飬Ʒ��"+sm_Code;
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
		rdShowMessageDialog( "У��ʧ�ܣ��������:<%=rcssss111%>��������Ϣ:<%=rmssss111%>");
		removeCurrentTab();
	</script>
<%
}






	/****
		ningtn 2012-6-20 09:52:34
		ADSL�������
		�����ADSL������˺����ɺ��볤�ȸ�Ϊ12λ
		ADSL����ҪԤռ
		diling update @ 2012/9/17 9:55:33
		�����ADSL������˺����ɺ��볤�ȸ�Ϊ18λ
		��������@������
		������ʾ����ʾΪ "<=18λ"
	*/
	String maxLengthSM = "11";
	String isNeedHold = "1";
	String vTypeFlag="0_9";
	String maxLengthSM_str = maxLengthSM+"λ����";
	/* 
   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
   * ����ʡ���kg������Ʒ��kh
   * houxuefengҪ��kf  kgֻ�������֣�kh���ֲ��䡣2014/11/4 13:36:10   ����kiƷ�ƺ�kfһ��--20160218
   */
  /*
   * update ͳһ�淶�˺��������� for ����Э���޸Ŀ���˺ű������Ϳ��Ͷ�ߴ���ʱ�޵ĺ�@2015/4/13 
	 *	�ƶ���� ���˺ű�������޸�Ϊyd+��11��12��λ���֣�--kf
	 *	�ƶ���������������˺ű�������޸�Ϊyd+��11��12��λ���� --kg
	 *	������� ���˺ű�������޸�Ϊysbn+��11��12��λ���֣� --ke 
	 *	�й��ƶ���ͨ��� ���˺ű�������޸�Ϊttkd+��11��12��λ���֣� --kd
	 *	��ͨ������˺ű�������޸�Ϊkdz+��11��16��λ���֣� --kh
   */
	if("kf".equals(sm_Code) || "kg".equals(sm_Code) || "ki".equals(sm_Code)){
		maxLengthSM = "12"; 
		maxLengthSM_str = maxLengthSM+">=11λ";
		isNeedHold = "1";
	}
	/*2014/11/21 10:32:26 gaopeng khƷ�Ƹ�Ϊ��ͨ�Խ� ��kdһ�����淨*/
	else if("kh".equals(sm_Code)){ //��ͨ���
		//maxLengthSM = "11"; 
		//maxLengthSM_str = maxLengthSM+"λ����";
		maxLengthSM = "16"; 
		maxLengthSM_str = maxLengthSM+">=11λ";
		vTypeFlag = "0_9";
		isNeedHold = "0";
	}
	else if("ke".equals(sm_Code)){
		maxLengthSM = "12"; 
		maxLengthSM_str = maxLengthSM+">=11λ";
  	isNeedHold = "0";
  }
  else if("kd".equals(sm_Code)){
		maxLengthSM = "12"; 
		maxLengthSM_str = maxLengthSM+">=11λ";
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

<!--���css��ʽ�����������л���ǩ����ʽ,,,����и��õ��л���ǩ���滻,,,��ɾ�������ʽ,��Ӱ��ҳ����������-->
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
<!-- ����Ʒ��ϸ����ʽ -->
<SCRIPT language=JavaScript>
var masterServId = "";
var offerId = "<%=offerId%>";	//����ƷID
var offerNodes;
var nodesHash = new Object(); //����IDȡ����Ʒ ��Ʒ�ڵ�
var groupHash = new Object(); //����ƷId=Ⱥ����Ϣ����Ⱥ����Ϣ�鿴����
var offerGroupHash = new Object(); //����ƷId=Ⱥ����Ϣ�ύ����
var AttributeHash = new Object(); //����Ʒ/��ƷId=������Ϣ
var prodCompIdArray = [];									//���Ӳ�Ʒ������Ϣ
var KDTypeId = "0";
var snShow="0";
//-----����Ʒ,��Ʒ����˵��----
var prodType = "O";
var majorProdType = "M";
var offerType = "10C";

var isOfferLoaded = false;  //�Ƿ��Ѿ���������Ʒ������ϸ
var hasProdCompInfo=false;//�Ƿ��и��Ӳ�Ʒ��־
//-----����Ʒ��ѡ��ʽ---------
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
			rdShowMessageDialog("�ͻ�ID�쳣,����ϵ����Ա!");
			window.close();	
		}	
		
		if("<%=opCode%>" == "4977" ){ //4977�������ʱ�ж�֤������
		//�жϵ�ǰ�ͻ�֤�������Ƿ�Ϊ����λ�ͻ����µ�֤������
		var isExitCustFlag = "N";
		var userIdType = "";
		var myPacket = new AJAXPacket("/npage/portal/shoppingCar/ajax_isExitForCust.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	  myPacket.data.add("g_CustId","<%=gCustId%>"); 
	  myPacket.data.add("opCode","<%=opCode%>");
	  core.ajax.sendPacket(myPacket,function(packet){
	  	var retCode=packet.data.findValueByName("retCode");
		  var retMsg=packet.data.findValueByName("retMsg");
		  var v_isExitCustFlag=packet.data.findValueByName("isExitCustFlag"); //��ǰ�ͻ��£��û��Ƿ����
		  var v_userIdType=packet.data.findValueByName("userIdType"); //��ǰ�ͻ��£��û��Ƿ����
		  if(retCode == "000000"){
		  	isExitCustFlag = v_isExitCustFlag;
		  	userIdType = v_userIdType;
		  	//alert(userIdType);
		  	//userIdType = "8";
		  	iccidtypequery=v_userIdType;
		 	}else{
		 		rdShowMessageDialog("��ѯ�˿ͻ��Ƿ�����û���Ϣʧ�ܣ��������:<%=retCode%><br>������Ϣ:<%=retMsg%>��",0);
				return  false;
		 	}
	  });
	  myPacket = null;	
	  //��Ϊ��λ�ͻ���ʵ��ʹ���������Ϣ���֤�����ͼ���Ӫҵִ�ա���֯�������롢��λ����֤��ͽ�����
	  if(userIdType == "8" || userIdType == "A" || userIdType == "B" || userIdType == "C"){ 
			$("#userType1").val("��λ");
			$("#realUserInfo1").show();
			$("#realUserInfo2").show();
			$("#realUserInfo1").find("td:eq(3)").attr("colSpan","3");
			$("#realUserInfo2").find("td:eq(3)").attr("colSpan","3");
			/*ʵ��ʹ��������*/
	  	document.all.realUserName.v_must = "1";
	  	/*��ʵ��ʹ���˵�ַ*/
	  	document.all.realUserAddr.v_must = "1";
	  	/*ʵ��ʹ����֤������*/
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
			rdShowMessageDialog("ȡ����Ʒѡ��ʽ�쳣!");
			//window.close();		
		}

		//����ϲ�Ʒ�н���Ⱥ�������һ��Ʒ��װ��
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
			$("#td_offerName").append("<input name='"+"<%=offerName%>"+"' type='button' onclick=\"showGroup('<%=offerId%>','<%=offerName%>','<%=groupTypeId%>')\"  value='Ⱥ��' id='group_"+"<%=offerId%>"+"' _groupId='"+"<%=groupTypeId%>"+"' class='b_text but_groups' />");
			//$("#td_offerName :button[id^='group']").bind('click',showGroup);
		}
		 
		if(typeof(offerId) != "undefined" && offerId != ""){
			$("#div_offerComponent").append("<div id='offer_"+offerId+"'></div>"); //��������Ʒ����չʾ����
			getMajorProd();
			getOfferAttr();
			getOfferDetail();
  	  getOfferRel();
		}

		getMidPrompt("10442","<%=offerId%>","td_offerName");
		buttonShow();
		$("select:visible").attr("style","width:130px");
		Pz.busi.operBusi($('#tab_addprod input'),'groupTitle',true,3);
		/*����ǹ��������ke��������ԴԤռ��������ʾ*/
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

//ʵ��ʹ����֤�����͸ı�
function valiRealUserIdTypes(idtypeVal){
	if(idtypeVal.indexOf("0") != -1||idtypeVal.indexOf("D") != -1){ //���֤
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


/*1���ͻ����ơ���ϵ������ У�鷽�� objType 0 ����ͻ�����У�� 1������ϵ������У��  ifConnect �����Ƿ�������ֵ(���ȷ�ϰ�ťʱ��������������ֵ)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserName.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "�ͻ�����";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "��ϵ������";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� ���뾭��������*/
	if(objType == 2){
		objName = "����������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "ʵ��ʹ��������";
		/*�����վ�����֤������*/
		idTypeVal = document.all.realUserIdType.value;
	}
	
	idTypeVal = $.trim(idTypeVal);
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal;
		
		/*����ʱ�����������Ķ�����*/
		if(objValue.indexOf("��ʱ") != -1 || objValue.indexOf("����") != -1){
					rdShowMessageDialog(objName+"���ܴ��С���ʱ���򡮴��졯������");
					
					nextFlag = false;
					return false;
			
		}
		
		/*�ͻ����ơ���ϵ��������Ҫ�󡰴��ڵ���2�����ĺ��֡�����������ճ��⣨��������տͻ����Ʊ������3���ַ�����ȫΪ����������)*/
		
		/*����������������*/
		if(idTypeText != "6"){
			/*ԭ�е�ҵ���߼�У�� ֻ������Ӣ�ġ����֡����ġ����ġ����ġ���������һ�����ԣ�*/
			
			/*2014/08/27 16:14:22 gaopeng ���ֹ�˾�����Ż������������Ƶ���ʾ Ҫ��λ�ͻ�ʱ���ͻ����ƿ�����дӢ�Ĵ�Сд��� Ŀǰ�ȸ�ɸ� idTypeText == "3" || idTypeText == "9" һ�����߼� �������ʿɲ�����*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"������ڵ���2�����֣�");
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
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog(objName+"ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
            		rdShowMessageDialog(objName+"ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*��ȡ�������ĺ��ֵĸ����Լ�'()����'�ĸ���*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^��|\.|\��*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//�ֱ��ȡ��������
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*��У������*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*���ŵ�����+���ֵ����� != ������ʱ ��ʾ������Ϣ(������Ҫע��һ�㣬��������Ҳ�����ġ�������������ֻ����Ӣ�����ŵ�ƥ������������ƥ����)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"�����������Ļ����������ŵ����(���ſ���Ϊ���Ļ�Ӣ�����š�()������)��");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"������ڵ���2�����ĺ��֣�");
							
							nextFlag = false;
							return false;
						}
					}
					/*ԭ���߼�
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"�������6�����֣�");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*�������������� У�� ��������տͻ�����(�����������ϵ������Ҳͬ��(sunaj��ȷ��))�������3���ַ�����ȫΪ����������*/
		if(idTypeText == "6"){
			/*���У��ͻ�����*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"����ȫΪ����������!");
						/*��ֵΪ��*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"������������ַ�!");
						
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
            var code = objValue.charAt(i);//�ֱ��ȡ��������
            var key = checkNameStr(code); //У��
            if(key == undefined){
              rdShowMessageDialog(objName+"ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
            		rdShowMessageDialog(objName+"ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
	�ͻ���ַ��֤����ַ����ϵ�˵�ַУ�鷽��
	���ͻ���ַ������֤����ַ���͡���ϵ�˵�ַ�����衰���ڵ���8�����ĺ��֡�
	����������պ�̨��ͨ��֤���⣬���������Ҫ�����2�����֣�̨��ͨ��֤Ҫ�����3�����֣�
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
		objName = "֤����ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "�ͻ���ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "��ϵ�˵�ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "��ϵ��ͨѶ��ַ";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "��������ϵ��ַ";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "ʵ��ʹ������ϵ��ַ";
		idTypeVal = document.all.realUserIdType.value;
	}
		
	idTypeVal = $.trim(idTypeVal);
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal;
		
		/*��ȡ�������ĺ��ֵĸ���*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*����Ȳ������������ Ҳ����̨��ͨ��֤ */
		if(idTypeText != "6" && idTypeText != "5"){
			/*��������8�����ĺ���*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"���뺬������8�����ĺ��֣�");
				/*��ֵΪ��*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*��������� ����2������*/
	if(idTypeText == "6"){
		/*����2�����ĺ���*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"���뺬�д���2�����ĺ��֣�");
				
				nextFlag = false;
				return false;
			}
	}
	/*̨��ͨ��֤ ����3������*/
	if(idTypeText == "5"){
		/*��������3���ĺ���*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"���뺬�д���3�����ĺ��֣�");
				
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
	֤�����ͱ��ʱ��֤�������У�鷽��
*/

function checkIccIdFunc(obj,objType,ifConnect){
	var nextFlag = true;
	
	if(document.all.realUserIccId.v_must !="1") {
	  return nextFlag;
	  return false;		
	}
	
	
	var idTypeVal = "";
	if(objType == 0){
		var objName = "֤������";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "������֤������";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "ʵ��ʹ����֤������";
		idTypeVal = document.all.realUserIdType.value;
	}
	
	/*ֻ��Ը��˿ͻ�*/
	var opCode = "<%=opCode%>";
	/*��ȡ������ֵ*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*��ȡ�����ֵ�ĳ���*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* ��ȡ��ѡ���֤������ 
		0|���֤ 1|����֤ 2|���ڲ� 3|�۰�ͨ��֤ 
		4|����֤ 5|̨��ͨ��֤ 6|��������� 7|���� 
		8|Ӫҵִ�� 9|���� A|��֯�������� B|��λ����֤�� C|������ 
		*/
		
		/*��ȡ֤���������� */
		var idTypeText = idTypeVal;
		
		/*1�����֤�����ڱ�ʱ��֤�����볤��Ϊ18λ*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"������18λ��");
					
					nextFlag = false;
					return false;
			}
		}
		/*����֤ ����֤ ���������ʱ ֤��������ڵ���6λ�ַ�*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"������ڵ�����λ�ַ���");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ�۰�ͨ��֤�ģ�֤������Ϊ9λ��11λ��������λΪӢ����ĸ��H����M��(ֻ�����Ǵ�д)������λ��Ϊ���������֡�*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"������9λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"����ĸ�����ǡ�H����M����");
					
					nextFlag = false;
					return false;
			}
			/*��ȡ����ĸ֮���������Ϣ*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"������ĸ֮�⣬����λ�����ǰ��������֣�");
					
					nextFlag = false;
					return false;
			}
		}
		/*֤������Ϊ
			̨��ͨ��֤ 
			֤������ֻ����8λ��11λ
			֤������Ϊ11λʱǰ10λΪ���������֣�
			���һλΪУ����(Ӣ����ĸ���������֣���
			֤������Ϊ8λʱ����Ϊ����������
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"����Ϊ8λ��11λ��");
					
					nextFlag = false;
					return false;
			}
			/*8λʱ����Ϊ����������*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
			}
			/*11λʱ�����һλ������Ӣ����ĸ���������֣�ǰ10λ�����ǰ���������*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"ǰʮλ����Ϊ����������");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"��11λ����Ϊ���������ֻ�Ӣ����ĸ��");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*��֯������ ֤��������ڵ���9λ��Ϊ���֡���-�����д������ĸ*/
		if(idTypeText == "A"){
			var m = /^([0-9\-A-Z]*)$/;
			var flag = m.test(objValue);
			if(!flag){
					rdShowMessageDialog(objName+"���������֡���-�������д��ĸ��ɣ�");
					
					nextFlag = false;
					return false;
			}
			if(objValueLength < 9){
					rdShowMessageDialog(objName+"������ڵ���9λ��");
					
					nextFlag = false;
					return false;
				
			}
		}
		/*Ӫҵִ�� ֤�����������ڵ���4λ���֣����������纺�ֵ��ַ�Ҳ�Ϲ�*/
		if(idTypeText == "8"){
			var m = /^[0-9]+$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//�ֱ��ȡ��������
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum < 4){
					rdShowMessageDialog(objName+"��������4�����֣�");
					
					nextFlag = false;
					return false;
			}
			/*20131216 gaopeng ������BOSS�����������ӵ�λ�ͻ���������Ϣ�ĺ� �����е�֤������Ϊ��Ӫҵִ�ա�ʱ��Ҫ��֤�������λ��Ϊ15λ�ַ�*/
			if(objValueLength != 15){
					rdShowMessageDialog(objName+"����Ϊ15���ַ���");
					nextFlag = false;
					return false;
			}
		}
		/*����֤�� ֤��������ڵ���4λ�ַ�*/
		if(idTypeText == "B"){
			if(objValueLength < 4){
					rdShowMessageDialog(objName+"������ڵ���4λ��");
					
					nextFlag = false;
					return false;
			}
			
		}


	}else if(opCode == "1993"){

	}
	return nextFlag;
}


function forKuoHao(obj){ //�����������š�.�� �⼸�ָ���
	var m = /^(\(?\)?\��?\��?)\��|\.|\��+$/;
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
  		//showTip(obj,"�������뺺�֣�");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"�����д���");
  		return false;
  	}
  	return true;
  }
  
  //ƥ����26��Ӣ����ĸ��ɵ��ַ���
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"����Ϊ��ĸ��");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"�����д���");
  		return false;
  	}
  
  	return true;
  }
  
  
  function checkNameStr(code){
			/* gaopeng 2014/01/17 9:50:35 ����ƥ������ ��Ϊ���ſ���������Ҳ������Ӣ�ģ����ȷ���KH ��֤�߼���ʧ��*/
				if(forKuoHao(code)) return "KH";//����
		    if(forA2sssz1(code)) return "EH"; //Ӣ��
		    var re2 =new RegExp("[\u0400-\u052f]");
		    if(re2.test(code)) return "RU"; //����
		    var re3 =new RegExp("[\u00C0-\u00FF]");
		    if(re3.test(code)) return "FH"; //����
		    var re4 = new RegExp("[\u3040-\u30FF]");
		    var re5 = new RegExp("[\u31F0-\u31FF]");
		    if(re4.test(code)||re5.test(code)) return "JP"; //����
		    var re6 = new RegExp("[\u1100-\u31FF]");
		    var re7 = new RegExp("[\u1100-\u31FF]");
		    var re8 = new RegExp("[\uAC00-\uD7AF]");
		    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //����
		    if(forHanZi1(code)) return "CH"; //����
    
   }
/*2016/2/25 10:53:04 gaopeng 

end

*/



/*�������Ʒ*/
function getMajorProd()
{
	 	var packet1 = new AJAXPacket("../s1104/getMajorProd.jsp","���Ժ�...");
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
			rdShowMessageDialog("������Ʒû������Ʒ��Ϣ!");
			window.close();
			return false;	
		}
}
/*�������Ʒ����*/
function getOfferAttr()
{
		var packet1 = new AJAXPacket("../s1104/getOfferAttr.jsp","���Ժ�...");
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
/*��ø�������Ʒ������ϸ*/
function  getOfferDetail()
{
 		var packet = new AJAXPacket("../s1104/offerDetailQry_new.jsp","���ڼ��ظ�������Ʒ������ϸ�����Ժ�...");
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
		showInfo(offerNodes);		//��������Ʒ����չʾ
		
		for(var i=0;i<offerNodes.item.length;i++)
		  {
		  	if(offerNodes.item[i].getType() == "role"){
		  		offerRoleID+=offerNodes.item[i].getId()+"#";
				}
		  }	
		  
		trea("<%=blindAddCombo%>");
		initInfo(offerNodes);		//��ʼ������,��ѡ ��ѡ Ĭ��ѡ��	
		$("#div_offerComponent :checkbox").bind("click",fn);
		$("#div_offerComponent :button[id^='att']").bind('click', showAttribute);
		$("#div_offerComponent select").bind('change',setEffectTime);
		
		setShowHid();
	}
}
/*������������Ʒʱ�䣬���ڸú���û�д���*/
function setEffectTime()
{
	var addOfferId = this.id.substring(8);
	var effTime = nodesHash[addOfferId].begTime.substring(0,8);
	var expTime = nodesHash[addOfferId].expireTime.substring(0,8);
	if(this.value == 1){ //������Ч
		var spanType = "MM";
		var spanVal = 1;
		
		var newEffTime = setDateMove(effTime,spanType,spanVal,'yyyyMM')+"01";	//���������Чʱ��
		var newExpTime = setDateMove(expTime,spanType,spanVal,'yyyyMM')+"01";	//�������ʧЧʱ��
		
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
/*����Ʒ����������ϵ*/
function getOfferRel() 
{
	var packet2 = new AJAXPacket("../s1104/getOfferRel.jsp","���ڼ��ظ�������Ʒ����������ϵ,���Ժ�...");
	packet2.data.add("offerId" ,offerId);
	core.ajax.sendPacketHtml(packet2,doGetOfferRel,true);
	packet2 =null;
}
function doGetOfferRel(data)
{
	$("#offer_component").html(data);
	isOfferLoaded = true;
}
/*��������������*/
function getMasterServType(majorProductId)
{
	var packet1 = new AJAXPacket("../s1104/getMasterServType.jsp","���Ժ�...");
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
				$("#billModeCd").html("<option value='A'>Ԥ����</option>");
			}
			$("#mastServerType").val(mastServerType);
			$("#serviceType").val(serviceType);
		}
	}
	else{
		rdShowMessageDialog(error_msg);
	}		
}
/*�������Ʒ����*/
function  getProdAttr(majorProductId)
{
	var packet2 = new AJAXPacket("../s1104/getProdAttr.jsp","���Ժ�...");
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
/*��ø�����Ʒ��Ϣ*/
function getProdCompInfo(majorProductId)
{
	var packet3 = new AJAXPacket("../s1104/getProdCompDet.jsp","���Ժ�...");
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
			$("#tab_addprod tr").append("<td><div id='items'><div class='item-col2 col-1'><div id='compProdInfoDiv'></div></div><div class='item-row2 col-2'><div class='title'><div id='title_zi'>�Ѷ�����Ʒ��Ϣ</div></div><div id='pro_component'></div></div></div></td>");
			
			$("#pro_component").append("<div id='prod_"+offerId+"'></div>"); 
		  $("#prod_"+offerId).after("<div id='pro_"+offerId+"' ></div>");
		  $("#pro_"+offerId).append("<table id='tab_pro' cellspacing=0></table>");
		  $("#tab_pro").append("<tr><th>��Ʒ����</th><th>��ʼʱ��</th><th>����ʱ��</th><th>����</th></tr>");
			
			for(var i=0;i<prodCompInfo.length;i++){
				if(typeof(compRoleCdHash[prodCompInfo[i][3]]) == "undefined"){	//���ɽ�ɫ��
					$("#compProdInfoDiv").append("<div  name='compProdrole' id='"+prodCompInfo[i][3]+"' style='cursor:hand'><div class='title'><div id='title_zi'>���Ӳ�Ʒ</div></div></div><table cellspacing='0'><tr><td><div id='div_"+prodCompInfo[i][3]+"' style='font-family:\"����\";'></div></td></tr></table>");
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
						$("#compSpan_"+prodCompInfo[i][11]).append("<input type='button' name='prod_"+prodCompInfo[i][2]+"' value='����' id='att_"+prodCompInfo[i][11]+"' class='b_text' />");
					}
					if($("#div_"+prodCompInfo[i][3]+" span").length%3 == 0){	//�������
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
	$("#tab_addprod :checkbox").bind("click",checkProdRel);	//У�鸴�ϲ�Ʒ���ϵ
	$("#tab_addprod :button").bind("click",showAttribute);	//�趨���ϲ�Ʒ����
	
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
/*��ø�����Ʒ��ϵ*/
function getProdCompRel(majorProductId)
{
	var packet2 = new AJAXPacket("../s1104/getProdCompRel.jsp","���ڼ��ظ�����Ʒ��������ϵ,���Ժ�...");
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

function setShowHid(){    /*����Ʒ������ɺ� ������ʾ������*/
  
		var roleIdArray = offerRoleID.split("#");
		var tempEqtd1V = "";

		for(var i=0;i<roleIdArray.length;i++){
			tempEqtd1V = "";
			$("#tab_"+roleIdArray[i]+" :checkbox").each(function(){	//�����Ƿ���ѡ��
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
	
/*������Ʒ������*/
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
		  async: false,//ͬ��
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "�ļ�������!");
				}
				else if (data.status=="500")
				{
				  alert("�ļ��������!");
				}
				else{
				  alert("ϵͳ����!");  				
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


/* ����Ʒ����*/
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
		  async: false,//ͬ��
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "�ļ�������!");
				}
				else if (data.status=="500")
				{
				  alert("�ļ��������!");
				}
				else{
				  alert("ϵͳ����!");  			
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

/*��������Ʒ��ѡ��*/
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
			$("#expOffset_"+this.id).attr("disabled",false);	//��ʧЧʱ��ƫ�����������Ϊ����
			$("#sel_"+this.id).attr("disabled",false);
			initInfo(nodesHash[this.id]);
		}
		else{
			$("#"+v_Id).css("display","none");	
			$("#expOffset_"+this.id).attr("disabled",true);	//��ʧЧʱ��ƫ�����������Ϊ������
			$("#sel_"+this.id).attr("disabled",true);
			nodesHash[this.id].cancelChecked(nodesHash[this.id]);
			$("#orderTr_"+nodesHash[this.id].getId()).remove();
		}
		
		checkOrderTab();
  }
	catch(E){
	 	  rdShowMessageDialog("���ڼ�������Ʒ����,���Ժ�....");
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
//�Ѷ���������Ʒ����ʾ
function showDetailProd2(nodeId,nodeName,obj,etFlag){
		/*�����ӵ�У��*/
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
  
  var packet = new AJAXPacket("../s1104/complexPro_ajax.jsp","���Ժ�...");//��ϲ�Ʒ�Ӳ�Ʒչʾ
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
/*У�鸴�ϲ�Ʒ���ϵ*/
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
/*��������Ʒ��ѡ��ȷ��*/
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

/*2015/04/15 10:40:56 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� �Ƿ�ʹ�û��ֵ���������*/
function ifUseIntegralBtn(){
	var ifUseIntegral = $("#ifUseIntegral").attr("checked");
	if(ifUseIntegral == true){
		$("#IntegralFiled").show();
		
	}else{
		$("#IntegralFiled").hide();
	}
}

/*2015/04/15 10:40:56 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� ��ȡ��ǰ���û��ֵķ���*/
function getIntegral(){
	
	var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
	
	if(ifUseIntegral){
	
		var iPhoneNo = $.trim($("#intePhoneNo").val());
		var iUserPwd = $.trim($("#intePassWord").val());
		
		if(iPhoneNo.length == 0){
			rdShowMessageDialog("�������ֻ����룡",1);
			return false;
		}
		if(iUserPwd.length == 0){
			rdShowMessageDialog("������������룡",1);
			return false;
		}
		
		var getdataPacket = new AJAXPacket("/npage/public/fGetIntegral.jsp","���ڻ�����ݣ����Ժ�......");
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
			rdShowMessageDialog("У��ɹ���",2);
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
			rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			
		}
}

var globalMarkFlag = false;
function markIntegral(){
	
		var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
		
		/*2015/04/22 10:42:04 gaopeng ѡ����ֵ ����Ϊ��*/
		var iPhoneNo = ifUseIntegral == true ? $.trim($("#intePhoneNo").val()):"";
		var iUserPwd = ifUseIntegral == true ? $.trim($("#intePassWord").val()):"";
		var inteUseNum = ifUseIntegral == true ? $.trim($("#inteUseNum").val()):"";
		var iKdNo = $.trim(document.all.phoneNo_h.value);
		var getdataPacket = new AJAXPacket("/npage/public/fMarkIntegral.jsp","���ڻ�����ݣ����Ժ�......");
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
			rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			globalMarkFlag = false;
		}
}

var globalIngegralFlag = false;
/*�������� У������Ļ���ֵ ������100�ı��� 100���ֵֿ�1��Ǯ*/
function checkIngegralNum(){
	var integralNumObj = $("#inteUseNum")[0];
	if(!checkElement(integralNumObj)){
		return false;
	}
	var integralNum = $.trim(integralNumObj.value);
	if(integralNum.length == 0){
		rdShowMessageDialog("������Ļ���ֵ��",1);
		integralNumObj.value = "";
		
		return false;
	}
	if((Number(integralNum) % 100) != 0){
		rdShowMessageDialog("����Ļ���ֵ������100�ı�����",1);
		integralNumObj.value = "";
		
		return false;
	}
	/*�ֿ۵Ľ��*/
	var integralMoney = Number(Number(integralNum) / 100);
	var maxIntegralNum = Number($.trim($("#maxIntegralNum").val()));
	if(integralMoney > maxIntegralNum){
		rdShowMessageDialog("�ֿ۽��ܳ�������",1);
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
	if(yxds == "δ������"){
		$("#jdhId").val("003903FF002100700000000000000000");
	}else if(yxds == "����ͨ"){
		$("#jdhId").val("003903FF002100700000000000000000");
	}
}
    
//ȷ��
function mySub()
{
		            
		/*ʵ��ʹ��������*/
	if(!checkElement(document.all.realUserName)){
		return false;
	}
	/*ʵ��ʹ������ϵ��ַ*/
	if(!checkElement(document.all.realUserAddr)){
		return false;
	}
	/*ʵ��ʹ����֤������*/
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
			/*���Ӫ����*/
				if(viewModel.useMarket()){
					if(!viewModel.marketCheck()){
						rdShowMessageDialog("����У��Ӫ������ˮ",0);
						return false;    
					}
				}
		<%}%>
		
		<%if(!is58_88flag.equals("0")) {%>	
				if(viewModel.useMarket()){
		      if(!viewModel.marketCheck()){
		        rdShowMessageDialog("����У��Ӫ������ˮ",0);
		        return false;
		      }
		    } 
		<%}%>
		
		
		<%if(is68flag.equals("yes")) {%>  
		  /*���Ӫ����*/
		    if(viewModel.useMarket()){
		      if(!viewModel.marketCheck()){
		        rdShowMessageDialog("����У��Ӫ������ˮ",0);
		        return false;
		      }
		    }
		<%}%>
		
		<%if(isSSflag.equals("yes") && isSS2flag.equals("yes")) {%>  
		  /*���Ӫ����*/
		    if(viewModel.useMarket()){
		      if(!viewModel.marketCheck()){
		        rdShowMessageDialog("����У��Ӫ������ˮ",0);
		        return false;
		      }
		    }
		<%}%>
		if("kf" == "<%=sm_Code%>"){
			/*ԭ����˺�У��*/
			if(!checkElement($("#yuankuandaiNum")[0])){
				return false;
			}
			if($("#anzhuangFangshi").val()==""){
				 rdShowMessageDialog("��ѡ��װ��ʽ��",0);
			     return false;
			}
		}
		
    getAfterPrompt(); 
    
    /* zhouby add ���ӿͻ����Ƴ��ȵ�У��*/
    var zCustName = document.all.userName11.value;
    if(getByteLen(zCustName) > 40 && "<%=sm_Code%>" != "ki"){
        rdShowMessageDialog("�û����벻Ҫ����20�����ֻ�40���ַ���",0);
        return false;
    }
    
    if(!checksubmit(prodCfm))
    { 
      return false ;  
    }     
    if(!isOfferLoaded)
    {
      rdShowMessageDialog("���ڼ�������Ʒ����!");
      HoverLi(2,2);
      return false;  
    } 
    if($("#serviceType").val() == ""){
      rdShowMessageDialog("ȡ�������ͳ���!");
      return false;  
    }
    if( ($("#noPort").val() != "1") && 
        (document.all.isYzResource.value!="1") && 
        (document.all.isDoNoResource.value !="1")
        &&($("#isNeedHold").val() == "1")){
      rdShowMessageDialog("û��Ԥռ��Դ������Ԥռ��Դ����!");
      return false;  
    }
    if(document.all.cfmLoginCheck.value!="1" ){
      rdShowMessageDialog("У������¼�˺�ʧ��!");
      return false;  
    }
    if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
        rdShowMessageDialog("��ϵ���벻����Ϊ�գ�������");
        document.all.contactPhone.focus();
        return false;
     }
     if(document.all.enter_addr.value==null || document.all.enter_addr.value==""){
      rdShowMessageDialog("��װ��ַ������Ϊ�գ�������");
      document.all.enter_addr.focus();
      return false;
     }
     var zhengze = /[\~\`\^\,\=]+/g;
     if(zhengze.test(document.all.enter_addr.value)){
         rdShowMessageDialog("��װ��ַ�����԰��� ~`^,=�������ַ����޸�!");
         document.all.enter_addr.focus();
         return false;
        }
     
      if(checkPwd2(document.all.cfmPwd,document.all.cfmPwdConfirm)==false)  return false;
      if(checkPwd1(document.all.userpwd,document.all.userpwdcfm)==false)  return false;   
    
     if(!forDate(document.all.appointvTime)){
        rdShowMessageDialog("ԤԼ����ʱ���ʽ����ȷ��");
        document.all.appointvTime.focus();
        return false;
     }
     if(forDate(document.all.appointvTime)){
        if($(document.getElementById("appointvTime")).val() < "<%=dateStr2%>")
        {
          rdShowMessageDialog("ԤԼ����ʱ�䲻��С�ڵ�ǰʱ�䣡");
          return false;
        }
        /*ԤԼʱ��*/
        var appointvTime = Number($.trim($(document.getElementById("appointvTime")).val()));
        var addMonthTStr = Number("<%=addMonthTStr%>");
        if(appointvTime > addMonthTStr){
        	rdShowMessageDialog("ԤԼ����ʱ�䲻�ܳ�����ǰʱ��+12���£�");
          return false;
        }
     }
     if("ki" == "<%=sm_Code%>"){
				document.all.kdZdFee.v_must = "1";
				if(!checkElement(document.all.kdZdFee)){
					//rdShowMessageDialog("���������ն˷��ã�");
					return false;
				}
			}
     if("kf" == "<%=sm_Code%>"){
				document.all.kdZdFee.v_must = "1";
				if(!checkElement(document.all.kdZdFee)){
					//rdShowMessageDialog("���������ն˷��ã�");
					return false;
				}
				var ifMBH = $("select[name='ifMBH']").find("option:selected").val();
				if(ifMBH == "1"){
					document.all.jdhId.v_must = "1";
					if(!checkElement(document.all.jdhId)){
						rdShowMessageDialog("�����������ID��");
						return false;
					}
					if($.trim(document.all.jdhId.value).length != 32){
						rdShowMessageDialog("������ID����Ϊ32λ��");
						return false;
					}
					
				}
			}		 
     
      if(!checkForm()){
        return false;
      }
     //alert(1292);
     /*ke���뼯�ű��У��һ�¸�ʽ*/
     if($("#newSmCode").val() == "ke"){
      if(!checkElement(document.prodCfm.unitId)){
        return false;
      }
      var unitId = $("#unitId").val();
      //alert(unitId);
      if(unitId != ""){
        var getUnitId_Packet = new AJAXPacket("/npage/s4977/fCheckUnitId.jsp","����У�����Ժ�......");
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
    
    var sonParentArr = []; //�������Ʒ,��Ʒ����~����ϵ
    var groupInstBaseInfo = "";       //Ⱥ����Ϣ
    var offer_productAttrInfo = ""; //����Ʒ,��Ʒ���Դ�
 //   if(printSN){
  //  	go_checkSnUse();
  //  }
  //  if(checksnUse){
 //   	return false;
  //  }
    //ѹ������Ʒ
    if(typeof(majorProductArr) != "undefined" && majorProductArr.length > 0){
      $("input[name='majorProductId']").val(majorProductArr[1]);
      sonParentArr.push($("input[name='majorProductId']").val()+"~"+offerId);
      pordIdArr.push($("input[name='majorProductId']").val());
      prodEffectDate.push("<%=currTime%>");
      prodExpireDate.push("20501231235959");
      isMainProduct.push(1);
    }
    else{
      rdShowMessageDialog("������Ʒ!"); 
      return false;
    }
    
    var addGroupIdArr= [];
    //��ϲ�Ʒ����ʱ,��ѡȺ����Ϣ
    $("#addGroupInfo :checked").each(function(){
      addGroupIdArr.push(this.id);
    });
    //��ע��Ϣ
    if($("input[name='op_note']").val() == ""){
      $("input[name='op_note']").val("����Ա"+"<%=workNo%>"+"�Կͻ�"+"<%=gCustId%>"+"���п������!"); 
    }
    //ѹ���������Ʒ
    sonParentArr.push(offerId+"~"+"0");
    offerIdArr.push(offerId);
    offerEffectTime.push("<%=currTime%>");  //��ʧЧʱ�仹ûȷ��
    offerExpireTime.push("<%=offExpDate%>");
    //var mastServerType = $("#mastServerType").val();
    
    if(typeof(offerGroupHash[offerId]) != "undefined"){
        groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[offerId]+"^";
    } 
    
        //---------���ɻ�������Ʒ������Ϣ----------
    var offerAttrStr = "";      //����Ʒ���Դ�
    $("#OfferAttribute :input").not(":button,[type='hidden']").each(function(){
        offerAttrStr+=this.name.substring(2);
        offerAttrStr+="~";
        offerAttrStr+=$(this).val()+" $";
    });
    if(offerAttrStr != ""){
      offer_productAttrInfo += offerId+"|"+offerAttrStr+"^";
    }
    
    //$("input[name='offerAttrStr']").val(offerAttrStr);
    //---------��������Ʒ������Ϣ----------
    var productAttrStr = "";      //��Ʒ���Դ�
    
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
    //ѹ�븽�Ӳ�Ʒ
    $("#tab_addprod :checked").each(function(){
        sonParentArr.push(this.id+"~"+offerId);
        pordIdArr.push(this.id);
      
        //if(document.getElementById("startDate_"+this.id)!=null&document.getElementById("stopDate_"+this.id)!=null){
        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-1){
                  rdShowMessageDialog("��ʼʱ���ʽ����ȷ,����������!",0);
                  (document.getElementById("startDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==-2){
                  rdShowMessageDialog("����ʱ���ʽ����ȷ,����������!",0);
                  (document.getElementById("stopDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
              
        if($(document.getElementById("startDate_"+this.id)).val() < "<%=dateStr2%>"){
                  rdShowMessageDialog("��ʼʱ��Ӧ��С�ڵ�ǰʱ��,����������!",0);
                  (document.getElementById("startDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
        if($(document.getElementById("stopDate_"+this.id)).val() <= "<%=dateStr2%>"){
                  rdShowMessageDialog("����ʱ��Ӧ���ڵ�ǰʱ��,����������!",0);
                  (document.getElementById("stopDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
              
        if(compareDates((document.getElementById("startDate_"+this.id)),(document.getElementById("stopDate_"+this.id)))==1 || $(document.getElementById("startDate_"+this.id)).val()==$(document.getElementById("stopDate_"+this.id)).val()){
                  rdShowMessageDialog("��ʼʱ��ӦС�ڽ���ʱ��,����������!",0);
                  (document.getElementById("stopDate_"+this.id)).select();
                  vFlag = false;
                  return false;
        }
              
        if($(document.getElementById("startDate_"+this.id)).val() > "<%=addThreeMonth%>"){
                  rdShowMessageDialog("��ʼʱ���������������,����������!",0);
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
      
        if(typeof(AttributeHash[this.id]) != "undefined"){    //װ�븽�Ӳ�Ʒ��������Ϣ
          offer_productAttrInfo += AttributeHash[this.id];
        } 
    }); 
      
    if(!vFlag){
       return false;
    }
        
    $("#div_offerComponent :checked").each(function(){
      /*��������Ʒ�н����ѯ��û�в�ѯ��Ʒ
      if(this.name.substring(0,4)=="prod" && $("#"+nodesHash[this.id].parentOffer).attr("checked") == true && $("#effType_"+nodesHash[this.id].parentOffer).val() == "0"){  //ֻ��������Ч��
        sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
        pordIdArr.push(this.id);
        prodEffectDate.push($("#effTime_"+nodesHash[this.id].parentOffer).attr("name"));
        prodExpireDate.push($("#expTime_"+nodesHash[this.id].parentOffer).attr("name"));
        isMainProduct.push(0);
        
        if(typeof(AttributeHash[this.id]) != "undefined"){    //װ���Ʒ������Ʒ��������Ϣ
          offer_productAttrInfo += AttributeHash[this.id];
        } 
        
        sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
        offerIdArr.push(this.id);
        offerEffectTime.push($("#effTime_"+this.id).attr("name"));
        
        offerExpireTime.push($("#expTime_"+this.id).attr("name"));
        
        if(typeof(offerGroupHash[this.id]) != "undefined"){ //װ������Ʒ��Ⱥ����Ϣ
          groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[this.id]+"^";
        }
      }*/
      if(this.name.substring(0,4)=="offe"){     
        sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
        offerIdArr.push(this.id);
        offerEffectTime.push($("#effTime_"+this.id).attr("name"));
        
        offerExpireTime.push($("#expTime_"+this.id).attr("name"));
        
        if(typeof(AttributeHash[this.id]) != "undefined"){  //װ���Ʒ������Ʒ��������Ϣ
          offer_productAttrInfo += AttributeHash[this.id];
        } 
        
        if(typeof(offerGroupHash[this.id]) != "undefined"){ //װ������Ʒ��Ⱥ����Ϣ
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
		
		$("input[name='sys_note']").val("<%=workNo%>"+"��"+"<%=gCustId%>"+"������"+"<%=offerName%>"+"��װ!");
		/* ʹ���µ�������� */
		encryptPwd();
		if($("#cfmPwdEncryptFlag").val() != "1"){
			rdShowMessageDialog("�������û�м��ܣ����ɼ�������ҵ��",0);
			return false;
		}
		/* ʹ���µ�������� */
		GetBroadUserNo();
		
		if(!yuanzhanghaoFlag){
			rdShowMessageDialog("ԭ����˺Ŵ��� ���޸�!",0);
			return false;
		}
		
		
		if(document.all.isYzPhoneNo.value != "1")
		{
			rdShowMessageDialog("û�л�ȡ�û�������룬���ɼ�������ҵ��",0);
			return false;
		}
		var path = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		
		var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
		if(ifUseIntegral){
			if(!globalIngegralFlag){
				 rdShowMessageDialog("����У��������룬������ֿۻ��֣�",0);
		     return false;
			}
		}
		/*���Ϊkf�����ʷѣ���¼�����㲻ѡ��ʹ�û���Ҳ��¼��ֻ������¼��*/
		if("<%=ifUseIntegFlag%>" == "yes"){
			markIntegral();
			if(!globalMarkFlag){
				
		    return false;
			}
		}
		
		
		
		//rdShowMessageDialog("����ҵ�������ӡ����ͳһ�ɷѺ��ӡ��");
		//if(rdShowConfirmDialog("��ȷ���Ƿ���в�Ʒ��װ��")==1)
		//{	
				conf(path);
		//}else{
		//			$("#cfmBtn").attr("disabled",false);			
		//}
		
}
function go_checkSnUse(){
	var getUnitId_Packet = new AJAXPacket("fCheckSN.jsp","����У�����Ժ�......");
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
			rdShowMessageDialog("���ű�Ų��ǹ����������򲻴��ڣ���ȷ��",0);
		}else{
			$("#unitIdFlag").val("1");
		}
	}
}
function encryptPwd(){
	var getEncryptPwd_Packet = new AJAXPacket("/npage/public/pubBroadEncrypt.jsp","������ܣ����Ժ�......");
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
		rdShowMessageDialog("�������ʧ��",0);
		$("#cfmPwdEncryptFlag").val("0");
	}else{
		$("#cfmPwdEncrypt").val(returnPwd);
		$("#cfmPwdEncryptFlag").val("1");
	}
}
//Ӫ������ˮУ�� 2013/07/10 16:15:51 gaopeng
function marketCheckFunc(){
  var orderId = $("#marketAccept").val();
  if(orderId.trim() == ""){
    rdShowMessageDialog("��������Ӫ������ˮ",0);
    return false;
  }
  var getMarketPacket = new AJAXPacket("marketCheck.jsp","����У�飬���Ժ�......");
  getMarketPacket.data.add("orderId",orderId);
  getMarketPacket.data.add("opCode","<%=opCode%>");
  getMarketPacket.data.add("offerId","<%=offerId%>");//hejwa add ��У������������ 2014��2��17��11:15:29
  core.ajax.sendPacket(getMarketPacket,doMarketCheckBack);
  getMarketPacket = null;
}
function doMarketCheckBack(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	var outDetailMsg = packet.data.findValueByName("outDetailMsg");
	/*�жϽ��(0Ϊ������Ч 1Ϊ������Ч)*/
	var outRlt = packet.data.findValueByName("outRlt");
	var outPhoneNo = packet.data.findValueByName("outPhoneNo");
	if(retcode == "000000"){
		if(outRlt == "0"){
			rdShowMessageDialog("У��ͨ��,��Ӫ������ˮ��Ӧ���ֻ�����Ϊ"+outPhoneNo+",�����û��˶Բ�ȷ��",2);
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
    rdShowMessageDialog("��������Ӫ������ˮ",0);
    return false;
  }
  var getMarketPacket = new AJAXPacket("marketCheck58_88.jsp","����У�飬���Ժ�......");
  getMarketPacket.data.add("orderId",orderId);
  core.ajax.sendPacket(getMarketPacket,doMarketCheckFunc58_88);
  getMarketPacket = null;
}
function doMarketCheckFunc58_88(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	/*�жϽ��(0Ϊ������Ч 1Ϊ������Ч)*/
	var outPhoneNo = packet.data.findValueByName("outPhoneNo");
	if(retcode == "000000"){
			rdShowMessageDialog("У��ͨ��,��Ӫ������ˮ��Ӧ���ֻ�����Ϊ"+outPhoneNo+",�����û��˶Բ�ȷ��",2);
			$("#marketAccept58_88").attr("readonly","readOnly");
			viewModel.marketCheck(true);
			$("#marketPhoneNo_58_88").val(outPhoneNo);
			$("#marketBtn").attr("disabled","disabled");
	}else{
		rdShowMessageDialog(retcode + ":" + retmsg,0);
		viewModel.marketCheck(false);
	}
}


/*gaopeng 2013/07/11 15:18:55 ����Э���������������˾���ն˴��۹����Ӫ�������ĺ� 6 8��Ӫ������У�鷽�� start*/
function marketCheckFunc68(){
  var orderId = $("#marketAccept").val();
  if(orderId.trim() == ""){
    rdShowMessageDialog("��������Ӫ������ˮ",0);
    return false;
  }
  var getMarketPacket = new AJAXPacket("marketCheck68.jsp","����У�飬���Ժ�......");
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
      rdShowMessageDialog("У��ͨ��,��Ӫ������ˮ��Ӧ���ֻ�����Ϊ"+outPhoneNo+",�����û��˶Բ�ȷ��",2);
      $("#marketAccept").attr("readonly","readOnly");
      viewModel.marketCheck(true);
      $("#marketPhoneNo").val(outPhoneNo);
  }else{
    rdShowMessageDialog(retcode + ":" + retmsg,0);
    viewModel.marketCheck(false);
  }
}
/*gaopeng 2013/07/11 15:18:55 ����Э���������������˾���ն˴��۹����Ӫ�������ĺ� 6 8��Ӫ������У�鷽�� end*/

function GetBroadUserNo()
{
	var getUserNo_Packet = new AJAXPacket("f1100_getBroadUserNo.jsp","���ڻ�ÿ��������룬���Ժ�......");
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
/**hejwa �����Ӫ��ҵ��һ����������죬ÿ�ε��ύ��ťȡ�ô�ӡ��ˮ�������ȷ���󷵻���������б仯*/
var sLoginAccept = "";
function ajaxGetAccept(){
	$.ajax({
				url: '/npage/innet/ajaxGetPrintAccept.jsp',
				type: 'POST',
				data: '',
				async: false,
				error: function(data){
						if(data.status=="404"){
						  alert( "�ļ�������!");
						}else if (data.status=="500"){
						  alert("�ļ��������!");
						}else{
						  alert("ϵͳ����!");
						}
				},
				success: function(msg){
				  if(msg.trim()!=""){
				  	sLoginAccept = msg.trim();
				  }else{
						rdShowMessageDialog("ȡ��ӡ��ˮ����!");
				  }
				}
	});
}


function conf(path){
			var myPacket = new AJAXPacket("/npage/s1104/savePrintInfos.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
			rdShowMessageDialog("�洢�����Ϣ�����������:"+retCode+"��������Ϣ:"+retMsg,0);
		}

}

var retResultStr = "";
var retResultStr1 = "";
/*���������ӡ*/
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
   //ͬ���ύ���������ˮ
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
	var packet = new AJAXPacket("ajaxSavePrintCont.jsp","���Ժ�...");
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
		rdShowMessageDialog("������ݴ洢ʧ�ܡ�"+retCode+"��"+retMsg+"��");
		return;
	}
}  
/***����������Ҫ�õ��Ĺ��˺���**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
/*��ӡ��Ϣ*/
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
	 
		cust_info += "����ʺţ�"+$("#cfm_login").val()+"|";
		cust_info += "�ͻ�������"+usernamezhanshi+"|";
		cust_info += "֤�����룺"+"<%=custIccid%>"+"|";
		cust_info += "�ͻ���ַ��"+$("#enter_addr").val()+"|";
		
		var cTime = "<%=cccTime%>";
		
		opr_info+= "ҵ������ʱ�䣺"+cTime+"|";
		opr_info+= "����ҵ�񣺿������"+"  "+"������ˮ��"+sLoginAccept+"|";		
		opr_info+= "��װ�ѣ� INSTALLFEE Ԫ"+"|";
		/*2014/04/03 15:32:46 gaopeng �ƶ���ͥ�ͻ����ҵ����Ӫ֧��ϵͳ���� �޸ĵ�Ʒ��Ϊ�ƶ����(kf)ʱ��������� start*/
		/* 
	   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
	   * ����ʡ���kg������Ʒ��kh
	   */
		if("kf" == "<%=sm_Code%>" || "kg" == "<%=sm_Code%>" || "kh" == "<%=sm_Code%>" || "ki" == "<%=sm_Code%>"){
			var kdZdFee = $.trim($("#kdZdFee").val());
			if(kdZdFee.length != 0){
				opr_info+= "����ն˷��ã� "+kdZdFee+" Ԫ"+"|";
			}else{
				opr_info+= "����ն˷��ã� 0 Ԫ"+"|";
			}
			if(("kf" == "<%=sm_Code%>" ||"ki" == "<%=sm_Code%>")&&printSN){
				opr_info+= "S/N�룺"+$("#snNumber").val()+"|";
			}
			
		}
		/*2014/04/03 15:32:46 gaopeng �ƶ���ͥ�ͻ����ҵ����Ӫ֧��ϵͳ���� �޸ĵ�Ʒ��Ϊ�ƶ����(kf)ʱ��������� end*/
		opr_info+= "����ײ�Ԥ�� PREMONEY Ԫ"+"|";
		opr_info+= "�ײ���Чʱ��:�����װ��Ϻ���Ч"+"|"; 
		
		var appointvTime_p = $("#appointvTime").val();
		var a_year       = appointvTime_p.substring(0,4);
		var a_month      = appointvTime_p.substring(4,6);
		var a_dayofMonth = appointvTime_p.substring(6,8);
		
		opr_info+="|�������ԤԼ��װʱ��Ϊ"+a_year+"��"+a_month+"��"+a_dayofMonth+"�գ����ڵ��ձ����ֻ���ͨ���ȴ����ǵİ�װ��Ա������ϵ��|";
		
 		note_info1+=" "+"|";
 		
		if(document.all.newZOfferDesc.value!=""){
			note_info1+="���ʷ�������"+document.all.newZOfferDesc.value+"|";
		}else{
			note_info1+="���ʷ�������<%=offerComments%>"+"|";
		}
		
		
		note_info2 += "��ע��" + "|";
		
		/*2014/04/03 15:32:46 gaopeng �ƶ���ͥ�ͻ����ҵ����Ӫ֧��ϵͳ���� �޸ĵ�Ʒ��Ϊ�ƶ����(kf)ʱ��������� start*/
		/* 
	   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
	   * ����ʡ���kg������Ʒ��kh
	   */
		if("kf" == "<%=sm_Code%>" || "kg" == "<%=sm_Code%>" || "kh" == "<%=sm_Code%>" || "ki" == "<%=sm_Code%>"){
			note_info2 += "1�������װǰ���ƶ���˾����ʱ������ϵԤԼ���Ű�װʱ�䣬�뱣֤��ϵ�绰��ͨ��"+ "|";
			note_info2 += "2������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ֪ͨ����"+ "|";
			note_info2 += "3������������벦��������ߣ�10086��"+ "|";
			/*����ʷ��ǰ����ʷ� ����Ʒ��Ϊkf   �������ú����������CRM�����ֻ����ֶһ������Ʒ���ܵ����� һ��
				�ն˷���Ҳ��ֻ��kf��չʾ 
			*/
			if("<%=ifUseIntegFlag%>" == "yes"&&"<%=gundongyueResult[0][0]%>" == "0"){
				note_info2 += "4���������ʷѵ��ں��Զ����Ϊ��׼���ʷѡ�"+ "|";
			}
		}
		/*2014/04/03 15:32:46 gaopeng �ƶ���ͥ�ͻ����ҵ����Ӫ֧��ϵͳ���� �޸ĵ�Ʒ��Ϊ�ƶ����(kf)ʱ��������� end*/	
		else{
			note_info2 += "1������ʱѡ��Ŀ���ײͽ��ڿ����װ��Ϻ���Ч�������װ��Ϻ���ͨ��˾����ʱ֪ͨ�����Կ�ʼʹ�ÿ��ҵ��" + "|";
			note_info3 += "2������ʱ��������˳���Ч֤�����������˷ѵ��û����ṩ���ڵ����˿�����ֽ�Ԥ��Ʊ������������Ԥ����ķ�Ʊ�������û�����������ײͣ�������ǰȡ������ҵ�񣬽���ʣ��Ԥ����30%����ΥԼ���ڰ�����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С����ҵ�������ͣ�ڼ�������գ�����������ͣ���������޲��Ӻ�" + "|";
		}
		
		if("kf" == "<%=sm_Code%>"){
					var kdzdtypes = $("#kdZd").val();
		      if(kdzdtypes=="ONT") {		      
		        var fysqfs = $("#fysqfs").val();
							if(fysqfs=="0") {//Ѻ��
							note_info3 += "�𾴵��û���������������������ʱ����Я��ONT�豸��Ѻ��Ʊ����Ч֤�������ƶ�ָ������Ӫҵ��������Ѻ�𡣿���ն�Ѻ�𷵻���ֹ���ڣ��û�������90���ڣ�����90�죩��" + "|";
							}        
          }			
		}
		
		/*2016/7/22 9:31:49 gaopeng ���ڼ��ſ����ƷBOSS���ο��������� 
			3�����Ʒ��Ϊ�����ſ��(ki)�����ҿ���ն�ѡ��ONT�����ҡ�������ȡ��ʽ��ΪѺ��
			�������Ϣ�ı�ע��Ϣ��kfһ�£�����
			   ���𾴵��û���������������������ʱ����Я��ONT�豸��Ѻ��Ʊ����Ч֤����
			   ���ƶ�ָ������Ӫҵ��������Ѻ�𡣿���ն�Ѻ�𷵻���ֹ���ڣ��û�������90���ڣ�����90�죩����
			4�����Ʒ��Ϊ�����ſ��(ki)�����ҿ���ն�ѡ��ONT�����ҡ�������ȡ��ʽ��ΪѺ��
			��Ҫ���ⵥ����ӡһ���վݣ�����Ʊ����˰���վ�������kfһ�¡�
			   ���Ʒ��Ϊ�����ſ��(ki)�����ҿ���ն�ѡ��ONT�����ҡ�������ȡ��ʽ��Ϊ���ۣ�
			   ��Ҫ���ⵥ����ӡһ�ŷ�Ʊ����Ʊ���š�˰����kfһ�¡�
		*/
		if("ki" == "<%=sm_Code%>"){
					var kdzdtypes = $("#kdZd").val();
		      if(kdzdtypes=="ONT") {		      
		        var fysqfs = $("#fysqfs").val();
							if(fysqfs=="0") {//Ѻ��
							note_info3 += "�𾴵��û���������������������ʱ����Я��ONT�豸��Ѻ��Ʊ����Ч֤�������ƶ�ָ������Ӫҵ��������Ѻ�𡣿���ն�Ѻ�𷵻���ֹ���ڣ��û�������90���ڣ�����90�죩��" + "|";
							}        
          }			
		}
		
		
		strcatDb(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);//�����ݴ������ݿ⣬��Ӫ��ҵ��һ��ʱ
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;	
}

/*�����ʷѲ�ѯ*/
function ajaxGetEPf(offerIdv,offerId){
		var packet = new AJAXPacket("../s1270/ajaxGetEPf.jsp","���Ժ�...");
		packet.data.add("offerIdv",offerIdv);
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("xqJf",offerId);
		core.ajax.sendPacket(packet,doAjaxGetEPf1);
		packet = null;
}  
	
function doAjaxGetEPf1(packet){
		 retResultStr = packet.data.findValueByName("retResultStr");
		 
		 document.all.newZOfferECode.value = packet.data.findValueByName("newZOfferECode");//���������ʷѴ���
		 document.all.newZOfferDesc.value = packet.data.findValueByName("newZOfferDesc"); //���������ʷ�����
		 document.all.dOfferId.value = packet.data.findValueByName("dOfferId"); //���ں�ִ���ʷ�Id
		 document.all.dOfferName.value = packet.data.findValueByName("dOfferName"); //���ں�ִ���ʷ�Name
		 document.all.dECode.value = packet.data.findValueByName("dECode"); //���ں��������
		 document.all.dOfferDesc.value = packet.data.findValueByName("dOfferDesc"); //���ں��ʷ�����
}
/*��ѡ�ʷѵĲ�ѯ*/
function ajaxGetEPf1(tempNote_info2v){
		var packet = new AJAXPacket("../s1104/ajaxGetEPf.jsp","���Ժ�...");
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
	
			groupHash[offerId]=ret.toString();	//�����ص�Ⱥ����Ϣ��ӦofferId����

			var offerGroupInfo = "";		//��װ����Ʒ��Ⱥ����Ϣ,��ʽ:offerId,groupinfo1,groupinfo2,~
			offerGroupInfo += offerId;
			offerGroupInfo += "|";
			var temp = ret.toString().split("/");

			$.each(temp[0].split("$"),function(i,n){
				if(typeof(n) != "undefined"){
					if(i<6){											//ǰ6��ΪȺ�������Ϣ,�����Ϊ����������Ϣ
						offerGroupInfo += n.split("~")[1];	
						offerGroupInfo += "$";	
					}
					else{
						offerGroupInfo += n.substring(2); //ȥ��"s_",id~value
						offerGroupInfo += "$";
					}
				}	
			});
			offerGroupInfo += "/";	
			
			offerGroupInfo+=temp[1];
			offerGroupHash[offerId] = offerGroupInfo;
		}	
		else{
			rdShowMessageDialog("δ����Ⱥ�飡");	
			return false;
		}
	}
	else{
		var ret=window.showModalDialog("../s1104/showGroup.jsp?opType=look&offerId="+offerId+"&offerName="+offerName+"&groupInfo="+groupHash[offerId]+"&groupTypeId="+groupTypeId+"&groutDesc="+document.all.groutDesc.value,"",prop);
	
		if(typeof(ret) != "undefined"){
				var retTemp = ret;
				
				ret = ret.substring(0,ret.indexOf("#"));
				document.all.groutDesc.value =  retTemp.substring(retTemp.indexOf("#")+1,retTemp.length);
			groupHash[offerId]=ret;	//�����ص�Ⱥ����Ϣ�Ծ�offerId����
			
			var offerGroupInfo = "";		//��װ����Ʒ��Ⱥ����Ϣ,��ʽ:offerId,groupinfo1,groupinfo2,~
			offerGroupInfo += offerId;
			offerGroupInfo += "|";
			var temp = ret.toString().split("/");
			$.each(temp[0].split("$"),function(i,n){
				if(typeof(n) != "undefined"){
					if(i<6){											//ǰ6��ΪȺ�������Ϣ,�����Ϊ����������Ϣ
						offerGroupInfo += n.split("~")[1];	
						offerGroupInfo += "$";	
					}
					else{
						offerGroupInfo += n.substring(2); //ȥ��"s_"
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
				rdShowMessageDialog("δ�������ԣ�");	
				return false;
			}
			$(this).attr("class","but_property_on");
			AttributeHash[queryId]=ret;	//�����ص�Ⱥ����Ϣ��ӦqueryId����
		}	
		else{
			rdShowMessageDialog("δ�������ԣ�");	
			return false;
		}
	}
	else{
		var ret=window.showModalDialog("../s1104/showAttr.jsp?queryId="+queryId+"&queryType="+queryType+"&attrInfo="+AttributeHash[queryId],"",prop);
		if(typeof(ret) != "undefined"){
			AttributeHash[queryId]=ret;	//�����ص�Ⱥ����Ϣ�Ծ�queryId����
		}
	}	
}

/*�û�����һ��У��*/
function checkPwd1(obj1,obj2)
{
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1==""){
			rdShowMessageDialog("�������û�����",0);
			obj1.focus();
			return false;
	}
		
	if(pwd1 != pwd2)
	{
		var message = "��������벻һ�£����������룡";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
}
/*����˺�����һ��У��*/
function checkPwd2(obj1,obj2)
{
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1==""){
			rdShowMessageDialog("���������˺�����",0);
			obj1.focus();
			return false;
	}		
	if(pwd1 != pwd2)
	{
		var message = "��������벻һ�£����������룡";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
} 
//��ʾ��ѡ������Ʒ��Ϣ
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
			/*��ҪԤռ��*/
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
/*���С����ѯ*/
function queryResource()
{ 
	 idleResInfo();
   if(document.all.isYzResource.value!="1"){
   
   var smcodess="<%=sm_Code%>";
  
   
		      var path ="../se276/queryResource.jsp?opCode="+"<%=opCode%>"+"&smCode="+smcodess;
		      window.open(path,'С����Դ��ѯ','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    }else{	 
    		yzResource();//�ͷ���Դ 	
    }
} 

String.prototype.replaceAll4977 = function(reallyDo, replaceWith, ignoreCase) {
�� if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);
} else {
return this.replace(reallyDo, replaceWith);
}
} 

function returnResBack(retInfo)
{
	var resPre=retInfo.substr(0,2);
	
	var resContent=retInfo.substr(2,retInfo.length-1);
	
	
  /*2016/8/3 11:15:06 gaopeng ��ȡ��׼��ַ С������ ȡ����ѡ��ĵ�ַ����*/
	document.all.area_nameh.value=  oneTok(resContent, "|", 7);
	
	document.all.enter_addr.value	=document.all.area_nameh.value.replaceAll4977("/","");
	
	document.all.area_codeh.value=  oneTok(resContent, "|", 2);
	document.all.areaAddr.value=  oneTok(resContent, "|", 3);	
	//document.all.bandWidth.value=oneTok(resContent, "|", 4);
	document.all.enter_type.value=  oneTok(resContent, "|", 5);
	//alert(document.all.enter_type.value);
	document.all.standardCode.value=oneTok(resContent, "|", 6);//addressCode��ַ����
	//alert("addressCode��ַ�����ǣ�"+oneTok(resContent, "|", 6));
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
	
	
	
	/*2014/04/03 11:17:27 gaopeng ��ȡ ������� ���ط�ʽ*/
	document.all.belongCategory.value=oneTok(resContent, "|", 18);
	document.all.bearType.value=oneTok(resContent, "|", 19);
	
	/*2014/09/05 10:12:39 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����
		����Դ��ѯ�ĳ��ط�ʽΪ�����ߡ��������ն˵�ֵΪ��ONT��
		����Դ��ѯ�ĳ��ط�ʽΪ�����ߡ��������ն˵�ֵΪ��CPE��
		ֻ�С��ƶ����(kf)����չʾ����ն˺Ϳ���ն˷��ã����ұ�ѡ������Ʒ�Ʋ�չʾ������ѡ�
	*/
	var bearTypeA = document.all.bearType.value;
	
	if("kf" == "<%=sm_Code%>"){
		/*����*/
		if(bearTypeA == "0"){
			$("select[name='kdZd']").find("option").each(function(){
				var thisVAL = $(this).val();
				if(thisVAL == "ONT"){
					$(this).attr("selected","selected");
				}
				
			});
		}
		/*����*/
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
	/* 4977�������С���ʷѲ�ѯ���ӹ�����ƣ���������Ϊ�ƶ��������С����������Ϊ��磬���������ԴԤռ@2014/5/29 16:39:50 */
	/*2014/11/19 10:52:43 ��ͨ�ں���Ŀ gaopeng �޸� ֻ��С�����������жϼ��ɣ�kg��ke��kh������Ԥռ
		kg=3 ke=4 kh=5
		2015/01/08 11:11:09 gaopeng 3 4 5 6(����)��ʱ�� ��������ԴԤռ
	*/
	if( document.all.propertyUnit.value.trim() == "3" || document.all.propertyUnit.value.trim() == "4" ){
		$("#isNeedHold").val("0");
		document.all.yz_resource.disabled=true;
	}
	/*2016/5/31 10:22:02 gaopeng ������ͨ����ͻ�Ǩ��֧��ϵͳ���첹������ĺ� 
		С���������� Ϊ5 5-��ͨ����ͨ���У�  6 6-����(�ƶ��Խ�)
		��������Ϊ ��2/FTTH���͡�3/FTTB��ʱ ��ҪԤռ
		�����������ҪԤռ
	*/
	if(document.all.propertyUnit.value.trim() == "5" || document.all.propertyUnit.value.trim() == "6"){
		/*��������Ϊ ��2/FTTH���͡�3/FTTB��ʱ ��ҪԤռ*/
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
	var pkt = new AJAXPacket("ajaxGetPartnerName.jsp","���Ժ�...");
	pkt.data.add("partnerCode",document.all.partnerCode.value);
	pkt.data.add("iSmCode","<%=sm_Code%>");
	core.ajax.sendPacket(pkt,doPartnertName);
	pkt = null;	
	
	
	//document.all.cctId.value="001";
	if(document.all.cctId.value != ""){
	    var packet = new AJAXPacket("ajaxGetCctName.jsp","���Ժ�...");
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
	var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "����У�飬���Ժ�......");
	myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
	myPacket.data.add("customerCode",document.all.cfm_login.value);/*�û����*/
	myPacket.data.add("productType","12");/*��Ʒ����*/
	myPacket.data.add("opCode", "<%=opCode%>");
	myPacket.data.add("yzFlag", "2");
	/*2013/3/1 ������ 9:09:16 gaopeng FTTH�������Ӳ��� addressCode ��ַ����*/
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
		//��Щ�����ɱ༭
		document.all.userName11.readOnly=false;
		document.all.contactPhone.readOnly=false;
		document.all.contactCustName.readOnly=false;
		document.all.cfm_loginF.readOnly=false;
		document.all.enter_addr.readOnly=false;
		document.all.cfmPwd.readOnlly=false;
		document.all.cfmPwdConfirm.readOnlly=false;
		//��Щ��ť����
		document.all.isYzResource.value="0";
		rdShowMessageDialog("��Դ�ͷųɹ�",2);
		buttonShow();
	}else{
		retContentArr = retContentT.split("=");
 		if(retContentArr.length > 3){
 			rdShowMessageDialog("������Ϣ��"+retContentArr[3]+"��",0);
 		}else{
 			rdShowMessageDialog("������Ϣ����Դ�ͷ�ʧ�ܣ�",0);
 		}
 		return false;
	}
}

function yzResource()
{
	  if(document.all.isGetAreaResource.value=="0"){
		       rdShowMessageDialog("û��ѡ����Դ����ѡ����Դ");
		       return false;
		}
		if(document.all.cfmLoginCheck.value=="0"){
				rdShowMessageDialog("û�п����½�˺Ų�����Ԥռ��Դ",0);
				return false;
		}
		if(document.all.contactCustName.value==null || document.all.contactCustName.value=="" || document.all.contactCustName.value=="0"){
		  	rdShowMessageDialog("��ϵ�˲�����Ϊ�գ�������");
		  	document.all.contactCustName.focus();
		  	return false;
		 }
		if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
		  	rdShowMessageDialog("��ϵ���벻����Ϊ�գ�������");
		  	document.all.contactPhone.focus();
		  	return false;
		 }
		 if(document.all.enter_addr.value==null || document.all.enter_addr.value==""){
			rdShowMessageDialog("��װ��ַ������Ϊ�գ�������");
			document.all.enter_addr.focus();
			return false;
		 }
			
		  if(checkPwd2(document.all.cfmPwd,document.all.cfmPwdConfirm)==false)	return false;
		  
		  if(!checkForm()){
				return false;
			}
/*Ԥռ�ӿ� 2013/2/26 ���ڶ� 16:27:36 gaopeng*/	

				   var myPacket = new AJAXPacket("../se276/ajax_yzResource.jsp", "����У�飬���Ժ�......");
				   myPacket.data.add("serviceOrder","<%=servBusiId%>"  );
						myPacket.data.add("customerCode",document.all.cfm_login.value);/*�û����*/
						myPacket.data.add("productType","12");/*��Ʒ����*/
						myPacket.data.add("yzFlag", "0");
						myPacket.data.add("opCode", "<%=opCode%>");
						/*2013/3/1 ������ 9:09:16 gaopeng FTTH�������Ӳ��� addressCode ��ַ����*/
						myPacket.data.add("addressCode", document.all.standardCode.value);
						/*2014/11/10 10:07:13 gaopeng �޸���ԴԤռ�ӿ�*/
						myPacket.data.add("enterType", document.all.enter_type.value);
						myPacket.data.add("propertyUnit", document.all.propertyUnit.value);
						core.ajax.sendPacket(myPacket,doYzResource);
						myPacket = null;
	
} 
function doYzResource(packet)
{
	//alert("����ص�����");
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  //alert("retCode==="+retCode+"---retMsg=="+retMsg);
	var retContentArr = new Array();
  var retContent = packet.data.findValueByName("retContent");
  var retContentT = ""+retContent;
  var iType = packet.data.findValueByName("iType");
	//alert(retCode+"--���ش���");
	       if(retCode=="000000"){	//��ʾ���÷���ɹ�
	       	 var retValue=retContent.split(",");
	         var retContent=retValue[2].split("=");
	         if(retContent[1]=="0"){//�ж��Ƿ�Ԥռ�ɹ�
	       	    //��Щ����򲻿ɱ༭
							document.all.userName11.readOnly=true;
							//document.all.contactPhone.readOnly=true;
							//document.all.contactCustName.readOnly=true;
							document.all.cfm_loginF.readOnly=true;
							//document.all.enter_addr.readOnly=true;
							//document.all.cfmPwd.readOnlly=true;
							//document.all.cfmPwdConfirm.readOnlly=true;
							//��Щ��ť������
							document.all.isYzResource.value="1";  
							//rdShowMessageDialog("��ԴԤռ�ɹ�",2);
							buttonShow();
		       }else{
		       		retContentArr = retContentT.split("=");
		       		if(retContentArr.length > 3){
		       			rdShowMessageDialog("������Ϣ��"+retContentArr[3]+"��",0);
		       		}else{
		       			rdShowMessageDialog("������Ϣ����ԴԤռʧ�ܣ�",0);
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
			    	    //��Щ�����ɱ༭
				       	document.all.userName11.readOnly=false;
				       	document.all.contactPhone.readOnly=false;
				       	document.all.contactCustName.readOnly=false;
				       	document.all.cfm_loginF.readOnly=false;
				       	document.all.enter_addr.readOnly=false;
				       	document.all.cfmPwd.readOnly =false;
				       	document.all.cfmPwdConfirm.readOnly =false;		       	 
				       	document.all.isGetAreaResource.value="0";
				    	  document.all.isYzResource.value="0"; 
				    	  rdShowMessageDialog("��Դ�ͷųɹ�",1);
				    	   buttonShow();
			         }else{
			    	      rdShowMessageDialog("��Դ�ͷ�ʧ��",0); 
			         } 
	         }else{ 
	         	 rdShowMessageDialog(retMsg,0);  
	         	 document.all.isYzResource.value="1"; 
	         }
	}*/
}
/*���ɿ���˺ţ���������֤*/
function checkCfmLogin()
{
		if(checkElement(document.all.cfm_loginF)){
			if(document.all.cfm_loginF.value.trim().length == 0)
			{
				rdShowMessageDialog("�˺����ɺ��벻��Ϊ��",0); 
			}else{
			  /*begin diling add for �����Ʒ��Ϊ����ʱ��(kf)[Ŀǰ��Ϊ�ƶ�������������Ϊ8-10������]��ʱ,��������@�����ֺ���ĸ@2012/9/17 */
			  /* 
			   * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
			   * ����ʡ���kg������Ʒ��kh
			   * houxuefengҪ��kf  kgֻ�������֣�kh���ֲ��䡣2014/11/4 13:36:05
			   */
			   /*update ͳһ�淶�˺��������� for ����Э���޸Ŀ���˺ű������Ϳ��Ͷ�ߴ���ʱ�޵ĺ�@2015/4/13 */
			  if("kf"=="<%=sm_Code%>" || "kg"=="<%=sm_Code%>" || "ke"=="<%=sm_Code%>" || "kd"=="<%=sm_Code%>" || "kh"=="<%=sm_Code%>" || "ki"=="<%=sm_Code%>"){
			    var reg =/^[0-9]*$/;
          if(reg.test(document.all.cfm_loginF.value.trim()) == false){
            rdShowMessageDialog("�˺����ɺ���������������ɣ�");
            return false;
          }
          var loginKf = document.all.cfm_loginF.value.trim();
          if("kh"=="<%=sm_Code%>"){
          	if(loginKf.length < 11  || loginKf.length > 16){
	          	rdShowMessageDialog("�˺����ɺ���Ϊ11-16�����֣�");
	            return false;
	          }
          }else{
          	//if(loginKf.length < 8  || loginKf.length > 10){
	          if(loginKf.length < 11  || loginKf.length > 12){
	          	rdShowMessageDialog("�˺����ɺ���Ϊ11-12�����֣�");
	            return false;
	          }
          }
			  }
			  /*
			  2014/11/21 10:33:30 gaopeng �����Ŀ ȥ��khУ�飬��kd����һ��
			  else if("kh"=="<%=sm_Code%>"){
			    var reg =/^[0-9a-zA-Z\@]*$/;
          if(reg.test(document.all.cfm_loginF.value.trim()) == false){
            rdShowMessageDialog("�˺����ɺ������������֡�@����ĸ���е�һ��������ɣ�");
            return false;
          }
          var loginKf = document.all.cfm_loginF.value.trim();
          if(loginKf.length < 8  || loginKf.length > 10){
          	rdShowMessageDialog("�˺����ɺ���Ϊ8-10���ַ���");
            return false;
          }
			  }
			  */
			  /*end diling add @2012/9/17 */
				  var cfm_login= document.all.cfm_loginF.value;
			    cfm_login="<%=prefix%>"+cfm_login+"<%=domainName%>";
				  var getUserId_Packet = new AJAXPacket("f1100_checkCfmLogin.jsp","���ڻ�ÿ���˺ţ����Ժ�......");
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
   if(retType=="CfmLoginK"){//У�����˺�
    	if(retCode=="000000"){
    			//rdShowMessageDialog("���˺ſ���ʹ��",2);
    			document.all.cfmLoginCheck.value="1";
    			document.all.cfm_login.value="<%=prefix%>"+document.all.cfm_loginF.value+"<%=domainName%>";
    			$("input[type=password][name=cfmPwd]").val(document.all.cfm_login.value.substring((document.all.cfm_login.value.length-6)));
    			$("input[type=password][name=cfmPwdConfirm]").val(document.all.cfm_login.value.substring((document.all.cfm_login.value.length-6)));
    		}else{
    			rdShowMessageDialog("���˺Ų����ã�",0);
    			document.all.cfmLoginCheck.value="0";
    		}
    } else if(retType=="BroadUserNo"){//��ȡ�������
	    	if(retCode=="000000"){
	    			var phoneNo_h = packet.data.findValueByName("phoneNo_h");  
	    			document.all.phoneNo_h.value = phoneNo_h;
	    			document.all.isYzPhoneNo.value = "1";
	    		}else{
	    			rdShowMessageDialog("��ȡ���������� " + retCode + retMessage,0);
	    			document.all.isYzPhoneNo.value = "0";
	    		}
    }
}
function ignoreThis(){
	if(rdShowConfirmDialog("��ȷ���Ƿ�ȡ����ҵ�� ȷ�Ϻ�ҵ�񽫱�ɾ��")==1){
		var packet1 = new AJAXPacket("../s1104/ignoreThis.jsp","���Ժ�...");
				packet1.data.add("sOrderArrayId","<%=orderArrayId%>");
				core.ajax.sendPacket(packet1,doIgnoreThis,true);
				packet1 =null;
			}
}
	
function doIgnoreThis(packet){
		var errorCode = packet.data.findValueByName("retrunCode");
		var returnMsg = packet.data.findValueByName("returnMsg");
		if(errorCode == "0"){
				rdShowMessageDialog("���Գɹ�",2);
				goNext("<%=custOrderId%>","<%=custOrderNo%>","<%=prtFlag%>");
			}else{
				rdShowMessageDialog("����ʧ��:"+returnMsg,0);
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
		���ύǰ���ֶ�������֤
		���ڷ��ӿ�ƽ̨�����Ƚ�ȫ������ơ�
		�˺ţ�����+Ӣ����ĸ+@��(ֻ��kfƷ�ƿ���������ĸ��@��)
		���룺����
		��ϵ�ˣ�����
		��ϵ�绰������
		��װ��ַ��Ӣ����ĸ+����+����+-() (�л��ߺ�С����)
		ʩ��Ҫ��Ӣ����ĸ+����+����
		ԤԼʱ�䣺����
	*/
	var m;
	var flag = false;
	/*�˺ţ�����+Ӣ����ĸ+@��(��ͬƷ���Ƿ�����������ĸ��@�������ƣ����ﲻ����)*/
	var cfmLoginFVal = document.all.cfm_loginF.value;
	if(cfmLoginFVal != ""){
		m = /^[0-9a-zA-Z@]+$/;
		flag = m.test(cfmLoginFVal);
		if(!flag){
			rdShowMessageDialog("�˺�ֻ����������ĸ���ֺ�@��");
			return false;
		}
	}
	
	/*���룺����*/
	var pswd = document.all.userpwd.value;
	if(pswd != ""){
		m = /^[0-9]+$/;
		flag = m.test(pswd);
		if(!flag){
			rdShowMessageDialog("�û�����ֻ������������");
			return false;
		}
	}
	var cfmPwd = document.all.cfmPwd.value;
	if(cfmPwd != ""){
		m = /^[0-9]+$/;
		flag = m.test(cfmPwd);
		if(!flag){
			rdShowMessageDialog("�������ֻ������������");
			return false;
		}
	}
	
	/*��ϵ�ˣ�����*/
	var contactCustName = document.all.contactCustName.value;
	if(contactCustName != ""){
		m = /^[\u0391-\uFFE5]+$/;
		var flag = m.test(contactCustName);
		if(!flag){
			rdShowMessageDialog("��ϵ��ֻ������������");
			return false;
		}
	}
	
	/*��ϵ�绰������*/
	var contactPhone = document.all.contactPhone.value;
	if(contactPhone != ""){
		m = /^[0-9]+$/;
		var flag = m.test(contactPhone);
		if(!flag){
			rdShowMessageDialog("��ϵ�绰ֻ������������");
			return false;
		}
	}
	
	/*��װ��ַ��Ӣ����ĸ+����+����+-() (�л��ߺ�С����)*/
	var enter_addr = document.all.enter_addr.value;
	if(enter_addr != ""){
		m = /^[\u0391-\uFFE5a-zA-Z0-9\-\(\)]+$/;
		var flag = m.test(enter_addr);
		if(!flag){
			rdShowMessageDialog("��װ��ַֻ�����������ġ���ĸ�����֡�-��()");
			return false;
		}
	}
	
	/*ʩ��Ҫ��Ӣ����ĸ+����+����
	var construct_request = document.all.construct_request.value;
	if(construct_request != ""){
		m = /^[\u0391-\uFFE5a-zA-Z0-9]+$/;
		var flag = m.test(construct_request);
		if(!flag){
			rdShowMessageDialog("ʩ��Ҫ��ֻ�����������ġ���ĸ������");
			return false;
		}
	}
	*/
	/*ԤԼʱ�䣺����*/
	var appointvTime = document.all.appointvTime.value;
	if(appointvTime != ""){
		m = /^[0-9]+$/;
		var flag = m.test(appointvTime);
		if(!flag){
			rdShowMessageDialog("ԤԼʱ��ֻ������������");
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
		if(fysqfs=="0") {//Ѻ��
		$("#kdZdFee").attr("v_minvalue","50");	
		$("#kdZdFee").attr("v_maxvalue","200");	
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").show();
		
		}else if(fysqfs=="1") {//����
		$("#kdZdFee").removeAttr("v_minvalue");
		$("#kdZdFee").removeAttr("v_maxvalue");
		$("#kdZdFee").removeAttr("readonly");
		$("#kdZdFee").removeAttr("class");
		$("#yjfwxianshi").hide();
		
		
		}else {//�Ա�
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
	var packet = new AJAXPacket("ajaxCheckyuanzhanghao.jsp","���Ժ�...");
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
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    if(error_code=="000000"){//���÷���ʧ��
    	yuanzhanghaoFlag=true;
		return;
    }else{//����ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
    	yuanzhanghaoFlag=false;
    	return false;
    }
}

function go_checkSNShow(){
	var packet = new AJAXPacket("ajaxCheckSnShow.jsp","���Ժ�...");
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
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    if(error_code=="000000"){
    	snShow=packet.data.findValueByName("vFlag");
    	//snShow="2";
    	showSN();
		return;
    }else{//����ʧ��
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
		<div id="title_zi">�ͻ���Ϣ</div>
</div>


<div id="custInfo">
<%@ include file="/npage/common/qcommon/bd_0002.jsp" %>
</div>

		<div id="tabsJ">
			<ul>
				<li class="current" id="tb_1"><input type='radio' name='changeSel' value='selBasic' checked onclick="HoverLi(1,2);">��������Ʒ&nbsp;</li>
				<li id="tb_2"><input type='radio' name='changeSelh' value='selStruc' onclick="HoverLi(2,2);">����Ʒ����</li>
			</ul>
		</div>

		<!-- ��������Ʒ ��ʼ-->
		<div class="dis" id="tbc_01">
				<div id=tb_01>
						<div class=input>
								<div id=baseInfo></div>
								<div class="title">
									<div id="title_zi">����Ʒ��Ϣ</div>
								</div>	
								<table cellSpacing=0>
								  <tr>
								    <td class="blue" width=17%>Ʒ��</td>
								  	<td width=33%><%=brandName%>  
								  		<input type="hidden" name="orderInfoV" value="0" />
								  		<input class=b_text id="orderInfoDiv"  type=button value=�鿴��ѡ�񸽼�����Ʒ��Ϣ /></td>
								    <td class="blue"  width=17%>����Ʒ����</td>
								    <td id="td_offerName"><%=(offerId+"-->"+offerName)%> </TD>
									</tr>
									<tr>
								    <td class="blue">����</Td>
								    <td colspan="3"><%=offerComments%></TD>
								  </tr>
								</table>  
								<div id="OfferAttribute"></div><!--����Ʒ����--></div>
								<div class="list" id="orderInfo" style="display:none">
										<div class=title><div id="title_zi">��ѡ�񸽼�����Ʒ��Ϣ</div>
								</div>
            		<div style="overflow-y:scroll;overflow-x:hidden;height:130px">	   	
				            <table cellSpacing=0 id="tab_order">
												<tr>
											    <th>����ƷID</td><th>����Ʒ����</td><th>��Чʱ��</td><th>ʧЧʱ��</td><th>����</td>
												</tr>
										</table>	
								</div>
						</div>

						<div class="input" style="display:none"  id="addGroupInfo">
								<table cellSpacing=0 style="display:none">
									<tr>
								    <td class="blue" style="width:100px">�ɼ�Ⱥ��</td>
								    <td id="addGroupTd"></td>
									</tr>
								</table>	
						</div>

						<div class="input" id="userinfo">
								<br>
								<div class="title">
								<div id="title_zi">������Ϣ</div>
								</div>
								<div id="userBaseInfo">
								<%@ include file="include/fKDUserBaseInfo.jsp" %>
								</div>
						</div>
				</div>

				<div class="title">
					<div id="title_zi">��Դ��Ϣ</div>
				</div>	
				<table cellSpacing=0 id="serviceNoInfo">	
				    <tr>
			        
			        <td colspan=6 align="center">     
			          <input type="button" class="b_text" name="query_res" value="С����Դ��ѯ" onClick="queryResource()" >
			          <input type="button" class="b_text" name="yz_resource" id="yz_resource" value="��ԴԤռ" onClick="yzResource()">
			          <input type="button" class="b_text" name="sf_resource" id="sf_resource" value="��Դ�ͷ�" onClick="sfResource()">
			          <input type="hidden" name="yxds" value="����ͨ">
			          <span id="keShowSpan" style="color:red;display:none;">�����������ԴԤռ����Դ�ͷ�</span>
			          <%if("1".equals(isNeedHold)) {%>
			          <span  style="color:red;">��Ԥռ�ͷš���ť�ɵ��ʱ�������п��������������Դ�ͷš�����Ҫֱ�ӹرս��档</span>
			          <%}%>
			        </td>     
			      </tr>
			      <tr>  
								<td class="blue">�˺����ɺ���</td>
								<td  width="21%">
								<%/*diling update for �����ADSL�����ȥ�� v_type="0_9" ����������@�����֣�����λ�������18λ��@2012/9/17 */%>
								
								<input type="text" value="<%=isPhone?activePhone:""%>" name="cfm_loginF" v_type="<%=vTypeFlag%>" maxlength="<%=maxLengthSM%>" class ="required" onblur="checkCfmLogin(this)">
								<font class="orange"><=<%=maxLengthSM_str%></font>
								</td>
								<td class="blue">�����½�˺�</td>
								<td width="20%"> <input type="text" name="cfm_login"  id="cfm_login"  maxlength="25"  readOnly></td>
								<td class="blue"  width="8%">��ϵ��</td>
								<td><input type="text" name="contactCustName" id="contactCustName" class="required" maxlength="15" value=""> <font class="orange">*</font>  </td>
			      </tr>
			      <tr>
								<td width="12%" class="blue"><div align="left">����˺�����</div></td>
								<td width="12%"><input name="cfmPwd" type="password" onKeyPress="return isKeyNumberdot(0)" class="button"  maxlength="8" onFocus="showNumberDialog(document.all.cfmPwd) " pwdlength="8"><font class="orange">*</font> </td>
								<td width="12%" class="blue"><div align="left">����˺�����У��</div></td>
								<td width="12%" colspan="3"><input  name="cfmPwdConfirm" type="password" onKeyPress="return isKeyNumberdot(0)"  class="button" prefield="cfmPwd" filedtype="pwd" maxlength="8" onFocus="showReNumberDialog(document.all.cfmPwdConfirm)" pwdlength="8"><font class="orange">*�����½����Ĭ��Ϊ��¼�˺ź�6λ</font> </td>
								
						</tr>
						<tr>
						<td class="blue" width="8%">��ϵ�绰</td>
								<td colspan="7"><input type="text" name="contactPhone" id="contactPhone" class="required andCellphone" value=""> <font class="orange">*</font> </td>
						</tr>
			      <tr>
			        <td class="blue">��װ��ַ</td>
			        <td colspan="3"><input type="text" name="enter_addr" id="enter_addr" size=80 value="" maxlength="100"><font class="orange">*</font></td>
			        <td class="blue" data-bind="visible:smCode()=='ke'">���ű��</td>
			        <td data-bind="visible:smCode()=='ke'">
			        	<input type="text" name="unitId" id="unitId" 
			        	 maxlength="10" v_type="0_9" onblur = "checkElement(this)" />
			        </td>
			      </tr>  
			      <tr>
			        <td class="blue">С������</td>
			        <td> 	
			        	<input type="text"  name="area_nameh"  readonly >   	
			        </td>
			      	<td class="blue">���ž�����</td>
			      	<td>
			      		<input type="text" name="cctName"   readonly>
			      	</td>
			        <td class="blue">���뷽ʽ</td>
			        <td><input type="text" name="enter_type" maxlength="25" size=20 value=""  readonly></td>       
			     	</tr>
			      <tr>
					<tr>
						<td class="blue">����������</td>
			        	<td colspan='5' >
			        		<input type="text" name="partnerName" maxlength="25" 
			        			size=20  readonly class='InputGrey'></td>       
			     	</tr>
			     	
			     	<% if("ki".equals(sm_Code)){%>
			     	<tr>
								<td class="blue">����ն�</td>
			        	<td>
			        		<select name = "kdZd" id="kdZd" onchange="kdzdchange();showSN();">
			        			<option value="ONT">ONT</option>
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue" id="fysqfsdisplay1">������ȡ��ʽ</td>
			        	<td id="fysqfsdisplay2">
			        		<select id ="fysqfs" name = "fysqfs" onchange="FEEsqfs();showSN();">
			        			<option value="0">Ѻ��</option>
			        			<option value="1">����</option>	
			        			<option value="2">�Ա�</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	
			        	<td class="blue">����ն˷���</td>
			        	<td id="kdzdfydisplay" >
			        		<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must ="0" v_type="money" class='forMoney required'/>
			        		<font class="orange">*</font><span style="display:none" id="yjfwxianshi">Ѻ��Χ50-200Ԫ</span>       
			        	</td> 
			        	
			     	</tr>
			     	<tr>
						<td class="blue" id="sntitletd">S/N��</td>
			        	<td id="sntexttd">
			        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="50" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
			        	</td>
			        	<td class="blue">������ʽ</td>
			        	<td>
			        		<select id ="openkdFlag" name = "openkdFlag" onchange="checkOpenkdFlag1()">
			        			<option value="7">��ͨ���</option>
				        		<option value="8">��У���</option>
			        		<select>
			        		<font class="orange">*</font>
			        	</td>
			        	<td></td>
			        	<td></td>
			     	</tr>
			     	
			     	<%}%>
			     	
			     	<!-- 2014/09/05 10:20:57 gaopeng ����ʷ�չ�ּ��ն˹��������ϵͳ֧���Ż�����  -->
			     	<% if("kf".equals(sm_Code)){%>
			     	<tr>
								<td class="blue">����ն�</td>
			        	<td>
			        		<select name = "kdZd" id="kdZd" onchange="kdzdchange();showSN();">
			        			<option value="ONT">ONT</option>
			        			<option value="CPE">CPE</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue" id="fysqfsdisplay1">������ȡ��ʽ</td>
			        	<td id="fysqfsdisplay2">
			        		<select id ="fysqfs" name = "fysqfs" onchange="FEEsqfs();showSN();">
			        			<option value="0">Ѻ��</option>
			        			<!-- <option value="1">����</option> -->
			        			<option value="2">�Ա�</option>	
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	
			        	<td class="blue">����ն˷���</td>
			        	<td id="kdzdfydisplay" >
			        		<input type="text" name="kdZdFee" id="kdZdFee" value="" v_must ="0" v_type="money" class='forMoney required'/>
			        		<font class="orange">*</font><span style="display:none" id="yjfwxianshi">Ѻ��Χ50-200Ԫ</span>       
			        	</td> 
			        	
			     	</tr>
			     	<tr>
						<td class="blue" id="sntitletd">S/N��</td>
			        	<td id="sntexttd">
			        		<input type="text" name="snNumber" id="snNumber" maxlength="30" value="" size="50" v_must ="1" v_type="" class='required'/><font class="orange">*</font>
			        	</td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			        	<td></td>
			     	</tr>
			     	<tr>
			     		<td class="blue" >������ʽ</td>
			        	<td>
			        		<select id ="openkdFlag" name = "openkdFlag" onchange="checkOpenkdFlag()">
			        			<%if(!"52914".equals(offerId)){
			        				%><option value="0">��������</option>
				        			<option value="1">���Ǩ��(kh->kf)</option>
				        			<option value="2">ЭͬǨ��(kd->kf)</option>
				        			<option value="4">��ͨ����(ADSL/XDSL)</option>
				        			<option value="5">��ͨ����(FTTH/FTTB)</option><%
			        			} %>
								<%if("52914".equals(offerId)){
			        			%><option value="3">У԰����</option><%
								} %>
			        		<select>
			        			<font class="orange">*</font>
			        	</td>
			        	<td class="blue" >�Ƿ�װIMS�̻�</td>
			        	<td>
			        		<select id="anzhuangFangshi" name="anzhuangFangshi">
			        			<option value="" selected="selected">-��ѡ��-</option>
								<option value="00">��</option>
								<!-- <option value="01">��װ</option> -->
								<option value="02">��</option>
							</select>
							<font class="orange">*&nbsp;&nbsp;������������IMS�̻�����һ�������ѡ���ǡ�</font>
			        	</td>
			        	<td class="blue" id="yuankuandaiTd1">ԭ����˺�</td>
			        	<td id="yuankuandaiTd2">
			        		<input type="text" id="yuankuandaiNum" name="yuankuandaiNum" v_must="0" onblur="go_checkYuanzhanghao()">
			        		<font class="orange">*</font>
			        	</td>
			     	</tr>
		     		<tr>
							<td class="blue">�Ƿ�װħ�ٺ�</td>
		        	<td colspan = "3">
		        		<select id="ifMBH" name = "ifMBH" onchange="ifMBHShow();">
		        			<option value="0" selected>��</option>	
		        			<option value="1" >��</option>
		        		<select>
		        			<font class="orange">*</font>
		        			<font class="red">������������ħ�ٺ�Ӫ����һ�������ѡ���ǡ���������ѡ�񡰷�</font>
		        	</td>
		        	<td></td><td></td>
			     	</tr>
			     	<tr id="ifMBH_show" style="display:none">
			     		<td class="blue" style="display:none">���ߵ���</td>
		        	<td style="display:none">
		        		<select name = "yxds" onchange="yxdsShow();">
		        			<option value="����ͨ" >����ͨ</option>
		        			<option value="δ������">δ������</option>	
		        		<select>
		        			<font class="orange">*</font>
		        	</td>
		        	<td class="blue">������ID</td>
		        	<td colspan="3">
		        		<input type="text" name="jdhId" size="60"  id="jdhId" value="" v_must ="0" maxlength="32" />
		        		<font class="orange">*</font>      
		        	</td> 
			     	</tr>
			     	
			     	<%}%>
			     	<!-- 2016/4/5 15:12:35  gaopeng  -->
			     	<% if("kd".equals(sm_Code)){%>
			     	<tr>
							<td class="blue">�Ƿ�װħ�ٺ�</td>
		        	<td colspan = "3">
		        		<select name = "ifMBH" onchange="ifMBHShow();">
		        			<option value="0" selected>��</option>	
		        			<option value="1" >��</option>
		        		<select>
		        			<font class="orange">* ������������ħ�ٺ�Ӫ����һ�������ѡ���ǡ���������ѡ�񡰷�</font>
		        	</td>
			     	</tr>
			     	<tr id="ifMBH_show" style="display:none">
			     		<td class="blue" style="display:none">���ߵ���</td>
		        	<td style="display:none">
		        		<select name = "yxds" onchange="yxdsShow();">
		        			<option value="����ͨ" >����ͨ</option>
		        			<option value="δ������">δ������</option>	
		        		<select>
		        			<font class="orange">*</font>
		        	</td>
		        	<td class="blue">������ID</td>
		        	<td colspan="3">
		        		<input type="text" name="jdhId" size="60"  id="jdhId" value="" v_must ="0" maxlength="32" />
		        		<font class="orange">*</font>      
		        	</td> 
			     	</tr>
			     	<%}%>
			      <tr>
			        <td class="blue">ʩ��Ҫ��</td>
			        <td colspan=3>
			        	<%if(!ifHappyMoreThan50M){
			        		%>
			        		<select name="construct_request">
				        		<option value="HGU��è��Wi-Fi" selected>HGU��è��Wi-Fi</option>
				        		<option value="SFU��è">SFU��è</option>
				        		<option value="�û��Ա���è">�û��Ա���è</option>
			        		</select>
			        		<%
			        	}else{
			        	%>
			        	<select name="construct_request">
			        		<option value="HGU��èWi-Fi" selected>HGU��èWi-Fi</option>
			        		<option value="SFU��è">SFU��è</option>
			        		<option value="�û��Ա���è">�û��Ա���è</option>
			        	</select>
			        	<%	
			        	}
			        	%>
			        </td> 
			        <td class="blue">ʩ�����ɷ�ʱ��</td>
				      <td><input type="text" name="appointvTime"  maxlength="8" id="appointvTime"  v_format="yyyyMMdd" class="required" value=""><font class="orange">(��ʽYYYYMMDD)</font><br/><font class="red">��ʱ�������û�ȷ�Ϻ���д</font></td>	
			      </tr>  
					  <tr>
					   	<td class="blue">�û�����</td>
					    <td><input readonly type="text" name="phoneNo_h" size="20" maxlength="20" >
					    <input type="hidden" name="cust_attr" value="0">
					    </td>
              <%if(is68flag.equals("yes")) {%>
					    <td class="blue">
					    	<div style="display:none">
					    		<input type="checkbox" id="joinMarket" name="joinMarket"
					    		data-bind="checked:useMarket"/>
					    	</div>
                ����Ӫ����
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept" name="marketAccept"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo" name="marketPhoneNo" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="У��" onclick="marketCheckFunc68()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <!-- 2013/07/24 9:58:30 gaopeng  ����һ������Ӫ������״̬ 1Ϊ���ۿ����0Ϊ0Ԫ�ʷѵĿ���� -->
                 <input type="hidden" id="joinType" name="joinType" value="1"/>
              </td>
              <%}else if(isSSflag.equals("yes") && isSS2flag.equals("yes")){ %>
              <td class="blue">
					    	<div style="display:none">
					    		<input type="checkbox" id="joinMarket" name="joinMarket"
					    		data-bind="checked:useMarket"/>
					    	</div>
                ����Ӫ����
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept" name="marketAccept"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo" name="marketPhoneNo" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="У��" onclick="marketCheckFunc68()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <!-- 2013/07/24 9:58:30 gaopeng  ����һ������Ӫ������״̬ 1Ϊ���ۿ��(����ͨ��Ȼ�¿��)��0Ϊ0Ԫ�ʷѵĿ���� -->
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
                ����Ӫ����
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept" name="marketAccept"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo" name="marketPhoneNo" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="У��" onclick="marketCheckFunc()" class="b_text"
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
                ����Ӫ����
              </td>
              <td colspan="3" data-bind="visible:useMarket">
                <input type="text" id="marketAccept58_88" name="marketAccept58_88"
                  maxlength="14" v_type="0_9"/>
                <input type="hidden" id="marketPhoneNo_58_88" name="marketPhoneNo_58_88" />
                <input type="button" id="marketBtn" name="marketBtn"
                 value="У��" onclick="marketCheckFunc58_88()" class="b_text"
                 data-bind="disabled:marketCheck"/>
                 <input type="hidden" id="joinType" name="joinType" value="0"/>
              </td>
              <%
              }%>
              
          </tr>
          <!--2015/04/14 14:16:50 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� �����Ƿ�ʹ�û��ֵĹ���ҳ�� 
          	���band_idΪ67 Ҳ����smcodeΪkf ����ΪynkbҲ���ǰ����ʷѵ�ʱ��չʾ������Ϣ
          -->
          <%if("yes".equals(ifUseIntegFlag)){%>
          	<%@include file="/npage/public/integralInfo.jsp"%>
          <%}%>
        </table>

				<div class="input" id="productInfo">
						<br>
						<div class="title">
						<div id="title_zi">��Ʒ��Ϣ</div>
			 		  </div>

						<div id="majorProdRel"></div> 

						<div id="prodAttribute"></div> <!--��Ʒ����-->

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
										<input type="checkbox" value="5" name="contact_type" v_div="vouch" onclick="check_o(this)">������&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="servsla_info" v_div="servsla" onclick="check_o(this)">����SLA��Ϣ&nbsp;&nbsp;&nbsp;&nbsp;
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

<!-- ��������Ʒ ����-->
<!-- ��������Ʒ ��ʼ-->
<DIV class="undis" id="tbc_02" style="display:none">
	
		<div class="title">
		<div id="title_zi">��������Ʒ</div>
	  </div>
	  <table cellSpacing=0 id="adddiscount">
	  </table>
		<div id="offer_component"></div> 
		<div id="div_offerComponent"></div> 

</DIV>
<!-- ��������Ʒ ����-->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=sysAcceptl%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table cellSpacing=0>
	<tr id="footer">
				<td align="center"> 
						<INPUT class=b_foot_long id="cfmBtn" onClick="mySub()" type=button value=ȷ��&��ӡ />
						<INPUT class=b_foot_long id="cfmOffer" onClick="cfmOfferf()" type=button value=����Ʒѡ��ȷ��  style="display:none" />
						<INPUT class=b_foot onclick="ignoreThis()" type=button value=����> 
						<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=ȡ��> 
			  </td>
	</tr>
</table>
<input type="hidden" name="offerId" value="<%=offerId%>" />
<input type="hidden" name="majorProductId"/>
<input type="hidden" name="assureId" value="0"/><!--�ͻ������˱�ʶ-->
<input type="hidden" name="assureNum" value="0"/><!--�ѵ���������-->
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
<!--����Ʒ��Ϣ-->
<input type="hidden" name="offerIdArr"/>
<input type="hidden" name="offerEffectTime"/>
<input type="hidden" name="offerExpireTime"/>
<!--��Ʒ��Ϣ-->
<input type="hidden" name="sonParentArr"/>
<input type="hidden" name="productIdArr" />
<input type="hidden" name="prodEffectDate"/>
<input type="hidden" name="prodExpireDate"/>
<input type="hidden" name="isMainProduct"/>
<input type="hidden" name="offer_productAttrInfo"/><!--������Ϣ-->

<!--Ⱥ����Ϣ-->
<input type="hidden" name="groupInstBaseInfo"/>
<input type="hidden" name="addGroupIdArr"/><!--��ϲ�Ʒ�����Ŀ�ѡȺ��-->

<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>" /> <!--��ˮ-->

<input type="hidden" name="groutDesc" id="groutDesc" value="" />
<input type="hidden" name="offId" id="offId" value="<%=offerId%>" /><!--������Բ�ѯ����-->

<input type="hidden" name="newZOfferECode"/>
<input type="hidden" name="newZOfferDesc"/>                         
<input type="hidden" name="dOfferId"/>
<input type="hidden" name="dOfferName"/>
<input type="hidden" name="dECode"/>
<input type="hidden" name="dOfferDesc"/>
<input type="hidden" name="path"/> 

<input type="hidden" name= "largess_card_sum" value="<%=strCardSum%>"> <!-- �������ͳ�ֵ����������-->
<!--<input type="hidden" name="groupId" value="<%=groupId%>"/>-->

<input type="hidden" id="work_flow_no" name="work_flow_no" value="<%=work_flow_no%>"/>
<input type="hidden" id="level4100" name="level4100" value="<%=level4100%>"/>
<input type="hidden" id="transJf" name="transJf" value="<%=transJf%>"/>
<input type="hidden" id="transXyd" name="transXyd" value="<%=transXyd%>"/>
<!--<input type="hidden" name="smCodeh"  value="kd"/>-->
<!--Ԥռ��Դ��Ϣ-->
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
<input type="hidden" name="belongCategory" value=""><!--������� 2014/04/03 11:10:26 gaopeng-->
<input type="hidden" name="bearType" value=""><!--���ط�ʽ 2014/04/03 11:10:28 gaopeng-->
<input type="hidden" name="propertyUnit" value=""><!--С���������� 2014/5/29 15:31:14-->
<input type="hidden" name="distKdCode" value=""><!--С������ 2014/5/29 15:27:10-->
<input type="hidden" name="nearInfo" value=""><!--С��������� 2014/5/29 15:27:10-->
<input type="hidden" name="cfmPwdEncrypt" id="cfmPwdEncrypt" />
<input type="hidden" name="cfmPwdEncryptFlag" id="cfmPwdEncryptFlag" value="0" />
<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" >
<input type="hidden"  id="cfmLoginCheck" name="cfmLoginCheck"  value="0" >
<input type="hidden"  id="isYzPhoneNo" name="isYzPhoneNo"  value="0" >
<input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
<input type="hidden"  id="noPort" name="noPort"  value="0" >
<!---- �Ƿ���ҪԤռ    0����Ҫ     1��Ҫ --->
<input type="hidden"  id="isNeedHold" name="isNeedHold"  value="<%=isNeedHold%>" >
<!--��Դ������������-->
 
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
