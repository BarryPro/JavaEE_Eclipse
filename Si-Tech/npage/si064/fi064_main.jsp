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
										�ļ�����˵����
				</td>
				</tr>
			<tr>
				<td  colspan="2">
					<b>�ϴ��ļ��ı���ʽΪ��</b><br>
					<font class="red">��������|�ͻ�����|֤������|֤������|֤����ַ|���ʷѴ���|Ԥ��|��ϵ������|��ϵ�˵绰|��ϵ�˵�ַ|sim����|</font><font class="blue">����������|��������ϵ��ַ|������֤������|������֤������|ʵ��ʹ��������|ʵ��ʹ������ϵ��ַ|ʵ��ʹ����֤������|ʵ��ʹ����֤������|����������|��������ϵ��ַ|������֤������|������֤������</font><br>
					<b>�м��޻��У���ɫ����Ϊ������Ϣ����ɫ����Ϊ��������Ϣ��ʵ��ʹ���˺���������Ϣ��ʾ�����£�</b><br/>	
					1064802000031|�ͻ�����|0|230231198709|���������ϸ���|39747|0|��ϵ������|18249091722|�������ϸ�|898600D6081370000007|��Ʒ�|������ʡ�������к�ˮ·13��|0|230305198505145014|��ʱ|������ʡ�������к�ˮ·13��|0|230305198505145015|��ʱ|������ʡ�������к�ˮ·13��|0|230305198505145015<br/>
				</td>
			</tr>
			
			
						<tr>
									<td class="blue">
										�ļ�����˵����
									</td>
					        <td > 
					        
					        �����ˡ�ʵ��ʹ���ˡ�������֤�����Ͷ�Ӧ��ϵ<br>
					        0 ���֤<br>
									1 ����֤<br>
									2 ���ڲ�<br>
									3 �۰�ͨ��֤<br>
									4 ����֤<br>
									5 ̨��ͨ��֤<br>
									6 ���������<br>
					            <b><font class="orange">ע�⣺
					            	<br>&nbsp;&nbsp;����������30�����֣�                           
												<br>&nbsp;&nbsp;��ַ������100�����֣�
												<br>&nbsp;&nbsp;֤������ ֻ����λ�ͻ�֤������ ���� 8��Ӫҵִ�գ�A����֯�������룩 B����λ����֤�飩 C����λ֤����                          
												<br>&nbsp;&nbsp;֤�����Ͳ�����1���ַ���                        
												<br>&nbsp;&nbsp;֤�����벻����20���ַ����������֡���ĸ�͡�-����
												<br>
					            <br>��ʽ�е�ÿһ�����������ڿո�,��ÿ�����ݶ���Ҫ�س����С�
					            <br>�ϴ��ļ���ʽΪtxt�ļ�������಻����500����¼��</font>
					            </b> 
					        </td>
	   					 	</tr>
			<tr>
				<TD WIDTH = '30%' align = 'center' >�����ļ���</TD>  				
				<TD WIDTH = '70%'>
<%}else{
%>

		<TR>
				<TD WIDTH = '100%' ALIGN = 'left' class = 'blue' colspan = '2'>
					<font color = 'red'>
						&nbsp&nbsp&nbsp&nbsp˵��:<%=fieldMsg%>
					</font>
				</TD>
			</tr>
			<tr>
				<TD WIDTH = '50%' align = 'center' >�����ļ���</TD>  				
				<TD WIDTH = '50%'>
<%	
}%>
					<INPUT TYPE = 'file' ID = 'f_ifo' NAME= 'f_ifo' ch_name = '�ļ�' />    
				</TD>    
			</TR>

			<TR>
				<TD COLSPAN = '2' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = 'ȷ��' onClick = 'doCfm()' />   
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