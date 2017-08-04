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
String logAcc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String workNo = (String)session.getAttribute("workNo");
String phoneNo = "";

String usrPwd = "";
String passwd = (String)session.getAttribute("password");

String regCode = (String)session.getAttribute("regCode");
String opName = request.getParameter("opName");
%>    
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<TITLE><%=opName%></TITLE>
	<script language = "javascript" type = "text/javascript" 
		src = "/npage/public/zalidate.js"></script>
</head>
<body>
<form  name = "frm" action = "" method = "POST" >
<%@ include file="/npage/include/header.jsp" %>	
<div id = "Operation_Table">
	<div id = "d0" name = "d0" style = "display:none">
		<div class="title">
    <div id="title_zi">基本信息</div>
  </div>
  
  <table cellspacing="0">
    <tr>
      <td colspan=4">配送订单隔月反馈时，配送结果只能是配送成功，且不允许隔月撤单</td>
    </tr>
  </table>
		<div class = "title" >
			<div id = "title_zi"><%=opName%></div>
		</div>
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >物流单号:</TD>
				<TD WIDTH = '*' ALIGN = 'left' class = 'blue' >
					<input id = 'comp_odr_id' name = 'comp_odr_id' type = 'text'
						ch_name = '物流单号' >
					<font color = 'red'>*<font>
				</TD>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >配送结果:</TD>
				<TD WIDTH = '*' ALIGN = 'left' class = 'blue' >
					<SELECT id = "ps_rst" name = "ps_rst"  onchange = 'getRsn()'>
						<OPTION value = '3' >3-->配送成功</OPTION>
						<OPTION value = '4' >4-->配送失败</OPTION>
					</SELECT>
				</TD>	
							
			</TR>
			<TR id = 'tr_fail_rsn' name = 'tr_fail_rsn' style = "display:none" >
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >失败原因:</TD>
				<TD WIDTH = '*' ALIGN = 'left' class = 'blue' colspan = '3'>
					<input id = 'fail_rsn' name = 'fail_rsn' type = 'text'
						ch_name = '失败原因' maxLength = '100' size = '100'>
					<font color = 'red'>*<font>
				</TD>
							
			</TR>
			
		</table>
	</div>
	<div ID = 'querydiv' ></div>
	<table>
		<TR>
			<TD ALIGN = 'CENTER' ID = 'footer'>			
				<input type = 'button' id = 'b_next' name= 'b_next' class = 'b_foot' 
					value = '下一步'/>   
				<input type = 'button' id = 'b_rst' name= 'b_rst' class = 'b_foot' 
					value = '重置'/>   
				<input type = 'button' id = 'b_cls' name= 'b_cls' class = 'b_foot' 
					value = '关闭'/>
			</TD>
		</TR>        
	</table>	
	<!--标准入参-->
	<input type = 'hidden' id = 'logAcc' name = 'logAcc' value = '<%=logAcc%>'/>
	<input type = 'hidden' id = 'chnSrc' name = 'chnSrc' value = '<%=chnSrc%>'/>	
	<input type = 'hidden' id = 'opCode' name = 'opCode' value = '<%=opCode%>'/>
	<input type = 'hidden' id = 'workNo' name = 'workNo' value = '<%=workNo%>'/>
	<input type = 'hidden' id = 'passwd' name = 'passwd' value = '<%=passwd%>'/>
	
	<input type = 'hidden' id = 'phoneNo' name = 'phoneNo' value = '<%=phoneNo%>'/>
	<input type = 'hidden' id = 'usrPwd' name = 'usrPwd' value = '<%=usrPwd%>'/>
	
	<!--其它参数-->
	<input type = 'hidden' id = 'opName' name = 'opName' value = '<%=opName%>'/>
</div>
<%@ include file="/npage/include/footer_new.jsp" %>
</form>
<SCRIPT>
var stepNum = 0;
$( document ).ready
(
	function ()
	{
		$( "#d0" ).show( 800 );
		stepNum = 1;
	}
);

$("#b_rst").click
(
	function ()
	{
		document.frm.action = "#";
		document.frm.submit();	
	}
);

$("#b_cls").click
(
	function ()
	{
		removeCurrentTab();
	}
);

$("#b_next").click
(
	function ()
	{
		if ( 1 == stepNum  )
		{
			if ( "" ==  $( "#comp_odr_id" ).val().trim() )
			{
				rdShowMessageDialog( "物流单号不能为空" , 0 );
				return false;
			}
			
			if ( document.all.ps_rst.value == "4" )
			{		
				if (  document.all.fail_rsn.value == ""  )
				{
					rdShowMessageDialog( "配送失败原因不能为空" , 0 );
					return false;					
				}
			}					
					
			var packet = new AJAXPacket("f<%=opCode%>_ajax.jsp","请稍后...");
		
			packet.data.add( "ajaxType" , "getLst" );
			packet.data.add( "logAcc" , $("#logAcc").val() );
			packet.data.add( "chnSrc" , $("#chnSrc").val() );
			packet.data.add( "opCode" , $("#opCode").val() );
			packet.data.add( "workNo" , $("#workNo").val() );
			packet.data.add( "passwd" , $("#passwd").val() );
			
			packet.data.add( "phoneNo" , $("#phoneNo").val() );
			packet.data.add( "usrPwd" , $("#usrPwd").val() );
			
			packet.data.add( "comp_odr_id" , $("#comp_odr_id").val() );
	
			core.ajax.sendPacketHtml(packet , setLst);//异步
		
			packet =null;	
		}
		else if ( 2 == stepNum )
		{
			$("#comp_odr_id").attr( "disabled" , false );
			$("#ps_rst").attr( "disabled" , false );
			$("#fail_rsn").attr( "disabled" , false );
			$("#b_next").attr( "disabled" , true );
			document.frm.action = 'fa382_2.jsp';
			document.frm.submit();
		}

	}
);

function getRsn()
{
	document.all.fail_rsn.value="";	

	if ( document.all.ps_rst.value == "3" )
	{
		document.all.tr_fail_rsn.style.display="none";	
	}
	else
	{		
		document.all.tr_fail_rsn.style.display="block";	
	}
}

function setLst ( data )
{
	$( "#querydiv" ).empty();
	$( "#querydiv" ).append( data );
	if ( "000000" != $( "#rc_set_ifo" ).val() )
	{
		rdShowMessageDialog( $( "#rc_set_ifo" ).val()  + ":" 
			+$( "#rm_set_ifo" ).val()  );	
		$("#b_next").attr( "disabled" , false );	
		$("#b_next").attr( "disabled" , false );
		$("#comp_odr_id").attr( "disabled" , false );
		$("#ps_rst").attr( "disabled" , false );
		$("#fail_rsn").attr( "disabled" , false );			
		return false;
	}	
	else
	{
		var odr_flag = $("#odr_flag").val();
		if(odr_flag == "1"){
			$("#ps_rst").find("option").each(function(){
				var thisVal = $(this).val();
				if(thisVal == "4"){
					$(this).remove();
				}
			});
		}
		$("#b_next").attr( "disabled" , false );
		$("#comp_odr_id").attr( "disabled" , true );
		$("#ps_rst").attr( "disabled" , false );
		$("#fail_rsn").attr( "disabled" , false );	
		$("#b_next").val( "确认" );
		stepNum = 2;
	}
}

</Script>
</body>
</html>
