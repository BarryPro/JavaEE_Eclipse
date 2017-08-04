<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%     
	String phone_no = request.getParameter("phone_no")==null?"":request.getParameter("phone_no");
  String Contact_id = request.getParameter("Contact_id")==null?"":request.getParameter("Contact_id");
  
  System.out.println("phone_no=="+phone_no);
  System.out.println("Contact_id=="+Contact_id);
  
  //接触平台状态
  String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 
  System.out.println("%%%%%%统一接触平台当前状态！%%%%%%%  "+appCnttFlag);
  
  if(appCnttFlag!=null&&("Y".equals(appCnttFlag)))
  {  
    System.out.println("%%%%%%%进入统一接触关闭程序！%%%%%%%%");
    try{
%>
				<wtc:service name="sEndCntt" routerKey="phone"  routerValue="<%=phone_no%>"  outnum="1">
				<wtc:param value="<%=Contact_id%>"/>
				<wtc:param value="<%=phone_no%>"/>
				</wtc:service>
<%
    if(retCode.equals("000000")){
     System.out.println("%%%%%统一接触关闭成功！%%%%%%%");
     }
    }catch(Throwable e)
      {
    
      }
  }
%>
