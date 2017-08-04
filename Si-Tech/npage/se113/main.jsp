<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/se179/public_title_name.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ include file="/npage/se179/footer.jsp"%>

<%
	String phoneNo = (String)request.getParameter("activePhone");		//手机号
	String custOrderId = (String)request.getParameter("custOrderId");	//crm传过来的
	String orderArrayId = (String)request.getParameter("orderArrayId");	//crm传过来的
	String servBusiId = (String)request.getParameter("servBusiId");		//crm传过来的
	String opCode = (String)request.getParameter("opCode");				//crm传过来的
	String opName = (String)request.getParameter("opName");				//crm传过来的
	String custOrderNo = (String)request.getParameter("custOrderNo");	//crm传过来的，跳转至缴费页面的入参
	String gCustId = (String)request.getParameter("gCustId");
	String selectType = (String)request.getParameter("selectType");
	System.out.println("========================================g798 终端业务取消 ==custOrderId = "+custOrderId);
	System.out.println("========================================g798 终端业务取消 ==custOrderNo = "+custOrderNo);
	System.out.println("========================================g798 终端业务取消 ======gCustId = "+gCustId);
	System.out.println("========================================g798 终端业务取消 ======selectType = "+selectType);
	System.out.println("========================================g798 终端业务取消 ======servBusiId = "+servBusiId);
	String chn_type = "";
	String act_Class = "";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>终端业务取消</title>
	</head>
	<body>
		<div id="operation">
			<form method="post" action="main.jsp">
			 	<div id="operation_table">
			 		<div class="title">
						<div class="text">
							终端业务取消查询
						</div>
					</div>
					<div class="input">	
						<table>
							<tr>
							<th>查询类型</th>	
								<td>
									<select id="selectType" name="selectType">
										 <option value="0">请选择</option>
										 <option value="1" <%if("1".equals(selectType)){%>selected<%}%>>裸机销售业务</option>
										 <option value="2" <%if("2".equals(selectType)){%>selected<%}%>>合约机销售业务</option>
										 <option value="3" <%if("3".equals(selectType)){%>selected<%}%>>买手机送话费业务</option>
									</select>
									<input type="hidden" name="activePhone" id="activePhone" value="<%=phoneNo %>">
									<input type="hidden" name="custOrderId" id="custOrderId" value="<%=custOrderId %>">
									<input type="hidden" name="orderArrayId" id="orderArrayId" value="<%=orderArrayId %>">
									<input type="hidden" name="servBusiId" id="servBusiId" value="<%=servBusiId %>">
									<input type="hidden" name="opCode" id="opCode" value="<%=opCode %>">
									<input type="hidden" name="opName" id="opName" value="<%=opName %>">
									<input type="hidden" name="custOrderNo" id="custOrderNo" value="<%=custOrderNo %>">
									<input type="hidden" name="gCustId" id="gCustId" value="<%=gCustId %>">
								</td>	
							</tr>
						</table>
					</div>
					<div id="operation_button">
						<input class="b_foot" type="button"  name="qry" value="查询" onclick="qryAct();">
					</div>
				</div>
			</form>
		</div>	
		
		<div id="operation">
			<div id="operation_table">
				<div class="title">
					<div class="text">
						客户已参加的活动列表
					</div>
				</div>
				<div class="list">
				<table>
					<tr>
						<th>活动名称</th>
						<th>营销用语</th>
						<th>办理类型</th>
						<th>销售流水</th>
						<th>办理时间</th>
						<th>渠道类型</th>
						<th>退机业务</th>
					</tr>
					<%if(selectType != null && !selectType.equals("0")) { %>
						<s:service name="WsGetOrderedResActList">
							<s:param name="ROOT">
								<s:param name="REQUEST_INFO">
									<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" /><!-- 用户手机号码 -->
									<s:param name="QUERY_TYPE" type="string" value="<%=selectType %>" /><!-- 可取消标识 1-取消-->
								</s:param>
							</s:param>
						</s:service>
	          	 			<%
	           	 			if ("0".equals(retCode)) {
								Map hmap = new HashMap();
								List datainfo = result.getList("OUT_DATA.ACT_LIST.ACT_INFO");
								System.out.println("===================********办理营销活动数目="+datainfo.size());
								for(int i=0;i<datainfo.size();i++){
									hmap = MapBean.isMap(datainfo.get(i));
									if(hmap==null) continue;
									String actId = (String)hmap.get("ACT_ID");
									String actName = (String)hmap.get("ACT_NAME");
									String saleLang = (String) hmap.get("MKT_DICTION");
									String orderType = (String)hmap.get("ORDER_TYPE");
									String serialNo = (String)hmap.get("SERIAL_NO");
									String actClass = (String)hmap.get("ACT_CLASS");
									act_Class = actClass;
									String concelPrifee = (String)hmap.get("CONCEL_PRIFEE");
									String busiId = (String)hmap.get("BUSI_ID");
									String operDate = (String)hmap.get("OPER_DATE");
									String busiType = (String)hmap.get("BUSINESS_TYPE");
									chn_type = (String)hmap.get("CHN_TYPE");
							%>
							<tr>						
								<td><%=actName%></td>
								<td><%=saleLang%></td>
								<td>
								   <%if("1".equals(orderType.trim())){%>
								   	  预约办理
								   <%}else{%>
								   	   正常办理
								   <%}%>
								</td>
								<td><%=busiId %></td>
								<td><%=operDate %></td>
								<td>
								   <%if("0".equals(chn_type.trim())){%>
								   	  前台
								   <%}else{%>
								   	  电子渠道
								   <%}%>
								</td>
								<td>
									<input type="button" class="b_text" name="actBtn" value="退机" 
									onclick="checkCancelLimit('<%=serialNo%>','<%=actName%>','<%=actId %>','<%=actClass%>','<%=concelPrifee %>','<%=busiId %>','<%=busiType%>')"/>
								</td>
							</tr>
						   <%
					        }
					      }
						}						
					   %>
				</table>
				</div>
				<div id="operation_button">
				</div>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript">
	
	function qryAct(){
		var selectType =trim($("#selectType").val());
		if(selectType == "0"){
			showDialog("请选择查询类型",1);
			return false;
		}else{
			document.forms[0].submit();
		}
	}
	
	var gBusiType = "";
	function checkCancelLimit(serialNo,act_name,act_id,actClass,concelPrifee,busiId, busiType){
		gBusiType = busiType;
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/callConcelLimit.jsp","请稍后...");
		packet.data.add("serialNo",serialNo);//销售流水
		packet.data.add("actId",act_id);//活动编码
		packet.data.add("phoneNo","<%=phoneNo%>");//手机号码
		packet.data.add("actName",act_name);//活动名称
		packet.data.add("actClass",actClass);//活动大类
		packet.data.add("concelPrifee",concelPrifee);
		packet.data.add("busiId",busiId);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacketHtml(packet,netCancelLimit,true);
		packet =null;
	}
	
	function netCancelLimit(data){
		var datas =data.split("~");
		if(trim(datas[0]) == 000000){
			if(trim(datas[7]) == 0){
				var packet = null;
				packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/callNetConcelLimit.jsp","请稍后...");
				packet.data.add("serialNo", datas[2]);//销售流水
				packet.data.add("actName",datas[3]);//活动名称
				packet.data.add("actClass",datas[4]);//活动大类
				packet.data.add("concelPrifee",datas[5]);
				packet.data.add("busiId",datas[6]);
				core.ajax.sendPacketHtml(packet,getOrderInfo,true);
				packet =null;
			}else{
				showDialog(datas[8],1);
			}
		}else{
			showDialog(datas[1],1);
		}
	}
	
	function getOrderInfo(data){
		var datas =data.split("~");
		if(trim(datas[0]) == 000000){
			var param = "selectType=<%=selectType%>&phoneNo=<%=phoneNo%>&serialNo="+trim(datas[2])+"&actName="+trim(datas[3])+"&actClass="+trim(datas[4])+"&concelPrifee="+
			trim(datas[5])+"&custOrderId=<%=custOrderId%>&orderArrayId=<%=orderArrayId%>&servBusiId=<%=servBusiId%>&opCode=<%=opCode%>&opName=<%=opName%>&busiId="+trim(datas[6])+
			"&custOrderNo=<%=custOrderNo%>&gCustId=<%=gCustId%>&chn_type=<%=chn_type%>&act_Class=<%=act_Class%>&busiType="+gBusiType;
			url="<%=request.getContextPath()%>/npage/se179/orderedInfo.jsp?"+param;
			location = url;
		}else{
			showDialog(datas[1],1);
		}
	}
	
</script>
