<%
/********************
 version v1.0
 开发商: si-tech
 update by wangzn @ 2010-3-7 09:39:00
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="import java.sql.*"%>
<%@ page import="java.text.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="frm" action="" method="post" >
    <input type="hidden" id="errPhoneList" name="errPhoneList" value="" />
    <input type="hidden" id="errMsgList" name="errMsgList" value="" />
</form>
</body>
<%
  
  
  String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
  String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String regionCode = iOrgCode.substring(0,2);
  
  String cust_id = request.getParameter("cust_id");
  String productSpec_number = request.getParameter("productSpec_number");
  String id_no = request.getParameter("id_no");
  String user_name = request.getParameter("user_name");
  String product_id = request.getParameter("product_id");
  
  
  

try{
%>

<wtc:service name="s4483Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage"  outnum="2" >
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
  <wtc:param value="<%=iOrgCode%>"/>
  <wtc:param value="<%=iIpAddr%>"/>
  <wtc:param value="<%=cust_id%>"/>
  <wtc:param value="<%=productSpec_number%>"/>
  <wtc:param value="<%=id_no%>"/>
  <wtc:param value="<%=user_name%>"/>
  <wtc:param value="<%=product_id%>"/>  
</wtc:service>
<wtc:array id="result" scope="end" />

<%

 if("000000".equals(retCode)){
            String errPhoneList = result[0][0];
            String errMsgList   = result[0][1];
        /* 成功后转到错误展示页面 */
        %>
            <script language='jscript'>
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                
              frm.action="f4483_result.jsp";
            	frm.method="post";
            	frm.submit();
            </script>
        <%
        }else{
            %>
            <!--wuxy alter 20100313错误信息:retMsg  -->
            <script type=text/javascript>
                rdShowMessageDialog("操作失败！<br/>错误代码：<%=retCode%>，错误信息:<%=retMessage%>",0);
                window.location="f4483_1.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s4483Cfm失败！",0);
            window.location="f4483_1.jsp";
        </script>
        <%
        System.out.println("# return from f4483_1.jsp -> Call Service s4483Cfm Failed!");
        e.printStackTrace();
    }
    
%>
</html>