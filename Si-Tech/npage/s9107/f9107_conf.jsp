<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
    	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    	//String[][] baseInfoSession = (String[][])arrSession.get(0);
    	//String[][] otherInfoSession = (String[][])arrSession.get(2);
    	//String[][] password = (String[][])arrSession.get(4);
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");

	String loginaccept = request.getParameter("loginAccept");
	String op_code = "9107";
	String workno = request.getParameter("workno");
	String systemNote = request.getParameter("systemNote");
	String opNote = request.getParameter("opNote");
    String sum_flag = "";
    String check_flag = request.getParameter("check_flag");
    String[] checkId = request.getParameterValues("checkId");
    for(int i = 0;i < checkId.length;i++){
    	sum_flag = sum_flag+checkId[i]+"|";
    }
    
%>
     <wtc:service name="s9107Check" routerKey="region" routerValue="<%=regionCode%>" retcode="sErrorNo" retmsg="sErrorMessage" outnum="0" >
     <wtc:param value="<%=loginaccept%>" />
     <wtc:param value="<%=op_code%>" />
     <wtc:param value="<%=workno%>"/>
     <wtc:param value="<%=systemNote%>"/>
     <wtc:param value="<%=opNote%>"/>
     <wtc:param value="<%=orgCode%>"/>
     <wtc:param value="<%=sum_flag%>"/>
     <wtc:param value="<%=check_flag%>"/>												
     </wtc:service>
   <% 
    if (sErrorNo.equals("000000"))
    {
%>
<script>
    rdShowMessageDialog("SPҵ����Ϣ����ɣ�",2);
    location="f9107_1.jsp";                                                                //��ӡ��ˮ
</script>
<%
     }
     else
     {
%>
<script>
    rdShowMessageDialog("������룺'<%=sErrorNo%>'������Ϣ��'<%=sErrorMessage%>'",0);
    location="f9107_1.jsp";
</SCRIPT>
<%
     }
%>	   
