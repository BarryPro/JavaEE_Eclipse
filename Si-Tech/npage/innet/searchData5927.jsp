<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
 /**
 *根据查询条件查询出所属客户订单的所有信息。
 * #inputparam
 * #utype
 * -paramType       string       传入的参数类型，服务号码 0 ,客户订单ID 1 ,客户订单子项ID  2  ,服务定单ID  3  ,或者冲正流水(服务定单流水)  4.
 * -paramValue      string       传入的参数  
 * -loginNO         string       操作工号 
 * -queryDate       string       查询的年月  只有当用服务号码和冲正流水时使用
 * #outputparam
 * #utype
 * -utype     # 2 客户信息
 * --custOrderId    string       客户订单ID
 * --custName       string       客户名称
 * --custIccid      string       客户证件号码
 
 * -utype    # 3 子项信息集
 * --utype   #子项信息1*
 * ---custArrayId    string       客户订单子项ID
 * ---custArrayName  string       客户订单子项名称
 * ---utype   #服务定单信息集
 * ----utype   #服务定单信息1
 * -----servOrderId    string       服务订单子项ID
 * -----actionName  string          动作名称
 * -----service_no  string          服务号码
 */

	String idType = request.getParameter("idType");          //查询条件
	String condittionValue = request.getParameter("servno"); //条件值
	String modeFlag = request.getParameter("modeFlag"); //条件值
	String selFlag = request.getParameter("selFlag"); //条件值
	String searchDate = request.getParameter("searchDate") == null?"":(String)request.getParameter("searchDate");  //查询日期
	String workNo = (String) session.getAttribute("workNo"); //登陆工号
	
	System.out.println("idType===========mylog=============="+idType);
	System.out.println("searchDate==========mylog==============="+searchDate);
	System.out.println("condittionValue=====mylog===================="+condittionValue);
	System.out.println("searchDate=============mylog============"+searchDate);
	
	
	//客户信息
	String custOrderId = "";
	String custName = "";
	String custIccid = "";
	
 
%>
<%String regionCode_sReveresQuery = (String)session.getAttribute("regCode");%>
<wtc:utype name="sReveresQuery" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sReveresQuery%>">
          <wtc:uparam value="<%= idType %>" type="String"/>      
          <wtc:uparam value="<%= condittionValue %>" type="String"/>      
          <wtc:uparam value="<%= workNo %>" type="String"/>      
          <wtc:uparam value="<%= searchDate %>" type="String"/>      
 </wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
if(retCode.equals("0")){
	
		//客户信息
		//custOrderId = retVal.getValue("2.0.0");
		//custName = retVal.getValue("2.0.1");
		//custIccid = retVal.getValue("2.0.2");
		int custArrayOrderSize = retVal.getSize("2");//子项信息个数；
		System.out.println("custArrayOrderSize========================="+custArrayOrderSize);
		
		StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		System.out.println("mylog"+logBuffer.toString());
%>

<div id="Operation_Table">
 
 
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">客户订单列表</div>
</div>
<table id="dataTable" cellspacing=0>
	<tr>
		<th>选择</th>
		<th>客户订单子项ID</th>
		<th>操作名称</th>
		<th style="display:none">服务定单</th>
		<th style="display:none">操作名称</th>
		<th>服务号码</th>
		<th>客户订单ID</th>
		<th>客户名称</th>
		<th  style="display:none">客户证件号码</th>
		
		<th>操作时间</th>
		<th>操作工号</th>
		<th>操作流水</th>
		<!--th>操作</th-->
	</tr>
<%
  String tempFlag = "";
	String custOrrayArrayId_new = "";
             String opCodeV1 ="";
	           String opCodeV2 = "";
	           String loginAccept = "";
	           String opNameV1 = "";
	           String opNameV2 = "";
	           
	for(int i=0;i<custArrayOrderSize;i++){//客户订单个数
	 
	 custOrrayArrayId_new = retVal.getValue("2."+i+".1.0.0");
	 
	 opCodeV1 = retVal.getValue("2."+i+".1.0.2.0.0.3");
	 opNameV1 = retVal.getValue("2."+i+".1.0.2.0.0.4");
	 opCodeV2 = retVal.getValue("2."+i+".1.0.2.0.0.5");
	 System.out.println(i+"--------------------------opCodeV2--------------------"+opCodeV2);
	 System.out.println(i+"--------------------------modeFlag--------------------"+modeFlag);
	 System.out.println(i+"--------------------------selFlag---------------------"+selFlag);
	 opNameV2 = retVal.getValue("2."+i+".1.0.2.0.0.6");
	 loginAccept = retVal.getValue("2."+i+".1.0.2.0.0.7");
	
	System.out.println("----------------------opCodeV1------------------"+opCodeV1);
	System.out.println("----------------------opNameV1------------------"+opNameV1);
	System.out.println("----------------------opCodeV2------------------"+opCodeV2);
	System.out.println("----------------------opNameV2------------------"+opNameV2);
	System.out.println("----------------------loginAccept---------------"+loginAccept);
	String hiddenStr = retVal.getValue("2."+i+".1.0.0")+"|"+retVal.getValue("2."+i+".1.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.0")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.2")+"|"+retVal.getValue("2."+i+".0.0")+"|"+retVal.getValue("2."+i+".0.1")+"|"+retVal.getValue("2."+i+".0.2");
%>
				<tr>
					<td><input type="radio" id="custOrderIds" value="<%=custOrrayArrayId_new%>"  checked v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>"  name="custOrderIds"></td>
					<td><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%></td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%></td>
					<td><%=retVal.getValue("2."+i+".0.0")%></td>
					<td><%=retVal.getValue("2."+i+".0.1")%></td>
					<td  style="display:none"><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td> <%=retVal.getValue("2."+i+".1.0.2.0.0.8")%></td>
					<td> <%=retVal.getValue("2."+i+".1.0.2.0.0.9")%></td>
					<td><%=loginAccept%> </td>
					
					<td style="display:none"><input name="custAdd<%=i%>" id="custAdd<%=i%>" value="<%=retVal.getValue("2."+i+".0.3")%>"></td>
				 
					<td style="display:none"><input name="hiddenStrv<%=i%>" id="hiddenStrv<%=i%>" value="<%=hiddenStr%>"></td>
					<td style="display:none"><input name="opCode1Hv<%=i%>" id="opCode1Hv<%=i%>" value="<%=opCodeV1%>"></td>
					<td style="display:none"><input name="opName1Hv<%=i%>" id="opName1Hv<%=i%>" value="<%=opNameV1%>"></td>
					<td style="display:none"><input name="opCode2Hv<%=i%>" id="opCode2Hv<%=i%>" value="<%=opCodeV2%>"></td>
					<td style="display:none"><input name="opName2Hv<%=i%>" id="opName2Hv<%=i%>" value="<%=opNameV2%>"></td>
					<td style="display:none"><input name="loginAcceptHv<%=i%>" id="loginAcceptHv<%=i%>" value="<%=loginAccept%>"></td>
				</tr>
<%
}
%>
</table>
</div>
 
<%
} %>
