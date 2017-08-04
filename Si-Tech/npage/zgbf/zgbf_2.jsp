<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zgbf";
		String opName = "专票虚拟关系审批";
 		String phone_no = request.getParameter("phone_no");
		String[] inParas2 = new String[2];
		inParas2[0]="select TAX_NO,TAX_NAME,TAX_ADDRESS,TAX_PHONE,TAX_KHH,TAX_CONTRACT,to_char(LOGIN_ACCPET),to_char(OP_TIME,'YYYYMMDD hh24:mi:ss'),LOGIN_NO from DVIRtaxdetail where phone_no=:s_no and s_flag='N'";
		inParas2[1]="s_no="+phone_no;

%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phone_no%>"  retcode="retCode1" retmsg="retMsg1" outnum="9">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(result1.length>0)
	{
		%>
		<HTML>
			<HEAD>
			<script language="JavaScript">
			function dotg(ls,tax_no)
			{
				//alert("ls is "+ls);
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("是否确定通过虚拟集团关系审批?");
				if (prtFlag==1)
				{
					document.frm.action="zgbf_3.jsp?ls="+ls+"&tax_no="+tax_no+"&phone_no="+"<%=phone_no%>";//展示分项信息 调用staxtailadd接口进行录入
					document.frm.submit();
					
					
				}
				else
				{
					return false;
				}
				
			}
			
			 function doPosSubInfo3(packet)
			 {
				 //alert("2");
				 var s_flag =  packet.data.findValueByName("flag1");
				 var errCode2 = packet.data.findValueByName("errCode2");
				 alert("s_flag is "+s_flag);
				 if(s_flag=="0")
				 {
					 rdShowMessageDialog("审批通过!");
				 }
				 else
				 {
					 rdShowMessageDialog("审批失败!错误代码:"+errCode2);
				 }
			 }
			 function doclear() {
					frm.reset();
			 }
			   
			 function sel1() {
					window.location.href='zgbf_1.jsp';
			 }
			 
			 
			  
			 
			 
			 

			  
			 </script> 
			 
			<title>成员信息添加</title>
			</head>
			<BODY >
			<form action="" method="post" name="frm">
					
					<%@ include file="/npage/include/header.jsp" %>   
				 
				
			  <table cellspacing="0">
				 
				<tr>
					<td>产品号码</td>
					<td>纳税人识别号码</td>
					<td>纳税人名称</td>
					<td>地址</td>
					<td>电话</td>
					<td>开户行</td>
					<td>账号</td>
					<td>申请流水</td>
					<td>申请时间</td>
					<td>申请工号</td>
					<td>操作</td>
				</tr>
				<%
					for(int i=0;i<result1.length;i++)
					{
						%>
							<tr>
								<td><%=phone_no%></td>
								<td><%=result1[i][0]%></td>
								<td><%=result1[i][1]%></td>
								<td><%=result1[i][2]%></td>
								<td><%=result1[i][3]%></td>
								<td><%=result1[i][4]%></td>
								<td><%=result1[i][5]%></td>
								<td><%=result1[i][6]%></td>
								<td><%=result1[i][7]%></td>
								<td><%=result1[i][8]%></td>
								<td><input type="button" id="docfm<%=i%>" class="b_foot" value="通过" onclick="dotg('<%=result1[i][6]%>','<%=result1[i][0]%>')"></td>
							</tr>
						<%
					}
				%> 

				
			 
			  </table>

			   
				<%@ include file="/npage/include/footer_simple.jsp"%>
			  <%@ include file="../../npage/common/pwd_comm.jsp" %>
			</form>
			 </BODY>
			</HTML>
		
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("该产品号码未配置专票虚拟集团关系!");
				window.location.href="zgbf_1.jsp";
			</script>
		<%
	}
%>
