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
    String opCode = "6995";
    String opName = "特服费用查询";

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
	    bill_typename = "帐单历史明细";
	} else {
	    bill_typename = "帐单未出帐明细";
	}

    String[] inParas1 = new String[1];
    
	inParas1[0] = "select id_no from dcustmsg where phone_no = '"+ in_phoneno +"'";
%>    
		<wtc:pubselect name="sPubSelect" outnum="1">
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
    }
%>
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
<wtc:service name="s1524_Qry" routerKey="phone" routerValue="<%=in_phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
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
<%
    //CallRemoteResultValue value = viewBean.callService("2",in_phoneno,"s1524_Qry","11",lens,inParas);
    String record_num = result1.length > 0 ? result1[0][0] : "";
    String return_code = result1.length > 0 ? result1[0][1] : "";
    String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<% 
	if (!return_code.equals("000000")) {
%>
		<script language="JavaScript">
		    rdShowMessageDialog("明细帐单查询失败! ", 0);
		    window.location = "f6995_1.jsp?activePhone=<%=in_phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
		<div id="title_zi"><%=bill_typename%> </div>
	</div>  
    <table cellspacing="0">
        <tr>
            <th>帐单年月</th>
            <th>批次</th>
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
        <tr>
            <td class="<%=tbclass%>" nowrap><%=result2[i][0]%>
            </td>
            <td class="<%=tbclass%>" nowrap><%=result2[i][1]%>
            </td>
            <td class="<%=tbclass%>" nowrap><%=result2[i][2]%>
            </td>
            <td class="<%=tbclass%>" nowrap><%=result2[i][3]%>
            </td>
            <td class="<%=tbclass%>" nowrap><%=result2[i][4]%>
            </td>
            <td class="<%=tbclass%>" nowrap><%=result2[i][5]%>
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
    <table>
        <tr>
            <td id="footer">
                <input class="b_foot" name=reset type=reset value=返回 onclick="JavaScript:history.go(-1)">&nbsp;
                <input class="b_foot" name=sure type=button value=关闭 onclick="removeCurrentTab();">&nbsp;
                <!-- <a href="f1500_sPubCustBillDet1.jsp?idNo=<%=idNo%>&opFlag=6995">详细资费信息查询</a> -->
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
