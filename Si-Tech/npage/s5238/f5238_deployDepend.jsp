<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-20
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "���˲�Ʒ����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	

<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	
	//��ȡ����ҳ�õ�����Ϣ
	String login_accept = request.getParameter("login_accept");	
	String mode_code = request.getParameter("mode_code");
	String mode_name = request.getParameter("mode_name");	
	String region_code = request.getParameter("region_code");	
	   					 
%>

<html>
<head>
<base target="_self">
<title>��Ʒ������������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
	
function qryModeDependErrMsg()
{	
	var url = "f5238_queryDependErrMsg.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&region_code=<%=region_code%>";
	escape(url);
	window.open(url,'','height=700,width=800,left=60,top=60,scrollbars=yes');

}

function modeDependOther()
{
	document.form1.modeTransOtherButton.disabled=true;
	var url = "f5238_modeDepend.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=0";
	window.open(url,'','height=700,width=800,left=60,top=60,scrollbars=yes');
}

function otherDependMode()
{
	document.form1.otherTransModeButton.disabled=true;
	var url = "f5238_modeDepend2.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>&trans_type=1";
	window.open(url,'','height=700,width=800,left=60,top=60,scrollbars=yes');
}

///�رմ�ҳ�沢����f5238_5.jspҳ���е�queryRelationFlag()�����ѯ��ϵ�����״̬
function closewindow()
{
    window.opener.document.form1.dependButton.disabled=false;
    window.opener.queryRelationFlag();
	window.close();
}
</script>
</head>

<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	

	  <form name="form1"  method="post">
	  	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">��Ʒ������������</div>
	</div>

	  		  	<TABLE   id="mainOne"  cellspacing="0">
	  				<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  					<TD width="35%">
	  						<%=mode_code%>
	  					</TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;��ǰ������ˮ��</TD>
	  					<TD width="35%"><font class="orange"><%=login_accept%></font></TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  					<TD colspan="3">
	  						<%=mode_name%>
	  					</TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD colspan="4" class="blue">
	  						&nbsp;&nbsp;���ò�Ʒ��<%=mode_code%>����������Ʒ��������ϵ����
	  						<input name="modeTransOtherButton" class="b_text" type="button" value="����" onClick="modeDependOther();">
	  						<input name="modeErr0" type="button"  class="b_text" value="ʧ�ܼ�¼��ѯ" onClick="qryModeDependErrMsg();">
	  					</TD>
	  				</tr>
	  				<tr  height="22">
	  					<TD colspan="4" class="blue">
	  						&nbsp;&nbsp;����������Ʒ����Ʒ��<%=mode_code%>����������ϵ����
	  						<input name="otherTransModeButton" type="button"  class="b_text" value="����" onClick="otherDependMode();">
								<input name="modeErr1" type="button" class="b_text"  value="ʧ�ܼ�¼��ѯ" onClick="qryModeDependErrMsg();">  					
	  					</TD>
	  				</tr>
	  			</table>
	  			<table id="mainThree" cellspacing="0" >
	  				<tr height="24" >
      		    <Th width="10%" align="center">��Ʒ����</Th>
	  					<Th width="30%" align="center">��Ʒ����</Th>
	  					<Th width="10%" align="center">��ϵ</Th>
	  					<Th width="10%" align="center">��Ʒ����</Th>
	  					<Th width="30%" align="center">��Ʒ����</Th>
	  					<Th width="10%" align="center">������ʽ</Th>
      		  		</tr>
	  				<tr  height="22">
	  					<td colspan="6">
	  						<IFRAME src="f5238_deployDependFrame.jsp?login_accept=<%=login_accept%>&mode_code=<%=mode_code%>&mode_name=<%=mode_name%>&region_code=<%=region_code%>" frameBorder=0 id=middle2 name=middle2 scrolling="yes" style="HEIGHT: 280; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1">
      		  	  			</IFRAME>
      		  	  		</td>
	  				</tr>
	          	</TABLE>
	          	<TABLE  cellSpacing=0>
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="lastButton" type="button" class="b_foot" value="����" onClick="closewindow();">
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

