<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-07 页面改造,修改样式
     *
     * s2900 名单管理模块需要使用这个页面.
     ********************/
%>
		<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_ajax.jsp" %>
		<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
    //得到输入参数
    String custId = request.getParameter("CUST_ID");
    String grpIdNo = request.getParameter("GRP_ID");
    String idNo = request.getParameter("ID_NO");
    String retType = request.getParameter("retType");
    String inPwd = request.getParameter("inPwd");
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);            

    String retResult  = "false";
    String retCode="000000";
    String retMessage="密码校验成功！";

    String sqlStr = null;
      
    if (custId != null){
    	 sqlStr="select cust_passwd from dCustDoc where cust_id = " + custId;
    }else if (grpIdNo != null){
    	 sqlStr="select USER_PASSWD from dGrpUserMsg where id_no = " + grpIdNo;
    }else if (idNo != null){
  		sqlStr="select USER_PASSWD from dCustMsg where id_no = " + idNo;
  	}else{
  		 retCode="100001";
  		 retMessage="错误的输入参数(CUST_ID、GRP_ID或ID_NO)！";
  	}
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
    retCode = retCode1;
    retMessage= retMsg1;
    int returnCode = retCode==""?999999:Integer.parseInt(retCode);
    if (returnCode==0)
    {
          String cust_passwd = result.length>0?(result[0][0]).trim():"9999999";
          inPwd = Encrypt.encrypt(inPwd);
          if (Encrypt.checkpwd2(cust_passwd,inPwd) == 1)
          {
              retResult = "true";
          }else{
              retResult = "false";
              retMessage="密码校验失败！";
      	  }
   }
%>
		var response = new AJAXPacket();
		var retType = "<%=retType%>";
		var retMessage="<%=retMessage%>";
		var retCode= "<%=returnCode%>";
		var retResult = "<%=retResult%>";
		
		response.data.add("retType",retType);
		response.data.add("retResult",retResult);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		core.ajax.receivePacket(response);
