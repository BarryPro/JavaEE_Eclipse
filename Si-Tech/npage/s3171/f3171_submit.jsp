<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-18 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode1 = "3171";
	String opName1 = "֧����ϵ����";
	
	String regionCode= (String)session.getAttribute("regCode");
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
		
	String workNo = request.getParameter("workNo");             //����
	String loginPass = request.getParameter("loginPass");       //����
	String contractPay = request.getParameter("contractPay");	//֧���ʺ�
	String contractPay2 = request.getParameter("contractPay2"); //��֧���ʻ�	
	String payOrder = request.getParameter("payOrder");	        //����˳��  
	
	String allFlag = request.getParameter("allFlag");	        //ȫ���־
	String cycleMoney = request.getParameter("cycleMoney");	    //������       
	String beginDate = request.getParameter("beginDate");       //��ʼ����
	String endDate = request.getParameter("endDate");           //��������
		
	ArrayList acceptList = new ArrayList();
	System.out.println("contractPay2:"+contractPay2);	
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

	//acceptList = impl.callFXService("s3171Cfm",paramsIn,"2");
%>	
	<wtc:service name="s3171Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
		<wtc:param value="<%=paramsIn[7]%>"/>
		<wtc:param value="<%=paramsIn[8]%>"/>
	</wtc:service>

 <%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode1+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1.trim()+"&opName="+opName1+"&workNo="+workNo+"&loginAccept=&pageActivePhone=&opBeginTime="+opBeginTime+"&contactId="+contractPay+"&contactType=acc";%>
 <%
	System.out.println("url==============="+url);
 %>
 
<jsp:include page="<%=url%>" flush="true" />
	
<%
	String errCode =retCode1; 
	String	errMsg=retMsg1;
	
	if(errCode.equals("000000"))
    	{
%>
	        <script language='javascript'>
	        	 rdShowMessageDialog("�����ɹ���",2);
			       window.location="/npage/s3171/f3171_1.jsp?opCode=3171&opName=֧����ϵ���� ";
	        </script>
<%	}
    else
    	{
%>        
		<script language='jscript'>
		          rdShowMessageDialog("������Ϣ��<%=errMsg%>",0);
		          history.go(-1);
		</script>         
<%            
    	}
%>

