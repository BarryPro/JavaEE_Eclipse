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
	<SCRIPT language = "javascript" type = "text/javascript" 
		src = "/npage/public/zalidate.js"></SCRIPT>
	<script language="javascript" type="text/javascript" 
		src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</HEAD>
<BODY>
<FORM  NAME = "frm" ACTION = "" METHOD = "POST" >
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV class = "title" >
			<DIV id = "title_zi"><%=opName%></DIV>
		</DIV>
		<table>
			<tr>
				<td>开始时间</td>
				<td>
					<input type = 'text' id = 'tm_b' name = 'tm_b' 
						ch_name = '开始时间' 
						onClick = "WdatePicker({minDate:'%y-{%M-6}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" />   				
				</td>
				
				<td>结束时间</td>
				<td>
					<input type = 'text' id = 'tm_e' name = 'tm_e' 
						ch_name = '结束时间'  			
						onClick = "WdatePicker({minDate:'%y-{%M-6}-01',maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" />   				
							
				</td>				
			</tr>	
			<tr>
				<td>渠道</td>
				<td colspan = '3'>
					<select id = 'chn_code' name = 'chn_code' >
						<option value = '02'>02-->网上营业厅</option>
						<option value = '69' selected>69-->手机营业厅</option>
						<option value = '14' >14-->手机旗舰店</option>
						<option value = '17' >17-->智能终端版CRM</option>
						<option value = '36' >36-->二维码营销</option> <!--add for 项目：二维码新增渠道，需要在实名制审核中需要新增@2014/11/10  -->
					</select>
				</td>			
			</tr>						
		</table>
		
		<TABLE>
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = 'b_qry' NAME= '' CLASS = 'b_foot' VALUE = '查询' />
					<INPUT TYPE = 'BUTTON' ID = 'b_ret' NAME= '' CLASS = 'b_foot' VALUE = '重置' />
					<INPUT TYPE = 'BUTTON' ID = 'b_cls' NAME= '' CLASS = 'b_foot' VALUE = '关闭' />
				</TD>				
			</TR>        
		</TABLE>		
	</DIV>

	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>	
	<INPUT TYPE = 'HIDDEN' ID = 'phoNo' NAME = 'phoNo' VALUE = ''/>	
	<INPUT TYPE = 'HIDDEN' ID = 'usrPwd' NAME = 'usrPwd' VALUE = ''/>	
</DIV>
<div id = 'queryDiv'></div>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<SCRIPT>
	
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).show( 500 );
		stepNum = stepNum + 1;
	}
);


$("#b_qry").click
(
	function ()
	{
		if ( fn_notNull ( document.all.tm_b ) ) return ;
		if ( fn_notNull ( document.all.tm_e ) ) return ;
		
		document.frm.action = 'f<%=opCode%>_lst.jsp';
		document.frm.submit();
	}
)

function getLst( packet )
{
	$("#queryDiv").empty();
	$("#queryDiv").append(data);
}

$("#b_ret").click
(
	function ()
	{
		document.frm.action = '#';
		document.frm.submit();
	}
)

$("#b_cls").click
(
	function ()
	{
		removeCurrentTab();
	}
)

$("#tm_b").click
(
	function ()
	{
		WdatePicker({startDate:'%y%M%d'
			,dateFmt:'yyyyMMdd'
			,readOnly:true
			,alwaysUseStartDate:true})	
	}
)

$("#tm_e").click
(
	function ()
	{
		WdatePicker({startDate:'%y%M%d'
			,dateFmt:'yyyyMMdd'
			,readOnly:true
			,alwaysUseStartDate:true})	
	}
)
</SCRIPT>
</BODY>
</HTML>