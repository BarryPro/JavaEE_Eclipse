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
	<SCRIPT language = "javascript" type = "text/javascript" src = "/njs/plugins/My97DatePicker/WdatePicker.js"></SCRIPT>
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
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >Ͷ�ߺ���:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'pho_no1' NAME= 'pho_no1' ch_name = 'Ͷ�ߺ���' MAXLENGTH = '15' value = '' />
					<font color = 'red'>*<font>    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >�������к���:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'pho_no2' NAME= 'pho_no2' ch_name = '�������к���' MAXLENGTH = '15' VALUE = '' />
					<font color = 'red'>*<font>        
				</TD>    
			</TR>

			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '��ѯ' onClick = 'doCfm()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '����' onClick = 'doRet()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '�ر�' onClick = 'removeCurrentTab();' />
				</TD>
			</TR>        
		</TABLE>
	</DIV>
	<DIV ID = 'queryDiv' ></DIV>
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'del_pho1' NAME = 'del_pho1' VALUE = ''/>
	
	<INPUT TYPE = 'HIDDEN' ID = 'del_pho2' NAME = 'del_pho2' VALUE = ''/>	
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
	if ( fn_notNull ( document.all.pho_no2 ) ) return ;
	
	var packet = new AJAXPacket("f<%=opCode%>_lst.jsp","���Ժ�...");

	packet.data.add( "ajaxType" , "setLst" );
	packet.data.add( "logacc" , "<%=logacc%>" );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
                     
	packet.data.add( "passwd" , "<%=passwd%>" );
	packet.data.add( "phoNo" , "" );
	packet.data.add( "usrPwd" , "" );
	packet.data.add( "pho_no1" , $( "#pho_no1" ).val() );
	packet.data.add( "pho_no2" , $( "#pho_no2" ).val() );

	core.ajax.sendPacketHtml(packet , setLst);//�첽

	packet =null;	
}

function setLst ( data )
{
	$( "#queryDiv" ).empty();
	$( "#queryDiv" ).append( data );
}

function del ( i )
{
	document.frm.del_pho1.value = document.getElementById ( "l_pho1"+i ).value;
	document.frm.del_pho2.value = document.getElementById ( "l_pho2"+i ).value;
	
	if (rdShowConfirmDialog("ȷ��ɾ����?")==1)
	{
		document.frm.action = 'f<%=opCode%>_del.jsp';
		document.frm.submit();		
	}

}
</SCRIPT>
</BODY>
</HTML>
