   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "��Ʒ����";
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                	//��½����
	String regionCode= (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String detail_code = request.getParameter("detail_code");
	String region_code = request.getParameter("region_code");
	String note = request.getParameter("note");
 	
 	System.out.println("detail_code="+detail_code);
 	System.out.println("region_code="+region_code);
 	
 	String  errCode="";
    String errMsg="";
 	
 	//��ȡ���е��Ż���Ϣ
	String[] paramsIn=new String[6];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	
//	retArray=callView.callFXService("s5238_MonthShw",paramsIn,"6");	
%>

    <wtc:service name="s5238_MonthShw" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />					
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%	
	errCode = code;
	errMsg = msg;
 
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        window.close();
        </script>
<%	} 
%>

<html>
<head>
<base target="_self">
<title>�����Ż�������Ϣ�鿴</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

</script>
</head>
                      
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	
  <form name="form1"  method="post">
  	<%@ include file="/npage/include/header_pop.jsp" %>   
	<div class="title">
		<div id="title_zi">�����Ż�������Ϣ�鿴</div>
	</div>
 
	  		  	<TABLE   id="mainOne"  cellspacing="0" >
	            <TBODY>
	  				<tr>
	  					<TD width="30%" height="22" class="blue">&nbsp;&nbsp;�Żݴ���</TD>
	  					<TD width="70%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr>
	  					<TD height="22" class="blue">&nbsp;&nbsp;�Ż�����</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr>
	  					<TD class="blue">&nbsp;&nbsp;����������</TD>
	  					<TD>
	  					 <input type=text  v_type="int" v_must=1 v_minlength=1 v_maxlength=4 v_name="����������" name=month_flag maxlength=4 value="<%=result_t[0][0]%>" readonly class="InputGrey"></input>  <font class="orange">(��λ��)</font>

	  						</TD>
	  				</tr>
	  				<tr>
	  					<TD height="22" class="blue">&nbsp;&nbsp;�����շ���</TD>
	  					<TD>
	  					<input type=text  v_type="money" v_must=1 v_minlength=1 v_maxlength=15 v_name="�����շ���" name=month_fee maxlength=15 value="<%=result_t[0][1]%>" readonly class="InputGrey"></input>  <font class="orange">(��λԪ)</font>

	  					</TD>
	  				</tr>
	  				<tr>
	  					<TD class="blue">&nbsp;&nbsp;������ȡ��ʶ</TD>
	  					<TD>
	  						<input type="radio" name="day_flag" value="1" <%=result_t[0][2].equals("1")==true?"checked":""%>>������
	  						<input type="radio" name="day_flag" value="0" <%=result_t[0][2].equals("0")==true?"checked":""%>>������
	  					</TD>
	  				</tr>
	  				<tr>
	  					<TD height="22" class="blue">&nbsp;&nbsp;�����շ���</TD>
	  					<TD>
	  				<input type=text  v_type="money" v_must=1 v_minlength=1 v_maxlength=15 v_name="������ȡ����" name=day_fee maxlength=15 value="<%=result_t[0][3]%>" readonly class="InputGrey"></input>  <font class="orange">(��λԪ)</font>

	  					</TD>
	  				</tr>
	  				<tr>
	  					<TD height="22" class="blue">&nbsp;&nbsp;��ȡ��Ŀ��</TD>
	  					<TD>
	  						<%=result_t[0][4]%>&nbsp;->&nbsp;<%=result_t[0][5]%>
	  					</TD>
	  				</tr>
	            </TBODY>
	          	</TABLE>
	          	<TABLE cellSpacing="0">
	  			  <tr>
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="reset" type="button" class="b_foot" value="����" onClick="window.close()" >
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  			 <%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
 
</body>
</html>

