<%
   /*
   *   ����: ��ѯ�û���Ϣ
�� * �汾: v1.0
�� * ����: 2008/03/30
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String regionCode = (String)session.getAttribute("regCode");
     
     String ret_code="999999";
    
     String bugid=request.getParameter("bugid")==""?"999999":request.getParameter("bugid");   
     
     String [] check = request.getParameterValues("checkbug");
	String [] vbugidIn   = {""};     

  if(check!=null)
  {
		String [] vbugid   = request.getParameterValues("bugid");
		
		vbugidIn     = new String [check.length];	

		for(int i=0;i<check.length;i++)
		{
			vbugidIn[i]=vbugid[new Integer(check[i]).intValue()];
		}
	}
     
%>

<wtc:service name="sBugDel" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:params value="<%=vbugidIn%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000"))
      {
        ret_code="000000";
      }
     else
     {
      ret_code="999999";
     }
  out.println(ret_code);
%>	