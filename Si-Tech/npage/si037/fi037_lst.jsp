<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");

String phoNo = request.getParameter("phoNo");
String usrPwd = request.getParameter("usrPwd");
String tm_b = request.getParameter("tm_b");
String tm_e = request.getParameter("tm_e");
String req_chn = request.getParameter("chn_code");
System.out.println("gaopengSeeLog==============req_chn:"+req_chn);

String regCode = (String)session.getAttribute("regCode");
String opName = request.getParameter("opName");
System.out.println( "~~~~~~~~~~~~~~"+ request.getParameter("pageNumber"));
int iPageNumber = request.getParameter("pageNumber")==null
	?1:Integer.parseInt(request.getParameter("pageNumber"));
System.out.println( "~~~~~~~~~~~~~~"+ request.getParameter("pageNumber"));
int pPage = iPageNumber - 1;
int iPageSize = 10;
String cur_page = iPageNumber + "";
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
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
				<TH WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >手机号码</TH> 
				<TH WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >证件号码</TH> 
				<TH WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >姓名</TH> 
				<TH WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >证件地址</TH> 
				<!-- <TH WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >证件有效期</TH>  -->
				<TH WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >审批</TH>  
			</TR>  			
			<wtc:service name = "sI037Qry" outnum = "8"
				routerKey = "region" routerValue = "<%=regCode%>" 
				retcode = "rc_cfm" retmsg = "rm_cfm" >
				<wtc:param value = "<%=logacc%>"/>
				<wtc:param value = "<%=chnSrc%>"/>
				<wtc:param value = "<%=opCode%>"/>
				<wtc:param value = "<%=workNo%>"/>
				<wtc:param value = "<%=passwd%>"/>
					
				<wtc:param value = "<%=phoNo%>"/>
				<wtc:param value = "<%=usrPwd%>"/>
				<wtc:param value = "<%=tm_b%>"/>
				<wtc:param value = "<%=tm_e%>"/>
				<wtc:param value = "10"/>
					
				<wtc:param value = "<%=cur_page%>"/>
				<wtc:param value = "2"/>
				<wtc:param value = "<%=req_chn%>"/>
				<wtc:param value = ""/>
				<wtc:param value = ""/>
			</wtc:service>
			<wtc:array id="rst0" start = "0" length = "1" scope="end" />
			<wtc:array id="rst" start = "1" length = "7" scope="end" />
			<%
			if ( !rc_cfm.equals("000000") )
			{
				if ( rc_cfm.equals("i03706") )/*当前页没有数据,返回上一页*/
				{
				%>
					<script >
						window.location = "fi037_lst.jsp?tm_b=<%=tm_b%>"
							+"&opCode=<%=opCode%>"
							+"&opName=<%=opName%>"
							+"&cur_page=<%=cur_page%>"
							+"&pageNumber=<%=pPage%>"
							+"&chn_code=<%=req_chn%>"
							+"&tm_e=<%=tm_e%>";
					</script>
				<%
				}
				else
				{
				%>
					<script >
						rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm%>" , 0 );
					</script>
				<%
				}

			}
			
			int recordNum = Integer.parseInt( rst0[0][0] );

			for ( int i=0;i<rst.length;i++ )
			{
				for ( int j = 0 ; j < rst[i].length ; j ++ )
				{
					System.out.println(" diling---rst["+i+"]["+j+"] ==============="+rst[i][j]);
				}
			%>
				<tr>
					<td width = '10%'>
						<input type = 'text' id = 'phone_no' name = 'phone_no' class = 'InputGrey' 
							readOnly value = '<%=rst[i][6]%>' size = '15'>
					</td>					
					<td  width = '10%'>
						<input type = 'text' id = 'id_iccid' name = 'id_iccid' class = 'InputGrey' 
							readOnly value = '<%=(req_chn.equals("02")?rst[i][0]:"")%><%=(req_chn.equals("14")?rst[i][0]:"")%>' size = '20'>
					</td>
					<td>
						<input type = 'text' id = 'id_name' name = 'id_name' class = 'InputGrey' 
							readOnly value = '<%=(req_chn.equals("02")?rst[i][1]:"")%><%=(req_chn.equals("14")?rst[i][1]:"")%>' size = '20'>
					</td>
					<td>
						<input type = 'text' id = 'id_addr' name = 'id_addr' class = 'InputGrey' 
							readOnly value = '<%=(req_chn.equals("02")?rst[i][2]:"")%><%=(req_chn.equals("14")?rst[i][2]:"")%>' size= "60">
					</td>
					<!--
					<td>
						<input type = 'text' id = 'exp_time' name = 'exp_time' class = 'InputGrey' 
							readOnly value = '<%=(req_chn.equals("02")?rst[i][3]:"")%>' size = '10'>
					</td>
					-->
					<td align = 'center'>
						<input type = 'button' id = 'b_appr' name = 'b_appr' class = 'b_text' 
							readOnly value = '审批' 
							v_qryChn = '<%=rst[i][4]%>'
							v_qryAcc = '<%=rst[i][5]%>'
							v_idx = '<%=i%>'
							v_iccid = '<%=(req_chn.equals("02")?rst[i][0]:"")%><%=(req_chn.equals("14")?rst[i][0]:"")%>'
							vNName = '<%=(req_chn.equals("02")?rst[i][1]:"")%><%=(req_chn.equals("14")?rst[i][1]:"")%>'
							vNHomeAddr = '<%=(req_chn.equals("02")?rst[i][2]:"")%><%=(req_chn.equals("14")?rst[i][2]:"")%>'
							vExpTime = '<%=(req_chn.equals("02")?rst[i][3]:"")%><%=(req_chn.equals("14")?rst[i][3]:"")%>'
							vPhoNo = '<%=rst[i][6]%>'
							onclick = 'getImg( this )'>												
					</td>				
				</tr>
			<%
			}
			%>      
		</TABLE>
		<table cellspacing="0" id=contentList>
			<tr>
				<td>
					<%	
					Page pg = new Page(iPageNumber,iPageSize,recordNum);
					PageView view = new PageView(request,out,pg); 
					view.setVisible(true,true,0,0);       
					%>
				</TD>
			</TR>
		</TABLE>		
		<TABLE>
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = 'b_bak' NAME= 'b_bak' CLASS = 'b_foot' VALUE = '返回'  />
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '关闭' onClick = 'removeCurrentTab();' />
				</TD>
			</TR>        
		</TABLE>		
	</DIV>

	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'workNo' NAME = 'workNo' VALUE = '<%=workNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'passwd' NAME = 'passwd' VALUE = '<%=passwd%>'/>
	
	<INPUT TYPE = 'HIDDEN' ID = 'phoNo' NAME = 'phoNo' VALUE = '<%=phoNo%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'usrPwd' NAME = 'usrPwd' VALUE = '<%=usrPwd%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'tm_b' NAME = 'tm_b' VALUE = '<%=tm_b%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'tm_e' NAME = 'tm_e' VALUE = '<%=tm_e%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'req_chn' NAME = 'req_chn' VALUE = '<%=req_chn%>'/>
	
	<INPUT TYPE = 'HIDDEN' ID = 'regCode' NAME = 'regCode' VALUE = '<%=regCode%>'/>	
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'cur_page' NAME = 'cur_page' VALUE = '<%=cur_page%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'pageNumber' NAME = 'pageNumber' VALUE = '<%=iPageNumber%>'/>		
</DIV>
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

function getImg( obj )
{
	document.frm.action = 'f<%=opCode%>_appr.jsp?idx='+obj.v_idx
		+'&v_qryChn='+obj.v_qryChn
		+'&v_iccid='+obj.v_iccid
		+'&vNName='+obj.vNName
		+'&vNHomeAddr='+obj.vNHomeAddr
		+'&vExpTime='+obj.vExpTime
		+'&v_qryAcc='+obj.v_qryAcc
		+'&vPhoNo='+obj.vPhoNo
		;
	document.frm.submit();
}

$("#b_bak").click
(
	function ()
	{
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';	
	}
)
</SCRIPT>
</BODY>
</HTML>