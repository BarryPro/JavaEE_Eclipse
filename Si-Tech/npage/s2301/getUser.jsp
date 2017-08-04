<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
String phoneNo = request.getParameter("phoneNo");
String idType = request.getParameter("idType");
String sql = "select belong_code,op_time,org_code,login_no,op_code,op_note from wlocalblacklist where black_no='"+phoneNo+"' and black_type='"+idType+"'";
%>

<wtc:pubselect name="sPubSelect" outnum="6">
  <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="userInfo" scope="end">
</wtc:array>

var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
<%
if(userInfo.length == 0){
%>
    response.data.add("backString","");
    response.data.add("flag","11");
    response.data.add("errCode","");
    response.data.add("errMsg","");
<%
}else{
    String strArray = CreatePlanerArray.createArray("userInfo",userInfo.length);
%>
    <%=strArray%>
<%

for(int i = 0 ; i < userInfo.length ; i ++){
      for(int j = 0 ; j < userInfo[i].length ; j ++){
%>
          userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>";
<%
      }
}
%>
    response.data.add("backString", userInfo);
    response.data.add("flag","12");
    response.data.add("errCode","");
    response.data.add("errMsg","");
<%
}
%>

core.ajax.receivePacket(response);