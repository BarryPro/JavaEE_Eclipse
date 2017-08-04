<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
		String phoneNo = request.getParameter("phoneNo");
		String contractno = request.getParameter("contractno");
		String yearmonth = request.getParameter("yearmonth");//8位
		String op_code = request.getParameter("op_code");

    String workno = (String)session.getAttribute("workNo");
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
		String sqlStr = null;
    if (op_code.equals("1300"))
    {
    sqlStr = "select  to_char(max(login_accept)) from wpay"+yearmonth.substring(0,6)+" where contract_no = "+contractno+" and op_code = '"+op_code+"' and total_date="+yearmonth+" and login_no = '"+workno+"' and back_flag = '0' group by contract_no";
    }
    else if (op_code.equals("1304"))
    {
    sqlStr = "select to_char(max(login_accept)) from wpay"+yearmonth.substring(0,6)+" where contract_no = "+contractno+" and op_code = '"+op_code+"' and total_date="+yearmonth+" and login_no = '"+workno+"' and back_flag = '0' group by contract_no";
    }
    else if (op_code.equals("1302")||op_code.equals("1306"))
    {
    sqlStr = "select   to_char(max(login_accept)) from wpay"+yearmonth.substring(0,6)+" where contract_no = "+contractno+" and op_code = '"+op_code+"' and total_date="+yearmonth+" and login_no = '"+workno+"' and back_flag = '0' group by contract_no";
    }	
    else
    {
    sqlStr = "select  to_char(max(login_accept)) from wpay"+yearmonth.substring(0,6)+" where contract_no = "+contractno+" and phone_no = '"+phoneNo+"' and op_code = '"+op_code+"' and total_date="+yearmonth+" and login_no = '"+workno+"' and back_flag = '0' group by contract_no";
    }		

     System.out.println("%%%%%sqlStrsqlStrsql%%%StrsqlStrsqlStr%%%%%="+sqlStr);
	   //CallRemoteResultValue value =  viewBean.callService("0",null,"sPubSelect","1", inParas); 
%>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />

<script language="JavaScript">

<%
	if(result==null||result.length==0)
	{
   %>
		  window.close();
<%
	}
	else
	{
%>
		window.returnValue="<%=result[0][0].trim()%>";
		window.close(); 
<%
    }
%>
    
</script>
