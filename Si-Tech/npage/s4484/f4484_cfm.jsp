<%
/********************
 version v2.0
 ������: si-tech
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
    <input type="hidden" id="unitId" name="unitId" value="" />
    <input type="hidden" id="loginAccept" name="loginAccept" value="" />
    <input type="hidden" id="grpName" name="grpName" value="" />
</form>
</body>
<%
  
  
  String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
  String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String regionCode = iOrgCode.substring(0,2);
  
  String unit_id = request.getParameter("unit_id");
  String productSpec_number = request.getParameter("productSpec_number");
  String product_id = request.getParameter("product_id");
  
  
  

try{
%>

<wtc:service name="s4484Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage"  outnum="2" >
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
  <wtc:param value="<%=iOrgCode%>"/>
  <wtc:param value="<%=iIpAddr%>"/>
  <wtc:param value="<%=unit_id%>"/>
  <wtc:param value="<%=productSpec_number%>"/>
  <wtc:param value="<%=product_id%>"/>  
</wtc:service>
<wtc:array id="result" scope="end" />

<%

 if("000000".equals(retCode)){
            String errPhoneList = result[0][0];
            String errMsgList   = result[0][1];
        /* �ɹ���ת������չʾҳ�� */
        %>
            <script type=text/javascript>
               rdShowMessageDialog("<%=retMessage%>"); 
            </script>
        <%
        }else{
            %>
            <script type=text/javascript>
                rdShowMessageDialog("����ʧ�ܣ�<br/>������룺<%=retCode%>��������Ϣ:<%=retMessage%>",0);
                window.location="f4484_1.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("���÷���s4484Cfmʧ�ܣ�",0);
            window.location="f4484_1.jsp";
        </script>
        <%
        System.out.println("# return from f4484_1.jsp -> Call Service s4484Cfm Failed!");
        e.printStackTrace();
    }
    
%>
</html>