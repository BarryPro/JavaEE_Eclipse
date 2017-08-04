<%
/********************
 version v2.0
 开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%
  response.setDateHeader("Expires", 0);
%>
<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String regionCode = (String)session.getAttribute("regCode");
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

  String custname="";
  
  String work_no = (String)session.getAttribute("workNo");
  String loginPwd    = (String)session.getAttribute("password");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String notestr="根据phoneNo==["+activePhone+"]进行查询";
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=work_no%>"/>	
  <wtc:param value="<%=loginPwd%>"/>		
  <wtc:param value="<%=activePhone%>"/>	
  <wtc:param value=""/>
  <wtc:param value="<%=ipAddr%>"/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result2" start="1" length="5" scope="end"/>

		<%
		  if("000000".equals(RetCode1)){
        if(result2.length>0){
          if("00".equals(returnFlag[0][0])){
            custname = result2[0][4];
          }
        }
      }else{
 	%>
 	<script language="javascript">
 	rdShowMessageDialog("错误代码：" + RetCode1 + "，错误信息：" + RetMsg1,0);
 	removeCurrentTab()；
 	</script>
 	<%
	}
	%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<script language="JavaScript">

   function printCommit() {
  	frm.submit();
	  return true;
   }

</script>


</head>


<body>
<form name="frm" action = "fe382_1.jsp" method="post"    >
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0" >
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="phoneNo" type="text"   id="phoneNo" value="<%=activePhone%>"  Class="InputGrey" readonly>
			</td>
		    <td class="blue">客户姓名</td>
            <td>
			  <input name="bp_name" type="text"   id="bp_name" value="<%=custname%>"  Class="InputGrey" readonly>
			</td>
          </tr>

		  <tr >

            <td colspan="4"> <div align="center">
                &nbsp;
			       	<input name="next" id="next" type="button" class="b_foot"   value="确定" onClick="printCommit()" >
                &nbsp;
                <input name="back" onClick="removeCurrentTab();" type="button" class="b_foot"  value="关闭">
                &nbsp;

				</div>
			</td>
          </tr>
      </table>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" id="opName" value="<%=opName%>">
    <input type="hidden" name="activePhone" id="activePhone" value="<%=activePhone%>">
		
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>


