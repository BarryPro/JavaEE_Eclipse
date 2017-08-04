<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		
		String planCode = request.getParameter("planCode");
		String smCode = request.getParameter("smCode");
		String spCode = request.getParameter("spCode");/*��Ʒ������*/
		String bizCode = request.getParameter("bizCode");/*��Ʒ������*/
		
		
		
	  String opName = "��Ʒ�б�";
	  String opCode = "";
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>


<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql>
		select Product_rateplanid, Product_rateplandesc from dproductrateplanInfo
             where  Pospec_number = '?'
               and    productspec_number = '?' order by Product_rateplanid
	</wtc:sql>
	<wtc:param value="<%=spCode%>" />
	<wtc:param value="<%=bizCode%>" />
</wtc:pubselect>
<wtc:array id="retListString1" scope="end" />


<html>
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header_pop.jsp" %> 
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<th height="26" align="center">
			ѡ��
		</th>
		<th  align="center">�ʷѼƻ���ʶ</th>
		<th align="center">�ʷѼƻ�����</th>
	</tr>
	<%for(int i=0;i < retListString1.length;i++){ %>
	<input type="hidden" name="planCode" value="<%=retListString1[i][0]%>">
	<input type="hidden" name="planName" value="<%=retListString1[i][1]%>">
	<tr>
		<td><input type="radio" name="num" value="<%=i%>"></td>
		<td><%=retListString1[i][0]%></td>
		<td><%=retListString1[i][1]%></td>
	</tr>
	<%}%>
	
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td id="footer">
				<div align="center">
			      <input class='b_foot'  type="button" name="commit" onClick="doCommit();" value=" ȷ�� ">
			      &nbsp;
			      <input class='b_foot' type="button" name="back" onClick="doClose();" value=" �ر� ">
		    </div>
		</td>
	</tr>
</table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

<script>

		function doCommit()
		{
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("��ѡ��һ����¼��");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//ֵΪһ��ʱ����Ҫ������
				if(document.all.num.checked){
					window.opener.form1.planCode.value=document.all.planCode.value;
					window.opener.form1.planName.value=document.all.planName.value;
					//window.close();
				}
				else{
					rdShowMessageDialog("��ѡ��һ����¼��");
					return false;
				}
			}
			else{//ֵΪ����ʱ��Ҫ������
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.planCode.value=document.all.planCode[a].value;
					window.opener.form1.planName.value=document.all.planName[a].value;
					//window.close();
				}
				else{
					rdShowMessageDialog("��ѡ��һ����¼��");
					return false;
				}
			}
			window.close();
		}
	
	function doClose()
	{
		
		window.close();
	}
</script>
