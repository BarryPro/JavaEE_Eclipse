<%
  /*
   * 功能: 12580预约服务设置时间间隔
　 * 版本: 1.0.0
　 * 日期: 2009/02/17
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>

<html>
  <head>
    <%
     String num = (String)request.getParameter("times");
     
     String INTERV_TIME = (String)request.getParameter("interv_time");
     
     int js = Integer.parseInt(num);
     
     String[] rstr = new String[js];
     
     if(INTERV_TIME != null && INTERV_TIME.length() > 0){
     
     	rstr = (String[])INTERV_TIME.split(";");
     }
     
    %>
    <script language="javascript">
    	function setSpace(){
    		var rs = "";
    		var tag = document.getElementsByTagName("input");
    		for(var j = 0; j < tag.length; j++){
					if(tag[j].value != "" && tag[j].type == "text"){
						if(!isNumber(tag[j].value)){
							showTip(tag[j],"时间间隔只能为数字！请从新选择后输入");
							tag[j].focus();
		        	return;
						}
						rs += tag[j].value + ";";
					}else if(tag[j].value == "" && tag[j].type == "text"){
						
						showTip(tag[j],"时间间隔不能为空！请从新选择后输入");
						tag[j].focus();
		        return;
						
					}
					
				}
    		window.returnValue = rs;
    		
    		window.close();
    	}
    </script>
  </head>
  
  <body>
    <form name="sitechform" id="sitechform">
    	<div id="Operation_Table">

				<div class="title">

					设置时间间隔

				</div>
    	<table cellspacing="0">
    		<tr align="center">
    			<th>间隔</th>
    			<th>时间(分钟)</th>
    		</tr>
    		<%
    			
	    	for(int i = 0; i < js; i++){
	    		if(i==0){
	    	%>
	    	<tr>
	    		<td>约定时间~第<%=i+1 %>次</td><td><input name="space" value="<%=rstr[i].equals("0")?"0":rstr[i] %>" maxlength="2" disabled /></td>	    		
	    	</tr>
	    	<%	
	        }else	{
	      %>
	      <tr>
	    		 <td>第<%=i %>次~第<%=i+1 %>次</td><td><input name="space" value="5" maxlength="2" /></td>	    		
	    	</tr>
	      <%  	
	        }
	    	}
    		%>
    		<tr align="center">
    			<td colspan="2"><input type="button" class="b_foot" value="确认" onClick="setSpace();"><input type="reset" class="b_foot" value="重置"><input type="button" class="b_foot" value="关闭" onClick="window.close();"></td>    			
    		</tr>
    	</table>
    	</div>
    </form>
  </body>
</html>
