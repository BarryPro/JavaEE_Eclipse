<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-19
********************/
%>
              
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@page contentType="text/html;charset=gb2312" %>
<%
	//��ȡ�û�session��Ϣ
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");                //����
	String nopass  = (String)session.getAttribute("password");                    	//��½����
	String regionCode = (String)session.getAttribute("regCode");
			
	//������Ϣ���������
	String errCode = "";
	String errMsg = "";
	System.out.println("@@@@@@@@@@@");
	String qryType = request.getParameter("qryType");
	String login_accept = request.getParameter("login_accept");
	String region_code = request.getParameter("region_code");
	String detail_code = request.getParameter("detail_code");
	String month_flag = request.getParameter("month_flag");
	String month_fee = request.getParameter("month_fee");
	String day_flag = request.getParameter("day_flag");
	String day_fee = request.getParameter("day_fee");
	String acc_detail = request.getParameter("acc_detail");
	String note = request.getParameter("note");
	String typeButtonNum = request.getParameter("typeButtonNum");
	
		
	String paramsIn[] = new String[12];
	paramsIn[0]=workNo;
	paramsIn[1]=nopass;
	paramsIn[2]="5238";
	paramsIn[3]=login_accept;
	paramsIn[4]=region_code;
	paramsIn[5]=detail_code;
	paramsIn[6]=month_flag;
	paramsIn[7]=month_fee;
	paramsIn[8]=day_flag;
	paramsIn[9]=day_fee;
	paramsIn[10]=acc_detail;
	paramsIn[11]=note;
	
//	acceptList = impl.callService("s5238_MonthCfm",paramsIn,"2");
	%>
	
	    <wtc:service name="s5238_MonthCfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />		
			<wtc:param value="<%=paramsIn[3]%>" />	
			<wtc:param value="<%=paramsIn[4]%>" />	
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />						
			<wtc:param value="<%=paramsIn[11]%>" />							
		</wtc:service>
	
	<%
	errCode=code;   
	errMsg=msg;
	
	if(!errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	        history.go(-1);
        </script>
<%	}
	else
	{
%>
		<script language='javascript'>
			rdShowMessageDialog("���óɹ�" ,2);
			window.opener.form1.typeButton<%=typeButtonNum%>.disabled=false;
        	window.opener.form1.typeButton<%=typeButtonNum%>.value="������";
			window.close();
        </script>
<%
	}
%>

