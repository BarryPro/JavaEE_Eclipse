<%
/********************
 version v2.0
开发商: si-tech
功能:综合信息查询之预存分类信息
update:anln@2009-1-12
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//输入参数 用户ID、手机号码、操作工号、操作员、角色、部门。
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String opCode = "1550";
	String opName = "综合历史信息查询之预存分类信息";
	String org_Code = (String)session.getAttribute("orgCode");  //归属代码		
	String sql_str="select pay_name,prepay_fee,last_prepay,add_prepay,live_flag,allow_pay,begin_dt,end_dt from dConMsgPreDead a,sPayType b where a.pay_type=b.pay_type and a.contract_no="+contract_no;
	
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_Code%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%	
	if(!retCode1.equals("000000")){
	%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("查询结果为空,没有符合条件的数据!");
	</script>
<%
		return;
	}
%>

<HTML>
	<HEAD>
		<TITLE>预存分类信息</TITLE>	
	</HEAD>
<body>
<FORM method=post name="f1550_dConMsgPre">
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">预存分类信息</div>
			</div>
  
      <table cellspacing="0" >        
              <TBODY>
                <TR>
                  <th>帐户科目</th>
                  <th>预存款</th>
                  <th>上次预存</th>
                  <th>本期发生</th>
                  <th>活动标志</th>
                  <th>允许付款 </th>
                  <th>开始日期</th>
                  <th>结束日期</th>
                </TR>
<%	      for(int y=0;y<result.length;y++){
%>
	        <tr>
<%    	        for(int j=0;j<result[0].length;j++){
%>
	          <td><%= result[y][j]%></td>
<%	        }
%>
	          </tr>
<%	      }
%>
              </TBODY>
	    </TABLE>   
      <table cellspacing="0">
      
	    <tr> 
	    	<td id="footer"> 
		    	<input class="b_foot" name=back onClick="history.go(-1)" type=button value="  返  回  ">
		        <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  关  闭  ">
		        &nbsp; 
	   	</td>
	    </tr>
  </table>
  <%@ include file="/npage/include/footer.jsp" %>

</FORM>
</BODY></HTML>
