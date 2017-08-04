
<%
/*
 * �汾: 1.0
 * ����: zhangyan
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.DateFormat"%>
<wtc:sequence name = "sPubSelect" key = "sMaxSysAccept" id = "sLoginAccept"/>
<%
String regCode = (String)session.getAttribute("regCode");

String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");

String passwd = (String)session.getAttribute("password");
String phoNo = request.getParameter ( "activePhone" );

Calendar cal = Calendar.getInstance();
cal.add(java.util.Calendar.HOUR_OF_DAY,1);
SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
String opTime = sf.format(cal.getTime());
%>	
<%
String sql = " SELECT COUNT(1) "
	+ " FROM PRODUCT_OFFER_INSTANCE A, SWLANMODE B, DCUSTMSG T "
	+ " WHERE A.SERV_ID = T.ID_NO "
	+ " AND T.PHONE_NO = :PHONE_NO "
	+ " AND A.OFFER_ID = B.OFFER_ID "
	+ " AND B.PACK_TYPE IN ('08', '09', '10') "
	+ " AND A.EXP_DATE > TRUNC(ADD_MONTHS(SYSDATE, 1), 'mm') ";
String sql_param = "PHONE_NO="+phoNo;
String BusiType = "1";
%>
<wtc:service name="TlsPubSelCrm"  outnum="2"
	routerKey="region" routerValue="<%=regCode%>"  
	retcode="retResult" retmsg="retMsg">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="<%=sql_param%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
if ( !result1[0][0].equals( "0" ) )
{
	BusiType = "2";
}
%>
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opCode%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></script>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</HEAD>
<BODY>
<FORM NAME = "frm" ACTION = "" METHOD = "POST" >
<%@ include file = "/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV CLASS = "title" >
			<DIV ID = "title_zi"><%=opName%></DIV>
		</DIV>
		<TABLE>
			<TR>
				<TD CLASS = "blue" ALIGN = "center" WIDTH = "25%">�û��˺�:</TD>
				<TD colspan = '3' >
					<INPUT type = "TEXT" ID = 'Account' NAME = 'Account' ch_name = '�û��˺�' MAXlENGTH = '64' 
						VALUE = '<%=phoNo%>' class = 'InputGrey' readOnly />	
				</TD>	
			<TR>
			<TR>
				<TD CLASS = "blue" ALIGN = "center" WIDTH = "25%">�����Ѷ���:</TD>
				<TD WIDTH = "25%">
					<SELECT ID ='BindReminder' NAME = 'BindReminder' ch_name='�����Ѷ���'>
						<OPTION VALUE=''>---��ѡ��---</OPTION>
						<OPTION VALUE='0'>0-->����</OPTION>
						<OPTION VALUE='1'>1-->�ر�</OPTION>
					</SELECT>				
				</TD>	
				<TD CLASS = "blue" ALIGN = "center" WIDTH = "25%">�������Ѷ���:</TD>
				<TD >
					<SELECT ID ='UseReminder' NAME = 'UseReminder' ch_name='�������Ѷ���'>
						<OPTION VALUE=''>---��ѡ��---</OPTION>
						<OPTION VALUE='0'>0-->����</OPTION>
						<OPTION VALUE='1'>1-->�ر�</OPTION>						
					</SELECT>
				</TD>	
			<TR>				
		</TABLE>	
		<TABLE>
			<TR>
				<TD COLSPAN="4" ALIGN="center" ID="footer">
					<INPUT TYPE = "button" ID = "" NAME = "" CLASS = "b_foot" VALUE = "ȷ��" onClick="doCfm( this )" />   
					<INPUT TYPE = "button" ID = "" NAME = "" CLASS = "b_foot" VALUE = "����" onClick="doRet( this )" />   
					<INPUT TYPE = "button" ID = "" NAME = "" CLASS = "b_foot" VALUE = "�ر�" onClick="removeCurrentTab();" />
				</TD>
			</TR>	
		</TABLE>
	</DIV>
</DIV>
<%@ include file="/npage/include/footer.jsp" %> 
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'phoNo' NAME = 'phoNo' VALUE = '<%=phoNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opTime' NAME = 'opTime' VALUE = '<%=opTime%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'BusiType' NAME = 'BusiType' VALUE = '<%=BusiType%>'/>
</form>
<SCRIPT>
var stepNum=0;
$(document).ready(
	function ()
	{
		$( "#d0" ).show( 300 );
		stepNum=stepNum+1;
	}
);
function doRet( obj )
{
	document.frm.action = "#";
	document.frm.submit();			
}

function doCfm( obj )
{
	document.frm.action = "fg853_cfm.jsp";
	document.frm.submit();
	obj.disabled = true ;
}
</SCRIPT>
</BODY>
</HTML>

