<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
	//-------------------------��ѯ�û���ǰ������ϵ--------------------
	String servId = WtcUtil.repNull(request.getParameter("servId"));
	String workNo = (String)session.getAttribute("workNo");
  StringBuffer sb = new StringBuffer(80);
  sb.append("<table id='userHadOfferTab'><tr><td class='blue'>����ƷID</td><td class='blue'>����Ʒ����</td><td class='blue'>����Ʒ����</td><td class='blue'>����</td><td class='blue'>״̬</td><td class='blue'>��Чʱ��</td><td class='blue'>ʧЧʱ��</td><td class='blue'>����</td></tr>");
%>
<wtc:utype name="sQryOfferInst" id="retVal" scope="end">
     <wtc:uparam value="<%=servId%>" type="LONG"/>
     <wtc:uparam value="<%=workNo%>" type="string"/>
     <wtc:uparam name="opCode" type="string"/>	
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="0" type="LONG"/>			
</wtc:utype>

<%
String retrunCode =retVal.getValue(0);
String returnMsg  =retVal.getValue(1).replaceAll("\\n"," ");

System.out.println("------------------retrunCode---------------------"+retrunCode);
System.out.println("------------------returnMsg----------------------"+returnMsg);
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());

String opCodesss = WtcUtil.repNull(request.getParameter("opCode"));
	
if(retrunCode.equals("0")){
	int lineNum=retVal.getSize(2);
  int  n=0; 
  String midOfferIds="";
  String midOfferIdDivIds="";
	for(int i=0;i<lineNum;i++){
		String  actionStr = "";
		String offerInstId = retVal.getUtype("2."+i).getValue(0);
		String offerId = retVal.getUtype("2."+i).getValue(1);
		String offerName = retVal.getUtype("2."+i).getValue(2);
		String offerTypeId = retVal.getUtype("2."+i).getValue(3);
		String offerTypeName = retVal.getUtype("2."+i).getValue(4);
		String effTime = retVal.getUtype("2."+i).getValue(5);
		String expTime = retVal.getUtype("2."+i).getValue(6);
		String stateName = retVal.getUtype("2."+i).getValue(8);
		String action = retVal.getUtype("2."+i).getValue(10);
		String attrTypeName = retVal.getUtype("2."+i).getValue(14);
		String paramVal ="";
		
		if(opCodesss.equals("1272")) {
		  paramVal = offerId+"|"+offerInstId+"|"+offerName+"||"+0+"|"+1;
		}else {
			paramVal = offerId+"|"+offerInstId+"|"+offerName;
		}
		
		midOfferIds+=offerId+"|";//zhangyan
		midOfferIdDivIds+="promot"+offerId+"|";//zhangyan
		System.out.println("---------------action--------------"+action);
		if(action.substring(0,1).equals("1")){	//��һλ:�Ƿ���˶� 
			//actionStr += "<input type='button' class='b_text' value='����' id='"+paramVal+"' optype='4' name='cancelBtn' >";

			actionStr += "<input type='button' class='b_text' value='�˶�' id='"+paramVal+"' optype='3' name='cancelBtn' >";
		}
		if(action.substring(1,2).equals("1")){	//�ڶ�λ:�Ƿ�ɱ�� 
			actionStr += "<input type='button' class='b_text' value='���' id='"+paramVal+"' optype='2' name='cancelBtn' >";
		}
		if(action.substring(2,3).equals("1")){	//����λ:�Ƿ������ 
			actionStr += "<input type='button' class='b_text' value='����' id='"+paramVal+"' optype='4' name='cancelBtn' >";
		}
		if(action.substring(3,4).equals("1")){	//����λ:�Ƿ��ȡ�� 
			actionStr += "<input type='button' class='b_text' value='ȡ��' id='"+paramVal+"' optype='9' name='cancelBtn' >";
		}
		if (action.substring(4,5).equals("1"))
		{
			actionStr += "<input type='button' class='b_text' value='����' id='"+paramVal+"' optype='Y' "
				+" name='cancelBtn' >";	
		}

		//sb.append("<tr><td><input type='radio' id='"+offerId+"' value='"+offerId+"|"+offerName+"|"+effTime+"|"+expTime+"' name='oldOfferId'></td>");
		sb.append("<tr><td>"+offerId+"</td>");
		sb.append("<td  id='promot"+offerId+"' style=''>"+offerName+"</td>");
		sb.append("<td>"+attrTypeName+"</td>");
		sb.append("<td>"+offerTypeName+"</td>");
		sb.append("<td>"+stateName+"</td>");
		sb.append("<td>"
			+"<input type='text' id='eff"+offerId+"' size='8' value="+effTime.substring(0,8)+"></td>");		
		if ( action.substring(4,5).equals("1") )
		{
			sb.append("<td>"
				+"<input type='text' id='exp"+offerId+"' size='8' value="+expTime.substring(0,8)+"></td>");
		}
		else
		{
			sb.append("<td>"
				+"<input type='text' id='exp"+offerId+"' readOnly class='InputGrey' size='8' value="+expTime.substring(0,8)+"></td>");
		}
		
		sb.append("<td>"+actionStr+"<input type='button' value='����' class='b_text' name='del"+offerId+"' onClick='showdesc("+offerId+","+offerInstId+")'></td></tr>");
		
		if(offerTypeId.equals("10")){		//��������Ʒ
			sb.append("<script>thisMonthOfferIdArr["+n+"] = "+offerId+"; </script>");	//��������ƷID
		  n++;
		}
	}
			sb.append("<script>btcGetMidPrompt('10442','"+midOfferIds+"','"+midOfferIdDivIds+"');</script>");	//ע������
	//zhangyan add 
		sb.append("<script>thisMonthOfferId = thisMonthOfferIdArr[0];</script>");	//ȡ��������ƷID
}

	sb.append("</table>");
	
	System.out.println("########"+sb.toString());
%>
<%=sb%>
