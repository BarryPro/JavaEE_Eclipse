<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	//-------------------------��ѯ�û���ǰ������ϵ--------------------
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo")); 
	 String groupId = (String)session.getAttribute("groupId");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  StringBuffer sb = new StringBuffer(80);
  sb.append("<table id='userHadOfferTab'><tr><td class='blue'>����ƷID</td><td class='blue'>����Ʒ����</td><td class='blue'>����Ʒ����</td><td class='blue'>����</td><td class='blue'>״̬</td><td class='blue'>��Чʱ��</td><td class='blue'>ʧЧʱ��</td><td class='blue'>����</td></tr>");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
			<wtc:service name="sQryCurOfferIns" routerKey="region" routerValue="<%=regionCode%>" outnum="11" retmsg="msg2" retcode="code2">
    		  <wtc:param value="<%=loginAccept%>"/>
    		  <wtc:param value="01"/>
    		  <wtc:param value="g538"/>
    		  <wtc:param value="<%=workNo%>"/>
    		  <wtc:param value="<%=password%>"/>
    		  <wtc:param value="<%=phoneNo%>"/>

    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>

<%

System.out.println("result_t.length======"+result_t.length);
	
if(code2.equals("000000")){
	int lineNum=result_t.length;
  int  n=0; 
  String midOfferIds="";
  String midOfferIdDivIds="";
	for(int i=0;i<lineNum;i++){
		String  actionStr = "";
		String offerInstId = result_t[i][0];
		String offerId = result_t[i][1];
		String offerName = result_t[i][2];
		String offercomments = result_t[i][3];
		String offerTypeId = result_t[i][4];
		String offerTypeName = result_t[i][5];
		String effTime = result_t[i][6];
		String expTime = result_t[i][7];
		String stateName = result_t[i][9];
		String action = result_t[i][10];
		String attrTypeName = result_t[i][9];
		String paramVal = offerId+"|0";
		
		midOfferIds+=offerId+"|";//zhangyan
		midOfferIdDivIds+="promot"+offerId+"|";//zhangyan
		System.out.println("---------------action--------------"+action);
		if(action.equals("Y")){	//��һλ:�Ƿ���˶� 
			actionStr += "<input type='button' class='b_text' value='�˶�' id='"+paramVal+"' optype='3' name='cancelBtn' >";
		}

		System.out.println("---------------2--------------");
		//sb.append("<tr><td><input type='radio' id='"+offerId+"' value='"+offerId+"|"+offerName+"|"+effTime+"|"+expTime+"' name='oldOfferId'></td>");
		sb.append("<tr><td title='"+offercomments+"'>"+offerId+"</td>");
		sb.append("<td  id='promot"+offerId+"' style='' title='"+offercomments+"'>"+offerName+"</td>");
		sb.append("<td>"+offerTypeId+"</td>");
		sb.append("<td>"+offerTypeName+"</td>");
		sb.append("<td>"+stateName+"</td>");
		sb.append("<td>"+effTime+"</td>");
		sb.append("<td>"+expTime+"</td>");
		sb.append("<td>"+actionStr+"</td></tr>");
		
	}
			sb.append("<script>btcGetMidPrompt('10442','"+midOfferIds+"','"+midOfferIdDivIds+"');</script>");	//ע������
	//zhangyan add 
		sb.append("<script>thisMonthOfferId = thisMonthOfferIdArr[0];</script>");	//ȡ��������ƷID
}

	sb.append("</table>");
	
	System.out.println("########"+sb.toString());
%>
<%=sb%>
