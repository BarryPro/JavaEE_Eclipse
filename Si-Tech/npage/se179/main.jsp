<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/se179/public_title_name.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ include file="/npage/se179/footer.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	String phoneNo = (String)request.getParameter("activePhone");		//手机号
	String custOrderId = (String)request.getParameter("custOrderId");	//crm传过来的
	String orderArrayId = (String)request.getParameter("orderArrayId");	//crm传过来的
	String servBusiId = (String)request.getParameter("servBusiId");		//crm传过来的
	String opCode = (String)request.getParameter("opCode");				//crm传过来的
	String opName = (String)request.getParameter("opName");				//crm传过来的
	String custOrderNo = (String)request.getParameter("custOrderNo");	//crm传过来的，跳转至缴费页面的入参
	String gCustId = (String)request.getParameter("gCustId");
	System.out.println("========================================g796 营销取消 ==custOrderId = "+custOrderId);
	System.out.println("========================================g796 营销取消 ==custOrderNo = "+custOrderNo);
	System.out.println("========================================g796 营销取消 ======gCustId = "+gCustId);
%>
<s:service name="WsGetOrderedActList">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" /><!-- 用户手机号码 -->
				<s:param name="CHN_TYPE" type="string" value="0" /><!-- 渠道编码 chn_type：0-前台 -->
				<s:param name="QUERY_TYPE" type="string" value="1" /><!-- 可取消标识 1-取消-->
			</s:param>
		</s:param>
</s:service>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>营销活动取消</title>
	</head>
	<body>
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
							<th>取消类型</th>
							<th>业务取消</th>
						</tr>
           	 				<%
								Calendar calendar = Calendar.getInstance();
								SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
								String sysdate = sf.format(calendar.getTime());
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
										String cancelPrifee = (String)hmap.get("CONCEL_PRIFEE");
										String busiId = (String)hmap.get("BUSI_ID");
										String operDate = (String)hmap.get("OPER_DATE");
										String busiType = (String)hmap.get("BUSINESS_TYPE");
										String isChangeLevel = hmap.get("IS_CHANGE_LEVEL")==null?"":(String)hmap.get("IS_CHANGE_LEVEL");
										String cancelType = hmap.get("CANCEL_TYPE")==null?"":(String)hmap.get("CANCEL_TYPE");//操作类型 0或空-正常取消,3-换挡取消,4-换挡订购
										String startDate = hmap.get("START_DATE")==null?"":(String)hmap.get("START_DATE");//生效时间 
										if(!"".equals(startDate)){
											startDate = startDate.substring(0, 8);
										}
										/**
										如果是升降档的订购，营销案未生效，则不允许取消 
										startDate<sysdate -1  startDate>sysDate 1  startDate=sysDate 0
										**/
										if("4".equals(cancelType) && startDate.compareTo(sysdate)>0){  
											continue;
										}
										
							%>
								<tr>						
									<td><%=actName%></td>
									<td><%=saleLang%></td>
									<td>
									   <%if("1".equals(orderType)){%>
									   	  预约办理
									   <%}else{%>
									   	   正常办理
									   <%}%>
									</td>
									<td><%=busiId %></td>
									<td><%=operDate %></td>
									<% 
									if("Y".equals(isChangeLevel)){
									%>
									<td>
										<select name="cancelType" id="cancelType<%=serialNo%>" >
											<option value='0'>正常</option>
											<option value='3'>换档</option>
										</select>
									</td>
										
									<%
									}else{
									%>
									<td>
										<select name="cancelType" id="cancelType<%=serialNo%>" >
											<option value='0'>正常</option>
										</select>
									</td>
									<% 
									}
									%>
									<td>
										<input type="button" class="b_text" name="actBtn" value="活动取消" 
										onclick="do_cancel('<%=serialNo%>','<%=actName%>','<%=actId %>','<%=actClass%>',
										'<%=cancelPrifee%>','<%=busiId%>','<%=busiType%>','<%=isChangeLevel%>')"/>
									</td>
								</tr>
							<%
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

	
	function do_cancel(serialNo,actName,actId,actClass,cancelPrifee,busiId, busiType,isChangeLevel){
		var check = checkChangeLevel(serialNo,isChangeLevel);
		if(check){
			checkCancelLimit(serialNo,actName,actId,actClass,cancelPrifee,busiId, busiType);
		}else{
			showDialog("不支持换挡取消!",1);
		}
		
	}
	
	var cancelType = "";
	function checkChangeLevel(serialNo,isChangeLevel){
		var flag = false;
		cancelType = document.getElementById("cancelType"+serialNo).value;
		if(isChangeLevel != "Y" && cancelType == "3"){
				flag = false;
		}else{
			flag = true;
		}
		return flag;
	}

	var gBusiType = "";
	function checkCancelLimit(serialNo,actName,actId,actClass,cancelPrifee,busiId, busiType){
		gBusiType = busiType;
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/callConcelLimit.jsp","请稍后...");
		packet.data.add("serialNo",serialNo);//销售流水
		packet.data.add("actId",actId);//活动编码
		packet.data.add("phoneNo","<%=phoneNo%>");//手机号码
		packet.data.add("actName",actName);//活动名称
		packet.data.add("actClass",actClass);//活动大类
		packet.data.add("concelPrifee",cancelPrifee);
		packet.data.add("busiId",busiId);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacketHtml(packet,netCancelLimit,true);
		packet =null;
	}
	
	function netCancelLimit(data){
		var datas =data.split("~");
		if(trim(datas[0]) == "000000"){
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
		if(trim(datas[0]) == "000000"){
			var param = "phoneNo=<%=phoneNo%>&serialNo="+trim(datas[2])+"&actName="+trim(datas[3])+"&actClass="+trim(datas[4])+"&concelPrifee="+
			trim(datas[5])+"&custOrderId=<%=custOrderId%>&orderArrayId=<%=orderArrayId%>&servBusiId=<%=servBusiId%>&opCode=<%=opCode%>&opName=<%=opName%>&busiId="+trim(datas[6])+
			"&custOrderNo=<%=custOrderNo%>&gCustId=<%=gCustId%>&busiType="+gBusiType+"&cancelType="+cancelType;
			url="orderedInfo.jsp?"+param;
			location = url;
		}else{
			showDialog(datas[1],1);
		}
	}
	
</script>
