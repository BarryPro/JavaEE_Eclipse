<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
    String opCode = "1556";
    String opName = "明细帐单查询";

    response.setHeader("Pragma", "No-Cache");
    response.setHeader("Cache-Control", "No-Cache");
    response.setDateHeader("Expires", 0);

		String workno = (String)session.getAttribute("workNo");
    String in_query_type = request.getParameter("query_type");
    String in_phoneno = request.getParameter("phone_no");
    String in_contract_no = request.getParameter("contract_no");
    String in_begin_time = request.getParameter("begin_time");
    String in_end_time = request.getParameter("end_time");
    String in_bill_type = request.getParameter("bill_type");

    Date date = new Date();
    String todayyearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

    if (in_query_type == null) {
        in_query_type = "2";
    }

    if (in_begin_time == null) {
        in_begin_time = todayyearmonth.substring(0, 6) + "01";
        in_end_time = todayyearmonth;
    }

    String bill_typename = "";
    if (in_bill_type.equals("1")) {
        bill_typename = "帐单明细";
    } else {
        bill_typename = "未出帐明细";
    }

    String[] inParas1 = new String[3];
    
	inParas1[0] = "select to_char(id_no) from dcustmsg where phone_no = '"+ in_phoneno +"'";
	inParas1[1] = "select to_char(user_passwd) from dcustmsg where phone_no  = '"+ in_phoneno +"'";
	inParas1[2] = "select to_char(password) from dloginmsg where login_no = '"+ workno +"'";
%>    
		<wtc:pubselect name="TlsPubSelBoss" outnum="1">
		<wtc:sql><%=inParas1[0]%></wtc:sql>
		</wtc:pubselect>
		 <wtc:array id="result" scope="end"/> 
		
<%
    String idNo = "";
    if (retCode.equals("000000")) {
        if (result != null) {
            if (result.length > 0) {
                idNo = result[0][0];
            }
        }
    }%>
    
    
   <!-- =================================取用户密码以及工号密码 add by zhangyta at 20120428 Begin============================================ -->  
		<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=in_phoneno%>"  retcode="retCode1" retmsg="retMsg3" outnum="1">
		<wtc:sql><%=inParas1[1]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result4" scope="end"/> 
    <%
    String user_pass = "";
    if (retCode.equals("000000")) {
        if (result4 != null) {
            if (result4.length > 0) {
                user_pass = result4[0][0];
            }
        }
    }%>
    
    
			<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=in_phoneno%>"  retcode="retCode1" retmsg="retMsg4" outnum="1">
		<wtc:sql><%=inParas1[2]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result5" scope="end"/> 
    <%
    String login_pass = "";
    if (retCode.equals("000000")) {
        if (result5 != null) {
            if (result5.length > 0) {
                login_pass = result5[0][0];
            }
        }
    }
%>
<!-- =================================取用户密码以及工号密码 add by zhangyta at 20120428 End============================================ -->


<%
    String inParas[] = new String[8];
    inParas[0] = in_query_type;
    inParas[1] = in_phoneno;
    inParas[2] = in_begin_time;
    inParas[3] = in_end_time;
    inParas[4] = in_bill_type;
    inParas[5] = in_contract_no;
    inParas[6] = workno;
    inParas[7] = opCode;
%>
<wtc:service name="s1524_Qry" routerKey="phone" routerValue="<%=in_phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="24">
    <wtc:param value="<%=inParas[0]%>"/>
    <wtc:param value="<%=inParas[1]%>"/>
    <wtc:param value="<%=inParas[2]%>"/>
    <wtc:param value="<%=inParas[3]%>"/>
    <wtc:param value="<%=inParas[4]%>"/>
    <wtc:param value="<%=inParas[5]%>"/>
    <wtc:param value="<%=inParas[6]%>"/>
    <wtc:param value="<%=inParas[7]%>"/>
</wtc:service>
<wtc:array id="result1" start="0" length="2" scope="end"/>
<wtc:array id="result2" start="2" length="6" scope="end"/>
<wtc:array id="result3" start="8" length="3" scope="end"/>
<wtc:array id="result7" start="23" length="1" scope="end"/>

	
<!--xl add 他人代付 begin-->
<wtc:service name="s1500AgtPayQry" routerKey="phone" routerValue="<%=in_phoneno%>" retcode="retCode2" retmsg="retMsg2" outnum="6" >
	<wtc:param value="<%=in_phoneno%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=in_begin_time%>"/>
	<wtc:param value="<%=in_end_time%>"/>
</wtc:service>
<wtc:array id="result_agt" scope="end"/>
<%
	String return_code_agt=retCode2;
	String return_msg_agt=retMsg2;
	String agt_type="";
	String agt_phone="";
	String agt_begin="";
	String agt_end="";
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa s1500AgtPayQry return_code_agt is "+return_code_agt+" and return_msg_agt is "+return_msg_agt+" and result_agt.length is "+result_agt.length);
	if(!return_code_agt.equals("000000"))
	{
		System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCCC 查询报错是否展示?");
		agt_type="无";
		agt_phone="无";
		agt_begin="无";
		agt_end="无";
		
	}
	else
	{
		//agt_type=result_agt[0][0];
		//agt_phone=result_agt[0][1];
		//agt_begin=result_agt[0][2];
		//agt_end=result_agt[0][3];
	}
%>
<!--xl add 他人代付 end--> 




<%
    //CallRemoteResultValue value = viewBean.callService("2",in_phoneno,"s1524_Qry","11",lens,inParas);
    String record_num = result1.length > 0 ? result1[0][0] : "";
    String return_code = result1.length > 0 ? result1[0][1] : "";
    String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<% 
	if (!return_code.equals("000000")  ) {
%>

		<script language="JavaScript">
		    rdShowMessageDialog("明细帐单查询失败! ", 0);
			var locations = "s1556.jsp?activePhone=<%=in_phoneno%>&opCode=c&opName=<%=opName%>";
			alert(locations);
		    window.location =locations;// "s1556.jsp?activePhone=<%=in_phoneno%>&opCode=c&opName=<%=opName%>";
		</script>
<% 
	} else { 
%>
<HTML>
<HEAD>
    <TITLE>黑龙江BOSS-明细帐单查询</TITLE>
    <META content="text/html; charset=GBK" http-equiv=Content-Type>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM  method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">帐单类型  <%=bill_typename%> </div>
	</div>  
    <table cellspacing="0">
        <tr align="center">
            <th>帐单年月</th>
            <th>费用名称</th>
            <th>应收</th>
            <th>优惠</th>
            <th>帐单帐目项</th>
        </tr>

        <%
        	String tbclass="";
            for (int i = 0; i < result2.length; i++) {
            	tbclass = (i%2==0)?"Grey":"";
        %>
        <tr align="center">
            <td width="22%" class="<%=tbclass%>" nowrap><%=result2[i][0]%>
            </td>
            <td width="22%" class="<%=tbclass%>" nowrap><%=result2[i][2]%>
            </td>
            <td width="22%" class="<%=tbclass%>" nowrap><%=result2[i][3]%>
            </td>
            <td width="22%" class="<%=tbclass%>" nowrap><%=result2[i][4]%>
            </td>
            <td width="22%" class="<%=tbclass%>" nowrap><%=result2[i][5]%>
            </td>
        </tr>
        <% } %>

        <tr>
            <td width="22%" colspan="2" nowrap>总应收：<%=result3[0][0]%>
            </td>
            <td width="22%" colspan="2" nowrap>总优惠：<%=result3[0][1]%>
            </td>
            <td width="22%" colspan="2" nowrap>总费用：<%=result3[0][2]%>
            </td>
        </tr>
    </table>
    
	<table cellspacing="0">
	  <div class="title">
			<div id="title_zi">代付信息</div>
	  </div>
	   <tr align="center"> 
			<th>代付类型</th>
			<th>代付号码</th>            
			<th>开始时间</th>
			<th>结束时间</th>
			<th>账务年月</th>
			<th>代付金额</th>
			</tr>
			<%
				for(int i=0;i<result_agt.length;i++)
				{
					%>
						<tr>
							<td><%=result_agt[i][0]%></td>
							<td><%=result_agt[i][1]%></td>
							<td><%=result_agt[i][2]%></td>
							<td><%=result_agt[i][3]%></td>
							<td><%=result_agt[i][4]%></td>
							<td><%=result_agt[i][5]%></td>
						</tr>
					<%
				}
			%>
	</table>


    <table>
        <tr>
            <td id="footer">
                <input class="b_foot" name=reset type=reset value=返回 onclick="JavaScript:history.go(-1)">&nbsp;
                <input class="b_foot" name=sure type=button value=关闭 onclick="removeCurrentTab();">&nbsp;
                <a href="f1500_sPubCustBillDet1.jsp?idNo=<%=idNo%>&opFlag=1556">详细资费信息查询</a>
            </td>
        </tr>
    </table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<% 
	} 
%>
