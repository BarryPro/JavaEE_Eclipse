<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "综合信息查询之用户交费信息";
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String begin_time  = request.getParameter("beginTime");
	String end_time  = request.getParameter("endTime");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
%>
	<wtc:service name="s1500_wPayQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="20" >
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=id_no%>"/>
	<wtc:param value="<%=begin_time%>"/>
	<wtc:param value="<%=end_time%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
	int iretCode=999999; 
	
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
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
		rdShowMessageDialog("查询结果为空,用户交费信息不存在!");
	</script>
<%
		return;
	}
	
	String return_code =result[0][0];
	String return_message =result[0][1];

	if (!return_code.equals("000000"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=return_message%><br>服务代码:<%=return_code%>.");
			history.go(-1);
		</script>
<%	
	}
%>

<!--xl add for 积分信息查询-->
<wtc:service name="s1500_PointQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20" >
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=id_no%>"/>
	<wtc:param value="<%=begin_time%>"/>
	<wtc:param value="<%=end_time%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end"/>
<%	
	int iretCode2=999999; 
	
	if(retCode2!=null&&!"".equals(retCode2)){
		iretCode2=Integer.parseInt(retCode2);
	}
	if(iretCode2!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode2%><br>服务信息:<%=retMsg2%>!");
	</script>
<%
		return;
	}
	String return_code2 =result2[0][0];
	String return_message2 =result2[0][1];

	if ((!return_code2.equals("000000"))&&(!return_code2.equals("150010")))
	//if (!return_code2.equals("000000"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=return_message2%><br>服务代码:<%=return_code2%>.");
			history.go(-1);
		</script>
<%	
	}
%>
<!--xl end 积分信息查询-->

<HTML><HEAD><TITLE>用户交费信息</TITLE>
</HEAD>
<body>

<FORM method=post name="f1500_wPayQry">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">用户交费信息</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue">服务号码</td>
          <td><%=phone_no%></TD>
          <TD class="blue">开始时间</td>
          <td><%=result[0][2]%></TD>
          <TD class="blue">结束时间</td>
          <td><%=result[0][3]%></TD>
        </TR>
      </TBODY>
    </table>
  	</div>
		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">用户交费明细</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr align="center">
          <th>交费时间</th>
          <th>交费工号</th>
          <th>交费流水</th>
          <th>操作模块</th>
          <th>交费方式</th>
          <th>交费金额</th>
          <th>新增预存</th>
          <th>当时预存</th>
          <th>冲销欠费</th>
          <th>滞纳金</th>
          <th>补收其它费</th>
          <th>回收陈帐</th>
          <th>退款标志</th>
          <th>转出预存</th>
		  <th>区县</th>
		  <th>营业厅名称</th>
        </tr>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++)
			{
				if(y%2==0)
				{
					tbClass="Grey";
				}else
				{
					tbClass="";
				}
%>
	        <tr align="center">
<%    		
				for(int j=4;j<result[0].length;j++)
				{
%>
		  			<td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%			
				}
			
%>
	        </tr>
<%	        }
			// xl add
			//为了剔除均为0的显示
			 
			if(result2.length>0 &&(!return_code2.equals("150010")) )
			{
				for(int y2=0;y2<result2.length;y2++)
				{
					if(y2%2==0)
					{
						tbClass="Grey";
					}else
					{
						tbClass="";
					}
	%>
				<tr align="center">
	<%    		
					for(int j=4;j<result2[0].length;j++)
					{
	%>
						<td class="<%=tbClass%>"><%= result2[y2][j]%>&nbsp;</td>
	<%			
					}
				
	%>
				</tr>
	<%	        }
			}
			
			// xl end
%>
         </TBODY>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=关闭>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
