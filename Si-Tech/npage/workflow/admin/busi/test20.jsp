<%
/********************
应用测试页面
定制的客户交互界面
输入：从request.attribute获取订单号 工单号 和 _paraMap(tux传入的默认值)
输出：tux接口要求的各个参数 订单号 工单号
********************/
%>

<%
System.out.println("in middle page");

%>

<jsp:forward page="/page/workflow/admin/pub/f_wb_pub_commit.jsp" />