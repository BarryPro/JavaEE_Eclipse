<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/xservice.tld" prefix="s" %>
<%@ include file="/npage/se112/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.bean.MapBean" %>


<%
	String order_id = request.getParameter("ORDER_ID")==null?"":request.getParameter("ORDER_ID");
	String meansId   = request.getParameter("MEANS_ID")==null?"":request.getParameter("MEANS_ID");
	String cardNO   = request.getParameter("CARD_NO")==null?"":request.getParameter("CARD_NO");
	String cardCount   = request.getParameter("CARD_NO")==null?"":request.getParameter("CARD_COUNT");
	String opCode = request.getParameter("opCode")==null?"g794": request.getParameter("opCode");
	String num = request.getParameter("num")==null?"": request.getParameter("num");
	String group_id = (String)session.getAttribute("groupId");
	String login_no = (String)session.getAttribute("workNo");
	String NOTE ="";
	System.out.println("order_id============"+order_id);
	System.out.println("cardNO============"+cardNO);
	System.out.println("cardCount============"+cardCount);
	System.out.println("opCode============"+opCode);
	System.out.println("group_id============"+group_id);
	System.out.println("login_no============"+login_no);
	System.out.println("num============"+num);
	
 %>
					<s:service name="sDzCardOccupy">
								<s:param name="ROOT">
								<s:param name="REQUEST_METHOD" type="string" value="sDzCardOccupy"/>
								 <s:param name="REQUEST_INFO">
								 		<s:param name="OCCUPY_ACCEPT" type="string" value="<%=order_id%>"/>
								 		<s:param name="RES_CODE" type="string" value="<%=cardNO%>" />
								 		<s:param name="OCCUPY_CARD_NUM" type="string" value="<%=cardCount%>"/>
								 		<s:param name="LOGIN_NO" type="string" value="<%=login_no%>"/>
								 		<s:param name="GROUP_ID" type="string" value="<%=group_id%>"/>
								 		<s:param name="OP_CODE" type="string" value="<%=opCode%>"/>
								 		<s:param name="NOTE" type="string" value=""/>
									</s:param>
								</s:param>
					</s:service>


<%	
	String RETURN_CODE = result.getString("RETURN_CODE");//�ɹ�0ʧ��1�Ѿ�Ԥռ2
	String RETURN_MSG = result.getString("RETURN_MSG");//�ɹ���ʧ������	
	String OCCUPY_CARD_NO = "";//����
	String OCCUPY_CARD_NUM = "";//����
	String RES_CODE = "";//�мۿ�����
	String OCCUPY_ACCEPT = "";//���񷵻ص���ˮ
	if("0".equals(RETURN_CODE.trim())||"2".equals(RETURN_CODE.trim())){
	 OCCUPY_CARD_NO =result.getString("OCCUPY_CARD_NO");
	 OCCUPY_CARD_NUM = result.getString("OCCUPY_CARD_NUM");
	 RES_CODE = result.getString("RES_CODE");
	 OCCUPY_ACCEPT = result.getString("OCCUPY_ACCEPT");
	}
//	String OCCUPY_CARD_NO =result.getString("OCCUPY_CARD_NO");//����
//	String OCCUPY_CARD_NUM = result.getString("OCCUPY_CARD_NUM");//����
//	String RES_CODE = result.getString("RES_CODE");//�мۿ�����
//	String OCCUPY_ACCEPT = result.getString("OCCUPY_ACCEPT");//��ˮ
	System.out.println("RETURN_CODE============="+RETURN_CODE);
    System.out.println("RETURN_MSG============="+RETURN_MSG);
	System.out.println("OCCUPY_CARD_NO============="+OCCUPY_CARD_NO);
	System.out.println("OCCUPY_CARD_NUM============="+OCCUPY_CARD_NUM);
	System.out.println("OCCUPY_ACCEPT============="+OCCUPY_ACCEPT);
	System.out.println("RES_CODE============="+RES_CODE);
		
%>
	var response = new AJAXPacket();
	response.data.add("RETURN_CODE","<%=RETURN_CODE%>");
	response.data.add("RETURN_MSG","<%=RETURN_MSG%>");
	response.data.add("OCCUPY_CARD_NO","<%=OCCUPY_CARD_NO%>");
	response.data.add("OCCUPY_CARD_NUM","<%=OCCUPY_CARD_NUM%>");
	response.data.add("RES_CODE","<%=RES_CODE%>");
	response.data.add("OCCUPY_ACCEPT","<%=OCCUPY_ACCEPT%>");
	response.data.add("num","<%=num%>");

	
