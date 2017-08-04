<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 登陆配置工号密码
　 * 版本: 1.0.0
　 * 日期: 2009/04/11
　 * 作者: fangyuan
　 * 版权: sitech
	 * update: yinzx 0715 客服调试  1.修改opName，修改opCode='K099'
	 *															2.规范样式的调整 3.修改相关校验方法
	 * 					 
	 * modify by yinzx 20091006 
　*/
%>
<%
	String opCode = "K099";
	String opName = "登陆配置工号密码";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String login_no ="";
	String tmpPasswd ="";
	//数据库中记录存在与否的标记
	boolean isExistFlag = false;
 
	 
	if(request.getParameter("login_no")!=null){
		login_no = (String)request.getParameter("login_no");
	}
	String subccno = (String)request.getParameter("subccno");
	String sql="select a.password from DLOGINCFG a where a.login_no=:login_no and a.subccno=:subccno";
	myParams = "login_no="+login_no + ",subccno="+subccno;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	if(result.length>0){
		isExistFlag = true;		
		tmpPasswd = result[0][0];
	} 
%>	

<html>
<head>
<title><%=opName%></title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<script>
	
var flag = <%=isExistFlag%>;

window.onload=function(){
	var serv = document.getElementById("subccno");
	var subccno = <%=subccno%>;
	
	toggle_button(flag);	
	if(subccno != undefined && subccno != null){
		serv.selected=false;
		serv.options[subccno-1].selected=true;
	}
}

//add by hucw,20100904
function toggle_button(flag){	
	if(!flag){
			$("#table_2 input:first").show();
			$("#table_2 input:gt(0)").hide();
	}else{
			$("#table_2 input:first").hide();
			$("#table_2 input:gt(0)").show();
	}
}
	
//修改回调
function handleUpd(packet){
	var retCode = packet.data.findValueByName("retCode");	
	if(retCode=="000000"){
		rdShowMessageDialog("设置成功!",2);
		flag=true;
		toggle_button(flag);
	}else{
		rdShowMessageDialog("设置失败!",0);
		return false;
	}
}
//修改
function doUpd(){		
	if(doCheck()==false) return;
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/logincfg_update.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("login_no", document.getElementById("login_no").value);
	packet.data.add("subccno", document.getElementById("subccno").value);
	packet.data.add("passwd", document.getElementById("passwd").value);
	core.ajax.sendPacket(packet,handleUpd,true);
	packet =null;
}

//插入回调
function handleInsert(packet){
	var retCode = packet.data.findValueByName("retCode");	
	if(retCode=="000000"){
		rdShowMessageDialog("设置成功!",2);
		flag=true;
		toggle_button(flag);
	}else{
		rdShowMessageDialog("设置失败!",0);
		return false;
	}
}
//增加
function doInsert(){	
	if(doCheck()==false) return;
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/logincfg_insert.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("login_no", document.getElementById("login_no").value);
	packet.data.add("passwd", document.getElementById("passwd").value);
	//add by hucw,20100618,dlogincfg插入时，必须的字段
	packet.data.add("subccno",document.getElementById("subccno").value);
	core.ajax.sendPacket(packet,handleInsert,true);
	packet =null;
}

//删除
function doDel(){	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/logincfg_del.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("login_no", document.getElementById("login_no").value);
	packet.data.add("passwd", document.getElementById("passwd").value);
	packet.data.add("subccno", document.getElementById("subccno").value);
	core.ajax.sendPacket(packet,handleDel,true);
	packet =null;
}


//删除回调
function handleDel(packet){
	var retCode = packet.data.findValueByName("retCode");	
	if(retCode=="000000"){
		rdShowMessageDialog("删除成功!",2);
		flag=false;
		toggle_button(flag);
		$("#table_1 input:not(:eq(1))").val("")
	}else{
		rdShowMessageDialog("删除失败!",0);
		return false;
	}
}

function doClose(){
	
	window.close();	
}

//提交前校验
function doCheck(){
	var el = document.getElementById('passwd');
	if(el.value==''){
		el.focus();
		return false;	
	}
}


 //验证
function doChecklogin()
{	
   var login_no = document.getElementById('login_no').value;
   var subccno = document.getElementById('subccno').value;
	 document.sitechform.action="logincfg.jsp?login_no="+login_no+"&subccno="+subccno;
   document.sitechform.method='post';
   document.sitechform.submit(); 
}


 //验证
function doback()
{	
	  window.location.replace("logincfg.jsp");
}


</script>
</head>
<body>
<form id="sitechform" name="sitechform" action="logincfg.jsp">
<%@ include file="/npage/include/header.jsp" %>
    <div class="title"><div id="title_zi">客服平台密码设置</div></div>
 
    <table cellpadding="0" id="table_1">
       <tr>
         <td class="blue">登陆工号</td>
         <td> 
         
         <input id="login_no" value="<%=login_no%>"><font class="orange">&nbsp;*</font> 
         </td>   
         <td class="blue">客服中心</td> 
         <td>
         	<select id="subccno" name="subccno">
         		<option value="1" selected="true">宝捷</option>
         		<option value="2" >江北</option>
         	</select>	
         	<font class="orange">&nbsp;*</font>
         	<input class = "b_text"   type="button" value="验证" onClick="doChecklogin()" >
         </td>    	
         <td class="blue">密码</td>
         <td><input id="passwd" value=""  type='password' maxlength="6" v_must="1" v_type="string" onBlur="checkElement(this)"><font class="orange">*</font></td>        
         
         <td>
         <!-- add by hucw,20100618 -->
       </tr>
    </table>
 

    <table id="table_2" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="footer"  align=center  > 
        <span><input class="b_foot" id="add" name="add" type="button" value="增加" onclick="doInsert()"   ></span>
        <span><input class="b_foot" id="modify" name="modify" type="button" value="修改" onclick="doUpd()" ></span>
        <span><input class="b_foot" id="del" name="del" type="button" value="删除" onclick="doDel()" ></span>
        <span><input class="b_foot" id="back" name="back" type="button" value="返回" onclick="doback()" ></span>
    </td>
   </tr>  
    </table>
    
</form>
</body>
</html>

<script>
if('<%=isExistFlag%>'=='true'){
	document.getElementById("passwd").value ='<%=tmpPasswd%>';
}
</script>


