<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  	response.setHeader("Pragma","No-cache");
  	response.setHeader("Cache-Control","no-cache");
  	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("GBK");

    String opName = "客户ID信息查询";
    String pageTitle = "客户ID信息查询";
    String fieldNum = "2";
    
    String password = (String)session.getAttribute("password");	
	  String work_no = (String)session.getAttribute("workNo");
	  String ipAddr = (String)session.getAttribute("ipAddr");
	  
	  String id_iccid = (String)request.getParameter("id_iccid");
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
		    window.returnValue = $('input:checked').attr("custId");
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
    </tr>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
<% String ssss = "根据身份证id[" + id_iccid + "]进行查询";%>
  <wtc:service name="sUserCustInfo" outnum="20" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="1211"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddr%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=id_iccid%>"/>
      <wtc:param value=""/>
  </wtc:service>
  
	<wtc:array id="result" scope="end" start="1" length="17"/>
<%
  
  int recordNum = result.length;
 
  if (recordNum > 0 ) {
     for(int i = 0; i < recordNum; i++) {
     
     					String ZSCustName11="";
				
			if(!("").equals(result[i][4].trim())) {
	
			if(result[i][4].trim().length() == 2 ){
				ZSCustName11 = result[i][4].trim().substring(0,1)+"*";
			}
			if(result[i][4].trim().length() == 3 ){
				ZSCustName11 = result[i][4].trim().substring(0,1)+"**";
			}
			if(result[i][4].trim().length() == 4){
				ZSCustName11 = result[i][4].trim().substring(0,2)+"**";
			}
			if(result[i][4].trim().length() > 4){
				ZSCustName11 = result[i][4].trim().substring(0,2)+"******";
			}
		}
		
		
            // System.out.println(" zhouby 1211w " + i + " " + 4 + "=" + result[i][4] );
%>
       <tr>
         <td><input type="radio" name="custId" custId="<%=result[i][0]%>"/></td>
         <td><%=result[i][0]%></td>
         <td><%=ZSCustName11%></td>
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
