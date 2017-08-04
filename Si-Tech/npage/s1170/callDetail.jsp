<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.crmpd.core.wtc.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	

<HTML><HEAD><TITLE>订单详情</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
	function doSearch(){
		$("#searchResult").toggle();
	}
	
	function callDetail(){
		window.showModalDialog("callDetail.jsp","","dialogWidth:50;dialogHeight:45;");
	}
</SCRIPT>
<body>
<div id="operation">
<FORM method=post name="frm1102">
	<%@ include file="/npage/include/header.jsp" %>
 	<div id="operation_table">
 		<div class="input">
 			<div class="title">
          <div class="text">查询条件</div> 
      </div>
          <table>
                <TR> 
                	<Th>查询条件：</Th>
                  <TD> 
                  	<select name="idType" id="idType" onchange="">
                  		<option value="0">服务号码</option>
                  		<option value="1">客户订单ID</option>
                  		<option value="1">客户订单子项ID</option>
                  		<option value="1">服务定单ID</option>
                  	</select> 
                  </TD>
                	 <Th><span class="red">*条件值：</span></Th>
                  <TD> 
                    <input type="text" name="servno" class="required" onchange=""/>
                  </TD>
                </TR>
           </table>
      </div>
      <div class="list" id="searchResult" style="display:none">
      	<table id="dataTable">
      		<tr>
	      		<th>选择</th>
	      		<th>客户订单子项ID</th>
	      		<th>客户订单子项名称</th>
	      		<th>服务定单</th>
	      		<th>动作名称</th>
	      		<th>服务号码</th>
	      		<th>操作</th>
	      	</tr>
	      	<tr>
	      		<td><input type="checkbox" ></td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td><a href="#" onclick="callDetail()">详情</a></td>
	      	</tr>
	      	<tr>
	      		<td><input type="checkbox" ></td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td><a href="#" onclick="callDetail()">详情</a></td>
	      	</tr>
	      	<tr>
	      		<td><input type="checkbox" ></td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td>test</td>
	      		<td><a href="#" onclick="callDetail()">详情</a></td>
	      	</tr>
      	</table>
      </div>
    </div>
         <div id="operation_button">                
              <input class="b_foot" onclick="doSearch()"  type=button value="查询"/>
              <input class="b_foot" id="doSubmit()"  onclick=""  type=button value="确认"/>
              <input class="b_foot" name="quit"  onclick="window.close()"  type=button value="退出"/>
		  	</div>

  <!------------------------> 

<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html> 	