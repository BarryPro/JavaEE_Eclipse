<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.18
 模块:EC产品订购
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    //得到输入参数
    String phone_no = "13904510288";
    String regCode = (String)session.getAttribute("regCode");
    String Pwd1 = "800313";
    String[][] result = new String[][]{};
    String retResult  = "false";
    String retCode="000000";
    String retMessage="密码校验成功！";
    String cust_passwd="";
    String sqlStr = "";
    String [] paraIn = new String[2];
    sqlStr = "select user_passwd from dCustMsg where phone_no = :vphone_no and substr(run_code,2,1) < 'a'";
    paraIn[0] = sqlStr;
    paraIn[1]="vphone_no="+phone_no;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="02" retcode="retCode1" retmsg="retMsg1" outnum="1" >
  <wtc:param value="<%=paraIn[0]%>"/>
  <wtc:param value="<%=paraIn[1]%>"/>
</wtc:service>
<wtc:array id="resultList" scope="end"/>

<%
  result = resultList;
  cust_passwd = (result[0][0]).trim();
  Pwd1 = Encrypt.encrypt(Pwd1);
  Pwd1=Pwd1.trim();
  if (Encrypt.checkpwd2(cust_passwd,Pwd1) == 1)
    retResult = "true";
%>
check Result <%=retResult%>
