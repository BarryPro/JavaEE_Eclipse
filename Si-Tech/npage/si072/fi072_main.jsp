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
	<style>
body{font-size:12px}
</style>
<div id=mytips style="position:absolute;background-color:#ffffff;width:121;height:16;border:1px solid gray;display:none;filter: progid:DXImageTransform.Microsoft.Shadow(color=#999999,direction=135,strength=3); left:0; top:5"></div>
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
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >������ˮ:</TD>
				<TD WIDTH = '*'>
					<INPUT TYPE = 'text' ID = 'op_acc' NAME= 'op_acc' ch_name = '������ˮ' MAXLENGTH = '15' value = '' />    
					<font color = 'orange'>*</font>
				</TD>      
			</TR>
			<TR>
				<td colspan="2"><font class="orange">����ҵ�����첽�������˲�ѯֻ���ο���</font></td>
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
		$( "#d0" ).show( 300 );
		stepNum = stepNum + 1;
	}
);
function seashowtip(tips,flag,iwidth){
	var my_tips=document.all.mytips;
	if(flag==1){
	    my_tips.innerHTML=tips;
	    my_tips.style.display="";
	    my_tips.style.width=iwidth;
	    my_tips.style.left=event.clientX+10+document.body.scrollLeft;
	    my_tips.style.top=event.clientY+10+document.body.scrollTop;
	   }
	else 
	  {
	   my_tips.style.display="none";
	   }
	}


function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
}

function doCfm ()
{
	if ( fn_notNull ( document.all.op_acc ) ) return ;

	var packet = new AJAXPacket("f<%=opCode%>_cfm.jsp","���Ժ�...");

	packet.data.add( "ajaxType" , "setLst" );
	packet.data.add( "logacc" , "<%=logacc%>" );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
                     
	packet.data.add( "passwd" , "<%=passwd%>" );
	packet.data.add( "phoNo" , "" );
	packet.data.add( "usrPwd" , "" );
	packet.data.add( "op_acc" , $( "#op_acc" ).val() );

	core.ajax.sendPacketHtml(packet , setLst);//�첽

	packet =null;	
}

function setLst ( data )
{
	$( "#queryDiv" ).empty();
	$( "#queryDiv" ).append( data );
}

</SCRIPT>
</BODY>
</HTML>
