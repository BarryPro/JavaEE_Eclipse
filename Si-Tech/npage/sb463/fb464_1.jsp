<%
	/*
	 * ����: wlanԤ���ѿ����벹��- ������
	 * �汾: v1.0
	 * ����: 2010/8/24
	 * ����: jianglei
	 * ��Ȩ: sitech
	 * �޸���ʷ
	 * �޸�����      �޸���      �޸�Ŀ��
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	//��ȡ�û�session��Ϣ	
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
	String opCode = "sb464";
	String opName = "wlanԤ���ѿ����벹��";
%>	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language=javascript>
	
	
function querycard()
{
	if(check(form1)){
		tabBtn1.style.display="";
		var phone_no = document.all.phone_no.value;
		document.middle.location="fb464info.jsp?phone_no="+phone_no;
    	loading("���ڼ��ز�ѯ��Ϣ�����Ժ򡤡���������");
	}
}	
function UnLoad(){
	unLoading();
}
</script>
</head>

<body>
<form action="" name="form1"  method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">wlanԤ���ѿ����벹��</div>
</div>
	<table cellspacing="0" >
		<tr>
		<td class="blue"  nowrap>�ֻ�����</td>
	    <td>
	    	<input  type="text" name="phone_no" id="phone_no" value="" size="20" >	
	    </td>
	</tr>
	</table>
	<TABLE id="tabBtn" style="display:''" id="mainOne" cellspacing="0" >	    
		<TR id="footer"> 
			<TD colspan = "4" align="center"> 
				<input name="queryAcBtn" style="cursor:hand" type="button" class="b_foot" value="��  ѯ" onClick="querycard()">
			</TD>
		</TR>
	</TABLE> 
	<TABLE id="tabBtn1" style="display:none" id="mainOne" cellspacing="0" >
		<TR id="footer"> 
			<TD colspan = "4" align="center"> 
				<IFRAME frameBorder=0 id=middle name=middle style="HEIGHT: 306px; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
				</IFRAME>
			</TD>
		</TR>
	</TABLE> 
	
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

