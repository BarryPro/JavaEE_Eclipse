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
* 功能: 宽带小区资源信息查询
* 版本: 1.0
* 日期: 2010-11-2
* 作者: lijy
* 版权: sitech
*/
%>
<%
System.out.println("===========资源预占或释放服务的调用============");
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

/*String chName="FIELDCHNAME=pboss业务类型|操作类型|业务所属地市|业务所属区域|业务需求描述|";
chName=chName+"用途|Emos登录用户名|申请系统主工单号|产品名称|产品编号|";
chName=chName+"产品类型|产品业务状态|拟生效时间|关联产品|宽带账号|";
chName=chName+"密码|客户名称|客户地址|客户级别|客户联系人|";
chName=chName+"联系电话|联系邮箱|客户编码|新客户名称|新客户地址|";
chName=chName+"新联系电话|用户标准地址|新宽带速率|旧宽带速率|服务类型|";
chName=chName+"设备ID|设备名称|端口ID|端口名称|合作类型|";
chName=chName+"宽带对象|备注,";
String enName="FIELDENNAME=serviceOrder|type|businessCity|businessArea|businessDemand|";
enName=enName+"productApplyUses|loginNo|applyId|productName|productCode|";
enName=enName+"productType|productState|validateTime|relatedProductCode|account|";
enName=enName+"password|customerName|customerAddress|customerGrade|customerLinkMan|";
enName=enName+"customerPhone|customerMail|customerCode|newCustomerName|newCustomerAddress|";
enName=enName+"newCustomerPhone|stdAddress|newRate|oldRate|serviceType|";
enName=enName+"deviceId|deviceName|portId|portName|collType|";
enName=enName+"broadBandObject|remark,";*/
/*备注，本来同资源，小区查询类似，将传递给应用集成平台的字符串以入参的形式传给tuxedo服务，这样如果接口修改，
则只需修改jsp代码即可，但是资源预占的入参太长，只能将部分信息拼接，其它在服务中拼接*/
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
/*String chName="FIELDCHNAME=addressCode地址编码|productType产品类型|customerCode宽带账号";
String enName="FIELDENNAME=addressCode|productType|customerCode";
*/
content=content+"CRM"+"|"+serviceOrder+"|"+yzFlag+"|"+addressCode+"|"+productType+"|"+customerCode+"|"+propertyUnit+"|"+enterType;

String iMsg=content;
System.out.println("传给应用集成平台数据是 " +iMsg);
String opName="宽带开户";
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
 
 



