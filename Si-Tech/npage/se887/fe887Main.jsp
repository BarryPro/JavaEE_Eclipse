   <%
	/**
	 * Title: ��Ʒ��װ
	 * Description: IMS��Ʒ��װ
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
<%
    Calendar today =   Calendar.getInstance();  
    today.add(Calendar.MONTH,3);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
    String addThreeMonth = sdf.format(today.getTime());
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
    String offerName	= WtcUtil.repNull(request.getParameter("offerName"));
		
		System.out.println("---------------orderArrayId---------------------"+orderArrayId);     
		System.out.println("---------------gCustId---------------------"+gCustId);
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
        
    String ModeName=offerName;
    String offerType = "";
    
%>
<wtc:service name="sGetDetailCode" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=offerId%>" />
			<wtc:param value="<%=workNo%>" />	
			<wtc:param value="<%=opCode%>" />	
</wtc:service>
<wtc:array id="result_t33" scope="end"   />

<%
	/*��ѯʧЧʱ��ƫ����*/
	String sqlOfferExpDate = "select exp_date_offset ,exp_date_offset_unit from product_offer where offer_id=:offerId";
	System.out.println("ningtn == sqlOfferExpDate["+sqlOfferExpDate+"]");
	System.out.println("ningtn == sqlOfferExpDate["+offerId+"]");
	String[] inParams = new String[2];
	inParams[0] = sqlOfferExpDate;
	inParams[1] = "offerId=" + offerId;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" 
		retmsg="msg0" retcode="code0" outnum="2">
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
<%	
	offExpSet = "";
	offExpSetUnit = "";
	System.out.println("ningtn == code0["+code0+"] ["+result0.length+"]");
	if(result0.length>0){
		offExpSet = result0[0][0];
		offExpSetUnit = result0[0][1];
	}
	offExpDate = getExpDate(offExpSet,offExpSetUnit);
	
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
String custInfoSql = "SELECT cust_address, id_iccid  FROM dcustdoc where cust_id ="+gCustId;
System.out.println("smCodeSql|"+smCodeSql);

String ip = (String)session.getAttribute("ipAddr");
String ssss = "ͨ��custId[" + gCustId + "]��ѯ";
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=smCodeSql%></wtc:sql>
 	  </wtc:pubselect>
<wtc:array id="result_t1" scope="end"/> 	

  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
  
  <wtc:service name="sUserCustInfo" outnum="40"  retmsg="msg" retcode="code">
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=nopass%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value="<%=gCustId%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

<wtc:array id="result_custInfo" scope="end"/> 	
<%	 	
if(result_t1.length>0&&result_t1[0][0]!=null)  sm_Code = result_t1[0][0];
String custIccid = "";
String custAddr = "";
if(result_custInfo.length>0){
	custAddr = result_custInfo[0][11];
	custIccid = result_custInfo[0][13];
	
	//System.out.println(" zhouby custAddr " + custAddr);
	//System.out.println(" zhouby custIccid " + custIccid);
}
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

var iccidtypequery="";
var checkphonflags="0";
var contactflags="0";

var KDTypeId = "0";
//-----����Ʒ,��Ʒ����˵��----
var prodType = "O";
var majorProdType = "M";
var offerType = "10C";

var isOfferLoaded = false;  //�Ƿ��Ѿ���������Ʒ������ϸ
var hasProdCompInfo=false;//�Ƿ��и��Ӳ�Ʒ��־
//-----����Ʒ��ѡ��ʽ---------
var selOfferType = "";
var ordArrayHash = new Object();
var v_printAccept = "<%=printAccept%>";
$(document).ready(function () {
		if("<%=gCustId%>" == "0"){
			rdShowMessageDialog("�ͻ�ID�쳣,����ϵ����Ա!");
			window.close();	
		}
		
			if("<%=opCode%>" == "e887"){ //��ͨ������������롢һ��˫�Ŷ�Ϊ1104����è����Ϊm028
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
		  	iccidtypequery=v_userIdType;
		 	}else{
		 		rdShowMessageDialog("��ѯ�˿ͻ��Ƿ�����û���Ϣʧ�ܣ��������:<%=retCode%><br>������Ϣ:<%=retMsg%>��",0);
				return  false;
		 	}
	  });
	  myPacket = null;	
	  //��Ϊ��λ�ͻ���ʵ��ʹ���������Ϣ���֤�����ͼ���Ӫҵִ�ա���֯�������롢��λ����֤��ͽ�����
	  if(userIdType == "8" || userIdType == "A" || userIdType == "B" || userIdType == "C"){ 
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
		$("select:visible").attr("style","width:130px");
		Pz.busi.operBusi($('#tab_addprod input'),'groupTitle',true,3);
		
		/* begin add for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
		$('input[name="userpwd"]').blur(function(){
		  checkPwdEasy(document.all.userpwd.value,"userpwd");
		});
		
		$('input[name="cfmPwd"]').blur(function(){
		  //checkPwdEasy(document.all.cfmPwd.value,"cfmPwd");
		  var inputPassword = document.all.cfmPwd.value;
		  var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{15}$/;
		  if (inputPassword.length != 15){
			   rdShowMessageDialog("���볤�ȱ���Ϊ15λ�����������룡");
			   document.all.inputpassword.focus();
			   return false;
		   }
		   if(!reg.test(inputPassword)){
				rdShowMessageDialog("���������ĸ�����֣�");
				document.all.inputpassword.focus();
				return false;
			}
		});
		/* end add for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
});

/* begin add for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
//��֤������ڼ�
function checkPwdEasy(pwd,pwdName) {
	if(pwd == ""){
		rdShowMessageDialog("���벻��Ϊ�գ����������룡");
		$("input[name='"+pwdName+"']").focus();
		return;
	}
	if(pwd.length < 6){
		rdShowMessageDialog("����λ��ӦΪ6λ���֣�����������!");
		$("input[name='"+pwdName+"']").focus();
		return false;
	}
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("custId", "<%=gCustId%>");
	checkPwd_Packet.data.add("opCode", "<%=opCode%>");
	checkPwd_Packet.data.add("pwdName", pwdName);
	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

var v_retResult;
var v_retResult2;
function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");
	var pwdName = packet.data.findValueByName("pwdName");
	if(pwdName == "userpwd"){ //����У��
  	v_retResult = retResult;
  }else{
  	v_retResult2 = retResult;
  }
	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		$("input[name='"+pwdName+"']").focus();
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		$("input[name='"+pwdName+"']").focus();
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		$("input[name='"+pwdName+"']").focus();
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		$("input[name='"+pwdName+"']").focus();
		return;
	}
}
/* end add for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */

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
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
              rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
            		rdShowMessageDialog("ֻ������Ӣ�ġ����֡����ġ����ġ����ġ����Ļ����롮���š��������һ�����ԣ����������룡");
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
	

	if(!checkCustNameFunc(document.all.realUserName,3,1)){
		return false;
	}

	if(!checkAddrFunc(document.all.realUserAddr,5,1)){
				return false;
		}

	if(!checkIccIdFunc(document.all.realUserIccId,2,1)){
						return false;
	}
	
	
    getAfterPrompt(); 
    if(!check(document.prodCfm)){
			return false;
		}
		
   var contactPhoness = $("#contactPhone").val();		
		
	  var myPacket = new AJAXPacket("checkContactPhones.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	  myPacket.data.add("contactPhoness",contactPhoness.trim()); 
	  core.ajax.sendPacket(myPacket,returnContactValue);
	  myPacket = null;	
	  
	  if(contactflags=="1") {
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
		if(document.all.userpwd.value == null || document.all.userpwd.value == ""){
			rdShowMessageDialog("����������!");
			document.all.userpwd.focus();
			return false;
		}
		if(document.all.userpwd.value != document.all.userpwdcfm.value){
			rdShowMessageDialog("������������벻ͬ������������!");
			document.all.userpwd.value = "";
			document.all.userpwdcfm.value = "";
			return false;
		}
		if($("#cfmPwd").val() == ""){
			rdShowMessageDialog("������̻�����!");
			document.all.cfmPwd.focus();
			return false;
		}
		if($("#cfmPwd").val() != $("#cfmPwdConfirm").val()){
			rdShowMessageDialog("��������̻������벻ͬ������������!");
			$("#cfmPwd").val("");
			$("#cfmPwdConfirm").val("");
			return false;
		}
		
		if(document.all.userpwd.value.length < 6){
			rdShowMessageDialog("����λ��ӦΪ6λ���֣�����������!");
			document.all.userpwd.focus();
			return false;
		}
		
		if($("#cfmPwd").val().length != 15){
			rdShowMessageDialog("�̻�����λ��ӦΪ15λ����+��ĸ��ɵģ�����������!");
			document.all.cfmPwd.focus();
			return false;
		}
		
		var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{15}$/;
		if(!reg.test($("#cfmPwd").val())){
			rdShowMessageDialog("���������ĸ�����֣�");
			document.all.inputpassword.focus(); 
			return false;
		}
		
		/* add for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
		checkPwdEasy(document.all.userpwd.value,"userpwd");
		if(v_retResult=="0"){
			checkPwdEasy(document.all.cfmPwd.value,"cfmPwd");
			if(v_retResult2 == "0"){
				if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
					rdShowMessageDialog("��ϵ���벻����Ϊ�գ�������!");
					document.all.contactPhone.focus();
					return false;
				}
		
			   /*ke���뼯�ű��У��һ�¸�ʽ*/
			   if($("#newSmCode").val() == "ke"){
					if(!checkElement(document.prodCfm.unitId)){
						return false;
					}
					var unitId = $("#unitId").val();
					if(unitId != ""){
						var selectSql = "90000015";
						var params = unitId + "|";
						var getUnitId_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","����У�����Ժ�......");
						getUnitId_Packet.data.add("selectSql",selectSql);
						getUnitId_Packet.data.add("params",params);
						getUnitId_Packet.data.add("wtcOutNum","1");
						core.ajax.sendPacket(getUnitId_Packet,doQryUnitIdBack);
						getEncryptPwd_Packet = null;
						
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
					$("input[name='op_note']").val("����Ա"+"<%=workNo%>"+"�Կͻ�"+"<%=gCustId%>"+"����IMS����!");	
				}
				//ѹ���������Ʒ
				sonParentArr.push(offerId+"~"+"0");
				offerIdArr.push(offerId);
				offerEffectTime.push("<%=currTime%>");	//��ʧЧʱ�仹ûȷ��
				offerExpireTime.push("<%=offExpDate%>");
				//var mastServerType = $("#mastServerType").val();
				
				if(typeof(offerGroupHash[offerId]) != "undefined"){
						groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[offerId]+"^";
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
				
				//$("input[name='offerAttrStr']").val(offerAttrStr);
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
					
						if(typeof(AttributeHash[this.id]) != "undefined"){		//װ�븽�Ӳ�Ʒ��������Ϣ
							offer_productAttrInfo += AttributeHash[this.id];
						}	
				});	
					
				if(!vFlag){
					 return false;
				}
						
				$("#div_offerComponent :checked").each(function(){
					/*��������Ʒ�н����ѯ��û�в�ѯ��Ʒ
					if(this.name.substring(0,4)=="prod" && $("#"+nodesHash[this.id].parentOffer).attr("checked") == true && $("#effType_"+nodesHash[this.id].parentOffer).val() == "0"){	//ֻ��������Ч��
						sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
						pordIdArr.push(this.id);
						prodEffectDate.push($("#effTime_"+nodesHash[this.id].parentOffer).attr("name"));
						prodExpireDate.push($("#expTime_"+nodesHash[this.id].parentOffer).attr("name"));
						isMainProduct.push(0);
						
						if(typeof(AttributeHash[this.id]) != "undefined"){		//װ���Ʒ������Ʒ��������Ϣ
							offer_productAttrInfo += AttributeHash[this.id];
						}	
						
						sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
						offerIdArr.push(this.id);
						offerEffectTime.push($("#effTime_"+this.id).attr("name"));
						
						offerExpireTime.push($("#expTime_"+this.id).attr("name"));
						
						if(typeof(offerGroupHash[this.id]) != "undefined"){	//װ������Ʒ��Ⱥ����Ϣ
							groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[this.id]+"^";
						}
					}*/
					if(this.name.substring(0,4)=="offe"){			
						sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
						offerIdArr.push(this.id);
						offerEffectTime.push($("#effTime_"+this.id).attr("name"));
						
						offerExpireTime.push($("#expTime_"+this.id).attr("name"));
						
						if(typeof(AttributeHash[this.id]) != "undefined"){	//װ���Ʒ������Ʒ��������Ϣ
							offer_productAttrInfo += AttributeHash[this.id];
						}	
						
						if(typeof(offerGroupHash[this.id]) != "undefined"){	//װ������Ʒ��Ⱥ����Ϣ
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
				/*IMS���ĸ������ɹ����е�仯���ֻ�����0��ͷ�ģ���0ɾ��*/
				var phoneNoStr = $("#phoneNo").val();
				if(phoneNoStr.length > 0){
					if(phoneNoStr.substr(0,1) == '0'){
						phoneNoStr = phoneNoStr.substr(1,phoneNoStr.length);
					}
				}
				$("input[name='SubId']").val("86"+phoneNoStr+"@ims.hl.chinamobile.com");
				$("input[name='IMPU']").val("sip:+86"+phoneNoStr+"@ims.hl.chinamobile.com");
				$("input[name='IMPI']").val("86"+phoneNoStr+"@ims.hl.chinamobile.com");
				$("input[name='tel']").val("tel:+86"+phoneNoStr);
				var path = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
				rdShowMessageDialog("����ҵ�������ӡ����ͳһ�ɷѺ��ӡ��");
				if(rdShowConfirmDialog("��ȷ���Ƿ���в�Ʒ��װ��")==1)
				{	
						conf(path);
				}else{

							$("#cfmBtn").attr("disabled",false);			
				}
			}
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



function conf(in_str){

			var myPacket = new AJAXPacket("/npage/s1104/savePrintInfos.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
			myPacket.data.add("path",codeChg(in_str));
			myPacket.data.add("sOrderArrayId","<%=orderArrayId%>");
			myPacket.data.add("opcode","<%=opCode%>");
			myPacket.data.add("optype","0");
					
			core.ajax.sendPacket(myPacket,dosaveflag);
			myPacket = null;

				document.all.printinfo_ot.value = in_str;
	}
	
	function dosaveflag(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		
		 if(retCode != "000000"){
			rdShowMessageDialog("�洢�����Ϣ�����������:"+retCode+"��������Ϣ:"+retMsg,0);
		}
			document.prodCfm.action="IMSconfm_new.jsp?offeridIMS=<%=offerId%>";
			document.prodCfm.submit();
}


var retResultStr = "";
var retResultStr1 = "";
/*���������ӡ*/
function showPrtDlg(printType,DlgMessage,submitCfm)
{   
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=sysAcceptl%>";
   var phone_no	= $("input[name='phoneNo_h']").val();
   
   var mode_code = document.all.offerIdArr.value;
   mode_code = mode_code.replace(/,/ig,"~");
   
   
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+""+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
/*��ӡ��Ϣ*/
function printInfo(printType){
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	
	cust_info+="�ͻ�������	"+$("#userName").val().trim()+"|";
	cust_info+="�ֻ����룺	"+$("#phoneNo").val().trim()+"|";
	cust_info+="֤�����룺	"+"<%=custIccid%>"+"|";
	cust_info+="�ͻ���ַ��	"+"<%=custAddr%>"+"|";
	
	var cTime = "<%=cccTime%>";
	
	opr_info+="ҵ������ʱ�䣺"+cTime+"  "+"�û�Ʒ��:"+"IMS�̻�"+"|";
	
	opr_info+="����ҵ��IMS�̻�������centrexҵ��"+"  "+"������ˮ��"+document.all.sysAcceptl.value+"|";
	
	opr_info+= "SIM���ţ�"+" SIM����:  |";
	opr_info+= "Ԥ�� PREMONEY Ԫ"+"|";
	opr_info+="���ʷѣ�"+"<%=offerId%>  <%=offerName %>"+"  ��Чʱ�䣺<%=dateStr2 %>  "+"|"; 
	
	ajaxGetEPf('<%=offerId%>','');
	
	
	
	<%	
	String descStr = "";
	for(int hhh=0;hhh<result_t33.length;hhh++){
		descStr = result_t33[hhh][7];
	%>
		if(document.all.dECode.value!="") {
			opr_info+="  ���ʷѶ������ۣ�"+document.all.dECode.value+"|";
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
	
	
	if(document.all.newZOfferDesc.value!=""){
		note_info1+="���ʷ�������"+document.all.newZOfferDesc.value+"|";
	}else{
		note_info1+="���ʷ�������<%=offerComments%>"+"|";
	}
	
	ajaxGetEPf1(tempDescById);
	note_info1+="��ѡ�ʷ�������|"+retResultStr1+"|";		
	
	note_info4+="��ע��"+document.all.op_note.value+"|";
	
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
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
				removeCurrentTab();
			}else{
				rdShowMessageDialog("����ʧ��:"+returnMsg,0);
				removeCurrentTab();
				}
			
}
function chk_Phone(){
		var phoneNo = $("#phoneNo").val().trim();
		if(phoneNo == ""){
			rdShowMessageDialog("�����������",0);
			return false;
		}
		
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
	

	if(!checkCustNameFunc(document.all.realUserName,3,1)){
		return false;
	}

	if(!checkAddrFunc(document.all.realUserAddr,5,1)){
				return false;
		}

	if(!checkIccIdFunc(document.all.realUserIccId,2,1)){
						return false;
	}
		
    if(iccidtypequery == "8" || iccidtypequery == "A" || iccidtypequery == "B" || iccidtypequery == "C"){
	  	var sjsyzjhm = document.all.realUserIccId.value;
	  	var sjsyzjlx = document.all.realUserIdType.value;
	  	if(sjsyzjhm.trim()=="") {
	  	 rdShowMessageDialog("����������߶�ȡʵ��ʹ����֤�����룡",1);
				return  false;
	  }
	  
	  var myPacket = new AJAXPacket("../s1104/checkRealUserNum.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	  myPacket.data.add("g_CustId","<%=gCustId%>"); 
	  myPacket.data.add("opCode","<%=opCode%>");
	  myPacket.data.add("phoness",phoneNo);
	  myPacket.data.add("sjsyzjhm",sjsyzjhm);
	  myPacket.data.add("sjsyzjlx",sjsyzjlx);
	  core.ajax.sendPacket(myPacket,returncheckflags);
	  myPacket = null;	
	  		if(checkphonflags=="1") {
					return false;
				}
	   }
	   
	   
		var packet1 = new AJAXPacket("ajaxCheckPhoneNo.jsp","���Ժ�...");
		packet1.data.add("phoneNo",phoneNo);
		packet1.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet1,doChkPhoneBack,true);
		packet1 =null;
}

	function returncheckflags(packet){
	  	var retCode=packet.data.findValueByName("retcode");
		  var retMsg=packet.data.findValueByName("retmsg");
		  if(retCode == "000000"){
		    checkphonflags="0";
		 	}else{
		 		rdShowMessageDialog("У��ʵ��ʹ������Ϣ����������룺"+retCode+"��������Ϣ��"+retMsg,0);
		 		checkphonflags="1";
		 	}
	  }
	  
	function returnContactValue(packet){
	  	var retCode=packet.data.findValueByName("retcode");
		  var retMsg=packet.data.findValueByName("retmsg");
		  if(retCode == "000000"){
		    contactflags="0";
		 	}else{
		 		rdShowMessageDialog("У����ϵ�绰����������룺"+retCode+"��������Ϣ��"+retMsg,0);
		 		contactflags="1";
		 		document.all.contactPhone.focus();
		 	}
	  }	  
	  
	  
function doChkPhoneBack(packet){
	var errorCode = packet.data.findValueByName("retCode");
	var returnMsg = packet.data.findValueByName("retMsg");
	if(errorCode != "000000"){
		rdShowMessageDialog("У��ʧ��"+errorCode + ":"+returnMsg,0);
		return false;
	}else{
		rdShowMessageDialog("У��ɹ�",2);
		$("#phoneNo").attr("readonly","readonly");
		$("#chkPhone").attr("disabled","disabled");
		$("#cfmBtn").removeAttr("disabled");
	}
}

 function isKeyNumberdot_(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if((s_keycode>=48 && s_keycode<=57 ) || (s_keycode>=97 && s_keycode<=122) || (s_keycode>=65 && s_keycode<=90))
			return true;
		else 
			return false;
    else
    {
		if(((s_keycode>=48 && s_keycode<=57) || s_keycode==46) || (s_keycode>=97 && s_keycode<=122) || (s_keycode>=65 && s_keycode<=90))
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('���������븺ֵ,����������!');
		    return false;
		}
		else
			  return false;
    }       
}

function showNumberDialog_(obj) {
    var path = "<%=request.getContextPath()%>/npage/se887/NumberDialog.jsp";
    var h=170;
    var w=470;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
    
	returnValue = window.showModalDialog(path,"",prop);
    
	if (returnValue != '') {
	   obj.value = returnValue;
	}
}

function showReNumberDialog_(obj) {
    var path = "<%=request.getContextPath()%>/npage/se887/ReNumberDialog.jsp";
    var h=170;
    var w=470;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
    
	returnValue = window.showModalDialog(path,"",prop);
    
	if (returnValue != '') {
	   obj.value = returnValue;
	}
}

//ʵ��ʹ����֤�����͸ı�
function valiRealUserIdTypes(idtypeVal){
	if(idtypeVal.indexOf("0") != -1){ //���֤
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

</SCRIPT>

</HEAD>
<BODY>
<DIV id=operation>
<FORM name="prodCfm" action="" method="post" width="100%"><!-- operation_table -->
<input type="hidden"  id="isYzResource" name="isYzResource"  value="0" >
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
								<%@ include file="include/IMSfUserBaseInfo.jsp" %>
								</div>
						</div>
				</div>

				<div class="title">
					<div id="title_zi">��Դ��Ϣ</div>
				</div>	
				<table cellSpacing=0 id="serviceNoInfo">	
					<tr id="tr_serviceNo" >
						<td class="blue"> �������</td>
						<td >
							<input type="text" id="phoneNo" name="phoneNo" v_must="1" maxlength="11"/>
							<font class="orange">*</font> 
							<input type="button" name="chkPhone" id="chkPhone" value="У��" 
							 class="b_text"  onClick="chk_Phone()" >  
						</td>
						<td class="blue">��ϵ��</td>
						<td>
							<input type="text" name="contactCustName" id="contactCustName" 
							 v_must="1" maxlength="15" value=""> 
							<font class="orange">*</font>
						</td>
						<td class="blue" width="8%">��ϵ�绰</td>
						<td>
							<input type="text" name="contactPhone" id="contactPhone" v_type="mobphone"  maxlength="11"
							 v_must="1" value=""> 
							<font class="orange">*</font> 
						</td>
					<tr>
					<tr>
							<td class="blue">�̻�����</td>
							<td>
								<input name="cfmPwd" id="cfmPwd" type="password" 
								  onKeyPress="return isKeyNumberdot_(0)" class="button" 
								  maxlength="15" onFocus="showNumberDialog_(document.all.cfmPwd) " pwdlength="15">
								<font class="orange">*</font>
							</td>
							<td class="blue">�̻�����У��</td>
							<td >
								<input  name="cfmPwdConfirm" id="cfmPwdConfirm" type="password" 
								 onKeyPress="return isKeyNumberdot_(0)"  class="button" 
								  prefield="cfmPwd" filedtype="pwd" maxlength="15" 
								   onFocus="showReNumberDialog_(document.all.cfmPwdConfirm)" pwdlength="15">
								<font class="orange">*</font>
							</td>
							<!--20121101 gaopeng ����ͳһcentrex����centrex�û����Ե����� ���������б� �û����� ��centrex��ͨ�û� �ǣ�HW-Centrex-VPN ����̨�û��ǣ�HW-Centrex-Operator -->
							<td class="blue">�û�����</td>
							<td>
								<select name="custAttr">
									<option value="HW-Centrex-VPN">centrex��ͨ�û�</option>
									<option value="HW-Centrex-Operator">����̨�û�</option>
								</select>
							</td>
					</tr>
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

<table cellSpacing=0>
	<tr id="footer">
				<td align="center"> 
						<INPUT class=b_foot_long id="cfmBtn" onClick="mySub()" type=button value="ȷ��&��ӡ" disabled />
						<INPUT class=b_foot_long id="cfmOffer" onClick="cfmOfferf()" type=button value=����Ʒѡ��ȷ��  style="display:none" />
						<INPUT class=b_foot onclick="ignoreThis()" type=button value=����> 
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
<input type="hidden" name="printinfo_ot"/> 


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
<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" >
<input type="hidden"  id="cfmLoginCheck" name="cfmLoginCheck"  value="0" >
<input type="hidden"  id="isYzPhoneNo" name="isYzPhoneNo"  value="0" >
<input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
<input type="hidden"  id="noPort" name="noPort"  value="0" >
<!--��Դ������������-->

<input type="hidden" name="regionId"  value=""/>

<input type="hidden" name="ipAddType"  value="<%=ipAddType%>"/>
<!--IMS�û���ʶ���û��˺�-->
<input type="hidden" id="SubId" name="SubId" value="">
<input type="hidden" id="IMPU" name="IMPU" value="">
<input type="hidden" id="IMPI" name="IMPI" value="">
<input type="hidden" id="tel" name="tel" value="">
<!--�Ƿ���mmtel�û��ı�־����ʼֵΪ0����ʾ����-->
<input type="hidden" id="isMmtel" name="isMmtel" value="0">
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
<frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
</DIV>
</BODY>
<script language="javascript">
	var viewModel = {
		smCode:ko.observable("<%=sm_Code%>")
	}
	ko.applyBindings(viewModel);
</script>
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>