<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
    String opCode = "2735";
    String opName = "集团客户详单查询";
    
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String iccid=request.getParameter("selected_iccid_no");//证件号码，用于返回时赋值。
  //input param
	String contract_no = request.getParameter("selected_contract_no"); //账号	
	String year_month = request.getParameter("selected_year_month");	  //查询年月
	
	String selectType = request.getParameter("selectType");  //查询类型
	String meetingId = request.getParameter("meetingId");  //会议ID
	String meetingInitiator = request.getParameter("meetingInitiator");  //会议发起人
	String searchType = request.getParameter("searchType");  //时间类型
	String paramsIn1[] = new String[2];
	paramsIn1[0]=contract_no;
	paramsIn1[1]=year_month;
	
	String[][] result = new String[][]{};
	
	ArrayList acceptList = new ArrayList();
	//acceptList = callView.callFXService("sQryGrpBill", paramsIn1, "13");	
    %>
        <wtc:service name="sQryGrpBill" retcode="retCode" retmsg="retMsg" outnum="13" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=paramsIn1[0]%>"/>
        	<wtc:param value="<%=paramsIn1[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
	//callView.printRetValue();
	int recordNum=0;
	String errCode = retCode;
	String errMsg = retMsg;
  //output param
	/*
	String[][] cust_id        = new String[][]{};
	String[][] cust_name      = new String[][]{}; 
	String[][] id_no          = new String[][]{};
	String[][] product_code   = new String[][]{};
	String[][] product_name   = new String[][]{};
	String[][] bill_begin     = new String[][]{};
    String[][] bill_end       = new String[][]{}; 
    String[][] should_pay     = new String[][]{}; 
	String[][] favour_fee     = new String[][]{}; 
	String[][] product_code_1     = new String[][]{}; 
	String[][] product_code_2     = new String[][]{}; 
	String[][] prepay_fee     = new String[][]{}; 
	String[][] owe_fee     = new String[][]{}; 
	*/
	if(!"000000".equals(errCode))
	{
	%>
	<script>
		rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	    history.go(-1);
	</script>
		<%
	}else{
        result = retArr;
        recordNum = retArr.length;
        /*
		cust_id          = (String[][])acceptList.get(0);  
		cust_name        = (String[][])acceptList.get(1); 
		id_no           = (String[][])acceptList.get(2); 
		product_code   = (String[][])acceptList.get(3); 
		product_name   = (String[][])acceptList.get(4); 
		bill_begin     = (String[][])acceptList.get(5); 
		bill_end       = (String[][])acceptList.get(6); 
		should_pay     = (String[][])acceptList.get(7); 
		favour_fee     = (String[][])acceptList.get(8); 
		product_code_1     = (String[][])acceptList.get(9); 
		product_code_2     = (String[][])acceptList.get(10); 
		prepay_fee     = (String[][])acceptList.get(11); 
		owe_fee     = (String[][])acceptList.get(12);
		recordNum =  id_no.length;
		*/ 				
		}
	%>              
                
<html xmlns="http://www.w3.org/1999/xhtml">       
<head>          
<title>集团客户详单列表</title>
<SCRIPT language="JavaScript">
function qry(op_type)
{
	if(op_type=="2")
	{
    document.fPubSimpSel.action="f2735DetQry.jsp?iccid="+"<%=iccid%>"+"&month=<%=year_month%>"+"&cust_id=<%=contract_no%>&selectType=<%=selectType%>&meetingId=<%=meetingId%>&meetingInitiator=<%=meetingInitiator%>&searchType=<%=searchType%> ";
    document.fPubSimpSel.submit();
	 }else{
		var path = "<%=request.getContextPath()%>/npage/s2735/f2735_show.jsp?";
    path = path + "op_type=" + op_type;
    path = path + "&iccid=<%=iccid%>";
    path = path + "&month=<%=year_month%>";
    path = path + "&cust_id=<%=contract_no%>";

		window.open(path,"newwindow2","height=450, width=400,top=50,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}
}
</SCRIPT>
</head>
<BODY>
<FORM method=post name="fPubSimpSel"> 
<%@ include file="/npage/include/header_pop.jsp" %>  
<div class="title">
	<div id="title_zi">集团客户详单列表</div>
</div>
  <table cellspacing="0">
	<TR>
	<TH nowrap>集团客户ID</TH>
	<TH nowrap>集团客户名称</TH>
	<TH nowrap>产品号码</TH>
	<TH nowrap>产品帐号</TH>
	<TH nowrap>产品代码</TH>
	<TH nowrap>产品名称</TH>
	<TH nowrap>开始时间</TH>
	<TH nowrap>结束时间</TH>
	<TH nowrap>应付金额</TH>
	<TH nowrap>优惠金额</TH>
	<TH nowrap>当前剩余金额</TH>
	<TH nowrap>欠费金额</TH>	        
    </TR> 
 
 <% 
	 for (int i = 0;i < recordNum; i++) {
  %>
    <tr> 
      <td align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][9]%></a>
      </td>
		  				<td align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][1]%></a>
      </td>
	          	<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][10]%></a> 
      </td>
      <td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][0]%></a> 
      </td>
		  			<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][3]%></a>
      </td>
		  			<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][4]%></a>
      </td>
	  						<td align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][5]%></a>
      </td>
								<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][6]%></a>
      </td>	  
								<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][7]%></a>
      </td>	  
								<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][8]%></a>
      </td>	  
								<td  align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][11]%></a>
      </td>	  
								<td align="center"><a href="f2735_detail.jsp?s_contract_no=<%=result[i][0]%>&s_year_month=<%=year_month%>&s_id_no=<%=result[i][2]%>"><%=result[i][12]%></a>
      </td>	                            					  
  </tr>
	<% } %>
   </tr>
  </table>

<!------------------------------------------------------>
    <table cellspacing=0>
    <TBODY>
        <TR id='footer'> 
            <TD align=center>
                <input class="b_foot" name=commit onClick="qry('2')" style="cursor:hand" type=button value=详单查询>
                <input class="b_foot" name=commit onClick="qry('4')" style="cursor:hand" type=button value=代付清单 style='display:none;' >
                <input class="b_foot" name=commit onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
    </TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
