<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-2-13
********************/
%>
<%
  String opCode = "3187";
  String opName = "�ʻ���ϵά��";
%>              

<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>

<%
	Logger logger = Logger.getLogger("f3187_midifySub.jsp");
	
	String workNo = request.getParameter("workNo");             //����
	String loginPass = request.getParameter("loginPass");       //����
	String contractPay = request.getParameter("contractPay");	//֧���ʺ�
	String contractPay2 = request.getParameter("contractPay2"); //��֧���ʻ�
	String allFlag = request.getParameter("allFlag");	        //ȫ���־
	String cycleMoney = request.getParameter("cycleMoney");	    //������       
	String beginDate = request.getParameter("beginDate");       //��ʼ����
	String endDate = request.getParameter("endDate");           //��������
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("contractPay2:"+contractPay2);
	String payOrder = request.getParameter("payOrder");	 
	String[] paramsIn = new String[9];
	
	paramsIn[0] = workNo;
	paramsIn[1] = loginPass;
	paramsIn[2] = contractPay;
	paramsIn[3] = contractPay2;
	paramsIn[4] = allFlag;
	paramsIn[5] = cycleMoney;
	paramsIn[6] = beginDate;    
	paramsIn[7] = endDate; 
	paramsIn[8] = payOrder;

	//acceptList = impl.callFXService("s3187Cfm",paramsIn,"2");
%>

    <wtc:service name="s3187Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />	
			<wtc:param value="<%=paramsIn[8]%>" />									
		</wtc:service>
<wtc:array id="result_t" scope="end"/>
<%	
	String errCode =code1;   
	String errMsg=msg1; 	
	System.out.println("--------errCode-------f3187_midifySub----------"+errCode);
	System.out.println("--------errMsg-------f3187_midifySub----------"+errMsg);
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("�����ɹ���",2);
			 		window.close();
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("������룺<%=errCode%><br>������Ϣ��<%=errMsg%>",0);
	          history.go(-1);
	      </script>         
<%            
    }
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	
<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&retMsgForCntt="+errMsg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+sysAcceptl+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+contractPay+"&contactType=acc";	%>						
<jsp:include page="<%=url%>" flush="true" />
