<%@ include file="/include/public_title_name.jsp"%>
<%
      ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
      String[][] baseInfoSession = (String[][])arrSession.get(0);
      String[][] otherInfoSession = (String[][])arrSession.get(2);
      String[][] password = (String[][])arrSession.get(4);
      String orgCode = baseInfoSession[0][16];
      String regionCode = (String)session.getAttribute("regCode");
      
      String workno = request.getParameter("workno");
      String loginaccept = request.getParameter("loginAccept");
      String op_code = "9107";
      String systemNote = request.getParameter("systemNote");
      String opNote = request.getParameter("opNote");
      String operator_code = request.getParameter("operator_code");
      String operator_name = request.getParameter("operator_name");
      String serv_type = request.getParameter("serv_type");
      String serv_attr = request.getParameter("serv_attr");
      String   icount  = request.getParameter("count");
      String bill_flag = request.getParameter("bill_flag");
      String other_bal_obj1 = request.getParameter("other_bal_obj1");
      String other_bal_obj2 = request.getParameter("other_bal_obj2");
      String valid_date = request.getParameter("valid_date");
      String expire_date = request.getParameter("expire_date");
      String bal_prop = request.getParameter("bal_prop");
      String maxaccept =request.getParameter("maxaccept"); 
%>
     <wtc:service name="s9107Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sErrorNo" retmsg="sErrorMessage" outnum="0" >
     <wtc:param value="<%=loginaccept%>" />
     <wtc:param value="<%=op_code%>" />
     <wtc:param value="<%=workno%>"/>
     <wtc:param value="<%=orgCode%>"/>
     <wtc:param value="<%=systemNote%>"/>
     <wtc:param value="<%=opNote%>"/>
     <wtc:param value="<%=operator_code%>"/>
     <wtc:param value="<%=operator_name%>"/>
     <wtc:param value="<%=serv_type%>"/>
     <wtc:param value="<%=serv_attr%>"/>
     <wtc:param value="<%=icount%>"/>
     <wtc:param value="<%=bill_flag%>"/>
     <wtc:param value="<%=other_bal_obj1%>"/>
     <wtc:param value="<%=other_bal_obj2%>"/>
     <wtc:param value="<%=valid_date%>"/>
     <wtc:param value="<%=expire_date%>"/>
     <wtc:param value="<%=bal_prop%>"/>
     <wtc:param value="<%=maxaccept%>"/>													
     </wtc:service>
     
 <% 
    if (sErrorNo.equals("000000"))
    {
%>
<script>
    rdShowMessageDialog("SP业务信息修改成功！");
    location="f9107_1.jsp";                                                                //打印流水
</script>
<%
     }
     else
     {
%>
<script>
    rdShowMessageDialog("错误代码：'<%=sErrorNo%>'错误信息：'<%=sErrorMessage%>'",0);
    location="f9107_1.jsp";
</SCRIPT>
<%
     }
%>	
