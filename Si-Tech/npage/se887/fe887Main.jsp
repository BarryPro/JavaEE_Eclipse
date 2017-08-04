   <%
	/**
	 * Title: 产品新装
	 * Description: IMS产品新装
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
<%
    Calendar today =   Calendar.getInstance();  
    today.add(Calendar.MONTH,3);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
    String addThreeMonth = sdf.format(today.getTime());
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
	/*查询失效时间偏移量*/
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
String custInfoSql = "SELECT cust_address, id_iccid  FROM dcustdoc where cust_id ="+gCustId;
System.out.println("smCodeSql|"+smCodeSql);

String ip = (String)session.getAttribute("ipAddr");
String ssss = "通过custId[" + gCustId + "]查询";
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

var iccidtypequery="";
var checkphonflags="0";
var contactflags="0";

var KDTypeId = "0";
//-----销售品,产品类型说明----
var prodType = "O";
var majorProdType = "M";
var offerType = "10C";

var isOfferLoaded = false;  //是否已经加载销售品构成明细
var hasProdCompInfo=false;//是否有附加产品标志
//-----销售品树选择方式---------
var selOfferType = "";
var ordArrayHash = new Object();
var v_printAccept = "<%=printAccept%>";
$(document).ready(function () {
		if("<%=gCustId%>" == "0"){
			rdShowMessageDialog("客户ID异常,请联系管理员!");
			window.close();	
		}
		
			if("<%=opCode%>" == "e887"){ //普通开户、特殊号码、一卡双号都为1104，天猫开户为m028
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
		  	iccidtypequery=v_userIdType;
		 	}else{
		 		rdShowMessageDialog("查询此客户是否存在用户信息失败！错误代码:<%=retCode%><br>错误信息:<%=retMsg%>！",0);
				return  false;
		 	}
	  });
	  myPacket = null;	
	  //当为单位客户，实际使用人相关信息必填。证件类型即：营业执照、组织机构代码、单位法人证书和介绍信
	  if(userIdType == "8" || userIdType == "A" || userIdType == "B" || userIdType == "C"){ 
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
		$("select:visible").attr("style","width:130px");
		Pz.busi.operBusi($('#tab_addprod input'),'groupTitle',true,3);
		
		/* begin add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
		$('input[name="userpwd"]').blur(function(){
		  checkPwdEasy(document.all.userpwd.value,"userpwd");
		});
		
		$('input[name="cfmPwd"]').blur(function(){
		  //checkPwdEasy(document.all.cfmPwd.value,"cfmPwd");
		  var inputPassword = document.all.cfmPwd.value;
		  var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{15}$/;
		  if (inputPassword.length != 15){
			   rdShowMessageDialog("密码长度必须为15位，请重新输入！");
			   document.all.inputpassword.focus();
			   return false;
		   }
		   if(!reg.test(inputPassword)){
				rdShowMessageDialog("必须包含字母和数字！");
				document.all.inputpassword.focus();
				return false;
			}
		});
		/* end add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
});

/* begin add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
//验证密码过于简单
function checkPwdEasy(pwd,pwdName) {
	if(pwd == ""){
		rdShowMessageDialog("密码不能为空，请重新输入！");
		$("input[name='"+pwdName+"']").focus();
		return;
	}
	if(pwd.length < 6){
		rdShowMessageDialog("密码位数应为6位数字，请重新输入!");
		$("input[name='"+pwdName+"']").focus();
		return false;
	}
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
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
	if(pwdName == "userpwd"){ //密码校验
  	v_retResult = retResult;
  }else{
  	v_retResult2 = retResult;
  }
	if (retResult == "1") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		$("input[name='"+pwdName+"']").focus();
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		$("input[name='"+pwdName+"']").focus();
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		$("input[name='"+pwdName+"']").focus();
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		$("input[name='"+pwdName+"']").focus();
		return;
	}
}
/* end add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */

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
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
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
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
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
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
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
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
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
		
	  var myPacket = new AJAXPacket("checkContactPhones.jsp","正在查询信息，请稍候......");
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
			rdShowMessageDialog("正在加载销售品构成!");
			HoverLi(2,2);
			return false;  
		}	
		if($("#serviceType").val() == ""){
			rdShowMessageDialog("取服务类型出错!");
			return false;  
		}
		if(document.all.userpwd.value == null || document.all.userpwd.value == ""){
			rdShowMessageDialog("请输入密码!");
			document.all.userpwd.focus();
			return false;
		}
		if(document.all.userpwd.value != document.all.userpwdcfm.value){
			rdShowMessageDialog("两次输入的密码不同，请重新输入!");
			document.all.userpwd.value = "";
			document.all.userpwdcfm.value = "";
			return false;
		}
		if($("#cfmPwd").val() == ""){
			rdShowMessageDialog("请输入固话密码!");
			document.all.cfmPwd.focus();
			return false;
		}
		if($("#cfmPwd").val() != $("#cfmPwdConfirm").val()){
			rdShowMessageDialog("两次输入固话的密码不同，请重新输入!");
			$("#cfmPwd").val("");
			$("#cfmPwdConfirm").val("");
			return false;
		}
		
		if(document.all.userpwd.value.length < 6){
			rdShowMessageDialog("密码位数应为6位数字，请重新输入!");
			document.all.userpwd.focus();
			return false;
		}
		
		if($("#cfmPwd").val().length != 15){
			rdShowMessageDialog("固话密码位数应为15位数字+字母组成的，请重新输入!");
			document.all.cfmPwd.focus();
			return false;
		}
		
		var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{15}$/;
		if(!reg.test($("#cfmPwd").val())){
			rdShowMessageDialog("必须包含字母和数字！");
			document.all.inputpassword.focus(); 
			return false;
		}
		
		/* add for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
		checkPwdEasy(document.all.userpwd.value,"userpwd");
		if(v_retResult=="0"){
			checkPwdEasy(document.all.cfmPwd.value,"cfmPwd");
			if(v_retResult2 == "0"){
				if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
					rdShowMessageDialog("联系号码不可以为空，请输入!");
					document.all.contactPhone.focus();
					return false;
				}
		
			   /*ke输入集团编号校验一下格式*/
			   if($("#newSmCode").val() == "ke"){
					if(!checkElement(document.prodCfm.unitId)){
						return false;
					}
					var unitId = $("#unitId").val();
					if(unitId != ""){
						var selectSql = "90000015";
						var params = unitId + "|";
						var getUnitId_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","正在校验请稍候......");
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
				
				var sonParentArr = []; //存放销售品,产品间子~父关系
				var groupInstBaseInfo = "";				//群组信息
				var offer_productAttrInfo = ""; //销售品,产品属性串
				
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
					$("input[name='op_note']").val("操作员"+"<%=workNo%>"+"对客户"+"<%=gCustId%>"+"进行IMS开户!");	
				}
				//压入基本销售品
				sonParentArr.push(offerId+"~"+"0");
				offerIdArr.push(offerId);
				offerEffectTime.push("<%=currTime%>");	//生失效时间还没确定
				offerExpireTime.push("<%=offExpDate%>");
				//var mastServerType = $("#mastServerType").val();
				
				if(typeof(offerGroupHash[offerId]) != "undefined"){
						groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[offerId]+"^";
				}	
				
						//---------生成基本销售品属性信息----------
				var offerAttrStr = "";			//销售品属性串
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
				var productAttrStr = "";			//产品属性串
				
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
					
						if(typeof(AttributeHash[this.id]) != "undefined"){		//装入附加产品的属性信息
							offer_productAttrInfo += AttributeHash[this.id];
						}	
				});	
					
				if(!vFlag){
					 return false;
				}
						
				$("#div_offerComponent :checked").each(function(){
					/*附加销售品中界面查询中没有查询产品
					if(this.name.substring(0,4)=="prod" && $("#"+nodesHash[this.id].parentOffer).attr("checked") == true && $("#effType_"+nodesHash[this.id].parentOffer).val() == "0"){	//只送立即生效的
						sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
						pordIdArr.push(this.id);
						prodEffectDate.push($("#effTime_"+nodesHash[this.id].parentOffer).attr("name"));
						prodExpireDate.push($("#expTime_"+nodesHash[this.id].parentOffer).attr("name"));
						isMainProduct.push(0);
						
						if(typeof(AttributeHash[this.id]) != "undefined"){		//装入产品，销售品的属性信息
							offer_productAttrInfo += AttributeHash[this.id];
						}	
						
						sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
						offerIdArr.push(this.id);
						offerEffectTime.push($("#effTime_"+this.id).attr("name"));
						
						offerExpireTime.push($("#expTime_"+this.id).attr("name"));
						
						if(typeof(offerGroupHash[this.id]) != "undefined"){	//装入销售品的群组信息
							groupInstBaseInfo = groupInstBaseInfo + offerGroupHash[this.id]+"^";
						}
					}*/
					if(this.name.substring(0,4)=="offe"){			
						sonParentArr.push(this.id+"~"+nodesHash[this.id].parentOffer);
						offerIdArr.push(this.id);
						offerEffectTime.push($("#effTime_"+this.id).attr("name"));
						
						offerExpireTime.push($("#expTime_"+this.id).attr("name"));
						
						if(typeof(AttributeHash[this.id]) != "undefined"){	//装入产品，销售品的属性信息
							offer_productAttrInfo += AttributeHash[this.id];
						}	
						
						if(typeof(offerGroupHash[this.id]) != "undefined"){	//装入销售品的群组信息
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
				/*IMS这四个码生成规则有点变化，手机号以0开头的，将0删除*/
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
				var path = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
				rdShowMessageDialog("开户业务免填单打印移至统一缴费后打印！");
				if(rdShowConfirmDialog("请确认是否进行产品新装？")==1)
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
			rdShowMessageDialog("集团编号不是归属哈尔滨或不存在，请确认",0);
		}else{
			$("#unitIdFlag").val("1");
		}
	}
}



function conf(in_str){

			var myPacket = new AJAXPacket("/npage/s1104/savePrintInfos.jsp","正在查询信息，请稍候......");
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
			rdShowMessageDialog("存储免填单信息出错，错误代码:"+retCode+"，错误信息:"+retMsg,0);
		}
			document.prodCfm.action="IMSconfm_new.jsp?offeridIMS=<%=offerId%>";
			document.prodCfm.submit();
}


var retResultStr = "";
var retResultStr1 = "";
/*电子免填单打印*/
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
function printInfo(printType){
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	
	cust_info+="客户姓名：	"+$("#userName").val().trim()+"|";
	cust_info+="手机号码：	"+$("#phoneNo").val().trim()+"|";
	cust_info+="证件号码：	"+"<%=custIccid%>"+"|";
	cust_info+="客户地址：	"+"<%=custAddr%>"+"|";
	
	var cTime = "<%=cccTime%>";
	
	opr_info+="业务受理时间："+cTime+"  "+"用户品牌:"+"IMS固话"+"|";
	
	opr_info+="办理业务：IMS固话开户（centrex业务）"+"  "+"操作流水："+document.all.sysAcceptl.value+"|";
	
	opr_info+= "SIM卡号："+" SIM卡费:  |";
	opr_info+= "预存款： PREMONEY 元"+"|";
	opr_info+="主资费："+"<%=offerId%>  <%=offerName %>"+"  生效时间：<%=dateStr2 %>  "+"|"; 
	
	ajaxGetEPf('<%=offerId%>','');
	
	
	
	<%	
	String descStr = "";
	for(int hhh=0;hhh<result_t33.length;hhh++){
		descStr = result_t33[hhh][7];
	%>
		if(document.all.dECode.value!="") {
			opr_info+="  主资费二次批价："+document.all.dECode.value+"|";
		}else{
			opr_info+="  主资费二次批价：<%=result_t33[hhh][2]%>|";
		}
	<%
	}
	%>
	
	var tempNote_info2 = "";
	var tempArray1 = document.all.offerIdArr.value.split(",");
	var aaa = "";
	opr_info+="可选资费：";
	var tempDescById = "";
	
	for(var h=1;h<tempArray1.length;h++){
		if(tempArray1[h]!=""&&tempArray1[h]!="undefined")
			var node = nodesHash[tempArray1[h]];
		if(node!=""&&node!="undefined"){
			tempDescById = tempDescById+node.getId()+"|";
			if("<%=dateStr2%>"==node.begTime.substring(0,8)){		  		
				tempNote_info2+="("+node.getId()+"、"+node.getName()+"、24小时生效)";			
			}else{
				tempNote_info2+="("+node.getId()+"、"+node.getName()+"、预约生效)";			
			}
		}
	}
	opr_info+= tempNote_info2+"|";	
	
	
	if(document.all.newZOfferDesc.value!=""){
		note_info1+="主资费描述："+document.all.newZOfferDesc.value+"|";
	}else{
		note_info1+="主资费描述：<%=offerComments%>"+"|";
	}
	
	ajaxGetEPf1(tempDescById);
	note_info1+="可选资费描述：|"+retResultStr1+"|";		
	
	note_info4+="备注："+document.all.op_note.value+"|";
	
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
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
				removeCurrentTab();
			}else{
				rdShowMessageDialog("忽略失败:"+returnMsg,0);
				removeCurrentTab();
				}
			
}
function chk_Phone(){
		var phoneNo = $("#phoneNo").val().trim();
		if(phoneNo == ""){
			rdShowMessageDialog("请先输入号码",0);
			return false;
		}
		
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
	  	 rdShowMessageDialog("请先输入或者读取实际使用人证件号码！",1);
				return  false;
	  }
	  
	  var myPacket = new AJAXPacket("../s1104/checkRealUserNum.jsp","正在查询信息，请稍候......");
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
	   
	   
		var packet1 = new AJAXPacket("ajaxCheckPhoneNo.jsp","请稍后...");
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
		 		rdShowMessageDialog("校验实际使用人信息出错，错误代码："+retCode+"，错误信息："+retMsg,0);
		 		checkphonflags="1";
		 	}
	  }
	  
	function returnContactValue(packet){
	  	var retCode=packet.data.findValueByName("retcode");
		  var retMsg=packet.data.findValueByName("retmsg");
		  if(retCode == "000000"){
		    contactflags="0";
		 	}else{
		 		rdShowMessageDialog("校验联系电话出错，错误代码："+retCode+"，错误信息："+retMsg,0);
		 		contactflags="1";
		 		document.all.contactPhone.focus();
		 	}
	  }	  
	  
	  
function doChkPhoneBack(packet){
	var errorCode = packet.data.findValueByName("retCode");
	var returnMsg = packet.data.findValueByName("retMsg");
	if(errorCode != "000000"){
		rdShowMessageDialog("校验失败"+errorCode + ":"+returnMsg,0);
		return false;
	}else{
		rdShowMessageDialog("校验成功",2);
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
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
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

//实际使用人证件类型改变
function valiRealUserIdTypes(idtypeVal){
	if(idtypeVal.indexOf("0") != -1){ //身份证
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
								<%@ include file="include/IMSfUserBaseInfo.jsp" %>
								</div>
						</div>
				</div>

				<div class="title">
					<div id="title_zi">资源信息</div>
				</div>	
				<table cellSpacing=0 id="serviceNoInfo">	
					<tr id="tr_serviceNo" >
						<td class="blue"> 服务号码</td>
						<td >
							<input type="text" id="phoneNo" name="phoneNo" v_must="1" maxlength="11"/>
							<font class="orange">*</font> 
							<input type="button" name="chkPhone" id="chkPhone" value="校验" 
							 class="b_text"  onClick="chk_Phone()" >  
						</td>
						<td class="blue">联系人</td>
						<td>
							<input type="text" name="contactCustName" id="contactCustName" 
							 v_must="1" maxlength="15" value=""> 
							<font class="orange">*</font>
						</td>
						<td class="blue" width="8%">联系电话</td>
						<td>
							<input type="text" name="contactPhone" id="contactPhone" v_type="mobphone"  maxlength="11"
							 v_must="1" value=""> 
							<font class="orange">*</font> 
						</td>
					<tr>
					<tr>
							<td class="blue">固话密码</td>
							<td>
								<input name="cfmPwd" id="cfmPwd" type="password" 
								  onKeyPress="return isKeyNumberdot_(0)" class="button" 
								  maxlength="15" onFocus="showNumberDialog_(document.all.cfmPwd) " pwdlength="15">
								<font class="orange">*</font>
							</td>
							<td class="blue">固话密码校验</td>
							<td >
								<input  name="cfmPwdConfirm" id="cfmPwdConfirm" type="password" 
								 onKeyPress="return isKeyNumberdot_(0)"  class="button" 
								  prefield="cfmPwd" filedtype="pwd" maxlength="15" 
								   onFocus="showReNumberDialog_(document.all.cfmPwdConfirm)" pwdlength="15">
								<font class="orange">*</font>
							</td>
							<!--20121101 gaopeng 关于统一centrex增加centrex用户属性的需求 新增下拉列表 用户属性 ：centrex普通用户 是：HW-Centrex-VPN 话务台用户是：HW-Centrex-Operator -->
							<td class="blue">用户属性</td>
							<td>
								<select name="custAttr">
									<option value="HW-Centrex-VPN">centrex普通用户</option>
									<option value="HW-Centrex-Operator">话务台用户</option>
								</select>
							</td>
					</tr>
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

<table cellSpacing=0>
	<tr id="footer">
				<td align="center"> 
						<INPUT class=b_foot_long id="cfmBtn" onClick="mySub()" type=button value="确定&打印" disabled />
						<INPUT class=b_foot_long id="cfmOffer" onClick="cfmOfferf()" type=button value=销售品选择确认  style="display:none" />
						<INPUT class=b_foot onclick="ignoreThis()" type=button value=忽略> 
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
<input type="hidden" name="printinfo_ot"/> 


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
<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" >
<input type="hidden"  id="cfmLoginCheck" name="cfmLoginCheck"  value="0" >
<input type="hidden"  id="isYzPhoneNo" name="isYzPhoneNo"  value="0" >
<input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
<input type="hidden"  id="noPort" name="noPort"  value="0" >
<!--资源所属所属地市-->

<input type="hidden" name="regionId"  value=""/>

<input type="hidden" name="ipAddType"  value="<%=ipAddType%>"/>
<!--IMS用户标识和用户账号-->
<input type="hidden" id="SubId" name="SubId" value="">
<input type="hidden" id="IMPU" name="IMPU" value="">
<input type="hidden" id="IMPI" name="IMPI" value="">
<input type="hidden" id="tel" name="tel" value="">
<!--是否是mmtel用户的标志，初始值为0，表示不是-->
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