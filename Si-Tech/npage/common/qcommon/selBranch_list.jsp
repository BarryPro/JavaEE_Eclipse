<%
  /*
   * 功能: 局点查询
　 * 版本: 2.0
　 * 日期: 2007-07-05 16:12
　 * 作者: zhanghb
　 * 版权: sitech
　*/
%> 
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
String  object_id = WtcUtil.repNull(request.getParameter("object_id"));
String  branchName = WtcUtil.repNull(request.getParameter("branchName"));
System.out.println("---------------------------branchName---"+branchName);
%>

<wtc:utype name="sSelBranch" id="retBranchInfo" scope="end">
		 <wtc:uparam value="<%=object_id%>" type="STRING"/>
     <wtc:uparam value="<%=branchName%>" type="STRING"/>
</wtc:utype>

<%
String strBranch = "";
String retBranchCode =retBranchInfo.getValue(0);
String retBranchMsg  =retBranchInfo.getValue(1);
System.out.println("retBranchCode========================================="+retBranchCode);
System.out.println("retBranchMsg========================================="+retBranchMsg);
%>
<body>
		<div id="operation">
				<div id="operation_table">
				<div class="list">
						<table>
							<tr>
								<th>选择</th>
								<th>处理局</th>
								<th>局点</th>
							</tr>
							<%
							for(int i=0;i<retBranchInfo.getSize(2);i++){
								out.println("<tr>");
								out.println("<td>");
								out.println("<input  type='radio'  name='radBrach'  onclick=parent.retBrach('"+retBranchInfo.getValue("2."+i+".0").trim()+"-"+retBranchInfo.getValue("2."+i+".1").trim()+"') />");
								out.println("</td><td>");
								out.println(retBranchInfo.getValue("2."+i+".3").trim());
								out.println("</td><td>");
								out.println(retBranchInfo.getValue("2."+i+".1").trim());
								out.println("</td></tr>");
							}
							%>
							
						</table>
						
					</div>
		</div>

</body>
</html>					