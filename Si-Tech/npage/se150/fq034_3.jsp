<%
   /*
   * ����: ������װ��ѯ(������װ)��ҳ��ѯ_2
�� * �汾: v1.0
�� * ����: 2009/01/30
�� * ����: jiangxl
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
     20110726      lijy        ���ӿ��
 ��*/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>		

<%
	String regionCode =(String)session.getAttribute("regCode");
	regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);	//-------------lgz
	String lLoginAccept="";
	
	String workNo = (String)session.getAttribute("workNo");
	int valid = 1;	//0:��ȷ��1��ϵͳ����2��ҵ�����
	String errorCode="444444";
	String errorMsg="ϵͳ��������ϵͳ����Ա��ϵ��лл!!";
	String strArray="var arrMsg; ";  //must 
	String strArray2="var arrMsg2; ";  //must y

	//utSetInt(puOrderChgIn, 0, 5);
	//utSetStr(puOrderChgIn, 1,���д���);
	//utSetStr(puOrderChgIn, 2, "");

%>

<wtc:utype name="sGetSeqNo" id="retSeqNo" scope="end" >
		<wtc:uparam value="5" type="int"/>
		<wtc:uparam value="<%=regionCode%>" type="string"/>
		<wtc:uparam value="" type="string"/>
</wtc:utype>
	<%
if(retSeqNo.getValue(0)!=null&&retSeqNo.getValue(0).equals("0")){
			if(retSeqNo.getSize() > 2 && retSeqNo.getUtype("2").getSize() > 0 ){
				lLoginAccept = retSeqNo.getValue("2.0");
			} 	
}else{
			errorCode=retSeqNo.getValue(0);
			if("000000".equals(errorCode)) errorCode="sGetSeqNo";
        	errorMsg = retSeqNo.getValue(1);  
			if(errorMsg!=null&&errorMsg.length()>35){
				errorMsg=errorMsg.substring(0,35);
			}
}

%>


<%	
	String posSubStr = request.getParameter("posSubArr");
	String retType = request.getParameter("retType");
	String phoneNo = request.getParameter("phoneNo");
	String stateFlag = request.getParameter("stateFlag");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String startRow = request.getParameter("startRow");
	String workName = request.getParameter("workName");
	String printAccept = request.getParameter("loginAccept");
	String endRow = request.getParameter("endRow");
	String sqlCondition =" and login_no='"+workNo+"'";
	if(!"".equals(phoneNo)) sqlCondition+=" and phone_no ='"+phoneNo+"'";
	if(!"".equals(stateFlag)) sqlCondition+=" and pre_flag ='"+stateFlag+"'";
	if(!"".equals(startTime)) sqlCondition+=" and  to_char(pre_time,'YYYYMMDD') >= '"+startTime+"'";
	// sqlCondition+=" and pre_time >= TO_DATE('"+startTime+"','yyyyMMdd')";
	if(!"".equals(endTime)) sqlCondition+=" and  to_char(pre_time,'YYYYMMDD')  <= '"+endTime+"'";
	//sqlCondition+=" and  pre_time<=TO_DATE('"+endTime+"','yyyyMMdd')";
		
  int recordNum = 0;
  String[][] result = null;


	String quetype=request.getParameter("quetype");
	String quetypes="";
	String quevalue=request.getParameter("quevalue");
	String orderSelectId=request.getParameter("orderSelectId");
	String opcodestr=request.getParameter("opcodestr");
	//lijy add@20110726
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String functionCode=request.getParameter("functionCode");
	
	//lijy add end 
	String custname="";
	String operater="";
	String orderstat="";
	String orderSelect="";
	if(quetype!=null&&quetype.equals("21")){
		quetype="2";
		quetypes="21";
	}
	System.out.println(quetype+"######################################");
	if(opcodestr==null||opcodestr.equals("")){
		opcodestr="1";
	}

	String orgCode = (String)session.getAttribute("orgCode");
	//Long lLoginAccept=new Long("2000012805097");
	if(opCode.equals("e083") && printAccept != null){
		lLoginAccept=printAccept;
	}
	String sOpCode=request.getParameter("opcodestr");	//="sq034";		//sq034 #sOpCode
	if(sOpCode==null||sOpCode.equals("")){
		sOpCode="1";
	}
	//3��������4��װ 5�ߵ���6 ��װ 9 ��װ�ָ�
	String sOPType="3";
	String sername="sCustOrderDraw"; 
	String opNamestr="";
	if(sOpCode.equals("1")){
		/*sOpCode="q034";	
		opNamestr = "����";	*/
		//lijy change @20110726 for ���
		sOpCode=opCode;	
		if("4977".equals(functionCode)){
			sOpCode = "e083";
		}else if("b542".equals(functionCode)){
			sOpCode = "e300";
		}
		opNamestr = opName;
	}else if(sOpCode.equals("2")){
		opNamestr = "����";
		if(quetype=="e150"){//�˵�����
			sOpCode="e150";
			sOPType="3";
		}else if(quetype=="q035"){//�˵�����
			opNamestr = "�ߵ�";		
			sOpCode="q038";	
			sOPType="5";
			sername="sCustOrderHurry";
		}
	}else if(sOpCode.equals("3")){
		/*opNamestr = "�ߵ�";		
		sOpCode="q038";	*/
		//lijy change @20110726 for ���
		sOpCode = opCode;	
		opNamestr = opName;
		sOPType="5";
		sername="sCustOrderHurry";
	}else if(sOpCode.equals("4")){
		opNamestr = "��װ";
		sOpCode="q035";	
		sOPType="6";
		sername="sCustOrderWait";
	}else if(sOpCode.equals("5")){
		/*opNamestr = "��װ";
		sOpCode="q036";	*/
		//lijy change @20110726 for ���
		sOpCode = opCode;	
		opNamestr = opName;
		sOPType="4";
		sername="sCustOrderDelay";
	}else if(sOpCode.equals("9")){//lijy add@20110726 for���
		sOpCode = opCode;	
		opNamestr = opName;
		sOPType="9";
		sername="sCustOrderDelbk";
	}
	
	System.out.println("----------------sername----------------"+sername);
	String sLoginNo=(String)session.getAttribute("workNo");
	String sLoginPwd=(String)session.getAttribute("password");
	String sIpAddress=request.getRemoteAddr();	//"172.16.24.100";	//request.getRemoteAddr();
	
  String  groupId = (String)session.getAttribute("groupId");
	String sOprGroupId=groupId;
	
	String sOpTime=new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());//"20080912 09:59:01";
	//String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String _orderID=request.getParameter("_orderID");
	if(_orderID.indexOf("->")!=-1) _orderID = _orderID.substring(0,_orderID.indexOf("->"));
	String sRegionCode=orgCode.substring(0,2);
	String sMark="["+workName+"]��["+_orderID+"]��["+opNamestr+"]";
	
	//����������Ϣ���ഫ��һ��������ע
	System.out.println(sMark+"###################");
	String BureauId=regionCode;	// #BureauId �����
	String ObjectId=groupId;	// #ObjectId �����

	sOPType=sOPType;	//3 #sOPType ��������          3��������4����װ�� 5���ߵ�  ��6��װ  
	String sCustOrderId=request.getParameter("quevalue");	//"A1009020300000000|A1009020300000001";	//1000001001|1000001000 #sCustOrderId ���������ַ���        0
	//#String C0208091200000001 #sCustOrderId �ͻ��������         0
	//lLoginAccept=new Long("2000012805097");
	lLoginAccept=lLoginAccept;
	//long lChangeType=1;	//1 #lChangeType �������                               1
	String lChangeType=sOPType;		//1 #lChangeType �������   select *from sOrderArrayChangeType t          1   
	String sChangeLogin=(String)session.getAttribute("workNo");	//ba0001 #sChangeLogin �����                          2
	String sChangeContent=request.getParameter("reasonDescription");	//"�ͻ������˵���";	//�ͻ������˵��� #sChangeContent �����������          3 
	//long lChangeReason=1;	// ���ԭ���ʶid 1���ͻ�����            4
	String lChangeReason=request.getParameter("reasonType");	//--"1";	// ���ԭ���ʶid 1���ͻ�����            4
	String sChangeDate=sOpTime; //"20090119 09:01:01";	//20090119 09:01:01 #sChangeDate ���ʱ��              5
	//long lChangeAuditResultId=0;	//#lChangeAuditResultId ����������ID                 6
	String lChangeAuditResultId="2";	//#lChangeAuditResultId ����������ID                 6

	//lLoginAccept=new Long("2000012805097");	//2000012805097 #lLoginAccept �����ˮ 
	//long lAuditRule=3;	//3 #lAuditRule ��˹����ʶ                             8
	lLoginAccept=lLoginAccept;	//2000012805097 #lLoginAccept �����ˮ 
	String lAuditRule="3";	//3 #lAuditRule ��˹����ʶ                             8

	String sAuditLogin="";	//sLoginNo;	//"badmin";	//badmin #sAuditLogin ��������                       9
	String sChangeAuditDate="";	//sOpTime; //"20090120 09:59:01";	//20090120 09:59:01 #sChangeAuditDate ������ʱ��     10
	String sAuditSuggestion="";	//"����ͨ��";	//����ͨ�� #sAuditSuggestionI ����������
	//Long lAuditLoginAccept=new Long("2000012805098");
	String lAuditLoginAccept=lLoginAccept;	// #lAuditLoginAccept �����ˮ
%>
	<%

UType sendInfo  = new UType();  
sendInfo.setUe("LONG",   lLoginAccept);//��ˮ
sendInfo.setUe("STRING", sOpCode);
sendInfo.setUe("STRING", sLoginNo);//����
sendInfo.setUe("STRING", sLoginPwd);//����
sendInfo.setUe("STRING", sIpAddress);//ip
sendInfo.setUe("STRING", sOprGroupId);//groupid
sendInfo.setUe("STRING", sOpTime);//����ʱ��
sendInfo.setUe("STRING", sRegionCode);//regioncode
sendInfo.setUe("STRING", sMark);	//[aaaaxp]��[����]";
sendInfo.setUe("STRING", BureauId);// regioncode
sendInfo.setUe("STRING", ObjectId);//	(String)session.getAttribute("groupId");

UType orderMsg  = new UType();  
orderMsg.setUe("STRING", sOPType);//3�ǳ���
//orderMsg.setUe("STRING", sCustOrderId);//ҵ�����û����������֪����ô��ù���dservordermsg 
orderMsg.setUe("LONG", lChangeType);////1 #lChangeType �������   select *from sOrderArrayChangeType t
orderMsg.setUe("STRING", sChangeLogin);//���ţ������
orderMsg.setUe("STRING", sChangeContent);//�������"������
orderMsg.setUe("LONG", lChangeReason);//���ԭ���ʾ����Ӧ����һ���µģ�
orderMsg.setUe("STRING", sChangeDate);//��ǰʱ�䴮
orderMsg.setUe("LONG", lChangeAuditResultId);// ����������ID      (��֪����ʲô)       
orderMsg.setUe("LONG", lLoginAccept);//��ˮ
orderMsg.setUe("LONG", lAuditRule);//��˹����ʶ    
orderMsg.setUe("STRING", sAuditLogin); //��������
orderMsg.setUe("STRING", sChangeAuditDate);//������ʱ��
orderMsg.setUe("STRING", sAuditSuggestion);//���������
orderMsg.setUe("LONG", lAuditLoginAccept);//��ˮ

 
UType uCustOrderId  = new UType();
String sCustOrderIds[]=sCustOrderId.split(",");
UType us[]=new UType[sCustOrderIds.length];
UType uuCustOrderId  = new UType();
for(int i=0;i<sCustOrderIds.length;i++){
	us[i]=new UType();
	us[i].setUe("STRING", sCustOrderIds[i]);
	uuCustOrderId.setUe(us[i]);
}
orderMsg.setUe(uuCustOrderId);



UType PosInfoUtype  = new UType();



String posArrInfo1[] = posSubStr.split("#");
for(int i=0;i<posArrInfo1.length&&(!"".equals(posArrInfo1[i]));i++){
	UType PosInfoUtype1  = new UType();
	String tempArrIn[] = posArrInfo1[i].split("\\|",-1);
	for(int j=0;j<tempArrIn.length;j++){
		PosInfoUtype1.setUe("STRING",tempArrIn[j]);
	}
	PosInfoUtype.setUe(PosInfoUtype1);
}

	System.out.println("\r\n\r\n\r\n\r\n-----------��������ο�ʼ-----------------------sername--------"+sername);
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(PosInfoUtype,1,"2",logBuffer);		
	System.out.println(logBuffer.toString());
	System.out.println("-----------��������ν���-------------------------------\r\n\r\n\r\n\r\n");
%>

<wtc:utype name="<%=sername %>" id="retVal" scope="end" >
	 <wtc:uparam value="<%=sendInfo %>" type="UTYPE"/> 
	 <wtc:uparam value="<%=orderMsg %>" type="UTYPE"/> 
	 <wtc:uparam value="<%=PosInfoUtype %>" type="UTYPE"/> 
</wtc:utype>
<%
if(retVal.getValue(0)!=null&&retVal.getValue(0).equals("0")){
			errorCode="000000";
      errorMsg = retVal.getValue(1);   	
}


if(retVal!=null&&retVal.getSize()>1){
	errorCode=retVal.getValue(0);
	if("000000".equals(errorCode)) errorCode=sername;
	errorMsg=retVal.getValue(1);
	if(errorMsg!=null&&errorMsg.length()>35){
	
		errorMsg=errorMsg.substring(0,35);
	}
}

%>   

var response = new AJAXPacket();
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
response.data.add("retType","<%= retType %>");

core.ajax.receivePacket(response);


