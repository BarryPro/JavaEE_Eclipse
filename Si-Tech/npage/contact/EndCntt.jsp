<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%     
	String phone_no = request.getParameter("phone_no")==null?"":request.getParameter("phone_no");
  String Contact_id = request.getParameter("Contact_id")==null?"":request.getParameter("Contact_id");
  
  System.out.println("phone_no=="+phone_no);
  System.out.println("Contact_id=="+Contact_id);
  
  //�Ӵ�ƽ̨״̬
  String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 
  System.out.println("%%%%%%ͳһ�Ӵ�ƽ̨��ǰ״̬��%%%%%%%  "+appCnttFlag);
  
  if(appCnttFlag!=null&&("Y".equals(appCnttFlag)))
  {  
    System.out.println("%%%%%%%����ͳһ�Ӵ��رճ���%%%%%%%%");
    try{
%>
				<wtc:service name="sEndCntt" routerKey="phone"  routerValue="<%=phone_no%>"  outnum="1">
				<wtc:param value="<%=Contact_id%>"/>
				<wtc:param value="<%=phone_no%>"/>
				</wtc:service>
<%
    if(retCode.equals("000000")){
     System.out.println("%%%%%ͳһ�Ӵ��رճɹ���%%%%%%%");
     }
    }catch(Throwable e)
      {
    
      }
  }
%>
