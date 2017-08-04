<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-01-08
********************/
%> 
<%@ page contentType="text/html; charset=GB2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<HTML>
	<HEAD>
		<TITLE>综合历史信息查询</TITLE>			
		<%	
			String workNo = (String)session.getAttribute("workNo");    //工号  	
			String workName = (String)session.getAttribute("workName");//工号名称  	
			String regionCode= (String)session.getAttribute("regCode");//地市	
			String ip_Addr = "172.16.23.13";         
		        String opCode = request.getParameter("opCode");	//header.jsp需要的参数
			String opName = request.getParameter("opName");	//header.jsp需要的参数       
			System.out.println("gaopengSeeLohg===1550_1===init!!");
		%>
		<SCRIPT language="JavaScript">
			function doCheck(){
				if(document.frm1550.condText.value==""){					
					rdShowMessageDialog("请输入查询条件！！");
					document.frm1550.condText.select();
					return false;
				}else{
					document.frm1550.action="f1550_2.jsp";
					frm1550.submit();
				}
				return true;
			}
		</SCRIPT> 
	</HEAD>
	<body>
		<FORM method=post name="frm1550" OnSubmit="return doCheck()">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title" id="changxun">
				<div id="title_zi">查询条件 </div>
			</div>
			<input type="hidden" name="opCode"  value="1550">
			<input type="hidden" name="opName"  value="<%=opName%>">
			<TABLE  cellspacing="0">
        			<TR> 
          				<TD width=16% class="blue">查询条件 </TD>
          				<TD width=34%>
						<select align="left" name="QueryType" width=50>
							<option class="button" value="0">服务号码</option>
						        <option class="button" value="2">证件号码</option>
							<option class="button" value="3">客户名称</option>
							<option class="button" value="4">SIM卡号</option>
						</select> 
		  			</TD>
          				<TD width=16% class="blue">请输入查询条件 </TD>
          				<TD width=34%>
          					<input type="text" class="button" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}" >
          					<input type="button" class="b_text" name="Button1" value="查询" onclick="doCheck()" >
          				</TD>
       				</TR>       				
      			</TABLE>    
      			<br>      			
      			<div class="title" id="jieguo">
				<div id="title_zi">查询结果</div>
			</div>   				 
			<table  id=contentList cellspacing="0">				
				<tr>					    
					<th>服务号码</th>
					<th>用户ID号</th>
					<th>服务类型</th>
					<th>当前状态</th>  
					<th>状态变更时间</th>  
					<th>入网时间</th>					     
				</tr>
			</table>
			<table cellspacing="0">
				  <tr> 
					    <td id="footer">
					      &nbsp; <input class="b_foot" name=reset  type=reset  value=清除>
					      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
					      &nbsp; 
					    </td>
				  </tr>			   
			</table>
			<%@ include file="/npage/include/footer.jsp" %> 
		</FORM>
	</BODY>
</HTML>

