<%@ page contentType= "text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String opCode = (String)request.getParameter("opCode");
		
		String sIpAddress = request.getRemoteAddr();
		String groupId = (String)session.getAttribute("groupId");
		String sOpTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
		String orgCode = (String)session.getAttribute("orgCode");
		String sRegionCode = regionCode.substring(0,2);
		String sMark="["+inLoginNo+"]��[" + phoneNo + "]��[����]";
		String BureauId = regionCode.substring(0,2);

		String errorCode = "";
		String errorMsg = "";
		System.out.println("chenlei opCode " + opCode);
		System.out.println("chenlei inLoginNo " + inLoginNo);
		System.out.println("chenlei regionCode " + regionCode);
		System.out.println("chenlei password " + password);
		System.out.println("chenlei accept " + accept);
		System.out.println("chenlei sIpAddress " + sIpAddress);
		System.out.println("chenlei groupId " + groupId);
		System.out.println("chenlei sOpTime " + sOpTime);
		System.out.println("chenlei orgCode " + orgCode);
		System.out.println("chenlei sRegionCode " + sRegionCode);
		System.out.println("chenlei sMark " + sMark);
		System.out.println("chenlei BureauId " + BureauId);
		
		/**
		 *@ ���������
		 *select * from dservordermsg where service_no like '209%'
			-[0]---------utype:
			-[0][0]--------long:110303419935
			-[0][1]--------string:q046
			-[0][2]--------string:aaaaxp
			-[0][3]--------string:EIGBDHBHPHHPMJCE
			-[0][4]--------string:10.109.221.11
			-[0][5]--------string:10031
			-[0][6]--------string:20130320 15:00:30
			-[0][7]--------string:01
			-[0][8]--------string:[aaaaxp]��[C0112090500000012]��[һ���Է��ýɷ�]
			-[0][9]--------string:01
			-[0][10]--------string:10031
			-[1]---------utype:
			-[1][0]--------string:3
			-[1][1]--------long:3
			-[1][2]--------string:aaaaxp
			-[1][3]--------string:�ڽɷѴ�ͳһ����
			-[1][4]--------long:3
			-[1][5]--------string:20130320 15:00:30
			-[1][6]--------long:2
			-[1][7]--------long:110303419935
			-[1][8]--------long:3
			-[1][9]--------string:
			-[1][10]--------string:
			-[1][11]--------string:
			-[1][12]--------long:110303419935
			-[1][13]--------utype:
			-[1][13][0]-------utype:
			-[1][13][0][0]------string:A0112090500000012
			
			select b.order_array_id from dservordermsg a ,dorderarraymsg b where  b.order_array_id = a.order_array_id and a.service_no='15045869789';
			
			RCustOrderOPChange.log
			sCustOrderDraw
		 
			System.out.println("zhouby opCode " + opCode);
		*/
		
		UType sendInfo  = new UType();
		sendInfo.setUe("LONG",   accept);//��ˮ
		sendInfo.setUe("STRING", "m022");//opcode
		sendInfo.setUe("STRING", inLoginNo);//����
		sendInfo.setUe("STRING", password);//����
		
		sendInfo.setUe("STRING", sIpAddress);//ip
		sendInfo.setUe("STRING", groupId);//groupid
		sendInfo.setUe("STRING", sOpTime);//����ʱ��
		sendInfo.setUe("STRING", sRegionCode);//regioncode
		sendInfo.setUe("STRING", sMark);	//[aaaaxp]��[����]
		sendInfo.setUe("STRING", BureauId);// regioncode
		sendInfo.setUe("STRING", groupId);	//	(String)session.getAttribute("groupId");
		
		UType orderMsg  = new UType();  
		orderMsg.setUe("STRING", "3");//3�ǳ���
		orderMsg.setUe("LONG", "3");//1 #lChangeType �������   select * from sOrderArrayChangeType t
		orderMsg.setUe("STRING", inLoginNo);//���ţ������
		orderMsg.setUe("STRING", "����");//������ݳ���
		orderMsg.setUe("LONG", "3");//���ԭ���ʾ����Ӧ����һ���µģ�
		orderMsg.setUe("STRING", sOpTime);//��ǰʱ�䴮
		orderMsg.setUe("LONG", "2");// ����������ID      (��֪����ʲô)       
		orderMsg.setUe("LONG", accept);//��ˮ
		orderMsg.setUe("LONG", "3");//��˹����ʶ    
		orderMsg.setUe("STRING", ""); //�������� 9
		orderMsg.setUe("STRING", "");//������ʱ�� 10
		orderMsg.setUe("STRING", "");//��������� 11
		orderMsg.setUe("LONG", accept);//��ˮ12
		
		UType uCustOrderId  = new UType();
		
		String sql = "select b.order_array_id from dservordermsg a ,dorderarraymsg b where  b.order_array_id = a.order_array_id and a.service_no='" + phoneNo + "'";
%>
		<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="order_array" scope="end" />
			
		var array = [];
<%
		UType uuCustOrderId  = new UType();
		
		if (order_array.length > 0){
				UType us[] = new UType[order_array.length];
				for(int i = 0; i < order_array.length; i++){
						us[i] = new UType();
						us[i].setUe("STRING", order_array[i][0]);
						System.out.println("chenlei---------order_array["+i+"]-------------" + order_array[i][0]);
						uuCustOrderId.setUe(us[i]);
				}
		}
		System.out.println("chenlei---------uuCustOrderId-------------" + uuCustOrderId);
		orderMsg.setUe(uuCustOrderId);
%>
		<wtc:utype name="sCustOrderDraw" id="retVal" scope="end" >
			 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
			 <wtc:uparam value="<%=orderMsg %>" type="UTYPE"/> 
		</wtc:utype>
<%
		if(retVal.getValue(0) != null && retVal.getValue(0).equals("0")){
				errorCode = "000000";
				System.out.println("chenlei---------errorCode1-------------" + errorCode);
		} else {
				errorCode = retVal.getValue(0); 
				System.out.println("chenlei---------errorCode2-------------" + errorCode);
		}
		
		errorMsg = retVal.getValue(1);
		if(errorMsg != null && errorMsg.length() > 35){
				errorMsg = errorMsg.substring(0,35);
		}
%>
		var response = new AJAXPacket();
		response.data.add("errorCode", "<%=errorCode%>");
		response.data.add("errorMsg", "<%=errorMsg%>");
		core.ajax.receivePacket(response);