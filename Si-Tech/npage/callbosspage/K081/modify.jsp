<%
   /*
   * 功能: 本机配置修改
   * 版本: 1.0.0
   * 日期: 20090825
   * 作者: yinzx
   * 版权: sitech
   *
   */	
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String id=request.getParameter("id");
//add by hucw,20100617
String serverAddr=request.getParameter("server_addr");
String[][] agenttype=new String[][]{{"2","普通座席"},{"4","PC+Phone"}};

    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2); 
 
String sqltotal="select s.agent_ip,s.mainccsip,s.mainccsip2,"+
								" s.ccsid,s.agenttype,s.bak2"+
								" from dcrmcallcfg s where agent_ip= :id and bak2= :server_addr " ;
myParams="id="+id+",server_addr="+serverAddr;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
	<wtc:param value="<%=sqltotal%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="totalPlan" start="0" length="6" scope="end"/>	
<html>
<head>
<title>本机配置修改</title>
<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
} 
#tabtit ul
{
	height:23px;
	position:absolute;
} 
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab 
{ 
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}
</style>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>


 
<script>
function doProcess(packet)
{
	   var retType = packet.data.findValueByName("retType");
	   var retCode = packet.data.findValueByName("retCode");
	   var retMsg = packet.data.findValueByName("retMsg");
   		if(retCode=="000000"){
    			rdShowMessageDialog("修改成功",'2');
          window.opener.location.href=window.opener.location.href;
          window.close();
	   	}else{
	   		rdShowMessageDialog("修改失败");
	   		return false;
	   	}   

}
 
  function submitInputCheck(){
    var agentIp = document.getElementById("agent_ip").value;
	 var mainCCSIp = document.getElementById("mainccsip").value;
	 var mainCCSIp2 = document.getElementById("mainccsip2").value;
	 var CCSId = document.getElementById("ccsid").value;
	 var agentType = document.getElementById("agentType").value;
	 var serv_addr = document.getElementById("serv_addr").value;
	 
	if(agentIp=='')
	{ 
			rdShowMessageDialog("IP地址段不能为空!",1);
		  document.getElementById("agent_ip").focus();
   	  return;
	}
	if(mainCCSIp=='')
	{
	 
		rdShowMessageDialog("主用CCS的IP地址不能为空!",1);
		document.getElementById("mainccsip").focus();
		return;
	}
	var patrnx =/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\*$/;
	if(!patrnx.exec(agentIp))
	{
   	rdShowMessageDialog("IP地址段格式不正确! <b> 格式为：192.168.0.*",1);
   	document.getElementById("agent_ip").focus();
	 	return;
   }   
	
	var patrn =/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	if(!patrn.exec(mainCCSIp))
	{
   	rdShowMessageDialog("主用CCS的IP地址格式不正确!",1);
   	document.getElementById("mainccsip").focus();
	 	return;
   }    
   if(mainCCSIp2=='')
   {
     
    	rdShowMessageDialog("备用CCS的IP地址不能为空!",1);
	  	document.getElementById("mainCCSIp2").focus();
	 		return;
   }
   if(!patrn.exec(mainCCSIp2))
	{
   
   	rdShowMessageDialog("备用CCS的IP地址格式不正确!",1);
   	document.getElementById("mainCCSIp2").focus();
	 	return;
   }   
	if(CCSId=='')
	{
	 
		rdShowMessageDialog("服务器进程ID不能为空!",1);
		document.getElementById("ccsid").focus();
		return;
	}	
		
	if(rdShowConfirmDialog("真的要保存吗?")==1){
		submitQcContent();
	}
    
    	
}
  
function submitQcContent()
{

   var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K081/update.jsp","正在获取本机配置信息,请稍后...");
    var sql="update dcrmcallcfg set mainccsip=:v1,mainccsip2=:v2,ccsid=:v3,agenttype=:v4 where agent_ip=:v5 and bak2=:v6";
    chkPacket.data.add("sql",sql);
    chkPacket.data.add("retType", "chkExample");
    chkPacket.data.add("agent_ip", document.getElementById("agent_ip").value);
    chkPacket.data.add("mainccsip", document.getElementById("mainccsip").value);
    chkPacket.data.add("ccsid", document.getElementById("ccsid").value);
    chkPacket.data.add("mainccsip2", document.getElementById("mainccsip2").value);
    chkPacket.data.add("agenttype", document.getElementById("agentType").value);
    chkPacket.data.add("serv_addr", document.getElementById("serv_addr").value);
    chkPacket.data.add("callerno", '');
    core.ajax.sendPacket(chkPacket,doProcess,true);
	  chkPacket =null;
}
		
	function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}
function closeWin()
{
  window.close();
}

</script>

</head>
<body>

<form  name="sitechform" id="sitechform">

<div id="Operation_Table">
		<div class="title"><div id="title_zi">本机配置修改</div></div>
		<table>
		 <tr>
  		    <td class="blue">IP地址段</td>
  		    <td  >
  		      <input id="agent_ip" name="agent_ip" size="15" maxlength="15" type="text" value="<%=totalPlan[0][0]%>" readonly >
            <input id="serv_addr" name="serv_addr" type="hidden" value="<%=totalPlan[0][5]%>">    
	  	      </td>
		    </tr>
		  <tr>
  				<td class="blue">主用CCS的IP地址</td>
  				<td  >
             <input id="mainccsip" name="mainccsip" size="15" maxlength="15" type="text" value="<%=totalPlan[0][1]%>">
	  			  </td>
			        </tr>
		  
		  <tr >
	 
  				<td class="blue">备用CCS的IP地址</td>
  				<td  >
             <input id="mainccsip2" name="mainccsip2" size="15" maxlength="15" type="text" value="<%=totalPlan[0][2]%>">
	  			  </td>
			        </tr>
		  
 
 
		  	<tr>
  				<td class="blue">服务器进程ID</td>
  				<td  >
             <input id="ccsid" name="ccsid" size="15" maxlength="15" type="text" value="<%=totalPlan[0][3]%>">
	  			  </td>
			        </tr>
 
		  	<tr>
  				<td class="blue">坐席类型</td>
  				<td  >
  						<select id="agenttype" name="agenttype" >
  					<%
      			    for(int i=0;i<2;i++)
      					{
      						String flag="";
      						if(totalPlan[0][4].trim().equals(agenttype[i][0].trim()))
      						{
      						
      							flag="selected";
      						}
      	
      						out.println("<option value="+agenttype[i][0].trim()+" "+flag+">"+agenttype[i][1]+"</option>");      						
      					}
      				%>	
             </select>
	  			  </td>
			        </tr>
		    
		  <tr >
  		    <td colspan="2" align="center" id="footer">
   		      <input name="submita" type="button" class="b_text" id="btn_internalcall" value="确认" onClick="submitInputCheck()">
   			<input name="reset1" type="button" class="b_text" id="close" value="退出" onClick="closeWin()">
  			  </td>
			</tr>
		      </table>
	            </div>
 
</form>
</body>
</html>
 
