<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/se179/public_title_name.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ include file="/npage/se179/footer.jsp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	String phoneNo = (String)request.getParameter("activePhone");		//�ֻ���
	String custOrderId = (String)request.getParameter("custOrderId");	//crm��������
	String orderArrayId = (String)request.getParameter("orderArrayId");	//crm��������
	String servBusiId = (String)request.getParameter("servBusiId");		//crm��������
	String opCode = (String)request.getParameter("opCode");				//crm��������
	String opName = (String)request.getParameter("opName");				//crm��������
	String custOrderNo = (String)request.getParameter("custOrderNo");	//crm�������ģ���ת���ɷ�ҳ������
	String gCustId = (String)request.getParameter("gCustId");
	System.out.println("========================================g796 Ӫ��ȡ�� ==custOrderId = "+custOrderId);
	System.out.println("========================================g796 Ӫ��ȡ�� ==custOrderNo = "+custOrderNo);
	System.out.println("========================================g796 Ӫ��ȡ�� ======gCustId = "+gCustId);
%>
<s:service name="WsGetOrderedActList">
		<s:param name="ROOT">
			<s:param name="REQUEST_INFO">
				<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" /><!-- �û��ֻ����� -->
				<s:param name="CHN_TYPE" type="string" value="0" /><!-- �������� chn_type��0-ǰ̨ -->
				<s:param name="QUERY_TYPE" type="string" value="1" /><!-- ��ȡ����ʶ 1-ȡ��-->
			</s:param>
		</s:param>
</s:service>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>Ӫ���ȡ��</title>
	</head>
	<body>
		<div id="operation">
			<div id="operation_table">
				<div class="title">
					<div class="text">
						�ͻ��ѲμӵĻ�б�
					</div>
				</div>
				<div class="list">
					<table>
						<tr>
							<th>�����</th>
							<th>Ӫ������</th>
							<th>��������</th>
							<th>������ˮ</th>
							<th>����ʱ��</th>
							<th>ȡ������</th>
							<th>ҵ��ȡ��</th>
						</tr>
           	 				<%
								Calendar calendar = Calendar.getInstance();
								SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
								String sysdate = sf.format(calendar.getTime());
								Map hmap = new HashMap();
								List datainfo = result.getList("OUT_DATA.ACT_LIST.ACT_INFO");
								System.out.println("===================********����Ӫ�����Ŀ="+datainfo.size());
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
										String cancelType = hmap.get("CANCEL_TYPE")==null?"":(String)hmap.get("CANCEL_TYPE");//�������� 0���-����ȡ��,3-����ȡ��,4-��������
										String startDate = hmap.get("START_DATE")==null?"":(String)hmap.get("START_DATE");//��Чʱ�� 
										if(!"".equals(startDate)){
											startDate = startDate.substring(0, 8);
										}
										/**
										������������Ķ�����Ӫ����δ��Ч��������ȡ�� 
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
									   	  ԤԼ����
									   <%}else{%>
									   	   ��������
									   <%}%>
									</td>
									<td><%=busiId %></td>
									<td><%=operDate %></td>
									<% 
									if("Y".equals(isChangeLevel)){
									%>
									<td>
										<select name="cancelType" id="cancelType<%=serialNo%>" >
											<option value='0'>����</option>
											<option value='3'>����</option>
										</select>
									</td>
										
									<%
									}else{
									%>
									<td>
										<select name="cancelType" id="cancelType<%=serialNo%>" >
											<option value='0'>����</option>
										</select>
									</td>
									<% 
									}
									%>
									<td>
										<input type="button" class="b_text" name="actBtn" value="�ȡ��" 
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
			showDialog("��֧�ֻ���ȡ��!",1);
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
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/callConcelLimit.jsp","���Ժ�...");
		packet.data.add("serialNo",serialNo);//������ˮ
		packet.data.add("actId",actId);//�����
		packet.data.add("phoneNo","<%=phoneNo%>");//�ֻ�����
		packet.data.add("actName",actName);//�����
		packet.data.add("actClass",actClass);//�����
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
				packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/callNetConcelLimit.jsp","���Ժ�...");
				packet.data.add("serialNo", datas[2]);//������ˮ
				packet.data.add("actName",datas[3]);//�����
				packet.data.add("actClass",datas[4]);//�����
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
