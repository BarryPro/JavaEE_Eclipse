  <%@ page contentType="text/html; charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*****************************************************
 Copyright (c) SI-TECH  Version V3.0
 All rights reserved
******************************************************/
%>
<%
/*
* ����: ���С����Դ��Ϣ��ѯ
* �汾: 1.0
* ����: 2010-11-2
* ����: lijy
* ��Ȩ: sitech
*/
%>
<%
System.out.println("===========��ԴԤռ���ͷŷ���ĵ���============");
String serviceOrder = request.getParameter("serviceOrder")==null?"":request.getParameter("serviceOrder");
String type = request.getParameter("type")==null?"":request.getParameter("type");
String businessCity = request.getParameter("businessCity")==null?"":request.getParameter("businessCity");
String businessArea = request.getParameter("businessArea")==null?"":request.getParameter("businessArea");
String businessDemand = request.getParameter("businessDemand")==null?"":request.getParameter("businessDemand");
String productApplyUses = request.getParameter("productApplyUses")==null?"":request.getParameter("productApplyUses");

String loginNo = request.getParameter("loginNo")==null?"":request.getParameter("loginNo");
String applyId = request.getParameter("applyId")==null?"":request.getParameter("applyId");

String productName = request.getParameter("productName")==null?"":request.getParameter("productName");
System.out.println("productName============"+productName);
String productCode = request.getParameter("productCode")==null?"":request.getParameter("productCode");
String productType = request.getParameter("productType")==null?"":request.getParameter("productType");
String yzFlag = request.getParameter("yzFlag")==null?"":request.getParameter("yzFlag");
String productState = request.getParameter("productState")==null?"":request.getParameter("productState");
String validateTime = request.getParameter("validateTime")==null?"":request.getParameter("validateTime");
String relatedProductCode = request.getParameter("relatedProductCode")==null?"":request.getParameter("relatedProductCode");

String account = request.getParameter("account")==null?"":request.getParameter("account");
String password = request.getParameter("password")==null?"":request.getParameter("password");
String customerName = request.getParameter("customerName")==null?"":request.getParameter("customerName");
String customerAddress = request.getParameter("customerAddress")==null?"":request.getParameter("customerAddress");
String customerGrade = request.getParameter("customerGrade")==null?"":request.getParameter("customerGrade");
String customerLinkMan = request.getParameter("customerLinkMan")==null?"":request.getParameter("customerLinkMan");
String customerPhone = request.getParameter("customerPhone")==null?"":request.getParameter("customerPhone");
String customerMail = request.getParameter("customerMail")==null?"":request.getParameter("customerMail");
String customerCode = request.getParameter("customerCode")==null?"":request.getParameter("customerCode");
String newCustomerName = request.getParameter("newCustomerName")==null?"":request.getParameter("newCustomerName");
System.out.println("newCustomerName============"+newCustomerName);
String newCustomerAddress = request.getParameter("newCustomerAddress")==null?"":request.getParameter("newCustomerAddress");
String newCustomerPhone = request.getParameter("newCustomerPhone")==null?"":request.getParameter("newCustomerPhone");
System.out.println("newCustomerPhone============"+newCustomerPhone);
String stdAddress = request.getParameter("stdAddress")==null?"":request.getParameter("stdAddress");
System.out.println("27          stdAddress============"+stdAddress);
String newRate = request.getParameter("newRate")==null?"":request.getParameter("newRate");
System.out.println("28        newRate============"+newRate);
String oldRate = request.getParameter("oldRate")==null?"":request.getParameter("oldRate");
System.out.println("29         oldRate============"+oldRate);

String serviceType = request.getParameter("serviceType")==null?"":request.getParameter("serviceType");
System.out.println("30            serviceType============"+serviceType);
String deviceId = request.getParameter("deviceId")==null?"":request.getParameter("deviceId");
System.out.println("31            deviceId============"+deviceId);
String deviceName = request.getParameter("deviceName")==null?"":request.getParameter("deviceName");
System.out.println("32            deviceName============"+deviceName);
String portId = request.getParameter("portId")==null?"":request.getParameter("portId");
System.out.println("33            portId============"+portId);
String portName = request.getParameter("portName")==null?"":request.getParameter("portName");
System.out.println("34            portName============"+portName);

String collType = request.getParameter("collType")==null?"":request.getParameter("collType");
System.out.println("35           collType============"+collType);
String broadBandObject = request.getParameter("broadBandObject")==null?"":request.getParameter("broadBandObject");
System.out.println("36           broadBandObject============"+broadBandObject);
String remark = request.getParameter("opNote")==null?"":request.getParameter("opNote");
System.out.println("37           remark============"+remark);

String opCode = request.getParameter("opCode")==null?"":request.getParameter("opCode");
System.out.println("37           opcode============"+opCode);
String addressCode = request.getParameter("addressCode")==null?"":request.getParameter("addressCode");

String enterType = request.getParameter("enterType")==null?"":request.getParameter("enterType");
String propertyUnit = request.getParameter("opCode")==null?"":request.getParameter("propertyUnit");
System.out.println("37           propertyUnit============"+propertyUnit);

/*String chName="FIELDCHNAME=pbossҵ������|��������|ҵ����������|ҵ����������|ҵ����������|";
chName=chName+"��;|Emos��¼�û���|����ϵͳ��������|��Ʒ����|��Ʒ���|";
chName=chName+"��Ʒ����|��Ʒҵ��״̬|����Чʱ��|������Ʒ|����˺�|";
chName=chName+"����|�ͻ�����|�ͻ���ַ|�ͻ�����|�ͻ���ϵ��|";
chName=chName+"��ϵ�绰|��ϵ����|�ͻ�����|�¿ͻ�����|�¿ͻ���ַ|";
chName=chName+"����ϵ�绰|�û���׼��ַ|�¿������|�ɿ������|��������|";
chName=chName+"�豸ID|�豸����|�˿�ID|�˿�����|��������|";
chName=chName+"�������|��ע,";
String enName="FIELDENNAME=serviceOrder|type|businessCity|businessArea|businessDemand|";
enName=enName+"productApplyUses|loginNo|applyId|productName|productCode|";
enName=enName+"productType|productState|validateTime|relatedProductCode|account|";
enName=enName+"password|customerName|customerAddress|customerGrade|customerLinkMan|";
enName=enName+"customerPhone|customerMail|customerCode|newCustomerName|newCustomerAddress|";
enName=enName+"newCustomerPhone|stdAddress|newRate|oldRate|serviceType|";
enName=enName+"deviceId|deviceName|portId|portName|collType|";
enName=enName+"broadBandObject|remark,";*/
/*��ע������ͬ��Դ��С����ѯ���ƣ������ݸ�Ӧ�ü���ƽ̨���ַ�������ε���ʽ����tuxedo������������ӿ��޸ģ�
��ֻ���޸�jsp���뼴�ɣ�������ԴԤռ�����̫����ֻ�ܽ�������Ϣƴ�ӣ������ڷ�����ƴ��*/
String content="FIELDCONTENT=";
/*
content=content+"CRM"+"|"+serviceOrder+"|"+type+"|"+businessCity+"|"+businessArea+"|"+businessDemand+"|";
content=content+productApplyUses+"|"+loginNo+"|"+applyId+"|"+productName+"|"+productCode+"|";
content=content+productType+"|"+productState+"|"+validateTime+"|"+relatedProductCode+"|"+account+"|";
content=content+password+"|"+customerName+"|"+customerAddress+"|"+customerGrade+"|"+customerLinkMan+"|";
content=content+customerPhone+"|"+customerMail+"|"+customerCode+"|"+newCustomerName+"|"+newCustomerAddress+"|";
content=content+newCustomerPhone+"|"+stdAddress+"|"+newRate+"|"+oldRate+"|"+serviceType+"|";
content=content+deviceId+"|"+deviceName+"|"+portId+"|"+portName+"|"+collType+"|";
content=content+broadBandObject+"|"+remark;
*/
/*String chName="FIELDCHNAME=addressCode��ַ����|productType��Ʒ����|customerCode����˺�";
String enName="FIELDENNAME=addressCode|productType|customerCode";
*/
content=content+"CRM"+"|"+serviceOrder+"|"+yzFlag+"|"+addressCode+"|"+productType+"|"+customerCode+"|"+propertyUnit+"|"+enterType;

String iMsg=content;
System.out.println("����Ӧ�ü���ƽ̨������ " +iMsg);
String opName="�������";
%>
<wtc:service name="sYzResource" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="2" >
	  <wtc:param value="<%=iMsg%>"/> 
		<wtc:param value="<%=opCode%>"/>   
		<wtc:param value="<%=loginNo%>"/>  	 	 	
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%

System.out.println("retcode========="+retcode);
System.out.println("retmsg========="+retmsg);
System.out.println("result========="+result.length);
for(int i = 0; i < result.length; i++){
	for(int j = 0; j < result[i].length; j++){
		System.out.println("result["+i+"]["+j+"]========="+result[i][j]);
	}
}
if(!retcode.equals("000000")){
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retcode%>");
response.data.add("retMsg","<%=retmsg%>");
response.data.add("iType","<%=yzFlag%>");
core.ajax.receivePacket(response);
<%}else{%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retcode%>");
response.data.add("retMsg","<%=retmsg%>");
response.data.add("retContent","<%=result[0][0]%>");
response.data.add("iType","<%=yzFlag%>");
core.ajax.receivePacket(response);
<%}%>
 
 



