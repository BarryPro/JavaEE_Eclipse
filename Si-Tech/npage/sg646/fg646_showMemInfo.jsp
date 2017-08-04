<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 查看家庭成员详细信息
   * 版本: 1.0
   * 日期: 2013-4-30 11:59:21
   * 作者: yansca
   * 版权: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>查看家庭成员详细信息</title>
	<%
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		String masterFlag = request.getParameter("masterFlag");
		String workNo = (String)session.getAttribute("workNo");
	  String passWord = (String)session.getAttribute("passWord");
	  String groupId = (String)session.getAttribute("groupId");
	  String regionCode=(String)session.getAttribute("regCode");
		String opName = "查看家庭成员详细信息";
	%>
<body>
<form id="frmg646" name="frmg646" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
<wtc:service name="sG645QryMemInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5">
	  <wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>
<%
    if("000000".equals(retCode)){
        if(retList.length > 0) {
%>
<form  name="frm" method="POST">
<div class="title">
		<div id="title_zi">成员信息</div>
</div>
<table cellspacing="0">
	   
     <tr>
     	    <td class="blue"> 
               <div align="left">成员名称：</div>
          </td>
          <td> 
               <input id="custName"  name="custName" value="<%=retList[0][0]%>" readonly />
          </td>
     	    <td class="blue"> 
               <div align="left">成员号码：</div>
          </td>
          <td> 
               <input id="phoneNo"  name="phoneNo" value="<%=retList[0][2]%>" readonly />
          </td>
     </tr>
     <tr>
     	    <td class="blue"> 
               <div align="left">号码品牌：</div>
          </td>
          <td> 
          	   <select id="smCode" name="smCode" disabled="disabled">
                  <wtc:pubselect name="sPubSelect" outnum="2" retcode="ret" retmsg="retm" routerKey="region" routerValue="<%=regionCode%>">
                          <wtc:sql>select distinct(SM_CODE),trim(SM_NAME) from sSmCode order by SM_CODE</wtc:sql>
                  </wtc:pubselect>
                  <wtc:iter id="rows" indexId="i">
                          <%if (rows[0].equals(retList[0][1])) {%>
                                <option selected="selected" value="<%=rows[0]%>">
                                	    <%=rows[0]%>---><%=rows[1]%>
                                </option>
                         <%} else {%>
                                 <option value="<%=rows[0]%>">
                                 	     <%=rows[0]%>--><%=rows[1]%>
                                 </option>
                         <%}%>
                  </wtc:iter>
               </select>
          </td>
     	     <td class="blue"> 
               <div align="left">家庭角色：</div>
          </td>
          <td> 
               <input id="homeRole" name="homeRole" value="<%if ("0".equals(masterFlag)) {%>成员<%} else {%>责任人<%}%>" readonly />
          </td>
     </tr>
</table>
 <table cellSpacing="0">
        <tr> 
          <td id="footer" >
			        <input class="b_foot"  id="b_close" name="b_close"    onclick="javascript:window.close();" type="button" value="关闭" />
			    </td>
        </tr>
 </table>
</form>
<%}}%>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
