<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**
	 * Title: 主资费变更（客服）
	 * Description: 
			为客服开发主资费变更
			模拟购物车，省略前面点击步骤自动生成订单。省略办理界面的客户信息
	 * Copyright: Copyright (c) 2013-5-23 13:51:35
	 * Company: SI-TECH
	 * author：ningtn hejwa
	 * version 1.0 
	 */
%>
<head>
	<title>主资费变更（客服）</title>
<head>
<style type="text/css">
				#addContainer{ 
				    position: absolute;
				    top: 50%;
				    left: 50%;
				    margin: -150px 0 0 -320px;
						text-align: center;
						width: 640px;
						padding: 20px 0 20px 0;
						border: 1px solid #339;
						background: #EEE;
						white-space: nowrap;
				}
				#addContainer img, #addContainer p{
						display: inline; 
						vertical-align: middle; 
						font: bold 12px "宋体", serif; 
				}
		</style>	
</head>
<%
		String opCode     = "g794"; //request.getParameter("opCode");
		String opName     = request.getParameter("opName");
		String gCustId    = "";
		String phone_no   = activePhone;
		String workNo     = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
		
     
    String dateStr    = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
 
	  
	  String gCustIdSql      = "select to_char(cust_id) from dcustmsg where phone_no=:phoneNo";
	  String gCustIdSqlParam = "phoneNo="+phone_no;
%>
<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=gCustIdSql%>" />
	<wtc:param value="<%=gCustIdSqlParam%>" />	
</wtc:service>
<wtc:array id="resultCustId" scope="end"  />
<%
if(resultCustId.length>0){
	gCustId = resultCustId[0][0];
}else{
%>
<script>
	rdShowMessageDialog("取客户ID失败！");
	removeCurrentTab();
</script>
<%
}
%>
<!--取客户产品信息-->
<wtc:utype name="sCustOffer" id="retConsOffer" scope="end" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:uparam value="<%=gCustId%>" type="LONG"/>
    <wtc:uparam value="<%=phone_no%>" type="STRING"/>
    <wtc:uparam value="0" type="STRING"/>
</wtc:utype>

<%
	String retCode = retConsOffer.getValue(0);
	int tsize = 0;
	if(retCode.equals("0")){
		tsize = retConsOffer.getSize("2");
		if(tsize==0){
%>
<script>
			rdShowMessageDialog("取客户信息失败，无节点！",0);
			removeCurrentTab();
</script>			
<%		
		}
	}else{
%>
<script>
	rdShowMessageDialog("取客户信息失败！【<%=retCode%>】",0);
	removeCurrentTab();
</script>	
<%		
	}
%>
<script language="javascript" type="text/javascript" src="/njs/si/validate_class.js"></script>
<script language="javascript" type="text/javascript" src="/njs/extend/mztree/stTree.js"></script>
<script language="javascript">
$(document).ready(function(){
	drawCustServiceTree('<%=retConsOffer.getValue("2.0.21")%>','<%=retConsOffer.getValue("2.0.0")%>','<%=retConsOffer.getValue("2.0.1")%>','<%=retConsOffer.getValue("2.0.6")%>','<%=retConsOffer.getValue("2.0.13")%>','<%=0%>','<%=tsize%>','<%=gCustId%>')	;
});
//客户服务树
function drawCustServiceTree(phoneNo, idNo, prodId, offerId, brandId, flag, allSize,CustId){	
    var packet = new AJAXPacket("/npage/portal/shoppingCar/getProdSrvKF.jsp");
    packet.data.add("prodId", prodId);
    packet.data.add("phoneNo", phoneNo);
    packet.data.add("idNo", idNo);
    packet.data.add("offerId", offerId);
    packet.data.add("brandId", brandId);
    packet.data.add("CustId", CustId);
    packet.data.add("opCode", "<%=opCode%>");
    core.ajax.sendPacketHtml(packet, doGetProdSrv, true);
    packet = null;
    
}
function doGetProdSrv(data){
    if(data.trim() == ""){
      rdShowMessageDialog("没有产品信息");
    }else{
       eval(data);
    }
    
}

function LK(opcode, functionName, phoneNo, idNo, servBusiId, offerId, brandId){
    //判断是否互斥
    var sData = getTableData("shoppingCarList", 2, 3);
    var packet = new AJAXPacket("/npage/portal/shoppingCar/chkProdSrvRel.jsp");
    packet.data.add("opcode", opcode);
    packet.data.add("functionName", functionName);
    packet.data.add("phoneNo", phoneNo);
    packet.data.add("idNo", idNo);
    packet.data.add("servBusiId", servBusiId);
    packet.data.add("sData", sData);
    packet.data.add("offerId", offerId);
    packet.data.add("brandId", brandId);
    packet.data.add("custId", '<%=gCustId%>');
    core.ajax.sendPacket(packet, doChkProdSrvRel);
    packet = null;

}

//判断是否互斥回调
function doChkProdSrvRel(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var checkflag = packet.data.findValueByName("checkflag"); //认证标识
    var custAuthIdType = packet.data.findValueByName("CustIdType"); //认证类型
    var phoneNo = packet.data.findValueByName("phoneNo");
    var opcode = packet.data.findValueByName("opcode");
    var functionName = packet.data.findValueByName("functionName");
    var brandId = packet.data.findValueByName("brandId");
    var idNo = packet.data.findValueByName("idNo");
    var servBusiId = packet.data.findValueByName("servBusiId");
    var offerId = packet.data.findValueByName("offerId");
    var tabID = "shoppingCarList";
    var tabRowNum = document.getElementById(tabID).rows.length;

    if (retCode == "0"){
        var sizeFlag = packet.data.findValueByName("sizeFlag");
        if (parseInt(sizeFlag) > 0){
            var prompt = packet.data.findValueByName("prompt");
            return false;
        } else {
              insertCar(idNo, offerId, opcode, servBusiId, phoneNo, functionName);
        }
    } else if (retCode == "2"){
        rdShowMessageDialog("session失效");
    } else {
        rdShowMessageDialog("[" + retCode + "]" + retMsg);
    }
}

function insertCar(idNo, offerId, opcode, servBusiId, phoneNo, functionName){
	  var packet = new AJAXPacket("/npage/portal/shoppingCar/checkOpCode.jsp");
	  		packet.data.add("idNo", idNo);
	  		packet.data.add("offerId", offerId);
        packet.data.add("opcode", opcode);
        packet.data.add("servBusiId", servBusiId);
        packet.data.add("phoneNo", phoneNo);
        packet.data.add("functionName", functionName);
        core.ajax.sendPacket(packet, doCheckOpCode);
        packet = null;
}

function doCheckOpCode(packet){
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  
	if(retCode=="0"){
			var idNo = packet.data.findValueByName("idNo");
		  var offerId = packet.data.findValueByName("offerId");
		  var opcode = packet.data.findValueByName("opcode");
		  var servBusiId = packet.data.findValueByName("servBusiId");
		  var phoneNo = packet.data.findValueByName("phoneNo");
		  var functionName = packet.data.findValueByName("functionName");
		  
			var tabID = "shoppingCarList";
	    var tabRowNum = document.getElementById(tabID).rows.length;
	    var offerInfoCode = "";
	    var offerInfoValue = "";
	    var dealNum = "<input type='text' style='border:1px solid #FFF' name=test onKeyUp=chkInt(this) onafterpaste=chkInt(this) readonly value='1' size='3'>&nbsp;";
	    var delBut = "<input  type='button' value='删除' class='b_text' onclick='delTr()' id=''><span style='display:none'>Y|" + idNo + "|" + offerId + "|" + opcode + "|" + servBusiId + "|" + offerInfoCode + "|" + offerInfoValue + "</span>&nbsp;";
	    var arrTdCon = new Array(phoneNo, functionName, dealNum, delBut);
	    addTr(tabID, tabRowNum, arrTdCon, 0|1);
	    custOrderC();
		}else{
			rdShowMessageDialog(retCode+":"+retMsg);
		}	
}		
 
function custOrderC()
{
    var sData = getTableData("shoppingCarList", 2, 3);
    var optorMsg = ",2,,, , , , ";
     if (!checksubmit(frm)) return false;
		//经办人信息未展开，则系统校验框架不起作用，需要手工校验。
    if (sData == "")
    {
        rdShowMessageDialog("请选择客户服务");
        return false;
    }
    var prtFlagValue = "Y";
    	
        var packet = new AJAXPacket("/npage/portal/shoppingCar/sCustOrderC.jsp");
        packet.data.add("sData", sData);
        packet.data.add("optorMsg", optorMsg);
        packet.data.add("custId", "<%=gCustId%>");
        packet.data.add("prtFlagValue", prtFlagValue);
        core.ajax.sendPacket(packet, doCustOrderC);
        packet = null;
}		
function doCustOrderC(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if (retCode == "0")
    {
        var prtFlag = "Y";
        var custOrderId = packet.data.findValueByName("custOrderId");
        var custOrderNo = packet.data.findValueByName("custOrderNo");
        goNext(custOrderId, custOrderNo, prtFlag);
    } else
    {
        rdShowMessageDialog("创建客户订单失败!请联系系统管理员!");
    }
}
var nextpath = "";
function goNext(custOrderId,custOrderNo,prtFlag)
{
	var packet = new AJAXPacket("/npage/portal/shoppingCar/sShowMainPlan.jsp");
	packet.data.add("custOrderId" ,custOrderId);
	packet.data.add("custOrderNo" ,custOrderNo);
	packet.data.add("prtFlag" ,prtFlag);
	core.ajax.sendPacket(packet,doNext);
	packet =null;
	document.frm.action=nextpath;
	document.frm.submit();		
}
/*2013/07/04 8:51:13 gaopeng 执行下一步回调函数*/
function doNext(packet)
{
    var retCode = packet.data.findValueByName("retCode"); 
	  var retMsg = packet.data.findValueByName("retMsg"); 
	  if(retCode=="0")
	  {
	  	var sData = packet.data.findValueByName("sData"); 
	  	//parent.parent.$("#carNavigate").html(sData);
	  	var custOrderId = packet.data.findValueByName("custOrderId"); 
	  	var custOrderNo = packet.data.findValueByName("custOrderNo"); 
	  	var orderArrayId = packet.data.findValueByName("orderArrayId"); 
	  	var servOrderId = packet.data.findValueByName("servOrderId"); 
	  	var status = packet.data.findValueByName("status"); 
	  	var funciton_code = packet.data.findValueByName("funciton_code"); 
	  	var funciton_add = packet.data.findValueByName("funciton_add"); 
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
	  	var validVal = packet.data.findValueByName("validVal"); 
	  	var openWay = packet.data.findValueByName("openWay"); 
	  	var closeId=orderArrayId+servOrderId;
	  	
	  	pageUrl = "../se112/main1.jsp"
	  	var path=   pageUrl+"?gCustId=<%=gCustId%>"
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
	  							+"&closeId="+funciton_code
	  							+"&servBusiId="+servBusiId
	  							+"&prtFlag="+prtFlag
	  							+"&work_flow_no="
	  							+"&transJf="
	  							+"&transXyd="
	  							+"&level4100="
	  							+"&opcodeadd="+funciton_add
	  							+"&opCode="+funciton_code
	  							+"&opName="+funciton_name
	  							+"&crmActiveOpCode="+funciton_code
	  							+"&activePhone="+phoneNo
	  							+"&broadPhone=";
	  							nextpath = path;	
	  }else
	  {
	  		  rdShowMessageDialog("操作导航失败!");
	  }
}
</script>
<body>

 
<form name="frm" method="POST" >
<div id='addContainer'><nobr><img src='/nresources/default/images/blue-loading.gif'><p class='orange'>&nbsp;&nbsp;&nbsp;&nbsp;正在进行生成订单处理，请请候……加载时间可能稍长，请勿刷新页面！</p></nobr></div>
 <table cellspacing="0" id="shoppingCarList" style="display:none" >
     <tr>
         <th>业务号码</th>
         <th>产品名称</th>
         <th>受理数量</th>
         <th>操作</th>
     </tr>
 </table>
</form>
</body>
</html>