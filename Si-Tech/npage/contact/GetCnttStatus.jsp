<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
//---------����ͳһ�Ӵ�ƽ̨״̬-------------------
application.setAttribute("appCnttFlag","N");
try{
%>
<wtc:service name="sGetCnttStatus" outnum="2">
</wtc:service>
<wtc:array id="CnttStatus"   scope="end"/>
<%
 if(retCode.equals("000000")){ 
    if(CnttStatus!=null&&CnttStatus.length>0){
	    application.setAttribute("appCnttFlag",CnttStatus[0][0]);
	    System.out.println("%%%%%%%��ѯͳһ�Ӵ�ƽ̨״̬�ɹ���%%%%%%%%%"+CnttStatus[0][0]);
    } 
  }
}catch(Exception ex)
{
  System.out.println("%%%%%%%��ѯͳһ�Ӵ�ƽ̨״̬ʧ�ܣ�%%%%%%%%%");
}
//-------------------------------------------------
%>
