<%
  /*
   * ����: ��վ����
   * �汾: 2.0
   * ����: 2010/11/25
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String passwd = ( String )session.getAttribute ( "password" );
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
<%

String dateStart="20150901";     
String dateEnd="20151130";    
String nowDate =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();

boolean ifCanShow = false;

if(!"".equals(nowDate)){
	if(Integer.parseInt(nowDate) >= Integer.parseInt(dateStart) && Integer.parseInt(nowDate) <= Integer.parseInt(dateEnd)){
		ifCanShow = true;
	}
}

String passFlag = "";
boolean pwrf=false;
String tempStrf = "";


		 ArrayList arr = (ArrayList)session.getAttribute("allArr");
		 String[][] temfavStr=(String[][])arr.get(3);
		 int infoLen = temfavStr.length;
		    for(int i=0;i<infoLen;i++)
			{
			    tempStrf = (temfavStr[i][0]).trim();
			    if(tempStrf.trim().equals("aq01"))
			    {
			      	 pwrf = true;
			    }
			}
	
	if (pwrf)
	{
	 	passFlag="";
	}
	else
	{
		passFlag="none";
	}
	
	System.out.println("------------------passFlag---------------------"+passFlag);
	
    Calendar today =   Calendar.getInstance();  
    today.add(Calendar.MONTH,3);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
    String addThreeMonth = sdf.format(today.getTime());
    System.out.println("### addThreeMonth = "+addThreeMonth);
    
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
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
    System.out.println("---------------servBusiId---------------------"+servBusiId);     
    System.out.println("---------------custOrderId---------------------"+custOrderId);     
    String custOrderNo=WtcUtil.repNull(request.getParameter("custOrderNo"));    
    String orderArrayId = WtcUtil.repNull(request.getParameter("orderArrayId"));
    String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
    String servOrderId = WtcUtil.repNull(request.getParameter("servOrderId"));
    String closeId = request.getParameter("closeId");
    
    //weigp===================
    String prtFlag = "Y"; //request.getParameter("prtFlag");//Ĭ��Ϊ�ϴ�Y     �ִ�ΪN
    //weigp===================
    String blindAddCombo = "";//WtcUtil.repNull(request.getParameter("blindAddCombo"));
    
    
    
    String brandID = "";
		String brandName= "";
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String offerName	= WtcUtil.repNull(request.getParameter("offerName"));
		
		
		System.out.println("---------------orderArrayId---------------------"+orderArrayId);     
    System.out.println("---------------gCustId---------------------"+gCustId);
    System.out.println("---------------servOrderId---------------------"+servOrderId);     
    System.out.println("---------------closeId---------------------"+closeId);
    System.out.println("---------------prtFlag---------------------"+prtFlag);     
		System.out.println("---------------offerId---------------------"+offerId);     
		System.out.println("---------------offerName-------------------"+offerName);     
		
		String expDateOffset = "";
		String expDateOffsetUnit = "";
		String offerComments = "";
		String groupTypeId = "";
    
    String workFormId=orderArrayId;
		String svcInstId = WtcUtil.repNull(request.getParameter("offerSrvId"));
		System.out.println("---------------svcInstId-------------------"+svcInstId);     
		String branchNo="";

		String region_flag="sx";
		
		String offerName_h = "";
		
		String offerNameById = "select offer_name from product_offer where offer_id = '"+offerId+"'";
		
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
    String custPwd = request.getParameter("custPwd");
    String ipt_PhoneID = request.getParameter("ipt_PhoneID");
    System.out.println("chenlei---ipt_PhoneID------------ipt_PhoneID-----------------"+ipt_PhoneID); 
    String occupId = request.getParameter("occupId").trim();
    String areaCode = request.getParameter("areaCode");
    String prePay_Fee = request.getParameter("prePay_Fee");
    String simPay_fee = request.getParameter("simPay_fee");
    String phone_no = request.getParameter("phone_no");	//huangrong add 2011-8-19 
    
    String idIccid = request.getParameter("idIccid");	//huangrong add 2011-8-19 
    
    String flag_code1="";//С���ʷѴ���   huangrong add 2011-8-29 
    String flagCodeString="select FLAG_CODE from dwebopenphonemsg where phone_no='"+phone_no+"'";
    
    /*gaopeng 2014/05/06 10:24:36 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� */
    String outSimName = WtcUtil.repNull(request.getParameter("outSimName"));
    String outSimType = WtcUtil.repNull(request.getParameter("outSimType"));
    
    System.out.println("gaopengSeeLog---------------outSimName-----------------"+outSimName); 
    System.out.println("gaopengSeeLog---------------outSimType-----------------"+outSimType); 
    String simResBrandCode ="";
    
    /*2015/9/7 13:53:52 gaopeng ���ڿ����������ͻ����Ͳ��塢�����м����Ķ���Ʒ�������������ĺ�
    	���������ѯ�Ƿ���ʾ����
    */
    String backCode= "";
    String backInfo = "";
    
%>

<%
	/*2014/05/26 11:10:47 gaopeng ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ����sql����ѯ����*/
	/*gaopeng 2014/05/26 11:07:39 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� ��ѯsql �����K06 �ٽ���У��*/
	String simResSql = "select brand_code from srescode where res_code = '"+outSimType+"'";
%>	
	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCodeRes" retmsg="retMsgRes">
		<wtc:sql><%=simResSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultRes" scope="end"/>

<%
	if(resultRes.length > 0 && "000000".equals(retCodeRes)){
		simResBrandCode = resultRes[0][0];
		System.out.println("gaopengSeeLog===simResBrandCode="+simResBrandCode);
	}
%>

<wtc:service name="sTSInfoBack" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_sTSInfoBack" retmsg="retMessage_sTSInfoBack" outnum="1"> 
    <wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passwd%>"/>
		<wtc:param value="<%=phone_no%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=offerId%>"/>
  </wtc:service>  
  <wtc:array id="result_sTSInfoBack"  scope="end"/>
<%
	backCode = retCode_sTSInfoBack;
	backInfo = retMessage_sTSInfoBack;
	System.out.println("gaopengSeeLogBusi==========backCode======"+backCode);
	System.out.println("gaopengSeeLogBusi==========backInfo======"+backInfo);
	String main_k_flag      = "";
	String main_k_type      = "";
	
%>
 


	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodeFlag" retmsg="retMsgFlag" outnum="1">
	<wtc:sql><%=flagCodeString%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultFlagCodeString" scope="end" />
	
	<%
    System.out.println("------------------------------------resultFlagCodeString-----------------"+resultFlagCodeString); 
	  if(!retCodeFlag.equals("000000")){
%>
	   <script language="javascript">
	   	  rdShowMessageDialog("��ѯС������ʧ��");
	   	  parent.removeTab('<%=opCode%>');
		 </script>
<%	
	  }		
	  if (resultFlagCodeString.length > 0 && resultFlagCodeString!=null){
			flag_code1 = (resultFlagCodeString[0][0]).trim();

		}
		    System.out.println("////////////////////////////////////////////////resultFlagCodeString-----------------"+flag_code1); 



 	  String is_check_readcard_result = "";
 	  String is_check_readcard_sql = " select to_char(count(*)) as count_col from wWebGoodPhoneopr "+
 	  															 " where status='2' and order_flag='3' "+
 	  															 " and phone_no=:kaihuphoneno "+
 	  															 " and id_iccid=:idIccid ";
 	  String is_check_readcard_sql_p1 = "kaihuphoneno="+phone_no+",idIccid="+idIccid;
 	  String is_check_readcard_sql_p2 = "";
 	  
 	  System.out.println("hejwa------------is_check_readcard_sql------------------->"+is_check_readcard_sql);
 	  System.out.println("hejwa------------is_check_readcard_sql_p1---------------->"+is_check_readcard_sql_p1);
 	  //System.out.println("hejwa------------is_check_readcard_sql_p2---------------->"+is_check_readcard_sql_p2);
 	  
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="1"> 
	<wtc:param value="<%=is_check_readcard_sql%>"/>
	<wtc:param value="<%=is_check_readcard_sql_p1%>"/>
</wtc:service>  
<wtc:array id="ret_is_check_readcard"  scope="end"/>
	
<%
if(ret_is_check_readcard.length>0){
	is_check_readcard_result = ret_is_check_readcard[0][0];
	System.out.println("hejwa------------is_check_readcard_result---------------->"+is_check_readcard_result);
}

%>


<!--��ѯ������־-->

    <wtc:service name="sGetDetailCode" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=offerId%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=opCode%>" />	
		</wtc:service>
		<wtc:array id="result_t33" scope="end"   />
			
<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql><%=offerNameById%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result22" scope="end"/>
	
<%

	if(result22.length>0&&result22[0][0]!=null){
		offerName_h= result22[0][0];
	}
	offerName = offerName_h;
%>	
<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql>select province_code from sProvinceCode where run_flag='Y'</wtc:sql>
</wtc:pubselect>
<wtc:array id="_region_flag">
	<%if(_region_flag[0][0].equals("089")){
					region_flag = "xj";
	}%>
</wtc:array>

<%
    String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String sysDate_Good=dateStr2;
		String currTime = new SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault()).format(new Date());
		String userGroupId = "";
		String userGroupName = "";
		String sqlStr = "SELECT a.parent_group_id,b.group_name FROM  dChnGroupInfo a, dChnGroupMsg b WHERE a.group_Id ='"+groupId+"' AND a.parent_level=4 AND a.parent_group_id=b.group_id";
%>
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>	
<wtc:array id="result1" scope="end"/>
<%
	if(retCode.equals("000000") && result1.length > 0){
		userGroupId = result1[0][0];
		userGroupName = result1[0][1];
	}
%>
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
	
	System.out.println("liubo groupTypeIdgroupTypeIdgroupTypeId==="+groupTypeId);
	
	String prodId = brandID;
%>
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
	String sqlStr1 = "select b.contract_no,c.bank_cust,d.type_name from dServOrderMsg a,dCustMsg b,dConMsg c,sAccountType  d where a.order_array_id='"+orderArrayId+"' and a.id_no = b.id_no and b.contract_no = c.contract_no AND c.account_type = d.account_type and a.service_no<>'0'";
	String contractInfo = "";
	if(returnCode.equals("0") && retGrpVal.getUtype("2").getSize()>0){
		for(int i=0;i<retGrpVal.getUtype("2").getSize();i++){
			groupIdStr = groupIdStr + retGrpVal.getValue("2."+i+".1")+",";
			groupNameStr = groupNameStr + retGrpVal.getValue("2."+i+".3")+",";
			if(retGrpVal.getValue("2."+i+".2").equals("180")){
				groupType = retGrpVal.getValue("2."+i+".2");
			}	
		}
	}
	
	if(groupType.equals("180")){
%>	
		<wtc:pubselect name="sPubSelect" outnum="3">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>	
		<wtc:array id="result2" scope="end"/>
<%			
		if(retCode.equals("000000") && result2.length > 0){
			contractInfo = result2[0][0]+"~"+result2[0][1]+"~"+result2[0][2];
		}
	}
System.out.println("contractInfo=============================="+contractInfo);
System.out.println("hj=============================="+orderArrayId);
%>
<%String regionCode_sGetOrdAryData = (String)session.getAttribute("regCode");%>
<wtc:utype name="sGetOrdAryData" id="retOrdAryVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sGetOrdAryData%>">	
	<wtc:uparam value="<%=orderArrayId%>" type="STRING"/>
</wtc:utype>	
<%
	 String strArray="var ordArray; ";
	 returnCode = String.valueOf(retOrdAryVal.getValue(0));
	 returnMsg = retGrpVal.getValue(1);
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


<%
	String belongCode =orgCode.substring(0,7);
	String beginDate = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date());
	String payCode = "0";
	String bankCode = "";
	String postCode = "";
	String accountType = "0";
	String endDate = "20501231";
	String accountNo = "0";

%>


<%
	String strCardSum="0";
	String strSql = "select card_sum from sInnetCard where region_code='"+regionCode+"' and district_code = '"+strDistrictCode+"' and op_code='"+opCode+"' and card_type='00' and sysdate between begin_time and end_time";
	System.out.println("strSql="+strSql);

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
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	
<%
System.out.println("-----------------------sysAcceptl---------------------------"+sysAcceptl);

%>	
<%
String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
String sm_Code = "";
String smCodeSql = "SELECT  Sm_Code FROM Band where  Band_Id = "+brandID;
String custInfoSql = "SELECT cust_address, id_iccid  FROM dcustdoc where cust_id ="+gCustId;
System.out.println("smCodeSql|"+smCodeSql);
%>
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=smCodeSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>
	 	
<%

String ipAddr = ( String )session.getAttribute ( "ipAddr" );
String opNote = "����cust_id:"+gCustId+"��ѯ�û�����,�������Ϣ.";
System.out.println("zhangyan~~basicOpenLogin~~sUserCustInfo=");
%>	 	
<wtc:service name = "sUserCustInfo"  outnum = "30" routerKey = "region" routerValue = "<%=regionCode%>"  
	retcode = "ret_code" retmsg = "retMessage1"  >
	<wtc:param value = "0"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
	<wtc:param value = "<%=ipAddr%>"/>
	<wtc:param value = "<%=opNote%>"/>
	<wtc:param value = "<%=gCustId%>"/>
	
	<wtc:param value = ""/>
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id = "result_custInfo" scope = "end" />	 	
<%	 	
System.out.println("zhangyan~~basicOpenLogin end ~~sUserCustInfo=");
if(result_t1.length>0&&result_t1[0][0]!=null)  sm_Code = result_t1[0][0];

String custIccid = "";
String custAddr = "";
if(result_custInfo.length>0){

	custAddr = result_custInfo[0][11];
	custIccid = result_custInfo[0][13];
	System.out.println("zhangyan~~~~custAddr="+custAddr);
	System.out.println("zhangyan~~~~custIccid="+custIccid);
}

String sqlOfferExpDate = "select exp_date_offset ,exp_date_offset_unit from product_offer where offer_id='"+offerId+"'";

%>
	 	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlOfferExpDate%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_ExpDateSet" scope="end"/>
	 	
	 	<%
	 		String offExpSet = "";
	 		String offExpSetUnit = "";
	 		
	 		if(result_ExpDateSet.length>0){
	 			offExpSet = result_ExpDateSet[0][0];
	 			offExpSetUnit = result_ExpDateSet[0][1];
	 		}
	 		System.out.println("---------offExpSet--------------------"+offExpSet);
	 		System.out.println("---------offExpSetUnit----------------"+offExpSetUnit);
	 		String offExpDate = getExpDate(offExpSet,offExpSetUnit);
	 		System.out.println("---------offExpDate----------------"+offExpDate);
	 	%>
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

<% 
	if(!"".equals(ipt_PhoneID)){
%>
  <wtc:service name="sBLKOfferCheck" outnum="2" retmsg="blkMsg" retcode="blkCode" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=passwd%>"/>
		<wtc:param value=""/>
	  	<wtc:param value=""/>
	  	<wtc:param value="<%=offerId%>"/>
	</wtc:service>
	<wtc:array id="result_mainK" scope="end"/>
<%
	if("000000".equals(blkCode)){
		main_k_flag = result_mainK[0][0];
		main_k_type = result_mainK[0][1];
	}
	
	System.out.println("-------chenlei--b893---------------main_k_flag---------->"+main_k_flag);
	System.out.println("-------chenlei--b893---------------main_k_type---------->"+main_k_type);
	
	//7����׼�����
		String paraAray[] = new String[10];
		
		paraAray[0] = "";                                       //��ˮ
		paraAray[1] = "01";                                     //��������
		paraAray[2] = opCode;                                   //��������
		paraAray[3] = (String)session.getAttribute("workNo");   //����
		paraAray[4] = (String)session.getAttribute("password"); //��������
		paraAray[5] = ipt_PhoneID;                                  //�û�����
		paraAray[6] = "";                                       //�û�����
		paraAray[7] = g_CustId;
		paraAray[8] = main_k_type;
		paraAray[9] = offerId;
		

		String serverName = "sPhoneIDCheck";
		try{
			%>		
			<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<%
						for(int i=0; i<paraAray.length; i++ ){
							System.out.println("-----chenlei-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
			%>
							<wtc:param value="<%=paraAray[i]%>" />
			<%					
						}
			%>									
					</wtc:service>
					<wtc:array id="serverResult" scope="end"  />
			<%
				retCode = code;
				retMsg = msg;
				
			 
			}catch(Exception ex){
				retCode = "404040";
				retMsg = "���÷���"+serverName+"��������ϵ����Ա";
			}


				System.out.println("--chenlei--------retCode-----serverName=["+serverName+"]---------"+retCode);
				System.out.println("--chenlei--------retMsg------serverName=["+serverName+"]---------"+retMsg);
				if(!"000000".equals(retCode)){//���÷���ʧ��
					%>
					<script language="javascript" >
						rdShowMessageDialog("<%=retCode%>"+"��"+"<%=retMsg%>");
				 		removeCurrentTab();
					</script>
					<% 
				     
				      
				}
		
	
	}%>
			
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

<!-- ����Ʒ��ϸ����ʽ -->
<SCRIPT language=JavaScript>
//tabҳ����
var objectId="<%=objectId%>";//ѡ����
var branchNo=""; //ѡ����
var svcId = "1"; //����id ѡ����
var srcNum = "<%=num%>";	  //��Դ���� ѡ����
var prodId = "";	//ѡ����
var vasProds = "<%=prodId%>"+"~"; //ѡ����
var masterServId = "";
var releaseNumFlag = true;		//�Ƿ��ͷź����ʶ

var offerId = "<%=offerId%>";	//����ƷID
var offerNodes;
var nodesHash = new Object(); //����IDȡ����Ʒ ��Ʒ�ڵ�
var groupHash = new Object(); //����ƷId=Ⱥ����Ϣ����Ⱥ����Ϣ�鿴����
var offerGroupHash = new Object(); //����ƷId=Ⱥ����Ϣ�ύ����
var AttributeHash = new Object(); //����Ʒ/��ƷId=������Ϣ
var prodCompIdArray = [];									//���Ӳ�Ʒ������Ϣ

//-----��Ʒ�������������˵��-----
var CDMATypeId = "0";
var GUTypeId = "1";
var ADSLTypeId = "2";
var VPNTypeId = "10";
var NetElementTypeId = "5";
//---�������ID----
var MSID_CM = 8006;
var MSID_IDC = 8008;
var MSID_oneNum = 8009;
//-----����Ʒ,��Ʒ����˵��----
var prodType = "O";
var majorProdType = "M";
var offerType = "10C";
var brandId_190 = "3";

var isOfferLoaded = false;  //�Ƿ��Ѿ���������Ʒ������ϸ

var offerTrafficflag="0"; //0�Ƕ��������ʷ��������㣬��0Ϊ���������ʷ�����������

//-----����Ʒ��ѡ��ʽ---------
var selOfferType = "";
var ordArrayHash = new Object();
var xqdm = "";   //С���Ʒ�

//��¼���е���������
var myArrs = new Array("1027","1026","1025","2042");

$(document).ready(function () {
		
		
		if("<%=gCustId%>" == "0"){
			rdShowMessageDialog("�ͻ�ID�쳣,����ϵ����Ա!");
			window.close();	
		}	
		if("<%=contractInfo%>" != ""){
			$("#btn_getConNo").attr("disabled",true);
			$("#contractNo").val("<%=contractInfo%>".split("~")[0]);
			$("input[name='contractName']").val("<%=contractInfo%>".split("~")[1]);
			$("input[name='contractType']").val("<%=contractInfo%>".split("~")[2]);
		}	
		
		if(typeof(ordArray) != "undefined"){
			for(var i=0;i<ordArray.length;i++){
				ordArrayHash[ordArray[i][1]] = ordArray[i][3];
				if(ordArray[i][1] == "20004"){
				 	selOfferType = ordArray[i][3];
				 	$("#innetType").val(selOfferType);
				}	
			}
			
			if(selOfferType == "03"){				//�������
				if(typeof(ordArrayHash["20005"]) != "undefined" && typeof(ordArrayHash["20006"]) != "undefined"){
					$("input[name='imeiNo']").val(ordArrayHash["20005"]);		
					$("input[name='saleMode']").val(ordArrayHash["20006"]);	
				}			
			}else if(selOfferType == "08"){				//�������� weigp
				//alert("weigp add:"+selOfferType);
				//document.all.cardTypeN.options[1].selected = true;
				//$("#cardTypeN").attr("disabled",true);
				$("#simCode").attr("readonly",true);
				$("#simCode").removeClass("required"); 
				$("#cardTypeN").replaceWith("<div><input type='hidden' name='cardTypeN' value='1'/>��</div>"); 
				$("#sfgz1").css("display","none");
				$("#sfgz2").css("display","none");
				$("#sfzl").css("display","none");
				document.all.writecardbz.value="0";
				document.all.cardtype_bz.value="k";
				
				//$("#selNum").bind("blur",function(){alert("success");});
		  	}else if(selOfferType == "04"){		//��������
				if(typeof(ordArrayHash["20007"]) != "undefined" && typeof(ordArrayHash["20008"]) != "undefined"){
					$("input[name='selNum']").val(ordArrayHash["20007"]);	
					$("input[name='goodType']").val(ordArrayHash["20008"]);	
					document.all.selNum.readOnly=true;
					$("#serviceNoInfo :radio").attr("disabled",true);			//����������
				}
			}
		}
		else{
			rdShowMessageDialog("ȡ����Ʒѡ��ʽ�쳣!");
		}
		
		if("<%=brandID%>" == "1012"){						//�½�����
			$("#userpwd").val("123456");
			$("#userpwdcfm").val("123456");
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
		
		$("#serviceNoInfo :radio").bind("click",choiceInputType);
		$("#orderInfoDiv").bind("click",getOrderInfo);
		$("#simCode").bind("change",function(){$("#cfmBtn").attr("disabled",true);});	//SIM���仯ʱ,ȷ����ť������
		$("#tr_contractNoType").css("display","none");
		
		if("<%=powerRight%>".trim() == "0"){		//Ȩ��Ϊ0ʱ,����ʾ"��Ƿͣ"
			$("#controlType").html("<option value='B'>Ƿͣ</option>");
		}
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
		 
		if((typeof(document.all.vouch_idType)!="undefined")&&(typeof(document.all.vouch_idNo)!="undefined"))
		{	
			change_idType();			//��ԭ���ύǰ��֤������   
		}
		

		
		$("#userGroupId").val("<%=userGroupId%>");					 		 
		 getMidPrompt("10442","<%=offerId%>","td_offerName");
		/* ningtn ��� */
		$("#contractNo").val("");		 
});



$(window).unload(function(){
	 if(releaseNumFlag){
			releaseNum();
		}
}); 

function GoodPhoneDateChg()
{
	if(document.all.GoodPhoneFlag.value == "Y")
	{
		//�������,Ĭ�Ͽɹ���ʱ��Ϊϵͳʱ���Ҹ�ʱ����޸�
		document.all.GoodPhoneDate.value = <%=sysDate_Good%>;
		document.all.GoodPhoneDate.disabled=false;
	}
	else
	{
		//���������,Ĭ�Ͽɹ���ʱ��Ϊ�̶�ʱ���Ҹ�ʱ�䲻���޸�
		document.all.GoodPhoneDate.value="20500101";
		document.all.GoodPhoneDate.disabled=true;
	}
}
	
function getMajorProd()
{
	 	var packet1 = new AJAXPacket("/npage/s1104/getMajorProd.jsp","���Ժ�...");
		packet1.data.add("offerId" ,offerId);
		core.ajax.sendPacketHtml(packet1,doGetMajorProd);
		packet1 =null;
}



function getOfferAttr()
{
		var packet1 = new AJAXPacket("getOfferAttr.jsp","���Ժ�...");
		packet1.data.add("OfferId" ,offerId);
		//packet1.data.add("areaCode","<%=areaCode%>");
		core.ajax.sendPacketHtml(packet1,doGetOfferAttr);
		packet1 =null;
}

</script>
<script language=JavaScript>
function  getOfferDetail()
{
 		var packet = new AJAXPacket("/npage/s1104/offerDetailQry_new.jsp","���ڼ��ظ�������Ʒ������ϸ�����Ժ�...");
		packet.data.add("goodNo" ,document.all.selNum.value); 
		packet.data.add("offerId","<%=offerId%>"); 		
		packet.data.add("opCode","<%=opCode%>"); 		
		core.ajax.sendPacketHtml(packet,doGetHtml,true);
		packet =null;
}

//������������Ʒʱ��
function setEffectTime()
{
	var addOfferId = this.id.substring(8);
	var effTime = nodesHash[addOfferId].begTime.substring(0,8);
	var expTime = nodesHash[addOfferId].expireTime.substring(0,8);
	if(this.value == 1){
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

function getOfferRel() 
{
	var packet2 = new AJAXPacket("/npage/s1104/getOfferRel.jsp","���ڼ��ظ�������Ʒ����������ϵ,���Ժ�...");
	packet2.data.add("offerId" ,offerId);
	core.ajax.sendPacketHtml(packet2,doGetOfferRel,true);
	packet2 =null;
}

function getMasterServType(majorProductId)
{
	var packet1 = new AJAXPacket("/npage/s1104/getMasterServType.jsp","���Ժ�...");
	packet1.data.add("majorProductId",majorProductId);
	core.ajax.sendPacket(packet1,doGetMasterServType);
	packet1 =null;
}

function  getProdAttr(majorProductId)
{
	var packet2 = new AJAXPacket("/npage/s1104/getProdAttr.jsp","���Ժ�...");
	packet2.data.add("majorProductId" ,majorProductId);
	core.ajax.sendPacketHtml(packet2,doGetpordAttribute);
	packet2 =null;
}

function getProdCompInfo(majorProductId)
{
	var packet3 = new AJAXPacket("/npage/s1104/getProdCompDet.jsp","���Ժ�...");
	packet3.data.add("goodNo" ,document.all.selNum.value); 
	packet3.data.add("groupId" ,"<%=groupId%>");
	packet3.data.add("selOfferType",selOfferType);//weigp add ����
	packet3.data.add("majorProductId" ,majorProductId);
	packet3.data.add("offerId" ,offerId);
	core.ajax.sendPacket(packet3,doGetProdCompInfo);
	packet3 =null;
}

function getProdCompRel(majorProductId)
{
	var packet2 = new AJAXPacket("/npage/s1104/getProdCompRel.jsp","���ڼ��ظ�����Ʒ��������ϵ,���Ժ�...");
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
		  
		  
		 	//����Ʒ�ĺ�����������//	
		}
		else
		{
			rdShowMessageDialog("������Ʒû������Ʒ��Ϣ!");
			window.close();
			return false;	
		}
}

function setGdNumBindOfferIds(goodType){
	var packet = new AJAXPacket("/npage/s1104/getGdNumBindOfferIds.jsp","���Ժ�...");
	packet.data.add("goodType" ,goodType);
	core.ajax.sendPacket(packet,doSetGdNumBindOfferIds);
	packet =null;
}

var offerRoleID = "";
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
		
		if(ordArrayHash["20004"] == "04"){
			setGdNumBindOfferIds(ordArrayHash["20008"]);	
		}
		
		$("#div_offerComponent :checkbox").bind("click",fn);
		$("#div_offerComponent :button[id^='att']").bind('click', showAttribute);
		$("#div_offerComponent select").bind('change',setEffectTime);
		
		setShowHid();
	}
}

function setShowHid(){    //����Ʒ������ɺ� ������ʾ������
  
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
	

function doSetGdNumBindOfferIds(packet){
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	if(error_code == "000000"){
		var gdNumBindOfferIds =  packet.data.findValueByName("gdNumBindOfferIds");
		if(typeof(gdNumBindOfferIds) != "undefined" && gdNumBindOfferIds != ""){
			var offerIds = gdNumBindOfferIds.split("|");
			$.each(offerIds,function(i,n){
				if(typeof(n) != "undefined" && n != ""){
					$("#"+n).attr("checked",true);
					$("#"+n).attr("disabled",true);
					$("#expOffset_"+n).attr("disabled",false);
					$("#sel_"+n).attr("disabled",false);
					if(typeof(nodesHash[n]) != "undefined"){
						initInfo(nodesHash[n]);
					}else{
						rdShowMessageDialog("�����Ų��ܶ���������Ʒ!");	
						window.close();
						return false;
					}	
				}	
			});
		}
		/*
		else{
			rdShowMessageDialog("δ��ѯ�������Ű󶨵�����Ʒ��Ϣ!");	
			window.close();
		}
		*/
	}
	else{
		rdShowMessageDialog("��ѯ���Ű�����Ʒ��Ϣʧ��!");
		window.close();
	}		
}


function choiceInputType(){
	if(this.value == 0){		//�ֹ�����
		$("#frame_sub_1").contents().find(":input").attr("disabled",true);
		$("#tr_serviceNo :input").not(":radio").attr("disabled",false);
		$("#tr_serviceNo1 :input").not(":radio").attr("disabled",false);
		
		$("#cfmBtn").attr("disabled",true);
		$("#btn_batch").attr("disabled",true);
		$("#tr_contractNoType").css("display","none");
		$("input[name='resDetail']").attr("disabled",true);
		$("#btn_getConNo").attr("disabled",false);
		$("#contractNo").val("");
		
		
		document.all.simCode.readOnly=false;
		document.all.simCode.className="";
		
		//document.all.selNum.readOnly=false;
		//document.all.selNum.className="";
		
		chaCardType();
	}
	else if(this.value == 1){  //�ļ�����
		$("#frame_sub_1").contents().find(":input").attr("disabled",false);
		$("#tr_serviceNo :input").not(":radio").attr("disabled",true);
		$("#tr_serviceNo1 :input").not(":radio").attr("disabled",true);
		
		$("#tr_serviceNo :input").not(":button").val("");
		$("#tr_serviceNo1 :input").not(":button").val("");
		
		$("#cfmBtn").attr("disabled",true);
		$("input[name='resDetail']").attr("disabled",false);
		$("#btn_batch").attr("disabled",false);
		$("#tr_contractNoType").css("display","");
		$("#btn_getConNo").attr("disabled",true);
		$("#contractNo").val(0);
 		chaCardType();
				
	}else if(this.value == 3){										//�����˻�
		$("#btn_getConNo").attr("disabled",true);
		$("#contractNo").val(0);
	}else if(this.value == 4){										//�����˻�
		$("#btn_getConNo").attr("disabled",false);
		$("#contractNo").val("");
	}		
}

//��������������ͼ�SIM����������ʾ
function doGetMasterServType(packet)
{
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var mastServerType = packet.data.findValueByName("mastServerType").trim();
	masterServId = packet.data.findValueByName("masterServId").trim();
	var serviceType = packet.data.findValueByName("serviceType").trim();

	if(error_code == "0"){
		if(typeof(mastServerType) != "undefined" && mastServerType != ""){
			if(mastServerType == CDMATypeId){		//���CDMA�Ļ�������һ��SIM�������,�����ص�ַ��Ϣ
				$("#serviceNoInfo :hidden").not("#tr_contractNoType").css("display","");
				$("#frame_sub_1").contents().find(":input").attr("disabled",true);
				$("#th_simInfo,#td_simInfo").css("display","");
				
				$("#billModeCd").html("<option value='A'>�󸶷�</option>");
				
				$("#cfmBtn").attr("disabled",true);
				$("#btn_batch").attr("disabled",true);
				$("#billDate").attr("readonly",true);	//�Ʒѿ�ʼʱ��
				
				$("#serviceOrderGroupId").html("<option value='0'></option>");
				$("#serviceOrderInfo").css("display","none");
			}
			if(mastServerType == VPNTypeId){
				getMemberId();
				
				$("#tr_serviceNo1 th").html("<span class='red'>*VPN���룺</span>");
			}
			if(masterServId == 8046 || masterServId == 8047 || masterServId == 8048 || masterServId == 8049 || masterServId == 8051){ //�½�����	
				$("#serviceOrderGroupId").html("<option value='0'></option>");
				$("#serviceOrderInfo").css("display","none");
			}	
			
			prodId = mastServerType.trim();
			$("#mastServerType").val(mastServerType);
			$("#serviceType").val(serviceType);
		}
	}
	else{
		rdShowMessageDialog(error_msg);
	}		
}

function doGetOfferRel(data)
{
	$("#offer_component").html(data);
	
	isOfferLoaded = true;
}

function chkLimit1(id,iOprType)
{
	var retList="";
	var phoneNo="<%=svcInstId%>";
	var opCode="<%=opCode%>";
	var sendUrl = "/npage/s1104/limitChk1.jsp";
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


/*add by yanpx @ 2009-07-22 for ����Ʒ����*/
function chkLimit(id,iOprType)
{
	var retList="";
	var phoneNo="<%=svcInstId%>";
	var opCode="<%=opCode%>";
	var sendUrl = "/npage/s1104/limitChk.jsp";
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

/*end by yanpx @ 2009-07-22 for ����Ʒ����*/
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
//tabҳ����

//չ������Ʒ��ѯ�б�
function doQuery()
{
	var querycondition = document.all.text_xiaosp.value;
	if(querycondition == "")
	{
		rdShowMessageDialog("�������ѯ������");
		document.all.text_xiaosp.focus();
		return false;
	}
}

function findStrInArr(str1,arrObj){
	var reFlag = false;
	$.each(arrObj,function(i,n){
		if(n == str1){
			reFlag = true;
		}
	});
	return reFlag;
}
function getAllCheckedRomaBox(){
	var checkedBoxObjs = $("#tab_addprod :checkbox[@checked]");
	var romaBoxNum = 0;
	$.each(checkedBoxObjs,function(i,n){
		if(findStrInArr(n.id,myArrs)){
			romaBoxNum++;
		}
	});
	return romaBoxNum;
}


function showDetailProd2(nodeId,nodeName,obj,etFlag){
		if(findStrInArr(nodeId,myArrs) && getAllCheckedRomaBox() > 1){
			rdShowMessageDialog("�û�ֻ��ѡ��һ������",0);
			$("#"+ nodeId +"").attr("checked","");
			return false;
		}
    if(obj != undefined){
        if(obj.checked == false){
            $("#pro_detail_"+nodeId).remove();
            return;
        }
    }
  
  var packet = new AJAXPacket("complexPro_ajax.jsp","���Ժ�...");//��ϲ�Ʒ�Ӳ�Ʒչʾ
	packet.data.add("nodeId" ,nodeId);
	packet.data.add("nodeName" ,nodeName);
	packet.data.add("etFlag",etFlag);
	core.ajax.sendPacketHtml(packet,doGetHtml2);
	packet =null;
	
	
}
function doGetHtml2(data){
    eval(data);
}

function doGetProdCompInfo(packet)
{
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var prodCompInfo = packet.data.findValueByName("prodCompInfo");

	if(error_code == "0"){
		if(typeof(prodCompInfo) != "undefined"){
			$("#tab_addprod").css("display","");
			var nodeIdStr = "";
			var nodeNameStr = "";
			var etFlagStr = "";
			var compRoleCdHash = new Object();
			//weigpɾ���Ѷ�����Ʒ��Ϣ �����ʾ��class���� class='item-row2 col-2'
			//$("#tab_addprod tr").append("<td><div id='items'><div ><div id='compProdInfoDiv'></div></div><div ><div class='title'><div id='title_zi'>�Ѷ�����Ʒ��Ϣ</div></div><div id='pro_component'></div></div></div></td>");
			/*liujian add ��ʾ���Ӳ�Ʒ begin*/
			$("#tab_addprod tr").append("<td><div id='items'><div class='item-col2 col-1'><div id='compProdInfoDiv'></div></div><div class='item-row2 col-2'><div class='title'><div id='title_zi'>�Ѷ�����Ʒ��Ϣ</div></div><div id='pro_component'></div></div></div></td>");
			/*liujian add ��ʾ���Ӳ�Ʒ end*/
			$("#pro_component").append("<div id='prod_"+offerId+"'></div>"); 
        	$("#prod_"+offerId).after("<div id='pro_"+offerId+"' ></div>");
        	$("#pro_"+offerId).append("<table id='tab_pro' cellspacing=0></table>");
        	$("#tab_pro").append("<tr><th>��Ʒ����</th><th>��ʼʱ��</th><th>����ʱ��</th><th>����</th></tr>");
			
			
			for(var i=0;i<prodCompInfo.length;i++){
				if(typeof(compRoleCdHash[prodCompInfo[i][3]]) == "undefined"){	//���ɽ�ɫ��
					//weigpȥ��չʾ��������Ʒ�ĸ�ѡ��
					//$("#compProdInfoDiv").append("<div  name='compProdrole' id='"+prodCompInfo[i][3]+"' style='cursor:hand;display:none'><div class='title'><div id='title_zi'>���Ӳ�Ʒ</div></div></div><table cellspacing='0' style='display:none'><tr><td><div id='div_"+prodCompInfo[i][3]+"' style='font-family:\"����\";'></div></td></tr></table>");
					/*liujian add ��ʾ���Ӳ�Ʒ begin*/
					$("#compProdInfoDiv").append("<div  name='compProdrole' id='"+prodCompInfo[i][3]+"' style='cursor:hand;'><div class='title'><div id='title_zi'>���Ӳ�Ʒ</div></div></div><table cellspacing='0'><tr><td><div id='div_"+prodCompInfo[i][3]+"' style='font-family:\"����\";'></div></td></tr></table>");
					/*liujian add ��ʾ���Ӳ�Ʒ end*/
					compRoleCdHash[prodCompInfo[i][3]] = "1";
				}	
			}
			var selNum = $("#selNum").val();//ȡ������
			var selNum3 = selNum.substring(0,3);
			for(var i=0;i<prodCompInfo.length;i++){
			    var tempStr = "";
			    if(i != 0){
			        tempStr = "&nbsp;";
			    }
				prodCompIdArray[i] = prodCompInfo[i][11];
				var relationType = prodCompInfo[i][9];
			if((prodCompInfo[i][2].split(":")[0]) == "1025" || (prodCompInfo[i][2].split(":")[0]) == "1026" || (prodCompInfo[i][2].split(":")[0]) == "1027")
				{
					if(selNum3 == "157")
					{
						//relationType = "3";
						var packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","������֤�����Ժ󡣡���");
                        packet.data.add("phoneNo",document.prodCfm.selNum.value);
                        core.ajax.sendPacket(packet,doPro);
                        packet =null;
                        
                        if($("#flag").val() == "TD")
                        {
                     		relationType = "3";
                     		$("#flag").val("true");
                        }
					}
					else if(selNum3 == "147")
					{
		                var packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","������֤�����Ժ󡣡���");
                        packet.data.add("phoneNo",document.prodCfm.selNum.value);
                        core.ajax.sendPacket(packet,doPro);
                        packet =null;
                        
                        if($("#flag").val() == "TD")
                        {
                     		relationType = "3";
                     		$("#flag").val("true");
                        }
          }
          /*2014/12/15 8:47:12 gaopeng R_CMI_HLJ_xueyz_2014_1933493@��������������Ŷκ�Դ��������תTD���ݵ���ʾ
          ����184�Ŷ�
          */     
          else if(selNum3 == "184")
					{
		                var packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","������֤�����Ժ󡣡���");
                        packet.data.add("phoneNo",document.prodCfm.selNum.value);
                        core.ajax.sendPacket(packet,doPro);
                        packet =null;
                        
                        if($("#flag").val() == "TD")
                        {
                     		relationType = "3";
                     		$("#flag").val("true");
                        }
          }
				}else if((prodCompInfo[i][2].split(":")[0]) == "2042"){
					/* ningtn �����147 TD�̻��û���ֻ����ѡ��2042������ */
					if(selNum3 == "147"){
							var packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","������֤�����Ժ󡣡���");
	            packet.data.add("phoneNo",document.prodCfm.selNum.value);
	            core.ajax.sendPacket(packet,doPro);
	            packet =null;
	            
	            if($("#flag").val() == "TD")
	            {
	         			relationType = "0";
	         			$("#flag").val("true");
	            }
					}
					/* gaopeng 20120914 �����157 TD�̻��û���ֻ����ѡ��2042������ */
					if(selNum3 == "157"){
							var packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","������֤�����Ժ󡣡���");
	            packet.data.add("phoneNo",document.prodCfm.selNum.value);
	            core.ajax.sendPacket(packet,doPro);
	            packet =null;
	            
	            if($("#flag").val() == "TD")
	            {
	         			relationType = "0";
	         			$("#flag").val("true");
	            }
					}
					if(selNum3 == "184"){
							var packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","������֤�����Ժ󡣡���");
	            packet.data.add("phoneNo",document.prodCfm.selNum.value);
	            core.ajax.sendPacket(packet,doPro);
	            packet =null;
	            
	            if($("#flag").val() == "TD")
	            {
	         			relationType = "0";
	         			$("#flag").val("true");
	            }
					}
				}

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
				else if(relationType == "3"){
					checkStr = "disabled";		
					etFlagStr = etFlagStr + "3" + "|";
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
				$("#div_"+prodCompInfo[i][3]).append(tempStr+"<span id='compSpan_"+prodCompInfo[i][11]+"'><input type='checkbox' onclick='showDetailProd2(\""+prodCompInfo[i][11]+"\",\""+prodCompInfo[i][2]+"\",this,1)' name='checkbox_"+prodCompInfo[i][2]+"' id='"+prodCompInfo[i][11]+"' _mutexNum='0' "+checkStr+" />"+prodCompInfo[i][2]+"</span>"+spaceStr);
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

function doPro(packet)
{
	var result = packet.data.findValueByName("result");
	if(result == "true")
	{
		$("#flag").val("TD");
		return ;
	}
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

function doGetOfferAttr(data)
{
	$("#OfferAttribute").html(data);
	
	$("#OfferAttribute :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
  //huangrong add ���С���ʷ���������Ϊ��ѡ���ֵ
	if("<%=flag_code1%>"!=null && "<%=flag_code1%>"!="")
	{
		if(typeof(document.all.s_60001)!="undefined")
		{
			document.all.s_60001.value="<%=flag_code1%>";		
		}
	}

}

function doGetpordAttribute(data)
{
	$("#prodAttribute").html(data);
	
	$("#prodAttribute :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
}

function showProdInfo(){
		$("#productInfo,#userinfo").css("display","block");
}

function doProcess(packet){
	var retType = packet.data.findValueByName("retType");
	if(retType.trim()=="releaseADSLNum")
	{
		var retCode = packet.data.findValueByName("retCode");
		if(retCode.trim()!="000000")
		{
			rdShowMessageDialog("�����ͷ�ʧ��,�������Ա��ϵ��");
			return false;
		}
	}
	
	if(retType.trim()=="release3GNum")
	{
		var retCode = packet.data.findValueByName("errCode");
		if(retCode.trim()!="000000")
		{
			rdShowMessageDialog("�����ͷ�ʧ��,�������Ա��ϵ��");
			return false;
		}
	}
	
	if(retType.trim()=="releaseGUNum")
	{
		var errCode_1 = packet.data.findValueByName("errCode_1");
		if(errCode_1.trim()!="000000")
		{
			rdShowMessageDialog("�����ͷ�ʧ��	,�������Ա��ϵ��");
			return false;
		}
	}
}
function getContractNo()
{
    //�õ��ʻ�ID
  var getAccountId_Packet = new AJAXPacket("/npage/s1104/f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet,dogetContractNo);
	getAccountId_Packet = null;
}
 
function dogetContractNo(packet){
      var retCode = packet.data.findValueByName("retCode"); 
      var retMessage = packet.data.findValueByName("retMessage");	
		  var retnewId = packet.data.findValueByName("retnewId");
		  
     	if(retCode=="000000")
    	{
    	    var getAccountId_Packet = new AJAXPacket("/npage/s1104/ajaxContractNo.jsp","���ڻ���ʻ�ID�����Ժ�......");
					
					
					getAccountId_Packet.data.add("accountId",retnewId);
					getAccountId_Packet.data.add("gCustId","<%=gCustId%>");
					getAccountId_Packet.data.add("newPwd","111111");
					getAccountId_Packet.data.add("accountName",document.all.userName.value);
					getAccountId_Packet.data.add("belongCode","<%=belongCode%>");
					getAccountId_Packet.data.add("beginDate","<%=beginDate%>");
					getAccountId_Packet.data.add("payCode","<%=payCode%>");
					getAccountId_Packet.data.add("bankCode","<%=bankCode%>");
					getAccountId_Packet.data.add("postCode","<%=postCode%>");
					getAccountId_Packet.data.add("accountNo","<%=accountNo%>");
					getAccountId_Packet.data.add("accountType","<%=accountType%>"); 
					getAccountId_Packet.data.add("unitCode","<%=orgCode%>");
					getAccountId_Packet.data.add("endDate","<%=endDate%>");
					getAccountId_Packet.data.add("opCode","<%=opCode%>");
					
					core.ajax.sendPacket(getAccountId_Packet,doNewContractNo);
					getAccountId_Packet = null;
					
					document.all.btn_getConNo.disabled=true;
    	}
    	else{
    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
    			rdShowMessageDialog(retMessage,0);
					return false;
    	}	
    	
	}
	
function doNewContractNo(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	var accountId = packet.data.findValueByName("accountId");
	if(errorCode.trim() == "0")
	{
		document.all.contractNo.value = accountId;
	}
	else{
		rdShowMessageDialog("�˻�����ʧ�ܣ�",0);
		return false;	
	}
} 

function doGetMemberId(packet){

		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode == "000000"){
			var memberId = packet.data.findValueByName("memberId");
			$("#IVPNMemberId").val(memberId);
		}
		else{
			rdShowMessageDialog("ȡVPNȺ���ԱIDʧ��!");
			return false;
		}
}

function getMemberId(){
	var packet = new AJAXPacket("/npage/s1104/getMemberId.jsp","���Ժ�...");
	core.ajax.sendPacket(packet,doGetMemberId);
	packet = null;
}

function cfmOfferf(){
		if(g('tbc_01').style.display=="none") HoverLi(1,2); 
	}
	


function ajaxOrderCmtChk(){
	
	if(document.all.selNum.value == "")
    {
        rdShowMessageDialog("�����������룡",0);
        document.all.selNum.focus();
        return ;
    }
    
 var  orderCmtChk_Packet = new AJAXPacket("/npage/s1104/ajaxOrderCmtChk.jsp","���ڻ���ʻ�ID�����Ժ�......");
			orderCmtChk_Packet.data.add("loginAccept","<%=sysAcceptl%>");
			orderCmtChk_Packet.data.add("offerId","<%=offerId%>");
			orderCmtChk_Packet.data.add("loginNo","<%=workNo%>");
			orderCmtChk_Packet.data.add("opCode","<%=opCode%>");
			orderCmtChk_Packet.data.add("phoneNo",document.all.selNum.value);
			core.ajax.sendPacket(orderCmtChk_Packet,doAjaxOrderCmtChk);
			getAccountId_Packet = null;	
}

function doAjaxOrderCmtChk(packet){
	
	var retCodeFOrderCmtChk = "0";	
	var retMsgFOrderCmtChk = "";	

	retCodeFOrderCmtChk = packet.data.findValueByName("errorCode");
	retMsgFOrderCmtChk = packet.data.findValueByName("errorMsg");	
	
				if(retCodeFOrderCmtChk!="0"){
		    	rdShowMessageDialog(retCodeFOrderCmtChk+":"+retMsgFOrderCmtChk);
		 			document.all.cfmBtn.disabled=true;
		    }else{
					selectCheckSimNo();		    	
		    }	
}

function setNoneRoma(romaArr,checkedFlag,disFlag){
		$.each(romaArr,function(i,n){
			var romaName = $("#" + n + "").attr("name").substr(9);
			var romaAttr = $("#"+ n +"").attr("checked");
			if(checkedFlag){
				if(romaAttr != "true"){
					$("#"+ n +"").attr("checked","true");
					showDetailProd2(n,romaName,$("#"+ n +"")[0],1);
				}
			}else{
				if(romaAttr){
					$("#"+ n +"").removeAttr("checked");
					showDetailProd2(n,romaName,$("#"+ n +"")[0],1);
				}
			}
			if(disFlag){
				$("#"+ n +"").attr("disabled","true");
			}else{
				$("#"+ n +"").removeAttr("disabled");
			}
		});
}

function mySub()
{
	var submitFlag = $("#submitFlag").val();
	 <%--if(submitFlag=="1"){//�޸Ļ�ȥ
		 rdShowMessageDialog("����У��ûͨ���������ύ!");
		 return false;
	 }--%>
	
    getAfterPrompt();
    //huangrong add �ύǰ�жϿ����ֻ����Ƿ������Ͽ����ֻ���һ��   2011-8-19 
  	if(document.all.selNum.value.trim() != document.all.phone_no.value.trim())
		{
			rdShowMessageDialog("����Ŀ����ֻ��ű��������Ͽ������ֻ���һ�£����������룡");
			return false;
		}	 
    // ningtn ���θ���
    if(getAllCheckedRomaBox() < 1){
    	rdShowMessageDialog("����ѡ��һ������!");
			return false;
    }		   
    //�ύǰд���ж� hejwa upd
    if((document.all.writecardbz.value!="0") && (document.all.cardtype_bz.value=="k")&&(document.all.cardTypeN.value=="1")){
 			rdShowMessageDialog("д��δ�ɹ�����ȷ��!");
 			return false;
 		}
		if(g('tbc_01').style.display=="none") HoverLi(1,2); 
		
		
	if(document.all.Good_PhoneDate_GSM.style.display == "")
	{
		if(document.all.GoodPhoneFlag.value != "Y" && document.all.GoodPhoneFlag.value != "N")
		{
			rdShowMessageDialog("��ѡ���������");
			document.all.GoodPhoneFlag.focus();
			return false;
		}
		else if(document.all.GoodPhoneFlag.value == "Y")
		{
			if((document.all.GoodPhoneDate.value).trim().length != 8)
			{
				rdShowMessageDialog("�밴��ȷ��ʽ�������ʱ��");
				document.all.GoodPhoneDate.focus();
				return false;
			}

	    var GoodPhoneDateChk = document.all.GoodPhoneDate.value;
	    var sysDate_GoodChk = <%=sysDate_Good%>;
	    if(GoodPhoneDateChk < sysDate_GoodChk)
	    {
        rdShowMessageDialog("����ʱ�䲻��С�ڵ�ǰϵͳʱ��");
        document.all.GoodPhoneDate.focus();
        return false;
	    }
		}
		
		document.all.isGPhoneFlag.value = document.all.GoodPhoneFlag.value;//��¼�������Ĺ�������
		document.all.isGPhoneDate.value = document.all.GoodPhoneDate.value;//��¼�������������ʱ��
		
	}
	
	
		if(document.all.pt_PhoneDate_GSM.style.display == "")  // ��ͨ�����������
		{
			if(document.all.ptPhoneFlag.value.trim()=="N"&&(document.all.ptPhoneDate.value).trim().length != 8)
			{
				rdShowMessageDialog("�밴��ȷ��ʽ�������ʱ��");
				document.all.ptPhoneDate.focus();
				return false;
			}
			
			if(document.all.ptPhoneFlag.value.trim()=="N"&&!forDate(document.all.ptPhoneDate)){
           	 	rdShowMessageDialog("����ʱ�������ʽ����ȷ,����������!");
            	document.all.ptPhoneDate.focus();
            	return false;
			}


	    var GoodPhoneDateChk = document.all.ptPhoneDate.value;
	    var sysDate_GoodChk = <%=sysDate_Good%>;
	    if(document.all.ptPhoneFlag.value.trim()=="N"&&GoodPhoneDateChk < sysDate_GoodChk)
	    {
        rdShowMessageDialog("����ʱ�䲻��С�ڵ�ǰϵͳʱ��");
        document.all.ptPhoneDate.focus();
        return false;
	    }
	    
	    document.all.isGPhoneFlag.value = document.all.ptPhoneFlag.value;//��¼��ͨ����Ĺ�������
			document.all.isGPhoneDate.value = document.all.ptPhoneDate.value;//��¼������ͨ���������ʱ��
		
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
		
		//if(!checkpwd1()) return false;			//����У��
		
		<%if(!regionCode.equals("09")){%>
			if("<%=is_check_readcard_result%>"=="1"){
	
			if(checkPwd1(document.all.userpwd,document.all.userpwdcfm)==false)	return false;
			
			}
		<%}%>
		if("<%=brandID%>" == brandId_190){
			if($("input[name='selNum']").val().trim().length < 11){
				rdShowMessageDialog("190ҵ��ķ������Ϊ�̻������Ż��ֻ�����!");
		 		return false;	
			}
		}	
		if("<%=brandID%>" == "1012"){						//�½�����
			if($("#userpwd").val().trim().length != 8){
				rdShowMessageDialog("�û��������Ϊ8λ!");
		 		return false;	
			}
		}
		if("<%=is_check_readcard_result%>"=="1"){
	checkPwdEasy(document.all.userpwd.value);	//2010-8-9 8:43 wanghfa��� ��֤������ڼ�
	}else {
	checkPwdEasy(document.all.userpwdyuanlai.value);
	}
}

//2010-8-9 8:43 wanghfa��� ��֤������ڼ� start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", document.all.selNum.value);
	checkPwd_Packet.data.add("idNo", "");
	checkPwd_Packet.data.add("custId", "<%=gCustId%>");

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

var printAddFlag = false;
function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");
	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "0") {
		//�жϴ�ǰ׺�ķ�������Ƿ���ȷ����,v_fpΪ��������ǰ׺�Զ�������
		if($("input[name='selNum']").attr("v_fp") != "" && $("input[name='selNum']").attr("v_fp") == $("input[name='selNum']").val()){
			rdShowMessageDialog("����ȷ����������!");
		  return false;  	
		}
		
		if(document.all.postName.value==""&&document.all.isPost.value=="0"){
				rdShowMessageDialog("�������ռ���!");
				document.all.postName.focus();
				return false;
			}
			
		$(":checkbox[name='contact_type']").each(function(){ //��δѡ�񾭰���,��չ��,�����̵�ʱ,�����ǵ�ֵ���ÿ�
			if(this.checked == false){
				$("#"+this.v_div+" input,#"+this.v_div+" select").each(function(){
					this.value = "";
				});
			}
		});
		
		var exitFlag = 0;
		var pordIdArr = new Array();
		var prodEffectDate = []; 
		var prodExpireDate = [];  
		var isMainProduct = []; 
		
		var offerIdArr = new Array();
		var offerNameArr = new Array();
		var offerEffectTime = new Array();
		var offerExpireTime = new Array();
		
		var sonParentArr = []; //�������Ʒ,��Ʒ����~����ϵ
		var groupInstBaseInfo = "";				//Ⱥ����Ϣ
		var offer_productAttrInfo = ""; //����Ʒ,��Ʒ���Դ�
		
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
			$("input[name='op_note']").val("����Ա"+"<%=workNo%>"+"�Կͻ�"+"<%=gCustId%>"+"������ͨ����!");	
		}
		//ѹ���������Ʒ
		sonParentArr.push(offerId+"~"+"0");
		offerIdArr.push(offerId);
		offerEffectTime.push("<%=currTime%>");	//��ʧЧʱ�仹ûȷ��
		offerExpireTime.push("<%=offExpDate%>");
		var mastServerType = $("#mastServerType").val();
		
		//ѹ���������Ʒ��Ⱥ����Ϣ
		if(mastServerType == VPNTypeId){
			var checkedOfferNum = 0;
			var checkedOfferId = "";
			if($("#group_"+offerId).attr("class") == "b_text but_groups"){
				rdShowMessageDialog("���趨��������ƷȺ����Ϣ!");
			  return false; 	
			}
			$("#div_offerComponent :checked").each(function(){
				if(this.name.substring(0,4)=="offe"){
					checkedOfferNum++;
					checkedOfferId = this.id;
				}				
			});		
			if(checkedOfferNum == 0){					//IVPN�¸������۱�ѡһ��										
				rdShowMessageDialog("��ѡ�񸽼�����Ʒ!");
			  return false; 	
			}
			if($("#group_"+checkedOfferId).attr("class") == "b_text but_groups"){
				rdShowMessageDialog("���趨"+nodesHash[checkedOfferId].getName()+"��Ⱥ����Ϣ!");
			  return false; 	
			}
			if(typeof(offerGroupHash[offerId]) != "undefined"){
				var addOfferInfo = offerGroupHash[checkedOfferId].split("|")[1];
				var addGroupId = addOfferInfo.split("$")[0];
				var VPNInfo = $("#IVPNMemberId").val()+"$0$0$2$70005$"+"<%=currTime%>"+"$20500101$0$"+addGroupId+"$";
				groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[offerId]+VPNInfo+"^";
			}	
		}
		else{
			if(typeof(offerGroupHash[offerId]) != "undefined"){
				groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[offerId]+"^";
			}	
		}
		
		//---------���ɻ�������Ʒ������Ϣ----------
		var offerAttrStr = "";			//����Ʒ���Դ�
		$("#OfferAttribute :input").not(":button,[type='hidden']").each(function(){
				offerAttrStr+=this.name.substring(2);
				offerAttrStr+="~";
				offerAttrStr+=$(this).val()+" $";
		});
		if(offerAttrStr != ""){
			offer_productAttrInfo += offerId+"|"+offerAttrStr+"^";
		}
		
		$("input[name='offerAttrStr']").val(offerAttrStr);
		
		var attrAry = offerAttrStr.split("\\$");	
		for(var i=0;i<attrAry.length;i++){
					var attrAry1= attrAry[i].split("~");	
					var attrId = attrAry1[0];
					var attrValue = attrAry1[1];
					if(attrId=="60001")
					{
						xqdm=attrValue.replace("$","").trim();
					}
	  }
		
		//alert("xqdm|"+xqdm);
		//---------��������Ʒ������Ϣ----------
		var productAttrStr = "";			//��Ʒ���Դ�
		
		$("#prodAttribute :input").not(":button,[type='hidden']").each(function(){
				productAttrStr+=this.name.substring(2);
				productAttrStr+="~";
				productAttrStr+=$(this).val()+" $";
		});
		
		if(productAttrStr != ""){
			offer_productAttrInfo += majorProductArr[1]+"|"+productAttrStr+"^";
		}
		$("input[name='productAttrStr']").val(productAttrStr);
		
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
	            
				//}
				
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
			
			if(typeof(AttributeHash[this.id]) != "undefined"){		//װ�븽�Ӳ�Ʒ��������Ϣ
				offer_productAttrInfo += AttributeHash[this.id];
			}	
		});	
			
			if(!vFlag){
			    return false;
			}
				
		$("#div_offerComponent :checked").each(function(){
			if(this.name.substring(0,4)=="prod" && $("#"+nodesHash[this.id].parentOffer).attr("checked") == true && $("#effType_"+nodesHash[this.id].parentOffer).val() == "0"){	//ֻ��������Ч��
				sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
				pordIdArr.push(this.id);
				prodEffectDate.push($("#effTime_"+nodesHash[this.id].parentOffer).attr("name"));
				prodExpireDate.push($("#expTime_"+nodesHash[this.id].parentOffer).attr("name"));
				isMainProduct.push(0);
				
				if(typeof(AttributeHash[this.id]) != "undefined"){		//װ���Ʒ��������Ϣ
					offer_productAttrInfo += AttributeHash[this.id];
				}	
			}
			if(this.name.substring(0,4)=="offe"){
				
				if(this.h_groupId!="0"){
					if(typeof(offerGroupHash[this.id])!="undefined"){
						if(offerGroupHash[this.id].indexOf(this.id)==-1){ //Ⱥ����Ϣ��û�����offerid��Ӧ����Ϣ��˵��Ⱥ������ʧ��
								rdShowMessageDialog("ѡ�������ʷѡ�"+this.h_offerName+"������������ѡ��",0);
								this.checked = false;
								checkOrderTab();
								exitFlag = 1;
						}
					}else{
								rdShowMessageDialog("ѡ�������ʷѡ�"+this.h_offerName+"������������ѡ��",0);
								this.checked = false;
								checkOrderTab();
								exitFlag = 1;
						}
				}
				
				sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
				offerIdArr.push(this.id);
				offerEffectTime.push($("#effTime_"+this.id).attr("name"));
				
				offerExpireTime.push($("#expTime_"+this.id).attr("name"));
				
				if(typeof(AttributeHash[this.id]) != "undefined"){	//װ������Ʒ��������Ϣ
					offer_productAttrInfo += AttributeHash[this.id];
				}	
				
				/*
				if(nodesHash[this.id].attrFlag == 1 && typeof(AttributeHash[this.id]) == "undefined"){
					rdShowMessageDialog("���趨"+nodesHash[this.id].getName()+"��������Ϣ!");
					exitFlag = 1;
					return false;	
				}
				*/
				
				if(typeof(offerGroupHash[this.id]) != "undefined"){	//װ������Ʒ��Ⱥ����Ϣ
					groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[this.id]+"^";
				}
			}
		});
		if(exitFlag == 1){
			return false;	
		}		
		
//		if(offerIdArr.length == 1){
//			if(rdShowConfirmDialog("����δѡ�񸽼�����Ʒ,�Ƿ�ѡ��") == 1){
//				HoverLi(2,2)
//				return false ;		
//			}
//		} 

		$("input[name='offer_productAttrInfo']").val(offer_productAttrInfo);
		$("input[name='sonParentArr']").val(sonParentArr);
		$("input[name='addGroupIdArr']").val(addGroupIdArr);	
		
		$("input[name='productIdArr']").val(pordIdArr);
		$("input[name='prodEffectDate']").val(prodEffectDate);
		$("input[name='prodExpireDate']").val(prodExpireDate);
		$("input[name='isMainProduct']").val(isMainProduct);
		//alert("offerIdArr|"+offerIdArr);
		$("input[name='offerIdArr']").val(offerIdArr);
		$("input[name='offerEffectTime']").val(offerEffectTime);
		$("input[name='offerExpireTime']").val(offerExpireTime);
		$("input[name='groupInstBaseInfo']").val(groupInstBaseInfo);
		
		$("input[name='sys_note']").val("<%=workNo%>"+"��"+"<%=gCustId%>"+"������"+"<%=offerName%>"+"��װ!");
		$("#cfmBtn").attr("disabled",true);
		
		/*���Ķ�*/
		
		if(("100001" == "<%=backCode%>" || "100002" == "<%=backCode%>") && ("<%=sm_Code%>" == "dn" || "<%=sm_Code%>" == "gn" || "<%=sm_Code%>" == "zn") && "<%=ifCanShow%>" == "true"){
			if(rdShowConfirmDialog("<%=backInfo%>")==1){
				printAddFlag = true;
			}else{
				printAddFlag = false;
			};
			
		}
		
		$("#printAddFlag").val(printAddFlag+"");
		$("#backCode").val("<%=backCode%>");
		
		var path = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		//alert(path);
		rdShowMessageDialog("����ҵ�������ӡ����ͳһ�ɷѺ��ӡ��");
		if(rdShowConfirmDialog("��ȷ���Ƿ���в�Ʒ��װ��")==1)
			{	
				conf(path);  
			}else{
					$("#cfmBtn").attr("disabled",false);			
			}
	}
}


function conf(path){
	 	document.all.simCodeCfm.value = document.all.simCode.value;
	 	document.all.path.value = path;
		document.prodCfm.action="basicOpenCfm.jsp";
		document.prodCfm.submit();
	}
var retResultStr = "";
var retResultStr1 = "";
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {   
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=sysAcceptl%>";
   var phone_no	= $("input[name='selNum']").val();
   //alert("phone_no=="+phone_no);
   
   var mode_code = document.all.offerIdArr.value;
   mode_code = mode_code.replace(/,/ig,"~");
   
   
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		iccidInfoStr = iccidInfoStr.replace(/\\/g,"|xg|");
		accInfoStr = accInfoStr.replace(/\\/g,"|xg|");
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;  /** handwrite �������ӻ����죬ָ���´�ӡҳ **/
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   //var ret=window.showModalDialog(path,printStr,prop);
   return path;

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
function printInfo(printType)
{
     var retInfo = "";
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 
		
    cust_info+="�ͻ�������	"+document.all.custNameforsQ046.value+"|";
    cust_info+="�ֻ����룺	"+$("input[name='selNum']").val().trim()+"|";
    cust_info+="֤�����룺	"+"<%=custIccid%>"+"|";
    cust_info+="�ͻ���ַ��	"+"<%=custAddr%>"+"|";
		
		var cTime = "<%=cccTime%>";
		
		if(document.all.newSmCode.value=="dn")
		{
			opr_info+= opr_info+="ҵ������ʱ�䣺"+cTime+"  "+"�û�Ʒ��:"+"���еش�"+"|";
		}else if(document.all.newSmCode.value=="gn"){
			opr_info+="ҵ������ʱ�䣺"+cTime+"  "+"�û�Ʒ��:"+"ȫ��ͨ"+"|";
		}else{
			opr_info+="ҵ������ʱ�䣺"+cTime+"  "+"�û�Ʒ��:"+"������"+"|";
		}
		
		 

		if((document.all.modedxpay.value).trim().length!=0){
			opr_info+="����ҵ����ͨ����"+"  "+"������ˮ��"+document.all.sysAcceptl.value+"   �������ѽ��"+document.all.modedxpay.value+"Ԫ"+"|";
		}else{
			opr_info+="����ҵ����ͨ����"+"  "+"������ˮ��"+document.all.sysAcceptl.value+"|";
		}
		
		opr_info+= "SIM���ţ�"+document.all.simCode.value+" SIM����: SIMCARDFEE |";
		opr_info+= "Ԥ�� PREMONEY Ԫ"+"|";
		opr_info+="���ʷѣ�"+"<%=offerId%>  <%=offerName %>"+"  ��Чʱ�䣺<%=dateStr2 %>  "+"|"; 
		
	  ajaxGetEPf('<%=offerId%>',xqdm);
		

		
		<%	
		String descStr = "";
		for(int hhh=0;hhh<result_t33.length;hhh++){
			descStr = result_t33[hhh][7];
			%>
		  if(document.all.dECode.value!="") {
			     opr_info+="  ���ʷѶ������ۣ�"+document.all.dECode.value+"-"+document.all.xq_name.value+"|";
	  	}else{
			     opr_info+="  ���ʷѶ������ۣ�<%=result_t33[hhh][2]%>|";
			 }
			<%
		}
		%>

		var tempNote_info2 = "";
		var tempArray1 = document.all.offerIdArr.value.split(",");
		var aaa = "";
		opr_info+="��ѡ�ʷѣ�";
		var tempDescById = "";
		
		for(var h=1;h<tempArray1.length;h++){
			if(tempArray1[h]!=""&&tempArray1[h]!="undefined")
			var node = nodesHash[tempArray1[h]];
			if(node!=""&&node!="undefined"){
				tempDescById = tempDescById+node.getId()+"|";
				if("<%=dateStr2%>"==node.begTime.substring(0,8)){		  		
						tempNote_info2+="("+node.getId()+"��"+node.getName()+"��24Сʱ��Ч)";			
				}else{
						tempNote_info2+="("+node.getId()+"��"+node.getName()+"��ԤԼ��Ч)";			
					}
					 
				}
				
		}
		opr_info+= tempNote_info2+"|";	
		
		var tempV3 = "";
		var tableObj=document.getElementById("tab_pro");
		
		var trObjs=tableObj.getElementsByTagName("tr");
		
		var newTFV1 = ""; //�����ط�24Сʱ����Ч
		var newTFV2 = ""; //�����ط�ԤԼ��Ч����
		var newTFVt2 = ""; //�����ط�ԤԼ��Чʱ��
		
		for(var i=1;i<trObjs.length;i++)
		{
		var tdObjs=trObjs[i].getElementsByTagName("td");
		
		var tempV2 = tableObj.rows[i].cells[0].innerHTML
		var inputV=tdObjs[1].getElementsByTagName("input")[0].value;
		var inputV1=tdObjs[2].getElementsByTagName("input")[0].value;
		
		
		if("<%=dateStr2%>"==inputV){
				newTFV1+=tempV2+"��";
			}else{
				newTFV2+=tempV2+"��";
				newTFVt2+=inputV+"��";
		 }
		}	
		
		if(newTFV1.length >0) newTFV1 = newTFV1.substring(0,newTFV1.length-1);
		if(newTFV2.length >0) newTFV2 = newTFV2.substring(0,newTFV2.length-1);
		if(newTFVt2.length >0) newTFVt2 = newTFVt2.substring(0,newTFVt2.length-1);
		
		
		opr_info+="��ͨ�ط���"+newTFV1+"|";	
		opr_info+=newTFV2+"|";
		opr_info+=newTFVt2+"|";
				
		if(document.all.is_not_adward.value=="Y"){
			if("<%=regionCode%>"=="12"){
				note_info1+="�����������齱��󣬿���Ԥ���δ����������Ԥ������������ԭ�۹�����Ʒ������ʣ�࿪��Ԥ����30%���ƶ���˾֧��ΥԼ��"+"|";
				note_info1+="����������ȡ��Ʒ�󣬲��ܽ��п�����Ԥ���������������Ѳ����˷ѡ�"+"|";
			}else if("<%=regionCode%>"=="02"){
				note_info1+="����������ȡ��Ʒ�󣬲��ܽ��п�����Ԥ���������������Ѳ����˷ѡ�����Ԥ���û��ʹ�����ǰ,���ܰ�������ҵ��"+"|";									
   				note_info1+="��������������������Ӫҵ����ȡ��Ʒ��������Ч��"+"|";
			}
			else{
				note_info1+="�����������齱���������(����������)�ڲ��ܽ����ʷѱ������������������ʷѣ�������Ʒ��������ԭ�����,����ʣ��Ԥ����30�����ƶ���˾֧��ΥԼ��"+"|";
				note_info1+="����������ȡ��Ʒ�󣬲��ܽ��п�����Ԥ���������������Ѳ����˷ѡ�"+"|";
			}
		}
 		note_info1+=" "+"|";
 		
 			if(document.all.newZOfferDesc.value!=""){
 				note_info1+="���ʷ�������"+document.all.newZOfferDesc.value+"|";
 			}else{
 				note_info1+="���ʷ�������<%=offerComments%>"+"|";
 			}
		
		
	
		ajaxGetEPf1(tempDescById);
		note_info1+="��ѡ�ʷ�������|"+retResultStr1+"|";	
		
		
		ajaxQueryOfferTraffic("<%=offerId%>");
		
    if(offerTrafficflag!="0") {
     note_info1+="��Ĭ��Ϊ����ͨ���������������<%=offerName %>�ײ��ڵ���ʣ�������ɽ�ת������ʹ�ã���ת���������µ�ʧЧ��ͬһ�����������ȿۼ����½�ת�������������±�����ײ͡�������Я��ת���ȣ�ԭ�ײ���ʣ����������ת�����¡�"+"|";
    }	


    //alert((document.all.isGoodNo.value).trim());
		if((document.all.isGoodNo.value).trim()==1){
		    //note_info4+=" "+"|";
			  //note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
		}
		//20100302 fengry add
		if((document.all.isGPhoneFlag.value).trim()=="N"){
			  note_info4+="�ͻ���Ը��ŵ��"+toStanDate(document.all.isGPhoneDate.value)+"ǰ������������ڼ׷�����ʹ�ã���ת�ۡ������͡��������������ʹ�ô˺���ʱ�������ҷ�Ӫҵ������������"+"|";
		}
		//20100302 end
   
	  if(document.all.largess_card.value=="Y"){
			note_info4+="������"+"<%=strCardSum%>" + "��10Ԫ��ֵ��ֵ��,����ƾ������Ʊ�ͷ��������������������30���ڵ�����ָ��Ӫҵ����ȡ���������ϡ�"+"|";			
		}else{
			note_info4+=" "+"|";
		}
    note_info4+="��ע��"+document.all.op_note.value+"|";
		 	/*���Ķ���ʾ��Ϣ*/
		 if("<%=backCode%>" == "100001" && printAddFlag){
		 	note_info4+= "�𾴵Ŀͻ���Ϊ��л����֧�֣��ҹ�˾���Ա�����Ϊ�����͡����Ķ���Ʒ����������桱���������������£����鵽�ڵ���25��ϵͳ���Զ�Ϊ���˶�ҵ�������ڼ���Ҳ���Է��Ͷ���QXCDBTY��10086ȡ����"+"|";
		 }
		 
		 /*������ʾ��Ϣ*/
		 if("<%=backCode%>" == "100002" && printAddFlag){
		 	note_info4+= "�𾴵Ŀͻ���Ϊ��л����֧�֣��ҹ�˾������������0Ԫ�������������������0Ԫ�������������2016��3��15�գ�����ɹ�48Сʱ����Ч�����鵽��ϵͳ�Զ�Ϊ���˶�ҵ�������ڼ���Ҳ���Է��Ͷ���QXCLTY��10086ȡ����������������������Ʒ����ͬʱ������ϵͳ�Կͻ����һ�ζ�����ƷΪ׼��"+"|";
		 }
 
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
 	return retInfo;	
}

function ajaxQueryOfferTraffic(offerids) {
		var funtionnames_Packet = new AJAXPacket("/npage/s1104/queryOfferTraffic.jsp","���ڲ�ѯ�����Ժ�......");
		funtionnames_Packet.data.add("offerId",offerids);
		core.ajax.sendPacket(funtionnames_Packet,doreturnFunctions);
		funtionnames_Packet=null;
}

  function doreturnFunctions(packet) {
    var queryCount = packet.data.findValueByName("queryCount");
		offerTrafficflag=queryCount;
  }
  

function toStanDate(isDatec)  {
	var yearStr = isDatec.substring(0,4);	
	var monthStr = isDatec.substring(4,6);	
	var dayStr = isDatec.substring(6,8);	
	var retStr = yearStr+"��"+monthStr+"��"+dayStr+"��";
	return retStr;
}
function ajaxGetEPf(offerIdv,offerId){
		var packet = new AJAXPacket("/npage/s1270/ajaxGetEPf.jsp","���Ժ�...");
		packet.data.add("offerIdv",offerIdv);
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("xqJf",offerId);
		core.ajax.sendPacket(packet,doAjaxGetEPf1);
		packet = null;
	}  
	
function doAjaxGetEPf1(packet){
		 retResultStr = packet.data.findValueByName("retResultStr");
		 
		 document.all.newZOfferECode.value = packet.data.findValueByName("newZOfferECode");
		 document.all.newZOfferDesc.value = packet.data.findValueByName("newZOfferDesc"); 
		 document.all.dOfferId.value = packet.data.findValueByName("dOfferId"); 
		 document.all.dOfferName.value = packet.data.findValueByName("dOfferName"); 
		 document.all.dECode.value = packet.data.findValueByName("dECode"); 
		 document.all.xq_name.value = packet.data.findValueByName("xq_name"); 
		 document.all.dOfferDesc.value = packet.data.findValueByName("dOfferDesc"); 
		 }
	
function ajaxGetEPf1(tempNote_info2v){
		var packet = new AJAXPacket("/npage/s1104/ajaxGetEPf.jsp","���Ժ�...");
		packet.data.add("tempNote_info2v",tempNote_info2v);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet,doAjaxGetEPf11);
		packet = null;
	}  
	
function doAjaxGetEPf11(packet){
		 retResultStr1 = packet.data.findValueByName("retResultStr");
	}		
		
		
function setLoginAccept(retVal){
	document.all.printAccept.value = retVal;
	releaseNumFlag = false;
	document.prodCfm.action="basicOpenCfm.jsp";
	document.prodCfm.submit();
}

function check_o(obj){ 
	if(obj.checked == true){
		document.getElementById(obj.v_div).style.display = "";
	}else{
		document.getElementById(obj.v_div).style.display = "none";
	}	
}

function releaseNum(){
	var selByWay = $("#selByWay").val();	//ѡ�ŷ�ʽ
	var NUM=document.all.selNum.value+"~";//��Ҫ�ͷŵĺ������봮��
	if(document.all.selNum.value==''){
		return false;	
	}
	if(prodId==GUTypeId && selByWay == 1){		//ֻ��ѡ�ĺ�����ͷ�
		releaseGUNum(NUM);
	}else if(prodId==CDMATypeId && selByWay == 1 ){
		//release3GNum(NUM); //hejwa  ע�� ˢ�±��� ѡ�ŷ�ʽ���
	}
}

//---����SIM����Դ---



function selectCheckSimNo(){
	
	
	var nuCardType = document.all.cardTypeN.value;
	if(nuCardType=="1"){ //�տ�����
			checksim();
		}else{
			qrySimType();
		}
	
        
	}
	

function checksim(){
	/*gaopeng 2014/05/06 11:08:59 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ����� */
	if(("<%=outSimType%>" != "10060" && "<%=outSimType%>" != "10061") && "<%=simResBrandCode%>" == "K06"){
		rdShowMessageDialog("ֻ����дSIM����Ϊ10060-LTE USIM��(3FF)��10061-LTE USIM��(4FF)�Ŀ���",0);
    return false;   
	}
	<%--if("<%=is_check_readcard_result%>"=="1"){
	}else {
		if("<%=simResBrandCode%>" == "K06" && document.all.simTypeCfm.value != "<%=outSimType%>" ){
			rdShowMessageDialog("��վ�ṩ��sim�������뵱ǰsim�����Ͳ�ƥ��,����������",0);
	    return false;   
		}
	}--%>
	
	if(document.all.selNum.value == "")
    {
        rdShowMessageDialog("�����������룡",0);
        document.all.selNum.focus();
        return ;
    }
    
    
    if(!forMobil(document.all.selNum))  return false;	//��֤������ֻ��������Ч��
    var operType = document.all.newSmCode.value;
    var sim_type = document.all.simTypeCfm.value;
    if(document.all.simCode.value == "")
    {
        rdShowMessageDialog("������SIM�����룡",0);
        return false;
    } 
    
    
		var checkResource_Packet = new AJAXPacket("/npage/s1104/f1104_5.jsp","���ڽ�����ԴУ�飬���Ժ�......");
		checkResource_Packet.data.add("retType","checkResource");
    checkResource_Packet.data.add("sIn_Phone_no",document.all.selNum.value);
    checkResource_Packet.data.add("sIn_OrgCode","<%=orgCode%>");
    checkResource_Packet.data.add("sIn_Sm_code",operType);
    checkResource_Packet.data.add("sIn_Sim_no",document.all.simCode.value);
    //begin weigp add �����߼���������08
    if("08" == selOfferType){
    	checkResource_Packet.data.add("sIn_Sim_type","10049");
    }else{
    	checkResource_Packet.data.add("sIn_Sim_type",sim_type);
    }
    //end weigp add �����߼���������08
    //alert("--"+document.all.innetType.value);
    checkResource_Packet.data.add("workno","<%=workNo%>");
    checkResource_Packet.data.add("innetType",document.all.innetType.value);
    
    var szph = "aaa";
    
    if(document.all.yzID.value.trim()!=""){ 
   		szph = document.all.yzID.value;
   	}
   	
    checkResource_Packet.data.add("zph",szph);
    checkResource_Packet.data.add("sIn_cardtype",document.all.cardtype_bz.value);
		core.ajax.sendPacket(checkResource_Packet,doChecksim,true);
		checkResource_Packet=null;  
		
		
	}
function doChecksim(packet){
					
		var retCode = packet.data.findValueByName("retCode");
		var retMessage = packet.data.findValueByName("retMessage");
		
		var isGoodNo = packet.data.findValueByName("isGoodNo");
		var prepayFee = packet.data.findValueByName("prepayFee");
		var mode_dxpay = packet.data.findValueByName("mode_dxpay"); 
		document.all.prepayFee.value = prepayFee;		
		document.all.isGoodNo.value = isGoodNo;
 		document.all.modedxpay.value = mode_dxpay;
 		 if(retCode=="0"||retCode=="000000"){
    	
    	    //getFee();   //�õ����ò���
				    	   var tempSimType = $("#simType").val().trim();
				    	    if(tempSimType>="10013" && tempSimType<="10015"){
												if(tempSimType=='10013' && tempSimType!='bgn'){
												rdShowMessageDialog("ֻ��ҵ��Ʒ����ȫ��ͨ���û�������ȫ��64KOTA����");
												return false;}
												if(tempSimType=='10014' && tempSimType!='bdn'){
												rdShowMessageDialog("ֻ��ҵ��Ʒ���Ƕ��еش����û������ö��еش�64KOTA����");
												return false;}
												if(tempSimType=='10015' && tempSimType!='bzn'){
												rdShowMessageDialog("ֻ��ҵ��Ʒ���������е��û�������������64KOTA����");
												return false;}
										}
		            rdShowMessageDialog("��ԴУ��ɹ���");
								//���θ������� ningtn
		            	var romaselNum = $("#selNum").val();//ȡ������
									var romaselNum3 = romaselNum.substring(0,3);//ȡ������ǰ3λ
									var gheadArrs = new Array("045","046","451");
									if(findStrInArr(romaselNum3,gheadArrs)){
										setNoneRoma(myArrs,false,false);
										var roma2042Arrs = new Array("2042");
										setNoneRoma(roma2042Arrs,true,true);
									}
								//���θ������� ningtn end		            
		            if(document.all.cardTypeN.value=="0"){   //�ǿտ�������ԴУ��ɹ�������ύ
									document.all.cfmBtn.disabled=false;		            	
		            }
		            //begin weigp add
		            if(document.all.cardTypeN.value=="1" && "08"==selOfferType){
		            	document.all.cfmBtn.disabled=false;
		            }
		             //end weigp add
								document.all.checksimN.disabled=true;
		            
						 if(document.all.cardtype_bz.value=='k'){
				  			document.all.b_write.disabled=false;
				  		}
			  		if(document.all.cardTypeN.value=="1" && "08"==selOfferType){// weigp add�տ�������ԴУ��ɹ�������ύ
	            	document.all.cfmBtn.disabled=false;
	            	document.all.b_write.disabled=true;
	           }				  		
				  	//document.all.selNum.readOnly=true;
					  //document.all.selNum.className="InputGrey";	
					  document.all.simCode.readOnly=true;
					  document.all.simCode.className="InputGrey";			
    	}else{
    		    document.all.cfmBtn.disabled=true;
						document.all.checksimN.disabled=false;
						//document.all.selNum.value="";/*20100128 add*/
						//document.all.selNum.className = "";
						//document.all.selNum.readOnly = false;
						document.all.simCode.value="";/*20100128 add*/
						document.all.simCode.className = "";
						document.all.simCode.readOnly = false;
    	    	retMessage = retMessage + "[errorCode8:" + retCode + "]";
    				rdShowMessageDialog(retMessage,0);
    				return false;
    	}
}


function qrySimType()
{
  var simCode	= $("#simCode").val().trim();
   //�õ�sim������
  var getAccountId_Packet = new AJAXPacket("/npage/s1104/pubGetSimType.jsp","���ڻ��sim�����ͣ����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("simNo",simCode);
	core.ajax.sendPacket(getAccountId_Packet,doQrySimType,true);
	getAccountId_Packet=null;
}

function doQrySimType(packet){
		var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    
         var sim_type = packet.data.findValueByName("sim_type");    	    
         var sim_typename = packet.data.findValueByName("sim_typename");
				 
				
         
	    if(retCode=="000000")
		  {  
	     document.all.simTypeCfm.value = sim_type;
       document.all.simType.value = sim_type;  
			 if(sim_typename=="null"){
			 		
			 	}else{
			 		document.all.simTypeName.value=(sim_typename).trim();
			 		}
		
		  }else
	      {
				retMessage = retMessage + "[errorCode2:" + retCode + "]";
				rdShowMessageDialog(retMessage,0);
				return false;
      }
      
      checksim();
	}
	
	
function dochecksim1(packet){
					
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode == "0"){
				var simType = packet.data.findValueByName("simType");
				var checkedSimCode = packet.data.findValueByName("checkedSimCode");
				var isSell = packet.data.findValueByName("isSell");
				var sellId = packet.data.findValueByName("sellId");
				
				$("input[name='sellGroupId']").val(sellId);
				
				if(simType != ""){
					$("input[name='simType']").val(simType);
					$("#simCode").val(checkedSimCode);
					rdShowMessageDialog("��ԴУ��ɹ�!");
					$("#cfmBtn").attr("disabled",false);
					if(document.all.cardtype_bz.value=='k'){
			  			document.all.b_write.disabled=false;
			  		}
				}
				else{
					rdShowMessageDialog("SIM������Ϊ��!");
					return false;
				}		
				
				if(isSell == "Y"){
					if($("#openType").val() == "01"){
						rdShowMessageDialog("�ú���Ӧѡ������̷���������ʽ!");
					}
					$("#openType").html("<option value='02'>�����̷���</option>");
				}else{
					if($("#openType").val() == "02"){
						rdShowMessageDialog("�ú���Ӧѡ����ͨ����������ʽ!");
					}
					$("#openType").html("<option value='01'>��ͨ����</option>");
					$("input[name='sellGroupId']").val("");
				}
		}
		else{
				rdShowMessageDialog("��ԴУ��ʧ��!"+errorMsg);
				$("#cfmBtn").attr("disabled",false);
				//return false;
		}
}

//---����SIM����Դ---
function checkBatchSim(){
		var packet = new AJAXPacket("/npage/s1104/checkBatchSIM.jsp","���Ժ�...");
		packet.data.add("brandId","<%=brandID%>");
		packet.data.add("gCustId","<%=gCustId%>");
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("simFlag",document.all.simFlag.value);
		packet.data.add("fileName",document.all.psfileName.value);
		core.ajax.sendPacket(packet,doCheckBatchSim);
		packet = null;
}

function doCheckBatchSim(packet){
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode == "000000"){
				var successNum = packet.data.findValueByName("successNum");
				var checkedPhoneNoStr = packet.data.findValueByName("checkedPhoneNoStr");
				var checkedSimNoStr = packet.data.findValueByName("checkedSimNoStr");
				var chFeeList = packet.data.findValueByName("chFeeList");
				if(successNum > 0){
					$("#phoneNoStr").val(checkedPhoneNoStr);
					$("#simNoStr").val(checkedSimNoStr);
					$("#chFeeList").val(chFeeList);
					rdShowMessageDialog("��ԴУ��ɹ�!");
					$("#cfmBtn").attr("disabled",false);	
				}
				else{
					rdShowMessageDialog("0����ԴУ��ɹ�!");
					return false;	
				}	
		}
		else{
				rdShowMessageDialog("��ԴУ��ʧ��!"+errorMsg);
				return false;
		}
}

function viewRes()
{ 
	//��ѯ��Դ��ϸ��Ϣ
	var paraArr=new Array(4);
	paraArr[0]=$("#phoneNoStr").val();
	paraArr[1]=$("#simNoStr").val();
	paraArr[2]=$("#chFeeList").val();
	paraArr[3]=$("#phoneNoStr").val();
	paraArr[4]=$("#phoneNoStr").val();
 	
   var path = "/npage/s1104/f1114_4gn.jsp";
	
	var t=window.screen.availHeight-300;
	var l=window.screen.availWidth-300;
 	var window_location= "dialogWidth:30;dialogHeight:40;"
  var retInfo = window.showModalDialog(path,paraArr,window_location);

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
	var ret=window.showModalDialog("/npage/s1104/showGroup.jsp?opType=set&offerId="+offerId+"&offerName="+offerName+"&groupTypeId="+groupTypeId+"&brandID="+"<%=brandID%>"+"&curTime="+curDate+"&groutDesc="+document.all.groutDesc.value,"",prop);
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
		var ret=window.showModalDialog("/npage/s1104/showGroup.jsp?opType=look&offerId="+offerId+"&offerName="+offerName+"&groupInfo="+groupHash[offerId]+"&groupTypeId="+groupTypeId+"&groutDesc="+document.all.groutDesc.value,"",prop);
	
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
function showGroup1(offIdv,offerNamev,groupIdv){
	var offerId = offIdv;
	var offerName = offerNamev;
	var groupTypeId = groupIdv;
 
	 	
	  var packet1 = new AJAXPacket("/npage/s1104/showGroup.jsp","���Ժ�...");
	  		packet1.data.add("opType","set");
	  		packet1.data.add("offerId",offerId);
	  		packet1.data.add("offerName",offerName);
	  		packet1.data.add("groupTypeId",groupTypeId);
	  		packet1.data.add("brandID","<%=brandID%>");
	  		packet1.data.add("groutDesc",document.all.groutDesc.value);
				packet1.data.add("sOrderArrayId","<%=orderArrayId%>");
				core.ajax.sendPacket(packet1,doShowGroup,true);
				packet1 =null;
			
}
function doShowGroup(packet){			
	var ret = packet.data.findValueByName("ret");
	
	
		if(typeof(ret) != ""){
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
		var ret=window.showModalDialog("/npage/s1104/showAttr.jsp?queryId="+queryId+"&queryType="+queryType,"",prop);
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
		var ret=window.showModalDialog("/npage/s1104/showAttr.jsp?queryId="+queryId+"&queryType="+queryType+"&attrInfo="+AttributeHash[queryId],"",prop);
		if(typeof(ret) != "undefined"){
			AttributeHash[queryId]=ret;	//�����ص�Ⱥ����Ϣ�Ծ�queryId����
		}
	}	
}

//����һ��У��
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


function doPostInfo(){
	
	document.all.checksimN.disabled=false;
	
	document.all.innetCode.options.length=document.all("dnInnetCode").length;		
	for(var i=0;i<document.all("dnInnetCode").length;i++)
	{
	  document.all.innetCode.options[i].value=document.all("dnInnetCode").options[i].value;
	  document.all.innetCode.options[i].text=document.all("dnInnetCode").options[i].text;
	  document.all.innetCode.options[i].mainCode=document.all("dnInnetCode").options[i].mainCode;   
	  document.all.innetCode.options[i].mainName=document.all("dnInnetCode").options[i].mainName;
  	document.all.innetCode.options[i].subCount=document.all("dnInnetCode").options[i].subCount;
	}
	
	
	var ispost = document.all.isPost.value;
	if(ispost==0){
			document.getElementById("postInfo").style.display = "";
		}else{
			document.getElementById("postInfo").style.display = "none";
			}
	} 
	
	
function changelargesscard(){
	if (parseInt(prodCfm.largess_card_sum.value) == 0){
		document.all.largess_card[1].selected = true;
		rdShowMessageDialog("�˵��л�����û���������ͳ�ֵ���");
		return false;
	}

 
}	

function isnotawardhange(){
 
    	if(document.all.is_not_adward.value=="Y"){
    		if (prodCfm.innetCode.options[prodCfm.innetCode.selectedIndex].text=="����绰" || prodCfm.innetCode.options[prodCfm.innetCode.selectedIndex].text=="����"||
						prodCfm.innetCode.options[prodCfm.innetCode.selectedIndex].text=="IP����"){
    			rdShowMessageDialog("����绰��IP�������ⲻ�ܲμ������¾�ϲ�");
				return false;
    		}
    	 if (prodCfm.goodphone.value=='Y'){
    			rdShowMessageDialog("������벻�ܲμ������͸��");
				return false;
    	}
	}
	
    	
}

function chaCardType(){  //�տ�����
	var nuCardType = document.all.cardTypeN.value;
	if(nuCardType=="1"){
 
		document.all.cardtype_bz.value="k";
		document.all.cfmBtn.disabled=true;	 // �տ����� �ύ�û�
		
  		 var phone = $("input[name='selNum']").val();;
  		 /****���������ƹ���ȡSIM������****/
  		 /* 
        * diling update for �޸�Ӫҵϵͳ����Զ��д��ϵͳ�ķ��ʵ�ַ�������ڵ�10.110.0.125��ַ�޸ĳ�10.110.0.100��@2012/6/4
        */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("�������ͳ���!");
    		 document.all.cardTypeN.value = "0";  //���� �տ����� Ϊ�� hejwa add
    		 document.all.cardtype_bz.value="s";  // �տ�����Ϊ��
    		 document.all.checksimN.disabled=false; //��ԴУ�鰴ť���� 
    		return false;   
    	 }
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("�������ͳ���!");
    		document.all.cardTypeN.value = "0";  //���� �տ����� Ϊ�� hejwa add
    		document.all.cardtype_bz.value="s";  // �տ�����Ϊ��
    		document.all.checksimN.disabled=false; //��ԴУ�鰴ť���� 
    		return false ;	
    	} 
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;
        	
    	} 
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("�������ͳ���!");
        			document.all.cardTypeN.value = "0";  //���� �տ����� Ϊ�� hejwa add
        			document.all.cardtype_bz.value="s";  // �տ�����Ϊ��
        			document.all.checksimN.disabled=false; //��ԴУ�鰴ť���� 
    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("�������ͳ���!");
    			document.all.cardTypeN.value = "0";  //���� �տ����� Ϊ�� hejwa add
    			document.all.cardtype_bz.value="s";  // �տ�����Ϊ��
    			document.all.checksimN.disabled=false; //��ԴУ�鰴ť���� 
    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("�������ͳ���!");
  			 document.all.cardTypeN.value = "0";  //���� �տ����� Ϊ�� hejwa add
  			 document.all.cardtype_bz.value="s";  // �տ�����Ϊ��
  			 document.all.checksimN.disabled=false; //��ԴУ�鰴ť���� 
    		 return false;   
    	}
  		 /****ȡSIM�����ͽ���******/
    		 var path = "<%=request.getContextPath()%>/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "����SIM������";
    	       
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		
    		document.all.checksimN.disabled=false;
    		//document.all.b_write.disabled=false;  ��ԴУ��ɹ���ſ���д��
    		 if(typeof(retInfo) == "undefined")     
    			{	return false;   }
    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));
    		document.all.simCode.value=simsim;
    		document.all.simType.value=(cardcard).trim();
    		document.all.simTypeCfm.value=(cardcard).trim();
    		
    		if((typetype).trim()=="null"){
    			
    			}else{
		 document.all.simTypeName.value=(typetype).trim();
    	}
		}else{
			document.all.cardtype_bz.value="s";
			}
	}
	
function setDateMove(time,moveFormat,moveNumber,outFormat)
{
    addSecond=function (dt,num)   
		{   
			dt.setSeconds(dt.getSeconds()+num);   
			return dt;   
		}   
	if(time.indexOf('/')==-1)
	{
		var arr=time.split(' ');
		var _time=arr[0].substr(0,4)+'/'+arr[0].substr(4,2)+'/'+arr[0].substr(6,2);
		arr[0]=_time;
		time=arr.join(" ");
		}
	if((date = new Date(time))=="NaN") {alert("ʱ���ʽ����ȷ��"); return "";}
	var moveDate='';
	var get_Year='';
	var get_Mon='';
	var get_date='';
	var get_Hours='';
	var get_Min='';
	var get_Sec='';
	get_Mon=date.getMonth()+1;
	get_date=date.getDate();
	get_Hours=date.getHours();
	get_Min=date.getMinutes();
	get_Sec=date.getSeconds();
	if(isNaN(moveNumber=parseInt(moveNumber))){alert("ʱ��λ�Ʊ���Ϊ��ֵ�ͣ�"); return "";}
	if(moveFormat=="hh") moveFormat = "kk";
	switch(moveFormat){
	case 'dd':
		moveNumber=moveNumber*24*60*60;
		moveDate=addSecond(date,moveNumber);
		get_Year=moveDate.getYear();
		get_Mon=moveDate.getMonth()+1;
		get_date=moveDate.getDate();
		get_Hours=moveDate.getHours();
		get_Min=moveDate.getMinutes();
		get_Sec=moveDate.getSeconds();
		break;
	case 'kk':
		moveNumber=moveNumber*60*60;
		moveDate=addSecond(date,moveNumber);
		get_Year=moveDate.getYear();
		get_Mon=moveDate.getMonth()+1;
		get_date=moveDate.getDate();
		get_Hours=moveDate.getHours();
		get_Min=moveDate.getMinutes();
		get_Sec=moveDate.getSeconds();
		break;
	case 'mm':
		moveNumber=moveNumber*60;
		moveDate=addSecond(date,moveNumber);
		get_Year=moveDate.getYear();
		get_Mon=moveDate.getMonth()+1;
		get_date=moveDate.getDate();
		get_Hours=moveDate.getHours();
		get_Min=moveDate.getMinutes();
		get_Sec=moveDate.getSeconds();
		break;
	case 'ss':
		moveDate=addSecond(date,moveNumber);
		get_Year=moveDate.getYear();
		get_Mon=moveDate.getMonth()+1;
		get_date=moveDate.getDate();
		get_Hours=moveDate.getHours();
		get_Min=moveDate.getMinutes();
		get_Sec=moveDate.getSeconds();
		break;
	case 'yyyy':
		date.setFullYear(date.getFullYear()+moveNumber); 	
		get_Year=date.getFullYear();
		get_Mon=date.getMonth()+1;
		get_date=date.getDate();
		get_Hours=date.getHours();
		get_Min=date.getMinutes();
		get_Sec=date.getSeconds();
		break;	
	case 'MM':
		date.setMonth(date.getMonth()+moveNumber);
		get_Year=date.getFullYear();
		get_Mon=date.getMonth()+1;
		get_date=date.getDate();
		get_Hours=date.getHours();
		get_Min=date.getMinutes();
		get_Sec=date.getSeconds();
		break;					
	default: 
		alert('��������');
		return "";
	}
	if(outFormat!=undefined)
	{
	    var times=outFormat.replace('yyyy',get_Year).replace('MM',("0"+get_Mon).slice(-2)).replace('dd',("0"+get_date).slice(-2)).replace('kk',("0"+get_Hours).slice(-2)).replace('mm',("0"+get_Min).slice(-2)).replace('ss',("0"+get_Sec).slice(-2));
	}
	else
		var times=get_Year+'/'+("0"+get_Mon).slice(-2)+'/'+("0"+get_date).slice(-2)+'/'+' '+("0"+get_Hours).slice(-2)+':'+("0"+get_Min).slice(-2)+':'+("0"+get_Sec).slice(-2);
	return times;
}

function ignoreThis(){
	
	if(rdShowConfirmDialog("��ȷ���Ƿ�ȡ����ҵ�� ȷ�Ϻ�ҵ�񽫱�ɾ��")==1){
		var packet1 = new AJAXPacket("/npage/s1104/ignoreThis.jsp","���Ժ�...");
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
function writechg(){
	if(document.all.simCode.value==""){
		rdShowMessageDialog("sim���Ų����ǿ�!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = $("input[name='selNum']").val();
  			document.all.b_write.disabled=true;
    		 var path = "<%=request.getContextPath()%>/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    		 path = path + "&sim_type=" +document.all.simTypeCfm.value;
    		 path = path + "&sim_no=" +document.all.simCode.value;
    		 path = path + "&op_code=" +"<%=opCode%>";
    	         path = path + "&phone=" + phone + "&pageTitle=" + "д��";
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		 if(typeof(retInfo) == "undefined")     
    			{	
    				 
    				document.all.writecardbz.value="1"; 
    				//document.all.b_write.disabled=false;
    				document.all.cfmBtn.disabled=true;   //д��ʧ�ܲ����ύ hejwa add 
    				rdShowMessageDialog("д��ʧ��");
    				return false;   
    				
    			}
    		 
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2));
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3))
    		 
    		 if(retsimcode=="0"){rdShowMessageDialog("д���ɹ�");
    		 document.all.writecardbz.value="0";
    		 document.all.simCode.value=retsimno;
    		 document.all.simCodeCfm.value=retsimno;
    		 document.all.cardstatus.value=cardstatus;
    		 document.all.cfmBtn.disabled=false;
    		 
    		 	//if(cardstatus=="3"){document.all.simFee.value="0";}
    		 
    		 }else{
    		 	document.all.writecardbz.value="1";
    		 	//document.all.b_write.disabled=false;
    		 	document.all.cfmBtn.disabled=true;
    		 	rdShowMessageDialog("д��ʧ��");
    		 }
	}
	else{
		rdShowMessageDialog("ʵ������д��");
		document.all.cfmBtn.disabled=true;   //д��ʧ�ܲ����ύ hejwa add 
		document.all.b_write.disabled=true;
		return false;
	}
}

//dujl add at 20100409 for ���ڵ���SIM�����ҵ���ܵ�����
function getHlr()
{
	if(document.all.selNum.value.trim() == "")
	{
		rdShowMessageDialog("���������ֻ����룡");
		return false;
	}
	
	var myPacket = new AJAXPacket("getHlrCode.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("selNum",document.all.selNum.value);
	myPacket.data.add("regionCode","<%=regionCode%>");
	core.ajax.sendPacket(myPacket,doGetHlrCode);
	myPacket=null;
}

function doGetHlrCode(packet)
{
	var result=packet.data.findValueByName("result");
	if(result=="")
	{
		rdShowMessageDialog("������ֻ����벻�ԣ����������룡");
		document.all.selNum.value="";

	}else{
		document.all.hlrCode.value = result;
	}
}

function setPtPDate(){
		if(document.all.ptPhoneFlag.value=="Y"){
			document.all.ptPhoneDate.readOnly=true;
		}else{
			document.all.ptPhoneDate.readOnly=false;
		}
}		
</script>

</HEAD>
<BODY onload="doPostInfo()">
    <DIV id=operation>
<FORM name="prodCfm" action="" method="post" width="100%"><!-- operation_table -->
<%@ include file="/npage/include/header.jsp" %>	
<DIV id="Operation_table">
    <div class="title">
	<div id="title_zi">�ͻ���Ϣ</div>
</div>


<div id="custInfo">
<%@ include file="/npage/common/qcommon/bd_0002.jsp" %>
</div>
<script type="javascript">
alert("<%=agent_idType%>");
			if("<%=agent_idType%>"=="0"){
			  submitFlag="1";
		  }
		  else {
			  submitFlag="0";
		  }
</script>

<!-- tab start -->
<!--
<div id="tabsJ">
	<ul>
		<li class="current" id="tb_1"><a href="#" onclick="HoverLi(1,2);">��������Ʒ</a></li>
		<li id="tb_2"><a href="#" onclick="HoverLi(2,2);">����Ʒ����</a></li>
	</ul>
</div>
-->
<div id="tabsJ">
	<ul>
		<li class="current" id="tb_1"><input type='radio' name='changeSel' value='selBasic' checked onclick="HoverLi(1,2);">��������Ʒ&nbsp;</li>
		<li id="tb_2"><input type='radio' name='changeSelh' value='selStruc' onclick="HoverLi(2,2);">����Ʒ����</li>
	</ul>
</div>
<!-- tab end -->
<!-- ��������Ʒ ��ʼ-->
<div class="dis" id="tbc_01">
<DIV id=tb_01>
<DIV class=input><!-- style="DISPLAY: none"-->
<div id=baseInfo></div>

<div class="title">
	<div id="title_zi">����Ʒ��Ϣ</div>
</div>

<TABLE cellSpacing=0>
  <TR>
    <Td class="blue" width=17%>Ʒ��</td>
  	<TD width=33%><%=brandName%>  
  		<input type="hidden" name="orderInfoV" value="0" />
  		<INPUT class=b_text id="orderInfoDiv"  type=button value=�鿴��ѡ�񸽼�����Ʒ��Ϣ /></TD>
    <Td class="blue"  width=17%>����Ʒ����</td>
     <TD id="td_offerName"><%=(offerId+"-->"+offerName)%> </TD>
	</TR>
	<tr>
    <Td class="blue">����</Td>
    <TD colspan="3"><%=offerComments%></TD>
   </TR>
  </table>  
  
<div id="OfferAttribute"></div><!--����Ʒ����-->
</DIV>

<div class="list" id="orderInfo" style="display:none">
<DIV class=title><div id="title_zi">��ѡ�񸽼�����Ʒ��Ϣ</div></DIV>
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

<DIV class="input" id="userinfo" style="display:none">
	<br>
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
<div id="userBaseInfo">
 	<%@ include file="fUserBaseInfo.jsp" %>
</div>
</div>
</div>

<DIV class="input" id="postInfo"  style="display:none">
		<div class="title">
			<div id="title_zi">�ʼ���Ϣ</div>
		</div>
<TABLE id=tbPost0  cellSpacing="0">
                <TBODY> 
                <TR  > 
                	        <TD   nowrap class=blue > 
                    ��������
                  </TD>
                  <TD nowrap  > 
                   <select align="left" name=OperateFlag id=OperateFlag  index="28">
                      <option value="1" selected>����</option>
                      <option value="2">�޸�</option>
                      <option value="3">ɾ��</option>
                    </select>
                  </TD>
                  
                  <TD  class=blue  nowrap  width=15%> 
                    <div align="left">�ʼ�����</div>
                  </TD>
                  <TD  nowrap  width=35%> 
                    <select align="left" name=postType  index="28">
                      <option value="1" selected>�ʼ��ʵ�</option>
                      <option value="2">Email</option>
                      <option value="3">����</option>
                    </select>
                  </TD>
                  
                </TR>
                <TR  > 
                		<TD  class=blue  nowrap  width=15%> 
                    <div align="left">�ռ���</div>
                  </TD>
                  <TD  nowrap  width=35%> 
                    <input class="button" name=postName  maxlength=40 v_must=1  v_maxlength=40 index="29" >
                    <font color="red">*</font> </TD>
                    	
                 
                  <TD nowrap  class=blue  > 
                    <div align="left">E_MAIL</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_name="E_MAIL" name=postMail maxlength=30 v_must=1 v_maxlength=30  index="31" >
                  </TD>
                </TR>
                <TR  > 
                  <TD   nowrap class=blue > 
                    <div align="left">�ʼĵ�ַ</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" name=postAdd   maxlength=30 v_must=0 v_maxlength=30 v_name="�ʼĵ�ַ" index="32" >
                  </TD>
                  <TD nowrap  > 
                    <div align="left" class=blue >�ʼı���</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" name=postZip maxlength=10 v_must=0 v_maxlength=30 v_name="�ʼı���" index="33" >
                  </TD>
                </TR>
                
                 <TR  > 
          				 <TD nowrap  class=blue  > 
                    <div align="left">����</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button"  name=postFax maxlength=30 v_must=1 v_maxlength=30 v_name="����" index="30" >
                  </TD>
          
                  <TD nowrap  > 
                    &nbsp;
                  </TD>
                  <TD nowrap  > 
                   &nbsp;
                  </TD>
                </TR>
                
                </TBODY> 
              </TABLE> 	
</div>

	<div class="title">
		<div id="title_zi">��Դ��Ϣ</div>
	</div>
		
<table cellSpacing=0 id="serviceNoInfo">	
	<TR id="tr_serviceNo" >
		<td class="blue" style="display:none">
				<input type="radio" name="enterType" value="0" checked>����ѡ��
		</td>
	  <Td class="blue"> �������</Td>
	  <TD ><%@ include file="/npage/common/qcommon/bd_0022.jsp" %>  <font class="orange">*</font>  
	  </TD>
	  <td class="blue">�������hlr</td>
	  <td><input class="button" type="text" name="hlrCode" size="20" readonly>
	  	<input type="button" name="b_hlr" value="��ѯ" class="b_text" onClick="getHlr()"> 
	  </td>
	 <td class="blue">�տ����� </td>
	 <td>
	  	<select align="left" id="cardTypeN" name="cardTypeN"  index="28" onchange="chaCardType()">
        <option value="0" selected>��</option>
        <option value="1">��</option>
      </select>	
   </td>
	</tr>
	<!-- gaopeng 2014/05/07 10:00:55 ������ʡ������ѡ�š��͡�18Ԫ�׿�ʡ�ڰ桱����SIM������ѡ���ܵ�����  -->
	<tr>
		<td colspan="7"><font color = "red"> ע��ֻ����дSIM����Ϊ10060-LTE USIM��(3FF)��10061-LTE USIM��(4FF)�Ŀ�</font></td>
	</tr>
	<tr  id="tr_serviceNo1">
	  <td class="blue" style="display:none" id="th_simInfo"> SIM���� </td>
	  <td colspan="4" style="display:none" id="td_simInfo">
	  	<input name=simType type=hidden value="">
	  	<input name=simTypeName type=text  readonly index="11" Class="InputGrey">
	  	<input type='text' name='simCode' id='simCode' maxlength="20" class="required numOrLetter" value="">
	  	<input type="button" id="checksimN" name="checksimN" value="��ԴУ��" class="b_text" onClick="ajaxOrderCmtChk()"> <font class="orange">*</font>
	  	<input type="button" name="b_write" value="д��" class="b_text" onClick="writechg()" disabled > 
	  </td>
	  <td class="blue" > SIM������ </td>
	  <td><%=outSimName%></td>
	</tr>
	<%if(!passFlag.equals("none")){%>
	<tr style="display:none" >	
		<td class="blue" >
				<input type="radio" name="enterType" value="1" id="radioBatch">�ļ�����
		</td>
		<td colspan="2" >
			<iframe name="frame_sub_1" id="frame_sub_1" src="/npage/s1104/getFile.jsp" width="400" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" >
			</iframe>
		</td>
		<td colspan="2">
			<div id="file10" style="background: eeeeee; height:25">
				<a href="#" onmousemove="document.all.file10_sub.style.visibility='visible'" onMouseOut="document.all.file10_sub.style.visibility='hidden'">��������˲鿴�ļ���ʽ</a>
				<span id="file10_sub" style="position: absolute; left: 0; top: -100;visibility: hidden; background: #eeeeee;width: 330px; margin: 0px; padding: 0px;border: 1px solid silver;overflow: visible;">
					<font color="red"></br>&nbsp;&nbsp;<font color="000000">�ļ�����:*.txt</font>
					<font color="red"></br>&nbsp;&nbsp;<font color="000000">�ļ���ʽ:</font></br>
					&nbsp;&nbsp;�������&nbsp;sim����</br>&nbsp;&nbsp;13900000000 89860106956667239400</br>&nbsp;&nbsp;13900000001 89860106956667239401</br>&nbsp;&nbsp;...........
					</font>
				</span>		
				<input type="button" value="��ԴУ��" class="b_text" id="btn_batch" onClick="checkBatchSim()">	
				<input  class="b_text"  name=resDetail onmouseup="viewRes()" onkeyup="if(event.keyCode==13)viewRes()" style="cursor:hand" type=button value=��ϸ��Ϣ index="25" disabled />	
			</div>	
		</td>	
	</tr>
	<%}%>
	<tr style="display:none" id="tr_contractNoType" >
		<td class="blue">�˺�����</td>
		<td colspan="8">
			<input type="radio" name="contractNoType" value="3" checked />�����˻�<input type="radio" name="contractNoType" value="4">�����˻�
		</td>
	</tr>
</TABLE>


<table cellSpacing=0 id="Good_PhoneDate_GSM"  style="display:none" >
	<TR >
								<TD nowrap class=blue >
									<div align="left">��������������</div>
								</TD>
								<TD nowrap >
									<select name ="GoodPhoneFlag" >
										<!--option class='button' value='Y' >�������</option-->
										<option class='button' value='N' selected>���������</option>
									</select>
								</TD>
								
								<TD nowrap class=blue >
									<div align="left" >�ɰ��������ʱ��</div>
								</TD>
								<TD nowrap >
									<input id="GoodPhoneDate"  name="GoodPhoneDate" maxlength="8"    value="20500101" readOnly class="InputGrey" >
									<font class="orange">*(��ʽYYYYMMDD)</font>&nbsp;&nbsp;
								</TD>
							 
							</TR>
	</table>

<table cellSpacing=0 id="pt_PhoneDate_GSM"   style="display:none">
	<TR >
								<TD nowrap class=blue >
									<div align="left">�����������</div>
								</TD>
								<TD nowrap >
									<select name ="ptPhoneFlag" onchange="setPtPDate()">
										<option class='button' value='Y' selected>�������</option>
										<option class='button' value='N' >���������</option>
									</select>
								</TD>
								
								<TD nowrap class=blue >
									<div align="left" >�ɰ��������ʱ��</div>
								</TD>
								<TD nowrap >
									<input id="ptPhoneDate"  name="ptPhoneDate" maxlength="8"  v_format="yyyyMMdd" v_type="date" readOnly >
									<font class="orange">*(��ʽYYYYMMDD)</font>&nbsp;&nbsp;
								</TD>
							 
							</TR>
	</table>
	
<!--hejwa ���� �������� dgoodphoneres �����м�¼ ��ʾ ������-->
<SCRIPT language=JavaScript>
	
	function isGoodPhoneF(selNumValue){
		var isGoddNo_Packet = new AJAXPacket("/npage/s1104/isGoodPhoneres.jsp","���ڻ�ð󶨸����ʷѣ����Ժ�......");
	 			isGoddNo_Packet.data.add("selNumValue",selNumValue);
	 			core.ajax.sendPacket(isGoddNo_Packet,doIsGoodPhoneF);
	 			isGoddNo_Packet=null; 
	}
	
	function doIsGoodPhoneF(packet){
			var countGoodNo = packet.data.findValueByName("countGoodNo");
			var innetType = $("#innetType").val();
			
			if(countGoodNo!=0){
					document.all.Good_PhoneDate_GSM.style.display = "";		
					document.all.pt_PhoneDate_GSM.style.display = "none";		
				}else{
					document.all.Good_PhoneDate_GSM.style.display = "none";		
					if(innetType=="01"){//��ͨ������������ʾ
						document.all.pt_PhoneDate_GSM.style.display = "";		
					}
				}
		}
		
		
$(document).ready(function () {
	document.all.selNum.value = "<%=phone_no%>";
	document.getElementById("selNum").className = "InputGrey";
	document.all.selNum.readOnly = true;
	isGoodPhoneF(document.all.selNum.value);
});

</SCRIPT>
<!--����-->	
<table cellSpacing=0>	
	<TR>
		<td class="blue" width=9%>�˺�ID </td>
	  <TD><input type="text" name="contractNo" id="contractNo" class="required for0_9" size="16" maxlength="14" readonly>
	  <input type="button" class="b_text" value="���" id="btn_getConNo" onClick="getContractNo()"> <font class="orange">*</font>  
	  <td></td> <td></td>
	  </TD>
	   
	</TR>
	<TR id="mimadis" >
			<jsp:include page="/npage/common/pwd_2.jsp">
					  <jsp:param name="width1" value=""  />
					  <jsp:param name="width2" value=""  />
					  <jsp:param name="pname" value="userpwd"  />
					  <jsp:param name="pcname" value="userpwdcfm"  />
	</jsp:include>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
		</TR>
</TABLE>



<DIV class="input" id="productInfo">
	<br>
		<div class="title">
		<div id="title_zi">��Ʒ��Ϣ</div>
	</div>

<div id="majorProdRel"></div> 

<div id="prodAttribute"></div> <!--��Ʒ����-->

<TABLE cellSpacing=0 id="tab_addprod" style="display:none">
  <TR>
    
  </TR>
</table>
</DIV>

<div id="serviceOrderInfo">
	<%@ include file="/npage/common/qcommon/serviceOrderInfo.jsp" %>	
</div>

<!-- weigp  webopen����sys_note op_note  /npage/common/qcommon/bd_0007.jsp-->
<!-- liujian  ��ʾsys_note op_note 
<input type="hidden" size="100"  value="" maxlength="60" name="sys_note" id="sys_note" />
<input type="hidden" size="100"  value=""  maxlength="60" name="op_note" id="op_note"/>
-->
<%@ include file="/npage/common/qcommon/bd_0007.jsp" %>	<!--sys_note op_note-->
<!-- weigp  webopen���ص����˼�������Ϣ -->
<div id="people_info" style="display:none"><!--������,�����˵ȵ���Ϣ-->
<DIV class=input>
	<table cellSpacing=0>
		<tr>
			<td class="blue">
				<input type="checkbox" value="5" name="contact_type" v_div="vouch" onclick="check_o(this)">������&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox" name="servsla_info" v_div="servsla" onclick="check_o(this)">����SLA��Ϣ&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>	
</table>
</DIV>
<div id="vouch" style="display:none">
    <%@ include file="/npage/common/qcommon/bd_0008.jsp" %>
</div>
<div id="servsla" style="display:none">
    <%@ include file="/npage/common/qcommon/bd_0019.jsp" %>
</div> 
</DIV>

</div>
</div><!--people_info end-->


<!-- ��������Ʒ ����-->
<!-- ��������Ʒ ��ʼ-->
<div class="undis" id="tbc_02" style="display:none">
		<div class="title">
		<div id="title_zi">��������Ʒ</div>
	</div>
  <TABLE cellSpacing=0 id="adddiscount">
  </TABLE>
<div id="offer_component"></div> 
<div id="div_offerComponent"></div> 

</div>
<!-- ��������Ʒ ����-->
<jsp:include page="/npage/public/hwReadCustCardNew.jsp">
	<jsp:param name="hwAccept" value="<%=sysAcceptl%>"  />
	<jsp:param name="showBody" value="01"  />
	<jsp:param name="sopcode" value="b893"  />
	<jsp:param name="labelName" value="submitFlag"/>
	<jsp:param name="idType" value="<%=agent_idType%>"/>
	<jsp:param name="idIccid" value="<%=agent_idNo%>"/>
	<jsp:param name="custName" value="<%=custName%>"/>
</jsp:include>
	<table cellSpacing=0  align="center">
		<tr id="footer"  align="center">
			 <td align="center"> 
		<INPUT class=b_foot_long id="cfmBtn" onClick="mySub()" type=button value=ȷ��&��ӡ />
		<INPUT class=b_foot_long id="cfmOffer" onClick="cfmOfferf()" type=button value=����Ʒѡ��ȷ��  style="display:none" />
		<INPUT class=b_foot onclick="ignoreThis()" type=button value=���� style="display:none"> 
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
<input type="hidden" name="addrId" value="" />
<input type="hidden" name="brandId" value="<%=brandID%>" />
<input type="hidden" name="prtFlag" value="<%=prtFlag%>"/>
<input type="hidden" name="regionCode" value="<%=regionCode%>"/>
<input type="hidden" name="mastServerType" id="mastServerType" />
<input type="hidden" name="serviceType" id="serviceType" />
<input type="hidden" name="printAccept" id="printAccept" />
<input type="hidden" name="IVPNMemberId" id="IVPNMemberId" />
<input type="hidden" name="selByWay" id="selByWay" />
<input type="hidden" name="innetType" id="innetType" />
<input type="hidden" name="workNo" value="<%=workNo%>"/>
<input name=cardtype_bz type=hidden value="s">
<input type="hidden" name="sonParentArr"/>
<input type="hidden" name="closeId" value="<%=closeId%>"/>
<input name=writecardbz type=hidden value="">
<input name="cardstatus" type=hidden value="">
<!--����Ʒ��Ϣ-->
<input type="hidden" name="offerIdArr"/>
<input type="hidden" name="offerEffectTime"/>
<input type="hidden" name="offerExpireTime"/>
<!--��Ʒ��Ϣ-->
<input type="hidden" name="productIdArr" />
<input type="hidden" name="prodEffectDate"/>
<input type="hidden" name="prodExpireDate"/>
<input type="hidden" name="isMainProduct"/>


<input type="hidden" name="newSmCode" value="<%=sm_Code%>"/>

<input type="hidden" name="offer_productAttrInfo"/><!--������Ϣ-->

<!--Ⱥ����Ϣ-->
<input type="hidden" name="groupInstBaseInfo"/>
<input type="hidden" name="addGroupIdArr"/><!--��ϲ�Ʒ�����Ŀ�ѡȺ��-->

<!--��������-->
<input type="hidden" name="phoneNoStr" id="phoneNoStr"/>
<input type="hidden" name="simNoStr" id="simNoStr" />
<input type="hidden" name="chFeeList" id="chFeeList" />
<input type="hidden" name="psfileName" />
<input type="hidden" name="simFlag" value="0" />

<!--����Ʒѡ��ʽ��ز���-->
<input type="hidden" name="selOfferType" />
<input type="hidden" name="saleMode" />
<input type="hidden" name="imeiNo" />
<input type="hidden" name="goodType" />
<input type="hidden" name="sellGroupId" />
<input type="hidden" name="blindAddCombo" id="blindAddCombo" />

<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>" /> <!--��ˮ-->

<input type="hidden" name="groutDesc" id="groutDesc" value="" /> <!--��ˮ-->
<input type="hidden" name="offId" id="offId" value="<%=offerId%>" />

<input type="hidden" name="modedxpay" id="modedxpay"   />
<input type="hidden" name="prepayFee" id="prepayFee"   />
<input type="hidden" name="isGoodNo" id="isGoodNo"   />
<input type="hidden" name="simTypeCfm" id="simTypeCfm"   />
<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />

<input type="hidden" name="ipt_PhoneID" id="ipt_PhoneID"  value="<%=ipt_PhoneID%>" />
<input type="hidden" name="main_k_type" id="main_k_type"  value="<%=main_k_type%>" />

<input type="hidden" name="newZOfferECode"/>
<input type="hidden" name="newZOfferDesc"/>                         
<input type="hidden" name="dOfferId"/>
<input type="hidden" name="dOfferName"/>
<input type="hidden" name="dECode"/>
<input type="hidden" name="xq_name"/>
<input type="hidden" name="dOfferDesc"/>
<input type="hidden" name="path"/> <!-- yanpx add ��Ӵ�ӡʹ�����ر���-->

<input type="hidden" name= "largess_card_sum" value="<%=strCardSum%>"> <!-- �������ͳ�ֵ����������-->
<input type="hidden" name="groupId" value="<%=groupId%>"/>

<input type="hidden" id="work_flow_no" name="work_flow_no" value="<%=work_flow_no%>"/>
<input type="hidden" id="level4100" name="level4100" value="<%=level4100%>"/>
<input type="hidden" id="transJf" name="transJf" value="<%=transJf%>"/>
<input type="hidden" id="transXyd" name="transXyd" value="<%=transXyd%>"/>

<input type="hidden" id="isGPhoneFlag" name="isGPhoneFlag" value=""/>
<input type="hidden" id="isGPhoneDate" name="isGPhoneDate" value=""/>
<input type="hidden" id="flag" name="flag" value="true"/> <!-- 20101206 caohq add TD�̻����ܰ�������ҵ��-->
<!-- Ԥ�����Ϣ -->
<input type="hidden" id="prePay_Fee" name="prePay_Fee" value="<%=prePay_Fee%>"/>
<input type="hidden" id="simPay_fee" name="simPay_fee" value="<%=simPay_fee%>"/>
<input type="hidden" id="phone_no" name="phone_no" value="<%=phone_no%>"/>  <!--huangrong add-->

<input type="hidden" id="printAddFlag" name="printAddFlag" value="true"/>
<input type="hidden" id="backCode" name="backCode" value="true"/>

<input type="hidden" id="is_check_readcard_result" name="is_check_readcard_result" value="<%=is_check_readcard_result%>"/>
<input type="text" name = "submitFlag" id="submitFlag" value="1"/>

<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
  <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
</DIV>
</BODY>
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>