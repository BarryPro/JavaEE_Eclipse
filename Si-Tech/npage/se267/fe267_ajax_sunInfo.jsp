<%
    /*************************************
    * 功  能: 4A白名单录入 e267 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-9-16
    **************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	String opCode="e267";
	String opName="4A白名单录入";
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String workNos = request.getParameter("val"); //选择的工号
    System.out.println("====e267=========workNos==========   "+workNos);
    String ip = (String)session.getAttribute("ipAddr");
	String selectGroupId = (String)request.getParameter("groupId")==null?"":(String)request.getParameter("groupId");
	System.out.println("=======e267======selectGroupId==========   "+selectGroupId);


		String[] workNosArr = new String[]{""};
		String workNosString = "";
		if(selectGroupId != null && selectGroupId.length() > 0){  //多选
			/* 使用选择工号 */
			    workNosArr = workNos.split(",");
    			System.out.println("==========workNosArr.length============   "+workNosArr.length);
    			if(workNosArr.length == 0){
    				workNosArr = new String[]{""};
    			}
		}else{  //单选
		    workNosString = workNos;
			    System.out.println("=========================e267 进入单选workNosString==========   "+workNosString);
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
        if(selectGroupId != null && selectGroupId.length() > 0){  //多选
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
        }else{    //单个录入
    %>   
        <wtc:param value="<%=workNosString%>"/>
    <%  
        }
    %>
        <wtc:param value="0"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>

<%
String retcode = Code;
String retmsg = Msg;
   if(retcode.equals("000000")){
   %>
        <script language='javascript'>
            rdShowMessageDialog("操作成功！",2);
            window.location = "fe267_main.jsp?opCode=e267&opName=4A白名单录入";
        </script>
      <%
   }else{
%>
        <script language='javascript'>
            rdShowMessageDialog("错误信息：<%=retmsg%><br>错误代码：<%=retcode%>", 0);
            window.location = "fe267_main.jsp?opCode=e267&opName=4A白名单录入";
        </script>
<%
 }
%>



                                                         



   	

