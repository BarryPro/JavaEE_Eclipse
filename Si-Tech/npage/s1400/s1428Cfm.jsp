		   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  String opCode = "1428";
  String opName = "���չ�ϵ���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>

 <%
    String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String iccid=WtcUtil.repNull(request.getParameter("iccid"));
	String comm_addr=WtcUtil.repNull(request.getParameter("comm_addr"));
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	
	String error_code="";
    String error_msg="";
	
	String nopass = (String)session.getAttribute("password");
	
    String work_no = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
	String iRegion_Code = org_code.substring(0,2);
	String op_code = "1428";

	String cus_name=WtcUtil.repNull(request.getParameter("cust_name"));
	
	String paraStr[]=new String[28];
	
	String iloginAccept=WtcUtil.repNull(request.getParameter("loginAccept"));
 	String iopCode=op_code;
 	String iloginNo=work_no;
	String iloginPasswd=nopass;
	String iorgCode=org_code;

	String iidNo=WtcUtil.repNull(request.getParameter("cust_id"));
	String icontractNo=WtcUtil.repNull(request.getParameter("s_acc_name"));
	String isystemNote=WtcUtil.repNull(request.getParameter("t_sys_remark"));

  //��Ϊ����,�޸�,ɾ������

  
	String iopType="d";
    iidNo=WtcUtil.repNull(request.getParameter("cust_id"));
    icontractNo=WtcUtil.repNull(request.getParameter("s_acc_name"));

	String iopNote=WtcUtil.repNull(request.getParameter("t_op_remark"));
	String iipAddr=request.getRemoteAddr();
  

            String paramsIn[] = new String[11];

            paramsIn[0]=iloginAccept   ;
            paramsIn[1]=iopCode        ;
            paramsIn[2]=iloginNo        ;
            paramsIn[3]=iloginPasswd    ;
						paramsIn[4]=iorgCode       ;
            paramsIn[5]=iopType      ;
            paramsIn[6]=iidNo       ;
            paramsIn[7]=icontractNo        ;
            paramsIn[8]=isystemNote      ;
            paramsIn[9]=iopNote       ;
            paramsIn[10]=iipAddr  ;

            //retStr = callView.callService("s1428Cfm", paramsIn, "1", "region", iRegion_Code);
 %>
 
 
     <wtc:service name="s1428Cfm" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=iRegion_Code%>">
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
		</wtc:service>
 
<%           
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+op_code +"&retCodeForCntt="+code+"&opName="+"���չ�ϵ���"+"&workNo="+work_no+"&loginAccept="+iloginAccept+"&pageActivePhone="+srv_no+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
            error_code = code;
            error_msg= msg;
			System.out.println("------------code--------------1428cfm----"+code);
			System.out.println("------------msg--------------1428cfm----"+msg);
   if(error_code.equals("000000"))
    {
	   System.out.println("55555555555555555555555555555555555555555");
%>
        <script>
	      rdShowMessageDialog("�ͻ����Ѽƻ��ѱ��ɹ��޸ģ�",2);
          history.go(-2);
	    </script>
<%
   }
   else
   {
%>
  
	<script>
	  rdShowMessageDialog('<%=error_msg%>�������²�����',0);
      history.go(-1);
	 </script>
<%
   }
%>
		<jsp:include page="<%=url%>" flush="true" />