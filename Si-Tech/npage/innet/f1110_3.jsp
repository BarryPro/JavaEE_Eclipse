 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1110";		
	String opName = "һ��˫�Ŷ�Ӧ��ϵ";	//header.jsp��Ҫ�Ĳ��� 	
	
   	String regionCode=(String)session.getAttribute("regCode");  
	/*
	���������������ʽ��A��D�������ֻ����룬���ţ����ű���
	���������������룬������Ϣ
	*/ 
	String opType = request.getParameter("bakOpType");            		/*�������� ���ӡ�ɾ��*/
	String mainPhoneNo = request.getParameter("mainPhoneNo");       /*���ֻ�����*/
	String iSimNo1= request.getParameter("mainSimNo");				/*��SIM����*/
	String iImsiNo1= request.getParameter("mainImsiNo");			/*��IMSI��*/
	String iPhoneNo2= request.getParameter("appendPhoneNo");		/*���ֻ�����*/
	String iSimNo2	= request.getParameter("appendSimNo");			/*��SIM����*/
	String iImsiNo2= request.getParameter("appendImsiNo");			/*��IMSI��*/
	String iOpNote	= request.getParameter("opNote");				/*��ע*/
	String iLoginNo	= request.getParameter("loginNo");				/*����*/
	String iOrgCode	= request.getParameter("orgCode");				/*���Ż�������*/
	String iOpCode	= "1110";										/*��������*/
	String iIpAdd	= request.getRemoteAddr();				/*ӪҵԱ��½IP*/
	
	String loginAccept="0";
	System.out.println("loginAccept====="+loginAccept);
	String orgId= request.getParameter("org_id");				    /*orgId*/
//----------------------------
	String ret_code = "0";      
	String retMessage = "";	 	        
	String serviceName = "s1110Cfm";
	String[] paraStrIn = new String[]{opType,mainPhoneNo,iSimNo1,iImsiNo1,iPhoneNo2,iSimNo2,iImsiNo2,iOpNote,iLoginNo,iOrgCode,iOpCode,iIpAdd,loginAccept,orgId};
	String outParaNums= "1";   	  
	    //retArray = callSvrImpl.callFXService(serviceName, paraStrIn, outParaNums);
	 %>
	 	<wtc:service name="s1110Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
			<wtc:params value="<%=paraStrIn%>"/>	
		</wtc:service>		
		<wtc:array id="result1"  scope="end"/>
	 <%
	       ret_code=retCode1;
	       retMessage=retMsg1;    
	       if(result1.length!=0)
	       	  loginAccept = result1[0][2];        
    
		if(ret_code.equals("000000"))
		{
			if(opType.compareTo("A") == 0)
			{		opType = "����";		}
			if(opType.compareTo("D") == 0)
			{		opType = "ɾ��";		}					
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=opType%>" + "һ��˫�Ŷ�Ӧ��ϵ�ɹ���",2);
                history.go(-1);
            </script>            
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]" ,0);
                history.go(-1);
            </script>
<%        
        }
%>



<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+mainPhoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />

