		   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-16
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>         

<%@page contentType="text/html;charset=gbk"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");               //����
	String regionCode= (String)session.getAttribute("regCode");
	
	Logger logger = Logger.getLogger("f5110_delSub.jsp");
	
	DateFormat df = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	String sysdate=df.format(new Date());
	
	
	//��ȡ�������Ϣ
	String prodDirect = request.getParameter("prodDirect");										//���
	
  String paramsIn[] = new String[4];
  paramsIn[0] = workNo;																			//����
  paramsIn[1] = "2951";																			//OP_CODE
  paramsIn[2] = "����Ա��"+workNo+"����ҵ��Ŀ¼ɾ������";		//��ע
  paramsIn[3] = prodDirect;																	//�����

  String errCode="";
  String errMsg="";
	try
	{   
	 //	acceptList = impl.callFXService("sSiDirDel",paramsIn,"2");
%>

    <wtc:service name="sSiDirDel" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />			
		</wtc:service>

<%	 	
		errCode=code;   
		errMsg=msg; 		 	 
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call sProdDirDel is Failed!");
	}
	       
	
	if(errCode.equals("000000"))
    {
%>
        <script language='javascript'>
        	 rdShowMessageDialog("�����ɹ���",2);
        	 document.location.replace("<%=request.getContextPath()%>/npage/s2951/f2951.jsp"); 
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
