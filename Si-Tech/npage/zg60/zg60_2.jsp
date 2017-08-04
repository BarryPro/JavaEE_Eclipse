<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/popup_window.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>

<%
	  String workno=(String)session.getAttribute("workNo");    //工号
	  
	  String opCode = "zg60";
	  String opName = "流量统付优惠查询";
	  String phoneNo = request.getParameter("phoneNo");
	  String yearMonth = request.getParameter("yearMonth");
	  String returnCode="";
	  String returnMsg="";
	  String cxtj = request.getParameter("cxtj");
	  System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaa cxtj is "+cxtj);
	  
	  //xl add PB不可以办理
	  String s_sm_code="";
	  String[] inParas_pp = new String[2];
	  inParas_pp[0]="select sm_code from dcustmsg where phone_no=:s_no";
	  inParas_pp[1]="s_no="+phoneNo;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCodeims" retmsg="retMsgims" outnum="1">
		<wtc:param value="<%=inParas_pp[0]%>"/>
		<wtc:param value="<%=inParas_pp[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_pp" scope="end" />
<%
	if(ret_pp!=null &&ret_pp.length>0)
	{
		s_sm_code=ret_pp[0][0];
		if(s_sm_code=="PB" ||s_sm_code.equals("PB"))
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("物联网号码不允许进行操作!");
					window.location="zg60_1.jsp?opCode=4141&opName=投诉退费";
				</script>
			<%
		}
		else
		{
			%>
				<wtc:service name="sFlowFavMsg" routerKey="regionCode"    retcode="scode" retmsg="sret" outnum="10">
		<wtc:param value="<%=phoneNo%>"/> 
		<wtc:param value="<%=yearMonth%>"/>		 
	</wtc:service>
	<wtc:array id="returncode" scope="end" start="0"  length="1" />	
	<wtc:array id="returnmsg" scope="end" start="1"  length="1" />	 
	<wtc:array id="return2" scope="end" start="2"  length="1" />
	<wtc:array id="return3" scope="end" start="3"  length="1" />
	<wtc:array id="return4" scope="end" start="4"  length="1" />
	<wtc:array id="return5" scope="end" start="5"  length="1" />
	<wtc:array id="return6" scope="end" start="6"  length="1" />
	<wtc:array id="return7" scope="end" start="7"  length="1" />
	<wtc:array id="return_j_J" scope="end" start="8"  length="1" />
	<wtc:array id="return_name" scope="end" start="9"  length="1" />
<%	
	returnCode=returncode[0][0];
	returnMsg=returnmsg[0][0];
	if(returnCode==null||returnCode.equals(""))
	{
%>
			<script language="javascript">
				rdShowMessageDialog("查询结果为空,请重新查询！");
				window.location.href='zg60_1.jsp';
			</script>
<%
	}
	else
	{
	  if(returnCode.equals("000000")){
%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>流量统付优惠查询结果</TITLE>
</HEAD>
<body>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">流量统付优惠查询结果</div>
</div>
<div id="Operation_Table">
      <table cellspacing="0" id = "PrintA">
         <tr> 
          <th>场景</th>          
				  <th>套餐使用明细</th>	
				  <th>赠送集团</th>
				  <th>总流量（时长）</th>
				  <th>实际使用</th> 
				  <th>使用百分比</th>
				  <th>定向流量SID</th>
				  
         </tr>
			<%
				String s_flag="";
				for(int i=0;i<return2.length;i++)
				{
				//xl add for gaoap 改造根据j J 判断取哪个值
				 s_flag=return_j_J[i][0].substring(0,1);
				 System.out.println("ccccccccccccccccccccccccccccccccc return_j_J[i][0] is "+return_j_J[i][0]+" and i is "+i+" and s_flag is "+s_flag);
				 if(cxtj=="A" || cxtj.equals("A")) 
				 {
					 System.out.println("fffffffffffffffffff 全部");
					 %>
					 <tr>
							<td><%=return2[i][0]%></td>
							<td><%=return3[i][0]%></td>
							<td><%=return_name[i][0]%></td>
						<%
							if(return2[i][0].indexOf("全量统付")!=-1)
							{
							%>
								<td>不限</td>
								<td><%=return5[i][0]+"MB"%></td>							
								<td>-</td>
							<%
							}else
							{
							%>
									<td><%=return4[i][0]+"MB"%></td>
									<td><%=return5[i][0]+"MB"%></td>							
									<td><%=Float.parseFloat(return6[i][0])*100+"%"%></td>
							<%
							}
							%>
							<%
							if(return2[i][0].indexOf("通用")!=-1)
							{
							%>							
								<td>-</td>
							 
							<%
							}else
							{
							%>					
								<td><%=return7[i][0]%></td>
								
							<%
							}
							%>
						</tr>
					 <%
				 }
				 else if (s_flag==cxtj || s_flag.equals(cxtj)) 
				 {
					 System.out.println("dddddddddddddddddddddddddddd 全时段统付 i is "+i);
					 %>
					 <tr>
							<td><%=return2[i][0]%></td>
							<td><%=return3[i][0]%></td>
							<td><%=return_name[i][0]%></td>
						<%
							if(return2[i][0].indexOf("全量统付")!=-1)
							{
							%>
								<td>不限</td>
								<td><%=return5[i][0]+"MB"%></td>							
								<td>-</td>
							<%
							}else
							{
							%>
									<td><%=return4[i][0]+"MB"%></td>
									<td><%=return5[i][0]+"MB"%></td>							
									<td><%=Float.parseFloat(return6[i][0])*100+"%"%></td>
							<%
							}
							%>
							<%
							if(return2[i][0].indexOf("通用")!=-1)
							{
							%>							
								<td>-</td>
							 
							<%
							}else
							{
							%>					
								<td><%=return7[i][0]%></td>
							 
							<%
							}
							%>
						</tr>
					 <%
				 }
				 else
				 {
				 }	
				   	
				  
			%>
						
			<%
				
				}	
			%>
</div>			         
          <tr id="footer"> 
      	    <td colspan="15">
    	      	<input class="b_foot" name=back onClick="window.location = 'zg60_1.jsp' " type=button value=返回>
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
		}else{
%>
			<script language="javascript">
				rdShowMessageDialog("查询服务sFlowFavMsg错误，错误代码："+"<%=returnCode%>"+",错误原因:"+"<%=returnMsg%>");
				window.location.href='zg60_1.jsp';
			</script>
<%
		}
	}
%>	  

			<%
		}
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("查询品牌信息出错!",0);
				window.location="zg60_1.jsp?opCode=4141&opName=投诉退费";
			</script>
		<%
	}
%>

	