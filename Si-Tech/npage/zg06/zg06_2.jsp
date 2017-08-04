<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zg06";
    String opName = "集团产品余额提醒阀值设置";
	String org_code = (String)session.getAttribute("orgCode");
	String unit_id = request.getParameter("unit_id");
	String id_no = request.getParameter("id_no");
	String product_name2 = request.getParameter("product_name2");
	String[] inParas2 = new String[2];
	inParas2[0]="select f.group_name,g.group_name,to_char(a.unit_id),a.unit_name,to_char(b.account_id),h.bank_cust,to_char(h.prepay_fee),c.name,to_char(nvl(j.thres_value,10)),to_char(j.login_accept) from dgrpcustmsg  a ,dgrpusermsg b,dgrpmanagermsg c, dchngroupinfo d,dchngroupinfo e, dchngroupmsg f,dchngroupmsg g,dconmsg h,dthres_cfg j where a.cust_id = b.cust_id and a.unit_id=:unit_id and b.id_no=:id_no and a.service_no = c.service_no and b.account_id = j.account_id(+) and b.account_id=h.contract_no and  d.denorm_level='2' and d.parent_group_id = f.group_id   and d.group_id=b.group_Id and  d.group_id  = e.group_id and e.denorm_level='1' and e.parent_group_id = g.group_id ";
	inParas2[1]="unit_id="+unit_id+",id_no="+id_no;
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaa unit_id is "+unit_id+" and id_no is "+id_no+" and inParas2[0] is "+inParas2[0]+" inParas2[1] is "+inParas2[1]);
 
%>
   
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=org_code.substring(0,2)%>"  retcode="retCode4" retmsg="retMsg4" outnum="10">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />	 

<%
	if(result.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询结果为空,请重新输入查询条件进行查询!");
				window.location="zg06_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>集团信息查询结果</TITLE>
				</HEAD>
				<body>


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>

					  <table cellspacing="0" >
								<tr> 
								  <td>地市</td>
								  <td><%=result[0][0]%></td>
								  <td>区县</td>
								  <td><%=result[0][1]%></td>
								</tr>
								<tr> 
								  <td>集团代码</td>
								  <td><%=result[0][2]%></td>
								  <input type="hidden" id="unit_id" value="<%=result[0][2]%>">
								  <td>集团名称</td>
								  <td><%=result[0][3]%></td>
								</tr>
								<tr> 
								  <td>产品账号</td>
								  <td><%=result[0][4]%></td>
								  <input type="hidden" id="account_id" value="<%=result[0][4]%>">
								  <td>产品名称</td>
								  <td><%=product_name2%></td>
								</tr>
								<tr> 
								  <td>当前产品余额</td>
								  <td><%=result[0][6]%></td>
								  <td>客户经理</td>
								  <td><%=result[0][7]%></td>
								</tr>
								 
								<tr> 
								  <td>阀值金额</td>
								  <td colspan=3>
									<input type="text" name="fz" onKeyPress="return isKeyNumberdot(1)" value="<%=result[0][8]%>"   maxlength="6" >
								  </td>
								 
								 <input type="hidden" id="value_id" value="<%=result[0][9]%>"> 
								</tr>
				 
 
						 
						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot" name=back onClick=doCfm() type=button value=设置>
							  <input class="b_foot" name=back onClick="window.location='zg06_1.jsp';" type=button value=返回>
					 
							</td>
						  </tr>
						  
					  </table>
					  <tr id="footer"> 
						   
						  </tr>
					
						
							
						

				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
			</BODY>
		</HTML>
		<%
	}
%> 
 


<script language="javascript">
	function doCfm()
	{
		var fz = document.all.fz.value;
		//var fz_new = fz.toFixed(2);
		//alert("fz is "+fz+" and fz_new is "+fz_new);
		var old_ls = document.getElementById("value_id").value;
		if(fz=="")
		{
			rdShowMessageDialog("请输入阀值金额!");
			 
			return false;
		}
		else if(fz<10)
		{
			rdShowMessageDialog("阀值金额不能少于10元!");
			 
			return false;
		}
		else
		{
			 
			var prtFlag=0;
			prtFlag=rdShowConfirmDialog("是否确认办理?");
			if (prtFlag==1){
				document.frm1508_2.action="zg06_3.jsp?unit_id="+document.getElementById("unit_id").value+"&account_id="+document.getElementById("account_id").value+"&fz="+fz+"&old_ls="+old_ls;
			 
				document.frm1508_2.submit();
			}else{ 
					return false;
			
			}
		
		}
	}
</script>