   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-16
********************/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%  
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
    	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");               //����
	String nopass  = (String)session.getAttribute("password");                 //��½����
	String regionCode= (String)session.getAttribute("regCode");
String powerCode  = (String)session.getAttribute("powerCode");                  
	
	Logger logger = Logger.getLogger("f8026_submit_mod.jsp");
	
	

	String role_code = request.getParameter("role_code"); 			 //��ɫ����
	String role_name = request.getParameter("role_name");				 //��ɫ����
	String role_describe = request.getParameter("role_describe");//��ɫ��Ϣ���� 
	String roleType_codeIn = request.getParameter("roleType_codeIn");//��ɫ����
	String use_flag = request.getParameter("use_flag");					 //��Ч��־

	System.out.println("========================"+use_flag);
	String op_note = request.getParameter("op_note");
	String ip_Addr = request.getParameter("ip_Addr");

 	ArrayList acceptList = new ArrayList();

    String paramsIn[] = new String[11];
	  paramsIn[0] = workNo;
		paramsIn[1] = nopass;
		paramsIn[2] = "e495";
    paramsIn[3] = ip_Addr;				//ip
    paramsIn[4] = 	op_note;   
    paramsIn[5] =  role_code;       
    paramsIn[6] =  role_name;     
    paramsIn[7] =  roleType_codeIn;     
    paramsIn[8] =  role_describe;   
    paramsIn[9] =  use_flag;           
    paramsIn[10] = op_note;   

    String errCode = "0";
    String errMsg = "";
    
	try
	{   
%>
    <wtc:service name="s8027_updateMop" outnum="2" retmsg="msg5" retcode="code5" routerKey="region" routerValue="<%=regionCode%>">
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
			<wtc:param value="<%=powerCode%>" />				
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />

<%	  	
		errMsg = msg5;   
		errCode = code5; 		 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call s8027_update is Failed!");
	}
	       
	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("�����ɹ���",2);
             document.location.replace("<%=request.getContextPath()%>/npage/opManage/s8026/f8026_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>"); 
//			 window.close(); ;
        </script>
<%	}
    else
    {
%>        
		  <script language='jscript'>
	          rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	          history.go(-1);
	      </script>         
<%            
    }
%>
