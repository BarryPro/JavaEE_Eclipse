<%
  /*
   * ����: ѡ��ҵ�����
�� * �汾: 1.0.0
�� * ����: 2008/12/20
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>

<%
	String opCode = "K217";
	String opName = "ѡ��ҵ�����";
	String call_cause_id = WtcUtil.repNull(request.getParameter("call_cause_id"));
	String call_cause_desc = WtcUtil.repNull(request.getParameter("call_cause_desc"));
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	if(call_cause_id.startsWith(",")){
			call_cause_id = call_cause_id.substring(1,call_cause_id.length());
	}
	if(call_cause_id.endsWith(",")){
	  	call_cause_id = call_cause_id.substring(0,call_cause_id.length()-1);
	}
	/***************�������ԭ�����ݿ�ʼ******************/
  String sqlGetCauseInfo = "select callcause_id,caption,fullname from dcallcausecfg where callcause_id in("+call_cause_id+")";
%>

<%
  //����ʼ���ˮ
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
			<wtc:param value="<%=sqlGetCauseInfo%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
  <wtc:array id="causeInfo" scope="end"/>
  	
<%
  /***************�������ԭ�����ݽ���******************/
%>

<html>
<head>
	<title>ѡ��ҵ�����</title>
	
<script>
function getReturnStr(){
		var texts = "";
		var ids   = "";
		var service_checkBox = document.getElementsByName("typeCheckBox");
	  var service_typeSpans = document.getElementsByName("typeSpan");
	  
		for(var i = 0; i < service_checkBox.length; i++){
				if(service_checkBox[i].checked==true){
					  texts += service_typeSpans[i].innerHTML + ",";
				    ids   += service_checkBox[i].value + ",";
			  }
		}
		return texts + '_' + ids;
}

function submitErrorClass(){
		window.returnValue = getReturnStr();
		window.close();
}
</script>

</head>
<body >
<form name="form1">

<%@ include file="/npage/include/header.jsp" %>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td>
<%
      		for(int i=0;i<causeInfo.length;i++){
%>
      		<input type="checkbox" name="typeCheckBox" id="typeCheckBox" value="<%=(causeInfo.length>0)?causeInfo[i][0]:""%>"><span id="typeSpan" name="typeSpan"><%=(causeInfo.length>0)?causeInfo[i][2]:""%></span><br>
<%
      		}
%>
      	</td>
      </tr>
    </table>
</div>

<div id="Operation_Table">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="submitErrorClass()" type="button" class="b_foot" value="ȷ��">
				<input name="confirm" onClick="window.close()" type="button" class="b_foot" value="ȡ��">
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>


