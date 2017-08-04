<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
    String opCode = "2735";
    String opName = "集团客户详单查询";
    
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    //input param
	String contract_no = request.getParameter("s_contract_no"); //账号	
	String year_month = request.getParameter("s_year_month");	  //查询年月
	String id_no = request.getParameter("s_id_no");    
		
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String paramsIn1[] = new String[3];
	paramsIn1[0]=contract_no;
	paramsIn1[1]=id_no;
	paramsIn1[2]=year_month;
	String[][] result=new String[][]{};
	      		
	
	ArrayList acceptList = new ArrayList();
	
	//acceptList = callView.callFXService("sQryGrpBillDet", paramsIn1, "11");	
    %>
        <wtc:service name="sQryGrpBillDet" retcode="retCode" retmsg="retMsg" outnum="11" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=paramsIn1[0]%>"/>
        	<wtc:param value="<%=paramsIn1[1]%>"/> 
        	<wtc:param value="<%=paramsIn1[2]%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
	//callView.printRetValue();              
	int recordNum=0;
	String errCode = retCode;
	String errMsg = retMsg;
        //output param
	/*
	String[][] product_code      = new String[][]{};
	String[][] product_name       = new String[][]{}; 
	String[][] bill_flag          = new String[][]{};
	String[][] grp_pack_code     = new String[][]{};
	String[][] grp_pack_name     = new String[][]{};
	String[][] grp_fee_code     = new String[][]{};
    String[][] grp_fee_name     = new String[][]{}; 
    String[][] grp_detail_code    = new String[][]{}; 
	String[][] grp_detail_name    = new String[][]{}; 
	String[][]   should_pay       = new String[][]{};  
	String[][]    favour_fee       = new String[][]{};    
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
		product_code         = (String[][])acceptList.get(0);  
		product_name         = (String[][])acceptList.get(1); 
		bill_flag           = (String[][])acceptList.get(2); 
		grp_pack_code      = (String[][])acceptList.get(3); 
		grp_pack_name      = (String[][])acceptList.get(4); 
		grp_fee_code       = (String[][])acceptList.get(5); 
		grp_fee_name       = (String[][])acceptList.get(6); 
		grp_detail_code    = (String[][])acceptList.get(7); 
		grp_detail_name    = (String[][])acceptList.get(8); 
		should_pay       =  (String[][])acceptList.get(9);    
	    favour_fee      =  (String[][])acceptList.get(10);   
	  	recordNum=product_code.length;
	    */
		
		}
	%>              
                
<html xmlns="http://www.w3.org/1999/xhtml">        
<head>          
<title>集团客户详单查询</title>
<SCRIPT language="JavaScript">
</SCRIPT>
</head>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>  
<div class="title">
	<div id="title_zi">详单明细</div>
</div>
<table cellspacing="0">
    <tr>
    	<TH>产品代码ID</TH>
    	<TH>产品名称</TH>
    	<TH>帐单类型</TH>
    	<TH>集团代码</TH>
    	<TH>集团名称</TH>
    	<TH>费用代码</TH>
    	<TH>费用名称</TH>
        <TH>详细代码</TH>   
    	<TH>详细名称</TH>  
    	<TH>应付金额</TH>
    	<TH>优惠金额</TH>
    </TR> 

<% 
for (int i = 0;i < recordNum; i++) {
%>
    <tr> 
        <td align="center" ><%=result[i][0]%>
        </td>
        <td align="center"><%=result[i][1]%>
        </td>
        <td align="center"><%=result[i][2]%>
        </td>
        <td align="center"><%=result[i][3]%>
        </td>
        <td align="center"><%=result[i][4]%>
        </td>
        <td align="center"><%=result[i][5]%>
        </td>
        <td align="center"><%=result[i][6]%>
        </td>	  
        <td align="center"><%=result[i][7]%>
        </td>	  
        <td align="center"><%=result[i][8]%>
        </td>	  
        <td align="center"><%=result[i][9]%>
        </td>	  
        <td align="center"><%=result[i][10]%>
        </td>	  
    </tr>
<% } %>
</table>


<!------------------------------------------------------>
<table cellspacing=0>
    <TBODY>
        <TR id='footer'> 
            <TD>

		<input class="b_foot" name=back onClick="JavaScript:history.go(-1)" style="cursor:hand" type=button value=返回>   
                <input class="b_foot" name=commit onClick="window.close()" style="cursor:hand" type=button value=关闭>
            </TD>
        </TR>
    </TBODY>
    </TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
