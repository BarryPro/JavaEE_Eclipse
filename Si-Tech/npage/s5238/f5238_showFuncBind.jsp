   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
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
	String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String sm_code = request.getParameter("sm_code");
	String detail_code = request.getParameter("detail_code");
	String note = request.getParameter("note");	
	String region_code = request.getParameter("region_code");
 	String typeButtonNum = request.getParameter("typeButtonNum");
 	
 	String errCode="";
  String errMsg="";
 	
 	//��ȡ���е��Żݰ���Ϣ
	String[] paramsIn=new String[4];
	paramsIn[0]="9102";
	paramsIn[1]=region_code;
	paramsIn[2]=sm_code;
	paramsIn[3]=detail_code;

 	String op_name ="��Ʒ��"+mode_code+"���ط�������";
	 	
	//retArray=callView.callFXService("sDynSqlCfm",paramsIn,"3");	
%>

    <wtc:service name="sDynSqlCfm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
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
	        history.go(-1);
        </script>
<%	} 
%>

<html>
<head>
<base target="_self">
<title>�ط�����Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

//-----�ύ���������Ż�����-----
function doSubmit()
{	
	document.form1.action="f5238_opFuncBind_submit.jsp"; 
	document.form1.submit();
}


//ѡ���ط�����
function queryFuncCode()
{
	var retToField = "func_code|func_name|";
	var url = "f5238_queryFuncCode.jsp?region_code=<%=region_code%>&sm_code=<%=sm_code%>&retToField="+retToField;
	window.open(url,"","height=600,width=400,scrollbars=yes");
}


</script>
</head>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	  <form name="form1"  method="post">
	  	
<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">�ط�����Ϣ</div>
	</div>
 
	  <input type="hidden" name="login_accept" value="<%=login_accept%>">
	  <input type="hidden" name="detail_code" value="<%=detail_code%>">
	  <input type="hidden" name="note" value="<%=note%>">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
	  <input type="hidden" name="sm_code" value="<%=sm_code%>">
	  <input type="hidden" name="typeButtonNum" value="<%=typeButtonNum%>">
	  
	  		  	<TABLE id="mainOne"  cellspacing="0" >
	            <TBODY>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;�Żݴ���</TD>
	  					<TD width="80%">
	  						<%=detail_code%>
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue">&nbsp;&nbsp;�Ż�����</TD>
	  					<TD>
	  						<%=note%>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;���ر�ʶ</TD>
	  					<TD>
	  						<input type="radio" v_must="1" v_name="���ر�ʶ" name="off_flag" value="1"  <%=result_t[0][2].equals("1")==true?"checked":""%> <%=result_t[0][2].trim().equals("")==true?"checked":""%> >��ͨ
	  						<input type="radio" v_must="1" v_name="���ر�ʶ" name="off_flag" value="0"  <%=result_t[0][2].equals("0")==true?"checked":""%>  >�ر�
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�ط�����</TD>
	  					<TD>
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=5 v_name="�ط�����" name=func_code maxlength=5 size="5" value="<%=result_t[0][0]%>" readonly Class="InputGrey"></input>
	  						<input type=text  v_name="�ط�����" name=func_name maxlength=40 value="<%=result_t[0][1]%>" readonly Class="InputGrey"></input>
	  					</TD>
	  				</tr>
	        </TBODY>
	         </TABLE>
	         <TABLE  cellSpacing= "0">
	  			  	<TR >
	  						<TD height="30" align="center" id="footer">
 
	          	 	    <input name="reset" type="button" class="b_foot" value="����" onClick="window.close()" >
	          	 	    &nbsp;
	  						</TD>
	  			  	</TR>
	  	    </TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
	  
</body>
</html>

