<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %><%/*update by diling for 营业生产主机weblogic报错自查流程@2011/10/27 */%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ taglib uri="/WEB-INF/si.tld" prefix="si" %> 
<%@ taglib uri="/WEB-INF/si-html.tld" prefix="html" %> 
<%@ taglib uri="/WEB-INF/si-logic.tld" prefix="logic" %>  

<%
    /* BEGIN : add by qidp for 系统换肤 @ 2010-04-19 */
    String versonType = WtcUtil.repNull((String)session.getAttribute("versonType"));    // 页面框架版本:: normal:普通版;simple:高速版.
    System.out.println("$ versonType = "+versonType);
    
    String cssPath = "default";
    if(!"simple".equals(versonType)){
        cssPath = WtcUtil.repNull((String)session.getAttribute("cssPath"));  // 系统皮肤
    }
    System.out.println("$ css path is : "+cssPath);
    /* END : add by qidp */
%>

<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/jquery.dimensions.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<script language="JavaScript" src="/njs/si/prompt.js"></script>
<link href="/nresources/<%=cssPath%>/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/<%=cssPath%>/css/prompt.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="/njs/extend/jquery/tooltip/jquery.tooltip.js"></script>	
<link href="/njs/extend/jquery/tooltip/jquery.tooltip.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>

<%
    String tabcloseId = WtcUtil.repNull(request.getParameter("closeId"));
	String activePhone  = (String)request.getParameter("activePhone");
	String appCnttFlag  = (String)application.getAttribute("appCnttFlag");//接触平台状态
	String opBeginTime  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//业务开始时间
	
	String g_CustId = request.getParameter("gCustId");
    String opName = request.getParameter("opName");
    String opCode = request.getParameter("opCode");
%>

<script language="javascript">
var oldClose = window.close;
window.close=function()
{
	if((typeof parent.removeTab )=="function")
	{
		 removeCurrentTab();
	}
	else 
	{
		oldClose();
	}
}

function goNext(custOrderId,custOrderNo,prtFlag)
{
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
	packet.data.add("custOrderId" ,custOrderId);
	packet.data.add("custOrderNo" ,custOrderNo);
	packet.data.add("prtFlag" ,prtFlag);
	core.ajax.sendPacket(packet,doNext);
	packet =null;
	
	if("<%=tabcloseId%>"!="")
	{
			parent.removeTab("<%=tabcloseId%>");
	}
}

function doNext(packet)
{
	var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  if(retCode=="0")
	  {
	  	var sData = packet.data.findValueByName("sData"); 
	  	parent.parent.$("#carNavigate").html(sData);
	  	//alert(sData);
	  	var custOrderId = packet.data.findValueByName("custOrderId"); 
	  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
	  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
	  	var servOrderId = packet.data.findValueByName("servOrderId"); 
	  	var status = packet.data.findValueByName("status"); 
	  	var funciton_code = packet.data.findValueByName("funciton_code"); 
	  	var funciton_name = packet.data.findValueByName("funciton_name"); 
	  	var pageUrl = packet.data.findValueByName("pageUrl"); 
	  	var offerSrvId = packet.data.findValueByName("offerSrvId"); 
	  	var num = packet.data.findValueByName("num"); 
	  	var offerId = packet.data.findValueByName("offerId"); 
	  	var offerName = packet.data.findValueByName("offerName"); 
	  	var phoneNo = packet.data.findValueByName("phoneNo"); 
	  	var sitechPhoneNo = packet.data.findValueByName("sitechPhoneNo"); 
	  	var prtFlag = packet.data.findValueByName("prtFlag"); 
	  	var servBusiId = packet.data.findValueByName("servBusiId"); 
	  	var closeId=orderArrayId+servOrderId;
	  	
	  	if(closeId=="")
	  	{
	  		closeId= funciton_code;
	  	}
	  	var path="/npage/"+pageUrl+"?gCustId=<%=g_CustId%>"
	  							+"&opCode="+funciton_code
	  						  +"&opName="+funciton_name
	  							+"&offerSrvId="+offerSrvId
	  							+"&num="+num
	  							+"&offerId="+offerId
	  							+"&offerName="+offerName
	  							+"&phoneNo="+phoneNo
	  							+"&sitechPhoneNo="+sitechPhoneNo
	  							+"&orderArrayId="+orderArrayId
	  							+"&custOrderId="+custOrderId
	  							+"&custOrderNo="+custOrderNo
	  							+"&servOrderId="+servOrderId
	  							+"&closeId="+closeId
	  							+"&servBusiId="+servBusiId
	  							+"&prtFlag="+prtFlag;
	  							
										parent.addTab(false,closeId,funciton_name,path);
	 			
	  }else
	  {
	  		alert("lose");
	  }
}
</script>