<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
	  String workno=(String)session.getAttribute("workNo");    //工号	  
	  String opCode = "zg38";
    String opName = "集团包年账户余额查询";
	  String unitid = request.getParameter("unitid");	  
	  String ret_val_new[][];
	  String[] inParas2 = new String[2];
		//inParas2[0]=" select to_char(b.bank_cust),to_char(b.contract_no),to_char(f.phone_no) ,to_char(e.offer_name),b.prepay_fee from dconusermsg a ,dconmsg b,dgrpusermsg c,dgrpcustmsg d ,product_offer e,dcustmsg f "
 		//						+" where a.contract_no=b.contract_no and a.id_no=c.id_no and c.cust_id=d.cust_id and c.product_code=e.offer_id and c.id_no=f.id_no "
 		//						+" and b.account_type='1' "
   	//						+" and a.bill_order!='99999999' and d.unit_id= :unitid";
   							
   							
   	inParas2[0]="	select to_char(bankcust),to_char(phone_no),to_char(e.offer_name),to_char(contractno),prepayfee from (select bankcust,contractno,f.phone_no,prepayfee,productcode from ( "
								+" select c.id_no as idno,b.bank_cust as bankcust,b.contract_no as contractno,b.prepay_fee as prepayfee ,c.product_code as productcode "
								+" from dconusermsg a ,dconmsg b,dgrpusermsg c,dgrpcustmsg d ,product_offer e "
 								+" where a.contract_no=b.contract_no and a.id_no=c.id_no and c.cust_id=d.cust_id and c.product_code=e.offer_id "
   							+" and a.bill_order!='99999999' and d.unit_id= :unitid and b.account_type='1' "
   							+" ) left join dcustmsg f on  idno=f.id_no )left join product_offer e on e.offer_id=productcode ";

		inParas2[1]="unitid="+unitid;
%>
	<wtc:service name="TlsPubSelBoss"   retcode="retCode" retmsg="retMsg" outnum="5">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
	if(ret_val==null||ret_val.length==0)
	{
%>
			<script language="javascript">
				rdShowMessageDialog("查询结果为空,请重新查询！");
				window.location.href='zg38_1.jsp';
			</script>
<%
	}
	else
	{
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团包年账户余额查询</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
<div id="title_zi">集团包年账户余额查询</div>
</div>
<div id="Operation_Table">
<table cellspacing="0" id = "PrintA">
  <tr>         			
			<th>集团用户名称</th>
			<th>产品号码</th>
			<th>产品名称</th> 
			<th>包年账号</th> 
			<th>包年费用余额</th> 
				  
  </tr>
			<%
				for(int i=0;i<ret_val.length;i++)
				{
			%>
						<tr>
							<td><%=ret_val[i][0]%></td>
							<td><%=ret_val[i][1]%></td>
							<td><%=ret_val[i][2]%></td>
							<td><%=ret_val[i][3]%></td>
							<td><%=ret_val[i][4]%></td>
						</tr>
			<%
				}	
			%>
</div>			
         
          <tr id="footer"> 
      	    <td colspan="11">
    	      <input class="b_foot" name=back onClick="window.location = 'zg38_1.jsp' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
    	    	</td>
          </tr>
          
      </table>
      <tr id="footer"> 
   		</tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
		}
%>	  
    
