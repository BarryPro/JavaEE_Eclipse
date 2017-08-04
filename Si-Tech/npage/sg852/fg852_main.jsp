
<%
/*
 * 版本: 1.0
 * 作者: zhangyan
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
	<script src="../public/json2.js" type="text/javascript"></script>
</HEAD>
<BODY>
<FORM NAME = "frm" ACTION = "" METHOD = "POST" >
<%@ include file = "/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV CLASS = "title" >
			<DIV ID = "title_zi"><%=opName%></DIV>
		</DIV>
		<TABLE WIDTH = "100%">
			<TR>
				<TD class = "blue" align = "center" WIDTH="25%">用户账号:</TD>
				<TD colspan = '3' >
					<INPUT type = "TEXT" ID = 'Account' NAME = 'Account' ch_name = '用户账号' MAXlENGTH = '64' 
						VALUE = '<%=phoNo%>' class = 'InputGrey' readOnly />	
				</TD>	
			</TR>			
		</TABLE>
	</DIV>
	<DIV ID = "d1" NAME = "d1" STYLE = "display:none">
		<TABLE WIDTH = "100%">
			<TR>
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">流水号:</TD>
				<TD WIDTH="25%" >
					<INPUT type = "TEXT" ID = 'SEQ' NAME = 'SEQ' ch_name = '流水号' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>	
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定用户帐号:</TD>
				<TD WIDTH="25%" >
					<INPUT type = "TEXT" ID = 'binduser' NAME = 'binduser' ch_name = '绑定用户帐号' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>					
			</TR>		
			<TR>
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定用户MAC:</TD>
				<TD WIDTH="25%" >
					<INPUT type = "TEXT" ID = 'bindmac' NAME = 'bindmac' ch_name = '绑定的用户MAC' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>	
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定状态:</TD>
				<TD WIDTH="25%" >
					<INPUT type = "TEXT" ID = 'status' NAME = 'status' ch_name = '绑定状态' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>					
			</TR>
			<TR>
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定IMEI:</TD>
				<TD WIDTH="25%" >
					<INPUT type = "TEXT" ID = 'imei' NAME = 'imei' ch_name = '绑定IMEI' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>	
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定终端型号:</TD>
				<TD WIDTH="25%" >
					<INPUT type = "TEXT" ID = 'phone' NAME = 'phone' ch_name = '绑定终端型号' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>					
			</TR>		
			<TR>
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定原因:</TD>
				<TD WIDTH="25%">
					<INPUT type = "TEXT" ID = 'Status_remark' NAME = 'Status_remark' ch_name = '绑定原因' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>	
				<TD WIDTH="25%" class = "blue" align = "center" WIDTH="25%">绑定状态变更时间:</TD>
				<TD WIDTH="25%">
					<INPUT type = "TEXT" ID = 'Status_time' NAME = 'Status_time' MAXlENGTH = '64' 
						VALUE = '' class = 'InputGrey' readOnly />	
				</TD>										
			</TR>										
		</TABLE>
	</DIV>	
	<TABLE>
		<TR>
			<TD ALIGN="CENTER" ID="footer" >
				<INPUT TYPE = "button" ID = "" NAME = "" CLASS = "b_foot" VALUE = "查询" onClick="getIfo()" />   
				<INPUT TYPE = "button" ID = "" NAME = "" CLASS = "b_foot" VALUE = "重置" onClick="doRet()" />   
				<INPUT TYPE = "button" ID = "" NAME = "" CLASS = "b_foot" VALUE = "关闭" onClick="removeCurrentTab();" />
			</TD>
		</TR>
	</TABLE>		
</DIV>
<%@ include file="/npage/include/footer.jsp" %> 
<INPUT TYPE = 'hidden' ID = 'hd_opCode' NAME = 'hd_opCode' VALUE = '<%=opCode%>'>
<INPUT TYPE = 'hidden' ID = 'hd_opName' NAME = 'hd_opName' VALUE = '<%=opName%>'>
<INPUT TYPE = 'HIDDEN' ID = 'BusiType' NAME = 'BusiType' VALUE = '<%=BusiType%>'/>
</form>
<SCRIPT>
var stepNum=0;
$(document).ready(
	function ()
	{
		$("#d0").show( 300 );
		$("#d1").hide("");
		stepNum=stepNum+1;
	}
);
function doRet()
{
	document.frm.action="#";
	document.frm.submit();			
}

function getIfo()
{
	
	var packet = new AJAXPacket( "fg852_ajax.jsp" , "请稍后..." );

	packet.data.add( "ajaxType" , "getIfo" );
	
	packet.data.add( "logacc" , "<%=logacc%>" );
	packet.data.add( "chnSrc" , "<%=chnSrc%>" );
	packet.data.add( "opCode" , "<%=opCode%>" );
	packet.data.add( "opName" , "<%=opName%>" );
	packet.data.add( "workNo" , "<%=workNo%>" );
	
	packet.data.add( "passwd" , "<%=passwd%>" );
	packet.data.add( "phoNo" , "<%=phoNo%>" );
	packet.data.add( "opTime" , "<%=opTime%>" );
	packet.data.add( "Account" , document.all.Account.value );
	packet.data.add( "remark" , "1");
	
	packet.data.add( "BusiType" , document.all.BusiType.value );
	
	core.ajax.sendPacket( packet , setIfo );//异步
	packet = null;
}
//ajax返回html
function setIfo( packet )
{
	$( "#d1" ).show( 1000 );
	var oRetCode = packet.data.findValueByName ( "oRetCode" );
	var oRetMsg = packet.data.findValueByName ( "oRetMsg" );
	if ( oRetCode != "000000" )
	{
		rdShowMessageDialog ( oRetCode + ":" + oRetMsg , 1 );
		removeCurrentTab();
	}
	else
	{
		var v_jsn=packet.data.findValueByName("oJsn") ;

		var v_jsn1 = JSON.parse(v_jsn,function(key,value){
			return value;
		});	

		if ( "1"== v_jsn1.STATUS )
		{
			$("#status").val("1-->未绑定");
			
			if ( "1" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("1-->短信取消绑定");
			}
			else if ( "2" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("2-->客服取消绑定");
			}
			else if ( "3" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("3-->MAC认证失败取消绑定");
			}			
			else if ( "4" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("4-->MAC重复认证取消绑定");
			}	
			else if ( "5" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("5-->IMEI变更取消绑定");
			}							
		}
		else if ( "2"== v_jsn1.STATUS )
		{
			
			$("#status").val("2-->已绑定");
			if ( "1" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("1-->首次绑定");
			}
			else if ( "2" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("2-->变更绑定");
			}
			else if ( "3" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("3-->短信恢复绑定");
			}			
			else if ( "4" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("4-->客服恢复绑定");
			}				
			
		}
		else if ( "3"== v_jsn1.STATUS )
		{
			$("#status").val("3-->已使用");
			if ( "1" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("1-->首次绑定");
			}
			else if ( "2" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("2-->变更绑定");
			}
			else if ( "3" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("3-->短信恢复绑定");
			}			
			else if ( "4" == v_jsn1.STATUSREMARK )
			{
				$("#Status_remark").val("4-->客服恢复绑定");
			}				
		}
		else if ( "4"== v_jsn1.STATUS )
		{
			$("#status").val("4-->MAC冲突");
			$("#Status_remark").val( "MAC冲突次数:" + v_jsn1.STATUSREMARK);			
		}
		else
		{
			$("#status").val( v_jsn1.STATUS );
		}
		
		$("#SEQ").val(v_jsn1.SEQ);
		$("#binduser").val(v_jsn1.BINDUSER);
		$("#bindmac").val(v_jsn1.BINDMAC);
		
		$("#Status_time").val(v_jsn1.STATUSTIME);
		
		$("#imei").val(v_jsn1.IMEI);
		$("#phone").val(v_jsn1.PHONE);
	}
}

</SCRIPT>
</BODY>
</HTML>

