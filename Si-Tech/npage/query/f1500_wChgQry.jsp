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
  String opName = "综合信息查询之变更记录查询";

	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String begin_time  = request.getParameter("beginTime");
	String end_time  = request.getParameter("endTime");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");

	//arlist = viewBean.s1500_wchgqry(id_no,begin_time,end_time,region_code); 
%>
	<wtc:service name="s1500_wChgQry" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="12" >
	<wtc:param  value=""/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=work_no%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value="<%=phone_no%>"/>
  <wtc:param  value=""/>
	<wtc:param value="<%=id_no%>"/>
	<wtc:param value="<%=begin_time%>"/>
	<wtc:param value="<%=end_time%>"/>
	<wtc:param value="<%=region_code%>"/>
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
		rdShowMessageDialog("查询结果为空,变更记录信息不存在!");
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
		rdShowMessageDialog("<%=return_message%><br>服务代码 :<%=return_code%>");
		history.go(-1);
	</script>
<%	
	}
%>

<HTML><HEAD><TITLE>变更记录查询</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_wChgQry">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">变更记录查询</div>
		</div>

    <TABLE cellSpacing="0">
      <TBODY>
        <TR>
          <TD class="blue">服务号码 <input class="InputGrey" value="<%=phone_no%>" maxlength="25" size=25 readonly></TD>
          <TD class="blue">开始时间 <input class="InputGrey" value="<%=result[0][2]%>" maxlength="25" size=25 readonly></TD>
          <TD class="blue">结束时间 <input class="InputGrey" value="<%=result[0][3]%>" maxlength="25" size=25 readonly></TD>
       </TR>
      </TBODY>
		</TABLE>
  
		</div>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">变更记录明细</div>
			</div>

    <TABLE cellSpacing="0">
      <TBODY>
        <tr align="center">
          <th>操作名称</th>
          <th>操作时间</th>
          <th>工号</th>
          <th>操作代码</th>
          <th>操作备注</th>
          <th>操作流水</th>
          <th>受理费用</th>
          <th>营销案活动名称</th>
        </TR>
        
<%	    
  		String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	    <tr align="center">
<%   /*        
			for(int j=4;j<result[0].length;j++){
%>
	       <td class="<%=tbClass%>"><%= result[y][j]%> </td>
<%	        
			}*/
%>
          <td class="<%=tbClass%>"><%= result[y][4]%> </td>
          <td class="<%=tbClass%>"><%= result[y][5]%> </td>
          <td class="<%=tbClass%>"><%= result[y][6]%> </td>
          <td class="<%=tbClass%>"><%= result[y][9]%> </td>
          <td class="<%=tbClass%>"><%= result[y][10]%> </td>
          <td class="<%=tbClass%>"><%= result[y][7]%> </td>
          <td class="<%=tbClass%>"><%= result[y][8]%> </td>
          <td class="<%=tbClass%>"><%= result[y][11]%> </td>
	        </tr>
<%
	   }
%>
	</TABLE>

      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
