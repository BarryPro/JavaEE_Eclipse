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
	<SCRIPT language = "javascript" type = "text/javascript" src = "<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></SCRIPT>
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
					<INPUT TYPE = 'text' ID = 'time_b' NAME= 'time_b' ch_name = '开始时间' MAXLENGTH = '15' 
						value = '<%=init_tme%>' readOnly
						onClick = "WdatePicker({minDate:'%y-{%M-6}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})"/>
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >结束时间:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'time_e' NAME= 'time_e' ch_name = '结束时间' MAXLENGTH = '15' 
						VALUE = '<%=init_tme%>' readOnly
						onClick = "WdatePicker({minDate:'%y-{%M-6}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})"/>  					 
				</TD>    
			</TR>			
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >投诉号码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'pho_no1' NAME= 'pho_no1' ch_name = '投诉号码' MAXLENGTH = '15' value = '' />    
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >受限主叫号码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'TEXT' ID = 'pho_no2' NAME= 'pho_no2' ch_name = '受限主叫号码' MAXLENGTH = '15' VALUE = '' />    
				</TD>    
			</TR>

			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '查询' onClick = 'doCfm()' />   
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
	if ( fn_notNull ( document.all.time_e ) ) return ;
	if ( fn_notNull ( document.all.time_b ) ) return ;
	
	var time_b = document.all.time_b.value 
	if ( parseInt( document.all.time_b.value,10 )>parseInt( document.all.time_e.value,10 ) )
	{
		rdShowMessageDialog( "开始时间必须小于结束时间!",0 );
		return ;
	}
	
	var packet = new AJAXPacket("f<%=opCode%>_lst.jsp","请稍后...");

	packet.data.add( "ajaxType" , "setLst" );
	packet.data.add( "logacc" , "<%=logacc%>" );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
                     
	packet.data.add( "passwd" , "<%=passwd%>" );
	packet.data.add( "phoNo" , "" );
	packet.data.add( "usrPwd" , "" );
	packet.data.add( "time_b" , $( "#time_b" ).val() );
	packet.data.add( "time_e" , $( "#time_e" ).val() );
	packet.data.add( "pho_no1" , $( "#pho_no1" ).val() );
	packet.data.add( "pho_no2" , $( "#pho_no2" ).val() );

	core.ajax.sendPacketHtml(packet , setLst);//异步

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

