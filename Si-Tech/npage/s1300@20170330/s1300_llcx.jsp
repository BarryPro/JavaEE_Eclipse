<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String result[][];
	String opCode = "1302";
	String opName="账号缴费";
	String phone_no  = request.getParameter("phone_no");
  
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	//sFavSumMsg s5186FavMsg
	//流量信息查询的
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String workno = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String  inputParsm1 [] = new String[5];
	inputParsm1[0] = workno;
	inputParsm1[1] = nopass;
	inputParsm1[2] = opCode;
	inputParsm1[3] = phone_no;
	inputParsm1[4] = dateStr;
	int rownum0 = 0;
%>
	<wtc:service name="sFavSumMsg" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=phone_no%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />

	<wtc:service name="s5186FavMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="17" >
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
	</wtc:service>
	<wtc:array id="cussidArr1" scope="end" start="0"  length="6"/> 
	<wtc:array id="cussidArr2" scope="end" start="6"  length="6"/>
	<wtc:array id="cussidArr3" scope="end" start="12"  length="3"/>
	<wtc:array id="cussidArr4" scope="end" start="15"  length="1"/>
	<wtc:array id="cussidArr5" scope="end" start="16"  length="1"/>
<%
    if(cussidArr1!=null&&cussidArr1.length>0){
		rownum0 = cussidArr3.length;
	}
	
	
	result=result1;
	 


	//System.out.println("sql_str="+sql_str);

	int result_row = result.length;
	if (result_row==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("没有查询到用户DOU信息记录!");
	history.go(-1);
</script>
<%	
	return;
	}
%>

<HTML><HEAD><TITLE>流量信息</TITLE>
</HEAD>
<body>
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户流量明细信息</div>
		</div>
    <TABLE cellSpacing="0">
      <TBODY>
        <tr align="center">
          
        
        </TR>
	        <tr>
				 <td>用户DOU值：<%=result[0][0]%></td>
	        </tr>
  
		<%
		for(int i =0;i<rownum0;i++)
		{
				%>
				<tr>
					<td colspan=4>
					【套餐名称<%=i+1%>】: <%=cussidArr3[i][0]%>&nbsp;&nbsp;&nbsp;&nbsp;
					应优惠流量为:<%=cussidArr3[i][1]%>,&nbsp;&nbsp;&nbsp;&nbsp;
					剩余流量为:<%=cussidArr3[i][2]%>;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<%
		}
		%>
        </TBODY>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp;
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
   </DIV>
</DIV>
</FORM>
</BODY></HTML>
