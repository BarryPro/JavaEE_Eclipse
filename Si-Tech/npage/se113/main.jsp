<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/se179/public_title_name.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@ include file="/npage/se179/footer.jsp"%>

<%
	String phoneNo = (String)request.getParameter("activePhone");		//�ֻ���
	String custOrderId = (String)request.getParameter("custOrderId");	//crm��������
	String orderArrayId = (String)request.getParameter("orderArrayId");	//crm��������
	String servBusiId = (String)request.getParameter("servBusiId");		//crm��������
	String opCode = (String)request.getParameter("opCode");				//crm��������
	String opName = (String)request.getParameter("opName");				//crm��������
	String custOrderNo = (String)request.getParameter("custOrderNo");	//crm�������ģ���ת���ɷ�ҳ������
	String gCustId = (String)request.getParameter("gCustId");
	String selectType = (String)request.getParameter("selectType");
	System.out.println("========================================g798 �ն�ҵ��ȡ�� ==custOrderId = "+custOrderId);
	System.out.println("========================================g798 �ն�ҵ��ȡ�� ==custOrderNo = "+custOrderNo);
	System.out.println("========================================g798 �ն�ҵ��ȡ�� ======gCustId = "+gCustId);
	System.out.println("========================================g798 �ն�ҵ��ȡ�� ======selectType = "+selectType);
	System.out.println("========================================g798 �ն�ҵ��ȡ�� ======servBusiId = "+servBusiId);
	String chn_type = "";
	String act_Class = "";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>�ն�ҵ��ȡ��</title>
	</head>
	<body>
		<div id="operation">
			<form method="post" action="main.jsp">
			 	<div id="operation_table">
			 		<div class="title">
						<div class="text">
							�ն�ҵ��ȡ����ѯ
						</div>
					</div>
					<div class="input">	
						<table>
							<tr>
							<th>��ѯ����</th>	
								<td>
									<select id="selectType" name="selectType">
										 <option value="0">��ѡ��</option>
										 <option value="1" <%if("1".equals(selectType)){%>selected<%}%>>�������ҵ��</option>
										 <option value="2" <%if("2".equals(selectType)){%>selected<%}%>>��Լ������ҵ��</option>
										 <option value="3" <%if("3".equals(selectType)){%>selected<%}%>>���ֻ��ͻ���ҵ��</option>
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
						<input class="b_foot" type="button"  name="qry" value="��ѯ" onclick="qryAct();">
					</div>
				</div>
			</form>
		</div>	
		
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
						<th>��������</th>
						<th>�˻�ҵ��</th>
					</tr>
					<%if(selectType != null && !selectType.equals("0")) { %>
						<s:service name="WsGetOrderedResActList">
							<s:param name="ROOT">
								<s:param name="REQUEST_INFO">
									<s:param name="PHONE_NO" type="string" value="<%=phoneNo %>" /><!-- �û��ֻ����� -->
									<s:param name="QUERY_TYPE" type="string" value="<%=selectType %>" /><!-- ��ȡ����ʶ 1-ȡ��-->
								</s:param>
							</s:param>
						</s:service>
	          	 			<%
	           	 			if ("0".equals(retCode)) {
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
								   	  ԤԼ����
								   <%}else{%>
								   	   ��������
								   <%}%>
								</td>
								<td><%=busiId %></td>
								<td><%=operDate %></td>
								<td>
								   <%if("0".equals(chn_type.trim())){%>
								   	  ǰ̨
								   <%}else{%>
								   	  ��������
								   <%}%>
								</td>
								<td>
									<input type="button" class="b_text" name="actBtn" value="�˻�" 
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
			showDialog("��ѡ���ѯ����",1);
			return false;
		}else{
			document.forms[0].submit();
		}
	}
	
	var gBusiType = "";
	function checkCancelLimit(serialNo,act_name,act_id,actClass,concelPrifee,busiId, busiType){
		gBusiType = busiType;
		var packet = null;
		packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se179/callConcelLimit.jsp","���Ժ�...");
		packet.data.add("serialNo",serialNo);//������ˮ
		packet.data.add("actId",act_id);//�����
		packet.data.add("phoneNo","<%=phoneNo%>");//�ֻ�����
		packet.data.add("actName",act_name);//�����
		packet.data.add("actClass",actClass);//�����
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
