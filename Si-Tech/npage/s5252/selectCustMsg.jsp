<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  	response.setHeader("Pragma","No-cache");
  	response.setHeader("Cache-Control","no-cache");
  	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("GBK");

    String opName = "客户信息查询";
    String pageTitle = "客户信息查询";
    
    String password = (String)session.getAttribute("password");	
    String work_no = (String)session.getAttribute("workNo");
    String ipAddr = (String)session.getAttribute("ipAddr");
  
    String iIdIccid = WtcUtil.repNull((String)request.getParameter("iIdIccid"));
    String iCustName  = WtcUtil.repNull((String)request.getParameter("custName"));
    
    System.out.println(" zhouby 5252 " + iCustName);
	  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
  <TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
  <META content=no-cache http-equiv=Pragma>
  <META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
function saveTo(){
        var length = $('input:checked').length;
    
		if(length <= 0){
		    rdShowMessageDialog("请选择信息项！",0);
		    return false;
		} else {
		    var obj = {};
		    
		    obj.in0 = $('input:checked').attr("in0");
		    obj.in1 = $('input:checked').attr("in1");
		    obj.in2 = $('input:checked').attr("in2");
		    obj.in3 = $('input:checked').attr("in3");
		    obj.in4 = $('input:checked').attr("in4");
		    obj.in5 = $('input:checked').attr("in5");
		    obj.in6 = $('input:checked').attr("in6");
		    obj.in7 = $('input:checked').attr("in7");
		    
		    window.returnValue = obj;
		    window.close();
		}
}

</SCRIPT>
</HEAD>
<body style="overflow-x:hidden">
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查询结果</div>
	</div>
	
  <table cellspacing="0" id="tabData">
    <tr>
      <td class="blue">选择</td>
      <td class="blue">客户ID</td>
      <td class="blue">客户名称</td>
      <td class="blue">开户时间</td>
      <td class="blue">证件类型</td>
      <td class="blue">证件号码</td>
      <td class="blue">客户地址</td>
      <td class="blue">归属代码</td>
      <td class="blue">客户密码</td>
    </tr>
    
      <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>

      <wtc:service name="sCustTypeQryA" outnum="8" >
          <wtc:param value="<%=loginAccept%>"/>
          <wtc:param value="01"/>
          <wtc:param value="5252"/>
          <wtc:param value="<%=work_no%>"/>
          <wtc:param value="<%=password%>"/>
          <wtc:param value=""/>
          <wtc:param value=""/>
          <wtc:param value="<%=iCustName%>"/>
          <wtc:param value="<%=iIdIccid%>"/>
      </wtc:service>
  
	  <wtc:array id="result" scope="end"/>
<%
  
  int recordNum = result.length;
 
  if (recordNum > 0 ) {
     for(int i = 0; i < recordNum; i++) {
%>
       <tr>
         <td>
           <input type="radio" name="xxx"
             in0="<%=result[i][0]%>"
             in1="<%=result[i][1]%>"
             in2="<%=result[i][2]%>"
             in3="<%=result[i][3]%>"
             in4="<%=result[i][4]%>"
             in5="<%=result[i][5]%>"
             in6="<%=result[i][6]%>"
             in7="<%=result[i][7]%>"
           />
         </td>
         <td><%=result[i][0]%></td>
         <td><%=result[i][1]%></td>
         <td><%=result[i][2]%></td>
         <td><%=result[i][3]%></td>
         <td><%=result[i][4]%></td>
         <td><%=result[i][5]%></td>
         <td><%=result[i][6]%></td>
         <td><%=result[i][7]%></td>
       </tr>
<%
     }
 }
%>
  </table>

  <TABLE cellspacing="0">
    <TR>
      <TD id="footer">
        <input name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=确认>&nbsp;
        <input name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=返回>&nbsp;
      </TD>
    </TR>
  </TABLE>
  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body></HTML>
