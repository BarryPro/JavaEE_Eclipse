<%
  /*
   * ����:Ӫҵ����mac��ַ��ɾ��
   * �汾: 1.0
   * ����: 2011/10/10
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "e313";
	String opName = "Ӫҵ����mac��ַ��ɾ��";
	String regionCode = (String)session.getAttribute("orgCode");
%>
    
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>" id="printAccept"/>
<%
        String iLoginAccept = printAccept;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">

var bind_values1 = new Array() ;
var notes = new Array() ;
//----����һ����ҳ��ѡ����֯�ڵ�--- ����
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree_login.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

function commitJspQry(){//��ѯ��ť
	if(document.all.groupName.value.length < 1) {
		rdShowMessageDialog("��ѡ��Ӫҵ����");
		return false;
	}
	document.form1.action="fe313_query.jsp";
 	form1.submit();
}

</script> 
 
<title>Ӫҵ����mac��ַ��ɾ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">Ӫҵ����mac��ַ��ɾ��</div>
	</div>
<table cellspacing="0">             
	<tr>
		<td class="blue" width="10%">Ӫҵ��</td>
		<td colspan="3">
			<input type="hidden" name="groupId" id="groupId">
			<input type="text" name="groupName" id="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly size="30">&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >	
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			&nbsp;
			<input type="button" name="querry"  class="b_foot" value="��ѯ" onclick="commitJspQry()">
			&nbsp;
			<input type="button" name="close" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
	
	<input type="hidden" name="groupidStr">   
	<input type="hidden" name="macAddrStr">   
	<input type="hidden" name="opCount">  
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>