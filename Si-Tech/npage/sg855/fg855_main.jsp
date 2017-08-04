<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.DateFormat"%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");
String regCode = (String)session.getAttribute("regCode");
String phoNo = request.getParameter ( "activePhone" );

Calendar cal = Calendar.getInstance();
cal.add(java.util.Calendar.HOUR_OF_DAY,1);
SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
String opTime = sf.format(cal.getTime());
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></SCRIPT>
</HEAD>
<BODY>
<FORM  NAME = "frm" ACTION = "" METHOD = "POST" >
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV class = "title" >
			<DIV id = "title_zi"><%=opName%></DIV>
		</DIV>
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >帐号:</TD>
				<TD WIDTH = '*'>
					<INPUT TYPE = 'text' ID = 'act_no' NAME= 'act_no' ch_name = '帐号' MAXLENGTH = '55' 
						value = '<%=phoNo%>' class = 'InputGrey' readOnly />.cmcc-hlj
					<font color = 'red' >*</font> 
				</TD>    
			</TR>

			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '确认' onClick = 'doCfm()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '重置' onClick = 'doRet()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '关闭' onClick = 'removeCurrentTab();' />
				</TD>
			</TR>        
		</TABLE>
	</DIV>
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'phoNo' NAME = 'phoNo' VALUE = '<%=phoNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opTime' NAME = 'opTime' VALUE = '<%=opTime%>'/>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<SCRIPT>
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).show( "300" );
		stepNum = stepNum + 1;
		
		var packet = new AJAXPacket( "/npage/public/pubGetUserBaseInfo.jsp" , "请稍后..." );
	
		packet.data.add( "ajaxType" , "getIfo" );
		packet.data.add( "phoneNo" , "<%=phoNo%>" );
		packet.data.add( "opCode" , "<%=opCode%>" );
		core.ajax.sendPacket( packet , setIfo );//异步
		packet = null;
		
	}
);

function setIfo ( packet )
{
	var retcode = packet.data.findValueByName ( "retcode" );
	var retmsg = packet.data.findValueByName ( "retmsg" );
	if ( retcode != "0" )
	{
		rdShowMessageDialog( retcode + ":" + retmsg , 0 );
		removeCurrentTab();
	}
	else
	{
		$("#act_name").val( packet.data.findValueByName( "stPMcust_name" ) );
	}
	
	
}
function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
}

function doCfm ()
{
	document.frm.action = 'f<%=opCode%>_cfm.jsp';
	document.frm.submit();
}


</SCRIPT>
</BODY>
</HTML>