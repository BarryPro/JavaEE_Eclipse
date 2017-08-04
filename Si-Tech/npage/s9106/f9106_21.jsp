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
      String op_code = "9106";
      String systemNote = request.getParameter("systemNote");
      String opNote = request.getParameter("opNote");
      String serv_type = request.getParameter("serv_type");
      String sp_code = request.getParameter("sp_code");
      String sp_name = request.getParameter("sp_name");
      String sp_type = request.getParameter("sp_type");
      String serv_code = request.getParameter("serv_code");
      String prov_code = request.getParameter("prov_code");
      String bal_prov = request.getParameter("bal_prov");
      String dev_code = request.getParameter("dev_code");
      String valid_date = request.getParameter("valid_date");
      String expire_date = request.getParameter("expire_date");
      String description = request.getParameter("description");
      int maxaccept =Integer.parseInt(request.getParameter("maxaccept")); 
%>
     <wtc:service name="s9106Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sErrorNo" retmsg="sErrorMessage" outnum="0" >
     <wtc:param value="<%=loginaccept%>" />
     <wtc:param value="<%=op_code%>" />
     <wtc:param value="<%=workno%>"/>
     <wtc:param value="<%=orgCode%>"/>
     <wtc:param value="<%=systemNote%>"/>
     <wtc:param value="<%=opNote%>"/>
     <wtc:param value="<%=serv_type%>"/>
     <wtc:param value="<%=sp_code%>"/>
     <wtc:param value="<%=sp_name%>"/>
     <wtc:param value="<%=sp_type%>"/>
     <wtc:param value="<%=serv_code%>"/>
     <wtc:param value="<%=prov_code%>"/>
     <wtc:param value="<%=bal_prov%>"/>
     <wtc:param value="<%=dev_code%>"/>
     <wtc:param value="<%=valid_date%>"/>
     <wtc:param value="<%=expire_date%>"/>
     <wtc:param value="<%=description%>"/>
     <wtc:param value="<%=String.valueOf(maxaccept)%>"/>													
     </wtc:service>
     
 <% 
    if (sErrorNo.equals("000000"))
    {
%>
<script>
    rdShowMessageDialog("SP企业信息修改成功！");
    location="f9106_1.jsp";                                                                //打印流水
</script>
<%
     }
     else
     {
%>
<script>
    rdShowMessageDialog("错误代码：'<%=sErrorNo%>'错误信息：'<%=sErrorMessage%>'",0);
    location="f9106_1.jsp";
</SCRIPT>
<%
     }
%>	
