<%
   /*
   * 功能: 查询用户开通服务信息
　 * 版本: v1.0
　 * 日期: 2008年4月17日
　 * 作者: wuln
　 * 版权: sitech
   * update:tangsong@2010-12-30 页面样式改造,美化用户信息页
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="/npage/common/portalInclude.jsp" %>

<%
  String opCode = "";
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String phone_no = (String)request.getParameter("activePhone");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String idNo = (String)request.getParameter("idno");
%>

<wtc:service name="sPCSelService" outnum="10"    routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
    <wtc:param value=""/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>	
    <wtc:param value="<%=phone_no%>"/>		
    <wtc:param value=""/>			
    <wtc:param value="5002"/>				
</wtc:service>
<wtc:array id="result" scope="end" />
	
	<%
	String iSmsCont = "";
	System.out.println("------------------kfktqk---------retCode-----"+retCode);
	System.out.println("------------------kfktqk---------retmsg------"+retMsg);
	
	if("000000".equals(retCode)){
      if(result.length>0){
          iSmsCont = "您的已开通业务如下:";
          for(int i=0;i<result.length;i++){
              iSmsCont += " "+(i+1)+"."+result[i][1]+";";
          }
      }else{
          iSmsCont = "您未开通任何业务。";
      }
  }
  System.out.println(iSmsCont);
%>
<html>
<head>
<script type="text/javascript">
	window.onload = function() {
		var newHeight = document.body.scrollHeight + 20 + "px";
		var newWidth = document.body.scrollWidth + 20 + "px";
		window.parent.document.getElementById("showCustWTab").style.height = newHeight;
		window.parent.document.getElementById("showCustWTab").style.width = newWidth;
		window.parent.document.getElementById("iFrame1").style.height = newHeight;
		window.parent.document.getElementById("iFrame1").style.width = newWidth;
	}
	
	/*
	comment by hucw,20110313,注释发送短信方式，采用K083_msgSend_rpc.jsp发送短信，有日志记录
	function sendProMsg(){
		var packet = new AJAXPacket("f6992_2.jsp");
		packet.data.add("phone_no" ,"<%=phone_no%>");
		packet.data.add("sms_cont" ,"<%=iSmsCont%>");
		core.ajax.sendPacket(packet,doSendProMsg,true);
		packet =null;
	}
	function doSendProMsg(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode!="000000"){
			rdShowMessageDialog(retCode+","+retMsg,0);
		}else{
			rdShowMessageDialog("发送特服短信成功",2);
		}
	}
	*/
	
	function sendMsg(){
		//update by wench 20111103
		if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("非接续状态，不能发送!",0);
				return;
		}
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K083/K083_msgSend_rpc.jsp","正在发送短信，请稍候......");
		mypacket.data.add("user_phone","<%=phone_no%>");
		mypacket.data.add("accepttype_flag","7");
		var contactId = window.top.document.getElementById('contactId').value;
		var kfcaller = window.top.cCcommonTool.getCaller();
		mypacket.data.add("msg_content","<%=iSmsCont%>");
		mypacket.data.add("kfcaller",kfcaller);
		mypacket.data.add("contactId",contactId);
		core.ajax.sendPacket(mypacket,function(packet){
			var retCode = packet.data.findValueByName("scucc_flag");
			if(retCode=="1"){
				rdShowMessageDialog("向<%=phone_no%>号码发送短信成功");
			}else if(retCode=="0"){
				rdShowMessageDialog("向<%=phone_no%>号码发送短信失败");
			}
		},true);
		mypacket = null;
	}
	
function dCustFuncHis() {
	var path = "f1500_dCustFuncHis.jsp?phoneNo=<%=phone_no%>&idNo=<%=idNo%>";
	document.getElementById("iFrame1").src = path;
	document.all.showCustWTab1.style.display = "";
	
}

</script>
</head>
<body>
<form>
<div id="Main" style="width:785px;">
   <DIV id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">特服开通情况 (他机验证密码)</div><input type="button" value="发送特服短信" class="b_text" onclick="sendMsg()">
		</div>
    <table width="100%" class="list" id="serviceMsg">
  	<tr>
    <th>特服名称</th>
		<th>开通时间</th>
		<th>到期时间</th>
		<th>优惠月数</th>
		<th>费用</th>
		<th>特服代码</th>
	  </tr>
    <%
		if(retCode.equals("000000")){
			if(result.length>0){
				for(int i=0;i<result.length;i++){
	      	String classes="";
					if(i%2==1){classes="grey";}
					{
			%>	             
		<tr>
			<td style="color:black"><%=result[i][1]%> </td>
			<td style="color:black"><%=result[i][2]%> </td>
			<td style="color:black"><%=result[i][3]%> </td>
			<td style="color:black"><%=result[i][6]%> </td>
			<td style="color:black"><%=result[i][5]%> </td>
			<td style="color:black"><%=result[i][0]%> </td>
		</tr>
		 <%
		       }
			  }
			 }
		}
		%>	
	  </table>
	  <table>
	  	<tr>
	  		<td id="footer">
	  			<input type="button" class="b_text" value="特服变更明细" onclick="dCustFuncHis()" />
	  		</td>
	  	</tr>
	</table>
</div>
<div id="showCustWTab1" style="display:none">
	<iframe name="iFrame1" id="iFrame1" src=""  width="100%" frameborder="0"></iframe>	 
</div>
</form>
</body>
