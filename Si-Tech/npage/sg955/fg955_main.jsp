<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");
String regCode = (String)session.getAttribute("regCode");
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
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >手机号码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'pho_no1' NAME= 'pho_no1' ch_name = '手机号码' MAXLENGTH = '15' value = '' />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >操作类型:</TD>
				<TD WIDTH = '25%'>
					<SELECT ID = 'op_type' NAME = 'op_type' ch_name='操作类型' >
						<OPTION VALUE = '' >---请选择---</OPTION>
						<OPTION VALUE = '0' >添加黑名单</OPTION>
						<OPTION VALUE = '1' >解除黑名单</OPTION>
					</SELECT>
				</TD>    
			</TR>

			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '查询' onClick = 'doQry()' />   
					<INPUT TYPE = 'BUTTON' ID = 'update' NAME= '' CLASS = 'b_foot' VALUE = '修改' onClick = 'doCfm()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '重置' onClick = 'doRet()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '关闭' onClick = 'removeCurrentTab();' />
				</TD>
			</TR>        
		</TABLE>
	</DIV>
	<DIV ID = 'queryDiv' ></DIV>
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'workNo' NAME = 'workNo' VALUE = '<%=workNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'passwd' NAME = 'passwd' VALUE = '<%=passwd%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'qryFlag' NAME = 'qryFlag' VALUE = '0'/>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<SCRIPT>
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).show( 1000 );
		stepNum = stepNum + 1;
	}
);

function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
	
}

function doCfm ()
{
	if ( fn_notNull ( document.all.pho_no1 ) ) return ;
	if ( fn_notNull ( document.all.op_type ) ) return ;

	document.frm.action = "f<%=opCode%>_cfm.jsp";
	document.frm.submit();
	$("#update").attr("disabled","true");
}

function doQry ()
{
	if ( fn_notNull ( document.all.pho_no1 ) ) return ;

	var packet = new AJAXPacket("f<%=opCode%>_ajax.jsp","请稍后...");

	packet.data.add( "logacc" , "<%=logacc%>" );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
	packet.data.add( "passwd" , "<%=passwd%>" );
	
	packet.data.add( "phoNo" , $( "#pho_no1" ).val() );
	packet.data.add( "usrPwd" , "" );
	packet.data.add( "opNote" , $( "#opCode" ).val() + $( "#opName" ).val() + $( "#pho_no1" ).val() );
	packet.data.add( "fromWay" , "0" );
	packet.data.add( "tm_b" , "" );
	
	packet.data.add( "tm_e" , "" );
	packet.data.add( "op_type" , $( "#op_type" ).val() );
	packet.data.add( "op_login" ,"" );
	
	packet.data.add( "ajaxType" , "setLst" );
	core.ajax.sendPacketHtml(packet , setLst);//异步

	packet =null;	
}

function setLst ( data )
{

	$( "#queryDiv" ).empty();
	$( "#queryDiv" ).append( data );
	
	if ( $( "#retcode" ).val()=='000000' )
	{
		var l_type = ( $( "#l_type" ).val() )
		$( "#op_type" ).val( $( "#l_type" ).val() );
		$( "#qryFlag" ).val( "1" );
	}
}

</SCRIPT>
</BODY>
</HTML>