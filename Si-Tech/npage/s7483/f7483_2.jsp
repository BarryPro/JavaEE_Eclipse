<%
    /********************
     * @ OpCode    :  7483
     * @ OpName    :  组合营销集团成员删除
     * @ CopyRight :  si-tech
     * @ Author    :  wangzn
     * @ Date      :  2010-4-28 17:05:29
     * @ Update    :  
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
  String opCode = "7483";
  
  String unit_id = WtcUtil.repNull((String)request.getParameter("unit_id"));
 
  String tmpR1 = WtcUtil.repNull((String)request.getParameter("tmpR1"));
  String tmpR2 = WtcUtil.repNull((String)request.getParameter("tmpR2"));
  String tmpR3 = WtcUtil.repNull((String)request.getParameter("tmpR3"));
  
  String iLoginAccept = WtcUtil.repNull((String)request.getParameter("sysAccept"));
  


  
  System.out.println("#   操作代码 = ["+opCode+"]");
  System.out.println("#   工号     = ["+workNo+"]");
  System.out.println("#   工号密码 = ["+iLoginPwd+"]");
  System.out.println("#   IP地址   = ["+iIpAddr+"]");
  System.out.println("#   iOrgCode = ["+iOrgCode+"]");
  System.out.println("#   集团编号 = ["+unit_id+"]");
  System.out.println("#   手机号码 = ["+tmpR1+"]");
  System.out.println("#   流水     = ["+iLoginAccept+"]");
  //System.out.println("#   客户姓名 = "+tmpR2+"]");
  //System.out.println("#   证件号码 = "+tmpR3+"]");
  

try{
%>
<wtc:service name="s7483Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage"  outnum="4" >
	<wtc:param value="<%=opCode%>"/><!--0-->
	<wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=iLoginPwd%>"/>
  <wtc:param value="<%=iOrgCode%>"/>
  <wtc:param value="<%=iIpAddr%>"/>
  <wtc:param value="<%=unit_id%>"/><!--5-->
  <wtc:param value="<%=tmpR1%>"/> 
  <wtc:param value="<%=iLoginAccept%>"/>   
</wtc:service>
<wtc:array id="result" scope="end" />


<%

if("000000".equals(retCode)){
            String errPhoneList = result[0][2];
            String errMsgList   = result[0][3];
        /* 成功后转到错误展示页面 */
          
        %>
            <script language='jscript'>
                $("#errPhoneList").val("<%=errPhoneList%>");
                $("#errMsgList").val("<%=errMsgList%>");
                
                frm.action="f7483_result.jsp";
              	frm.method="post";
              	frm.submit();
            </script>           
        <%
        }else{
            %>
            <!--wuxy alter 20100313错误信息:retMsg  -->
            <script type=text/javascript>
                rdShowMessageDialog("操作失败！<br/>错误代码：[<%=retCode%>]，错误信息:[<%=retMessage%>]",0);
                window.location="f7483_1.jsp";
            </script>
            <%
        }
    }catch(Exception e){
        %>
        <script type=text/javascript>
            rdShowMessageDialog("调用服务s7983Cfm失败！",0);
            window.location="f7483_1.jsp";
        </script>        
        <%
        System.out.println("# return from f7483_2.jsp -> Call Service s7983Cfm Failed!");
        e.printStackTrace();
    }
    
%>
</html>