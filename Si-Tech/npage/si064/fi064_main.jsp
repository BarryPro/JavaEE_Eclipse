<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");
String regCode = (String)session.getAttribute("regCode");

String fieldPath = request.getRealPath("npage/properties")
		+"/fieldMsg.properties";
String fieldMsg = readValue(opCode , "d0" ,"f_msg",fieldPath);	
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js">
	</SCRIPT>
	
<SCRIPT language = "javascript" type = "text/javascript">
<%
if("i067".equals(opCode)){
%>
	location = "fi067_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
<%}%>	
</SCRIPT>		
</HEAD>
<BODY>
<FORM  NAME = "frm" ACTION = "" METHOD = "POST" ENCTYPE="multipart/form-data">
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV class = "title" >
			<DIV id = "title_zi"><%=opName%></DIV>
		</DIV>
		<TABLE>
<%
if("i067".equals(opCode)){
%>
			<tr>
				<td class="blue" colspan="2">
										文件内容说明：
				</td>
				</tr>
			<tr>
				<td  colspan="2">
					<b>上传文件文本格式为：</b><br>
					<font class="red">开户号码|客户姓名|证件类型|证件号码|证件地址|主资费代码|预存|联系人姓名|联系人电话|联系人地址|sim卡号|</font><font class="blue">经办人姓名|经办人联系地址|经办人证件类型|经办人证件号码|实际使用人姓名|实际使用人联系地址|实际使用人证件类型|实际使用人证件号码|责任人姓名|责任人联系地址|责任人证件类型|责任人证件号码</font><br>
					<b>中间无换行，红色部分为开户信息，蓝色部分为经办人信息和实际使用人和责任人信息。示例如下：</b><br/>	
					1064802000031|客户姓名|0|230231198709|哈尔滨市南岗区|39747|0|联系人姓名|18249091722|哈尔滨南岗|898600D6081370000007|孙菲菲|黑龙江省哈尔滨市汉水路13号|0|230305198505145014|临时|黑龙江省哈尔滨市汉水路13号|0|230305198505145015|临时|黑龙江省哈尔滨市汉水路13号|0|230305198505145015<br/>
				</td>
			</tr>
			
			
						<tr>
									<td class="blue">
										文件内容说明：
									</td>
					        <td > 
					        
					        经办人、实际使用人、责任人证件类型对应关系<br>
					        0 身份证<br>
									1 军官证<br>
									2 户口簿<br>
									3 港澳通行证<br>
									4 警官证<br>
									5 台湾通行证<br>
									6 外国公民护照<br>
					            <b><font class="orange">注意：
					            	<br>&nbsp;&nbsp;姓名不超过30个汉字，                           
												<br>&nbsp;&nbsp;地址不超过100个汉字，
												<br>&nbsp;&nbsp;证件类型 只允许单位客户证件类型 即： 8（营业执照）A（组织机构代码） B（单位法人证书） C（单位证明）                          
												<br>&nbsp;&nbsp;证件类型不超过1个字符，                        
												<br>&nbsp;&nbsp;证件号码不超过20个字符必须是数字、字母和“-”等
												<br>
					            <br>格式中的每一项均不允许存在空格,且每条数据都需要回车换行。
					            <br>上传文件格式为txt文件。且最多不超过500条记录。</font>
					            </b> 
					        </td>
	   					 	</tr>
			<tr>
				<TD WIDTH = '30%' align = 'center' >批量文件：</TD>  				
				<TD WIDTH = '70%'>
<%}else{
%>

		<TR>
				<TD WIDTH = '100%' ALIGN = 'left' class = 'blue' colspan = '2'>
					<font color = 'red'>
						&nbsp&nbsp&nbsp&nbsp说明:<%=fieldMsg%>
					</font>
				</TD>
			</tr>
			<tr>
				<TD WIDTH = '50%' align = 'center' >批量文件：</TD>  				
				<TD WIDTH = '50%'>
<%	
}%>
					<INPUT TYPE = 'file' ID = 'f_ifo' NAME= 'f_ifo' ch_name = '文件' />    
				</TD>    
			</TR>

			<TR>
				<TD COLSPAN = '2' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '确认' onClick = 'doCfm()' />   
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
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<SCRIPT>
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).show( 300 );
	}
);

function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
}

function doCfm ()
{
	document.frm.action = "fi064_cfm.jsp?logacc=<%=logacc%>"
		+"&chnSrc=<%=chnSrc%>"
		+"&opCode=<%=opCode%>"
		+"&workNo=<%=workNo%>"
		+"&passwd=<%=passwd%>"
		
		+"&phoNo="
		+"&usrPwd="
		+"&opName=<%=opName%>";	
	document.frm.submit();		
}

</SCRIPT>
</BODY>
</HTML>