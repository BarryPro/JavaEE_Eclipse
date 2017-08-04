<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 本机系统配置
　 * 版本: 1.0.0
　 * 日期: 2008/10/16
　 * 作者: tancf
　 * 版权: sitech
	 *update:  yinzx 0715 客服调试 1.增加规范，修改样式
	 *														 2.界面头部的icdCfgObject 需要隐藏，释放出来显示一个圈 不知道为什么
　*/
%>
<%
	String opCode = "K081";
	String opName = "本机系统配置";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>
<div style="display:none"> 
<OBJECT id='icdCfgObject' classid="CLSID:7F3929A0-C455-43EC-ACF0-8B1AD46873DC"
 codebase="/ocx/localId.cab#version=1,0,0,0"
	  width=20
	  height=20
	  align=center
	  hspace=0
	  vspace=0>
</OBJECT>
</div>  
<html>
<head>
<title>本机系统配置</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/CCcommonTool.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/sitechcallcenter.js"></script>
<script>

/*提交配置信息*/
function submitConfig(){
  var macAdds="";
	var agentIp = document.getElementById("agent_ip").value;
	var mainCCSIp = document.getElementById("mainccsip").value;
	var mainCCSIp2 = document.getElementById("mainccsip2").value;
	var CCSId = document.getElementById("ccsid").value;
	var agentType = document.getElementById("agentType").value;
	//var callinnerflag = document.getElementById("callinnerflag").value;
	//var callerNo =document.getElementById("callerno").value;
	if(agentIp=='')
	{
	//alert("IP地址不能为空");
	rdShowMessageDialog("IP地址不能为空!",1);
	document.getElementById("agent_ip").focus();
   return;
	}
	if(mainCCSIp=='')
	{
	//alert("主用CCS的IP地址不能为空");
	rdShowMessageDialog("主用CCS的IP地址不能为空!",1);
	document.getElementById("mainccsip").focus();
	return;
	}
	var patrn =/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	if(!patrn.exec(mainCCSIp))
	{
   //alert("您输入要查找的IP格式不正确");
   rdShowMessageDialog("您输入的IP格式不正确!",1);
   document.getElementById("mainccsip").focus();
	 return;
   }    
   if(mainCCSIp2=='')
   {
    //alert("备用CCS的IP地址不能为空");
    rdShowMessageDialog("备用CCS的IP地址不能为空!",1);
	  document.getElementById("mainCCSIp2").focus();
	  return;
   }
   if(!patrn.exec(mainCCSIp2))
	{
   //alert("您输入要查找的IP格式不正确");
   rdShowMessageDialog("您输入的IP格式不正确!",1);
   document.getElementById("mainCCSIp2").focus();
	 return;
   }   
	if(CCSId=='')
	{
	//alert("服务器进程ID不能为空");
	rdShowMessageDialog("服务器进程ID不能为空!",1);
	document.getElementById("ccsid").focus();
	return;
	}		
	if(rdShowConfirmDialog("真的要保存吗?")==1){
	updateLocalCfg(macAdds);
	}
}

function deleteClose(){
document.getElementById("mainccsip").value='';
document.getElementById("mainccsip2").value='';  
}

/*对返回值进行处理*/
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var agentIp = packet.data.findValueByName("agentIp");
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="chkExample"){
		if(retCode=="000000"){
		  icdCfgObject.writeLocalIp(agentIp);
			rdShowMessageDialog("成功更新本机配置信息!",1);
		}else{
			rdShowMessageDialog("无法更新本机配置信息!",1);
			return false;
		}
	}
}


/*对返回值进行处理*/
function doProcessSelect(packet)
{
	//var retType = packet.data.findValueByName("retType");
	//var retCode = packet.data.findValueByName("retCode"); 
	//var retMsg = packet.data.findValueByName("retMsg");
	var agent_ip = document.getElementById("agent_ip").value;
	var mainccsip = packet.data.findValueByName("mainccsip");
	document.getElementById("mainccsip").value=mainccsip;
	var ccsid =packet.data.findValueByName("ccsid");
	if(ccsid=='' ||ccsid==null){
	   ccsid='22';
	}
	document.getElementById("ccsid").value=ccsid;
	var mainccsip2 = packet.data.findValueByName("mainccsip2");
	document.getElementById("mainccsip2").value=mainccsip2;
	//var create_time = packet.data.findValueByName("create_time");
	var agenttype = packet.data.findValueByName("agenttype");
	var typeone=document.getElementById("agentType");
	if(agenttype!=""){
		
	 for(var j=0;j<typeone.length;j++)
	 {
	 if (agenttype == typeone[j].value) { 
		typeone[j].selected = true; 
		break; 
		} 	
	 }
	}
	else
		{
		typeone[0].selected = true; 	
		}
	//var callerno = packet.data.findValueByName("callerno");
	// document.getElementById("callerno").value=callerno;
	
		if(mainccsip!=''){ 
			rdShowMessageDialog("成功获取本机配置信息!",1);
		}else{
			rdShowMessageDialog("没有配置信息!",1);
			return false;
		}
}

/*添加或者修改本机配置信息*/	
function updateLocalCfg(macAdds)
{   
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/local_config_update.jsp","正在获取本机配置信息,请稍后...");
    chkPacket.data.add("retType", "chkExample");
    chkPacket.data.add("agent_ip", document.getElementById("agent_ip").value);
    chkPacket.data.add("mainccsip", document.getElementById("mainccsip").value);
    chkPacket.data.add("ccsid", document.getElementById("ccsid").value);
    chkPacket.data.add("mainccsip2", document.getElementById("mainccsip2").value);
    chkPacket.data.add("agenttype", document.getElementById("agentType").value);
    chkPacket.data.add("callerno", '');
    core.ajax.sendPacket(chkPacket,doProcess,true);
	  chkPacket =null;
}		
function getLocale()
{
		var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/public/selectCCSInfo.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
    chkPacket.data.add("localIp", document.getElementById("agent_ip").value);
    core.ajax.sendPacket(chkPacket,doProcessSelect,true);
	  chkPacket =null;
}
</script>
</head>
<body>
<form  name=formbar>
<%@ include file="/npage/include/header.jsp" %>

    <div class="title"><div id="title_zi">本机系统参数配置</div></div>
    <%--本机系统配置表格Begin{--%>
    <table cellpadding="0">
      <tr>
         <td  class="Blue">IP地址</td>
         <td>
         	<select id="agent_ip" onchange="getLocale();"></select>
         </td>
        <td  class="Blue">主用CCS的IP地址</td>
        <td> 
        <input id="mainccsip"  maxlength="15" index="27"  v_must=1 v_maxlength=15 v_type="text" size="15"><font class="orange">&nbsp;&nbsp;*</font>
        </td>
        <td class="Blue">备用CCS的IP地址</td>
        <td> 
          <input id="mainccsip2" maxlength="15" index="27"  v_must=1 v_maxlength=8 v_type="date" size="15"><font class="orange">&nbsp;&nbsp;*</font>
        </td>        
      </tr>
       <tr>
         <td class="Blue">服务器进程ID</td>
         <td> 
         <input id="ccsid" value="22"><font class="orange">&nbsp;&nbsp;*</font>
         </td>       	
         <td class="Blue">坐席类型</td>
         <td colspan="3" > 
          <select id='agenttype'>
         	 <option value="2">普通座席</option>
         	 <option value="4">PC+Phone</option>
          </select>
          
         </td>
          
         <!-- 20090310 fangyuan 取消内部求助 option
         <td class="blue"><!--手机号->是否接受内部求助</td>
         <td> -->
         	<!-- 
         <input id="callerno" maxlength=13 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
         -->
         <!-- 20090310 fangyuan 取消内部求助 option
         <select id='callinnerflag'>
         	 <option value="1">是</option>
         	 <option value="0">否</option>
        </select>
         
         </td>     20090310 fangyuan 取消内部求助 option  end -->           
       </tr>
       
    </table>
       
    <%--本机系统配置表格End}--%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="footer"  align=center> 
        <input class="b_foot" name="submit" type="button" value="确认" onclick="submitConfig()">
        <input type="reset" name="Reset" value="Reset" style="display:none">
    </td>
   </tr>  

    </table>
    
    <!--以下被替换-->
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
  <SCRIPT >
 var locator = document.getElementById("locator");
 var varMacObject = document.getElementById("varMacObject");
 //var service = locator.ConnectServer();
 //service.Security_.ImpersonationLevel=3;
 //service.InstancesOfAsync(varMacObject, 'Win32_NetworkAdapterConfiguration');
 var flag=0;
 
//获取ip
 onInit();
 function onInit(){
 var selectMac = document.getElementById("agent_ip");
 var localIp=icdCfgObject.ownerIp();
 var arr =localIp.split("|");
 for(var i=0;i<arr.length-1;i++){
 selectMac.options.add(new Option(arr[i],arr[i]));
 if(i==0){
   getLocale();
 }
 }
 }
</script>



