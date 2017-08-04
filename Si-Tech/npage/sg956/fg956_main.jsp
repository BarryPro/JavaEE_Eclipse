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

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyyMM");
java.text.SimpleDateFormat sf1 = new java.text.SimpleDateFormat("yyyyMMdd");

Calendar cal = Calendar.getInstance();
cal.add(java.util.Calendar.MONTH,-6);
String init_tmb = sf.format(cal.getTime())+"01";
String init_tme = sf1.format(sysdate);
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></SCRIPT>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
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
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >开始时间:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'tm_b' NAME= 'tm_b' ch_name = '开始时间' MAXLENGTH = '15' 
						value = '<%=init_tmb%>' readOnly 						
						onClick = "WdatePicker({minDate:'%y-{%M-6}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" />   
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >结束时间:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'tm_e' NAME= 'tm_e' ch_name = '结束时间' MAXLENGTH = '15' 
						value = '<%=init_tme%>' readOnly 						
						onClick = "WdatePicker({minDate:'%y-{%M-6}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" /> 
				</TD>    
			</TR>			
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >受理号码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'pho_no1' NAME= 'pho_no1' ch_name = '受理号码' MAXLENGTH = '15' value = '' />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >操作方式:</TD>
				<TD WIDTH = '25%'>
					<SELECT ID = 'op_type' NAME = 'op_type' ch_name='操作类型' >
						<OPTION VALUE = '' >---请选择---</OPTION>
						<OPTION VALUE = '0' >0-->添加</OPTION>
						<OPTION VALUE = '1' >1-->删除</OPTION>
					</SELECT>
				</TD>    
			</TR>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >操作工号:</TD>
				<TD WIDTH = '25%' colspan = '3'>
					<INPUT TYPE = 'text' ID = 'op_login' NAME= 'op_login' ch_name = '受理号码' MAXLENGTH = '6' value = '' />    
				</TD>     
			</TR>			
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '查询' onClick = 'doQry()' />   
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


function doQry ()
{
	if ( fn_notNull ( document.all.tm_b ) ) return ;
	if ( fn_notNull ( document.all.tm_e ) ) return ;
	
	if ( parseInt( document.all.tm_b.value,10 )>parseInt( document.all.tm_e.value,10 ) )
	{
		rdShowMessageDialog( "开始时间必须小于结束时间!",0 );
		return ;
	}
	
	var packet = new AJAXPacket("f<%=opCode%>_ajax.jsp","请稍后...");

	packet.data.add( "logacc" , "<%=logacc%>" );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
	packet.data.add( "passwd" , "<%=passwd%>" );
	
	packet.data.add( "phoNo" , $( "#pho_no1" ).val() );
	packet.data.add( "usrPwd" , "" );
	packet.data.add( "opNote" , $( "#opCode" ).val() + $( "#opName" ).val() + $( "#pho_no1" ).val() );
	packet.data.add( "fromWay" , "1" );
	packet.data.add( "tm_b" , $( "#tm_b" ).val() + " 00:00:00" );
	
	packet.data.add( "tm_e" , $( "#tm_e" ).val() + " 23:59:59" );
	packet.data.add( "op_type" , $( "#op_type" ).val() );
	packet.data.add( "op_login" , $( "#op_login" ).val() );
	
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