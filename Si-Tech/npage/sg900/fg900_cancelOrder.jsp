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
		System.out.println("hejwa--------------- accept " + accept);
		System.out.println("hejwa--------------- phoneNo " + phoneNo);
		System.out.println("hejwa--------------- opCode " + opCode);
		String sIpAddress = request.getRemoteAddr();
		String groupId = (String)session.getAttribute("groupId");
		String sOpTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
		String orgCode = (String)session.getAttribute("orgCode");
		String sRegionCode = regionCode.substring(0,2);
		String sMark="["+inLoginNo+"]��[" + phoneNo + "]��[����]";
		String BureauId = regionCode.substring(0,2);

		String errorCode = "";
		String errorMsg = "";
try{	
		
		UType sendInfo  = new UType();
		sendInfo.setUe("LONG",   accept);//��ˮ
		sendInfo.setUe("STRING", opCode);
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
						System.out.println("hejwa---------order_array["+i+"]-------------" + order_array[i]);
						uuCustOrderId.setUe(us[i]);
				}
		}
		
		orderMsg.setUe(uuCustOrderId);
%>
		<wtc:utype name="sCustOrderDraw" id="retVal" scope="end" >
			 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
			 <wtc:uparam value="<%=orderMsg %>" type="UTYPE"/> 
		</wtc:utype>
<%
		if(retVal.getValue(0) != null && retVal.getValue(0).equals("0")){
				errorCode = "000000";
		} else {
				errorCode = retVal.getValue(0); 
		}
		
		errorMsg = retVal.getValue(1);
		if(errorMsg != null && errorMsg.length() > 35){
				errorMsg = errorMsg.substring(0,35);
		}
}catch(Exception e){
		errorCode = "40404";
		errorMsg  = "���÷���ϵͳ��������ϵ����Ա";
}
		
%>
		var response = new AJAXPacket();
		response.data.add("code", "<%=errorCode%>");
		response.data.add("msg", "<%=errorMsg%>");
		core.ajax.receivePacket(response);