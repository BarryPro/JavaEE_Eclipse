<%
   /*
   * ����: ��ѯ�û���ͨ������Ϣ
�� * �汾: v1.0
�� * ����: 2008��4��17��
�� * ����: wuln
�� * ��Ȩ: sitech
   * update:tangsong@2010-12-30 ҳ����ʽ����,�����û���Ϣҳ
 ��*/
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
          iSmsCont = "�����ѿ�ͨҵ������:";
          for(int i=0;i<result.length;i++){
              iSmsCont += " "+(i+1)+"."+result[i][1]+";";
          }
      }else{
          iSmsCont = "��δ��ͨ�κ�ҵ��";
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
	comment by hucw,20110313,ע�ͷ��Ͷ��ŷ�ʽ������K083_msgSend_rpc.jsp���Ͷ��ţ�����־��¼
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
			rdShowMessageDialog("�����ط����ųɹ�",2);
		}
	}
	*/
	
	function sendMsg(){
		//update by wench 20111103
		if(parent.parent.current_CurState !=5){
				rdShowMessageDialog("�ǽ���״̬�����ܷ���!",0);
				return;
		}
		var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K083/K083_msgSend_rpc.jsp","���ڷ��Ͷ��ţ����Ժ�......");
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
				rdShowMessageDialog("��<%=phone_no%>���뷢�Ͷ��ųɹ�");
			}else if(retCode=="0"){
				rdShowMessageDialog("��<%=phone_no%>���뷢�Ͷ���ʧ��");
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
			<div id="title_zi">�ط���ͨ��� (������֤����)</div><input type="button" value="�����ط�����" class="b_text" onclick="sendMsg()">
		</div>
    <table width="100%" class="list" id="serviceMsg">
  	<tr>
    <th>�ط�����</th>
		<th>��ͨʱ��</th>
		<th>����ʱ��</th>
		<th>�Ż�����</th>
		<th>����</th>
		<th>�ط�����</th>
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
	  			<input type="button" class="b_text" value="�ط������ϸ" onclick="dCustFuncHis()" />
	  		</td>
	  	</tr>
	</table>
</div>
<div id="showCustWTab1" style="display:none">
	<iframe name="iFrame1" id="iFrame1" src=""  width="100%" frameborder="0"></iframe>	 
</div>
</form>
</body>
