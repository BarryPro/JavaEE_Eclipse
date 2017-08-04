<%
    /*************************************
    * 功  能: 4A白名单删除 e268
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-9-16
    **************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String opCode="e268";
	String opName="4A白名单删除";

    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String workNos = request.getParameter("val"); //选择的工号
    System.out.println("====e268=========workNos==========   "+workNos);
    String ip = request.getRemoteAddr();
	String selectGroupId = (String)request.getParameter("groupId")==null?"":(String)request.getParameter("groupId");
	System.out.println("=======e268======selectGroupId==========   "+selectGroupId);


		String[] workNosArr = new String[]{""};
		String workNosString = "";
		if(selectGroupId != null && selectGroupId.length() > 0){  //多选
			    workNosArr = workNos.split(",");
    			System.out.println("==========workNosArr.length============   "+workNosArr.length);
    			if(workNosArr.length == 0){
    				workNosArr = new String[]{""};
    			}
		}
%>   
<wtc:service name="se267Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="2" >
        <wtc:param value="0"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
    <%
            if(workNosArr!=null){
                if(workNosArr.length!=0){
    %>
                    <wtc:params value="<%=workNosArr%>"/>
    <%
                }
            }else{
    %>
                 <wtc:param value=""/>
    <%
            }
    %>
        <wtc:param value="1"/>   <% //操作标识：0为录入，1为删除 %>
</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
String retcode = Code;
String retmsg = Msg;
   if(retcode.equals("000000")){
   %>
      <script language='javascript'>
      	  rdShowMessageDialog("操作成功！",2);
      	  window.location = "fe268_main.jsp?opCode=e268&opName=4A白名单删除";
      </script>
      <%
   }else{
%>
    <script language='javascript'>
        rdShowMessageDialog("错误信息：<%=retmsg%><br>错误代码：<%=retcode%>", 0);
        window.location = "fe268_main.jsp?opCode=e268&opName=4A白名单删除";
    </script>
<%
 }
%>



                                                         



   	

