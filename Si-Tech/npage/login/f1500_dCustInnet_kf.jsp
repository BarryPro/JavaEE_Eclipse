<%
/********************
 * version v2.0
 * 开发商: si-tech
 * add by sunbya @ 2013-03-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.* ,java.text.SimpleDateFormat,java.util.*"%>
<%
	String opCode = "1500";
  String opName = "综合信息查询之用户入网信息";

	/*获得Session*/
	String workNo   = (String)session.getAttribute("workNo"); //获得工号
	String iLoginPwd =(String)session.getAttribute("password"); //工号密码
	String phone_no=request.getParameter("phoneNo");
	
	//入参变量
	String iLoginAccept="0"; //流水
	String iChnSource="1";		//渠道标识
	String iOpCode="1500";			//操作代码
	String iLoginNo=workNo;	//操作工号
	String iLoginPwd1=iLoginPwd;		//工号密码
	String iPhoneNo=phone_no; 		//手机号码
	String iUserPwd="";			//手机密码

%>
<wtc:service name="sDcustInnetQry" outnum="12" retcode="oRetCode" routerKey="region">
	<wtc:param value="<%=iLoginAccept%>"/>	
  <wtc:param value="<%=iChnSource%>"/>  
  <wtc:param value="<%=iOpCode%>"/>    
  <wtc:param value="<%=iLoginNo%>"/>   
  <wtc:param value="<%=iLoginPwd1%>"/>  
  <wtc:param value="<%=iPhoneNo%>"/>   
  <wtc:param value="<%=iUserPwd%>"/>    
</wtc:service>
<wtc:array id="result" scope="end"/>

<body>
<FORM method=post name="f1500_dCustInnet">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户入网信息</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="15%">入网时间</td>
          <td width="18%"><%=result[0][0]%>&nbsp;</TD>
          <TD class="blue" width="15%">机器代码</td>
          <td width="18%"><%=result[0][1]%>&nbsp;</TD>
          <TD class="blue" width="15%">入网工号</td>
          <td width="17%"><%=result[0][10]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">手 续 费</td>
          <td><%=result[0][2]%>&nbsp;</TD>
          <TD class="blue">选 号 费</td>
          <td><%=result[0][3]%>&nbsp;</TD>
          <TD class="blue">机 器 费</td>
          <td><%=result[0][4]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">SIM 卡费</td>
          <td><%=result[0][5]%>&nbsp;</TD>
          <TD class="blue">现金交款</td>
          <td><%=result[0][6]%>&nbsp;</TD>
          <TD class="blue">支票交款</td>
          <td><%=result[0][7]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">交款总额</td>
          <td><%=result[0][8]%>&nbsp;</TD>
          <TD class="blue">用户备注</td>
          <td colspan="3"><%=result[0][9]%>&nbsp;</TD>
        </TR>
        <TR>
          <TD class="blue">网点名称</td>
          <td colspan="5"><%=result[0][11]%></TD>
        </TR>
      </TBODY>
    </TABLE>
    <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="close_window();return false;" type=button value=关闭/>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
	<script>
		function close_window(){
			window.close();	
		}	
	</script>
</HTML>