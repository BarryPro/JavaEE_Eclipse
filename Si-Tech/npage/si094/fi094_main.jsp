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
String accept = sLoginAccept;
String chnSrc = "01";
String opCode = request.getParameter ("opCode");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");

String phoneNo = request.getParameter( "activePhone" );
String usrPwd = "";

String regCode = (String)session.getAttribute("regCode");
String opName = request.getParameter("opName");
String sql_pack_type = "";
String sql_pack_code = "";
%>    
<wtc:service name="s9387Qry" outnum="9" 
	routerKey="region" routerValue="<%=regCode%>"
	retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=accept%>"/>
	<wtc:param value="<%=chnSrc%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=passwd%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=usrPwd%>"/>
	<wtc:param value="10"/>
</wtc:service>
<wtc:array id="tempArr" scope="end"/>
<%
if(!(retCode.equals("000000")))
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
		history.go(-1);
	</script>
<%
}
if(tempArr.length == 0)
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("未查询到该用户基本信息！",0);
		history.go(-1);
	</script>
<%
}
%>

<wtc:service name="si093Qry" outnum="9" 
	routerKey="region" routerValue="<%=regCode%>"
	retcode="retCode1" retmsg="retMsg1">
	<wtc:param value="<%=accept%>"/>
	<wtc:param value="<%=chnSrc%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=passwd%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=usrPwd%>"/>
	<wtc:param value="10"/>
</wtc:service>
<wtc:array id="rst" scope="end"/>
<%
if(!(retCode1.equals("000000")))
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=retCode1%>，错误信息：<%=retMsg1%>",0);
		history.go(-1);
	</script>
<%
}
if(rst.length == 0)
{
%>
	<script language="JavaScript">
		rdShowMessageDialog("未查询到该用户套餐信息！",0);
		history.go(-1);
	</script>
<%
}
System.out.println("zhangyan rst[0][0]===="+ rst[0][0]);
System.out.println("zhangyan rst[0][1]===="+ rst[0][1]);

String [] arr_pack_type = rst[0][0].split("\\|");
String [] arr_pack_code = rst[0][1].split("\\|");

for ( int i = 0 ; i < arr_pack_type.length ; i ++ )
{
	sql_pack_type += "'" + arr_pack_type[i] +"',";
}

sql_pack_type = sql_pack_type.substring( 0,sql_pack_type.length() - 1 );

for ( int i = 0 ; i < arr_pack_code.length ; i ++ )
{
	sql_pack_code += "'" + arr_pack_code[i] +"',";
}

sql_pack_code = sql_pack_code.substring( 0,sql_pack_code.length() - 1 );

%>

<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" 
		src = "/npage/public/zalidate.js"></SCRIPT>
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
					<INPUT TYPE = 'text' ID = 'phoNo' NAME= 'phoNo' 
						ch_name = '手机号码' class = 'InputGrey'
						value = '<%=phoneNo%>' readOnly />    
				</TD>       
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >客户姓名:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'usrName' NAME= 'usrName' 
						ch_name = '客户姓名' class = 'InputGrey'
						value = '<%=tempArr[0][2]%>' readOnly />    
				</TD>      				
			</TR>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >客户地址:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'addr' NAME= 'addr' 
						ch_name = '客户地址' class = 'InputGrey'
						value = '<%=tempArr[0][3]%>' readOnly />    
				</TD>       
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >业务品牌:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'sm_name' NAME= 'sm_name' 
						ch_name = '业务品牌' class = 'InputGrey'
						value = '<%=tempArr[0][6]%>' readOnly />    
				</TD>      				
			</TR>	
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >证件类型:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'id_type' NAME= 'id_type' 
						ch_name = '证件类型' class = 'InputGrey'
						value = '<%=tempArr[0][4]%>' readOnly />    
				</TD>       
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >证件号码:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'iccid' NAME= 'iccid' 
						ch_name = '证件号码' class = 'InputGrey'
						value = '<%=tempArr[0][5]%>' readOnly />    
				</TD>      				
			</TR>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >归属地市:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'grp_name' NAME= 'grp_name' 
						ch_name = '归属地市' class = 'InputGrey'
						value = '<%=tempArr[0][7]%>' readOnly />    
				</TD>       
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >运行状态:</TD>
				<TD WIDTH = '25%'>
					<INPUT TYPE = 'text' ID = 'run_name' NAME= 'run_name' 
						ch_name = '运行状态' class = 'InputGrey'
						value = '<%=tempArr[0][8]%>' readOnly />    
				</TD>      				
			</TR>
			
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >可办理套餐类型:</TD>
				<TD WIDTH = '25%'>
					<select ID = 'biz_type' NAME= 'biz_type' ch_name = '可办理套餐类型' 
						style = 'width:200px'>
						<option value = "" >---请选择---</option>
						<%
						String biz_sql = " SELECT pack_type,type_name FROM swlanmode "
							+ " where pack_type in ( "+sql_pack_type+" ) and pack_type <>'08' "
							+ " GROUP BY pack_type,type_name ";
						%>
						<wtc:pubselect name="sPubSelect" 
							routerKey="region" routerValue="<%=regCode%>" 
							retcode="TimeRetCode" retmsg="TimeRetMsg" outnum="2">
							<wtc:sql><%=biz_sql%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="rst_biz" scope="end" />
						<%
						for ( int i = 0 ; i < rst_biz.length ; i ++ )
						{
						%>
							<option value = '<%=rst_biz[i][0]%>'>
								<%=rst_biz[i][0]%>--><%=rst_biz[i][1]%>
							</option>
						<%
						}
						%>
					
					</select>    
				</TD>       
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >可办理套餐代码:</TD>
				<TD WIDTH = '25%'>
					<select ID = 'biz_code' NAME= 'biz_code' ch_name = '可办理套餐代码' 
						style = 'width:200px'>
					</select>    
				</TD>      				
			</TR>												
		</table>
		<table>
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = 'b_cfm' NAME= '' CLASS = 'b_foot' VALUE = '确认' />   
					<INPUT TYPE = 'BUTTON' ID = 'b_cls' NAME= '' CLASS = 'b_foot' VALUE = '关闭' />
				</TD>
			</TR>        
		</TABLE>
	</DIV>
	<INPUT TYPE = 'HIDDEN' ID = 'accept' NAME = 'accept' VALUE = '<%=accept%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'workNo' NAME = 'workNo' VALUE = '<%=workNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'passwd' NAME = 'passwd' VALUE = '<%=passwd%>'/>
	
	<INPUT TYPE = 'HIDDEN' ID = 'phoneNo' NAME = 'phoneNo' VALUE = '<%=phoneNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'usrPwd' NAME = 'usrPwd' VALUE = '<%=usrPwd%>'/>
	<%
		System.out.println( "zhangyan  sql_pack_code~~"+sql_pack_code );
	%>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'sql_pack_code' NAME = 'sql_pack_code' 
		VALUE = "<%=sql_pack_code%>"/>
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<SCRIPT>
var stepNum = 0;
$( document ).ready
(	
	function ()
	{
		$( "#d0" ).show( 800 );
		stepNum = stepNum + 1;
	}
);

$("#biz_type").change
(
	function ()
	{
		if ( fn_notNull ( document.all.biz_type ) )
		{
			$("#biz_code").empty();	
			return false;
		} 

		var packet = new AJAXPacket("f<%=opCode%>_ajax.jsp","请稍后...");
	
		packet.data.add( "ajaxType" , "setBizCode" );
		packet.data.add( "biz_type" , $("#biz_type").val() );
		packet.data.add( "sql_pack_code" , $("#sql_pack_code").val() );
	
		core.ajax.sendPacket( packet , setBizCode );//异步
	}
)

function setBizCode( packet )
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
	if ( retCode != "000000" )
	{
		rdShowMessageDialog( retCode + ":" + retMsg );
		return false;
	}
	else
	{
		$("#biz_code").empty();
		$("#biz_code").append ('<option value = "" >---请选择---</option>');
		
		var arr_code = packet.data.findValueByName( "arr_code" );
		var arr_name = packet.data.findValueByName( "arr_name" );
		for(var i=0; i<arr_code.length; i++)
		{
			var str = "<option value = '"+arr_code[i]+"' >"
				+arr_code[i] + "-->" +arr_name[i]+"</option>";
			$("#biz_code").append ( str );
		}
	}
}

$("#b_cfm").click
(
	function ()
	{
		if ( fn_notNull ( document.all.biz_code ) ) return false;
		
		if ( rdShowConfirmDialog("确认提交吗?") == 1)
		{
			document.frm.action = "f<%=opCode%>_cfm.jsp";
			document.frm.submit();
		}
	}
)

$("#b_cls").click
(
	function ()
	{
		removeCurrentTab();	
	}
)

</SCRIPT>
</BODY>
</HTML>