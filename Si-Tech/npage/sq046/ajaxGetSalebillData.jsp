<%
/********************
 version v2.0
������: si-tech
*
*hejwa ȡӪ����Ʊ����
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
		String regionCode    = (String)session.getAttribute("regCode");
		String custOrderId   = request.getParameter("custOrderId");
		String opCodeBillPrt = request.getParameter("opCodeBillPrt");
		String billFlag      = request.getParameter("billFlag");
		String iFlag         = request.getParameter("iFlag");
		String retCode       = "";
		String retMsg        = "";
		String searchDate   = WtcUtil.repNull(request.getParameter("searchDate"));
		String opflag   = WtcUtil.repNull(request.getParameter("opflag"));
		
		System.out.println("mylog--custOrderId--"+custOrderId);
		System.out.println("mylog--billFlag-----"+billFlag);
		
try{		
%>
	<wtc:utype   name="sGetPrintInfo" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=custOrderId%>" type="String"/> 
		<wtc:uparam value="<%=billFlag%>"    type="int"/> 	
		<wtc:uparam value="<%=searchDate%>" type="String"/> 
	</wtc:utype>
<%
      retCode = retVal.getValue(0);
      retMsg  = retVal.getValue(1).replace('\n',' ');
     System.out.println("mylog--retCode------"+retCode);
     System.out.println("mylog--retMsg-------"+retMsg);
     System.out.println("mylog--retVal.getSize(2)-------"+retVal.getSize("2"));
		out.print("var retArr = new Array();");
	if(retVal.getSize("2")>0){
		out.print("retArr[0]  = '"+retVal.getValue("2.0.0") +"';");   //--�ͻ�������                                    
		out.print("retArr[1]  = '"+retVal.getValue("2.0.1") +"';");   //--ҵ������                                      
		out.print("retArr[2]  = '"+retVal.getValue("2.0.2") +"';");   //--�ͻ�����                                      
		out.print("retArr[3]  = '"+retVal.getValue("2.0.3") +"';");   //--�ֻ�����                                      
		out.print("retArr[4]  = '"+retVal.getValue("2.0.4") +"';");   //--��ӡ��ʶ��0�ϴ�1�ִ�                        
		out.print("retArr[5]  = '"+retVal.getValue("2.0.5") +"';");   //--��ӡ��ʶΪ0ʱ�Ǻϼƽ�(��д)��Ϊ1ʱ�ǹ�����
		out.print("retArr[6]  = '"+retVal.getValue("2.0.6") +"';");   //--��ӡ��ʶΪ0ʱ��(Сд)��Ϊ1ʱ�ǣ�              
		out.print("retArr[7]  = '"+retVal.getValue("2.0.7") +"';");   //--��ӡ��ʶΪ1ʱ��Ч��ר��(��д)                 
		out.print("retArr[8]  = '"+retVal.getValue("2.0.8") +"';");   //--��ӡ��ʶΪ1ʱ��Ч����(Сд)                   
		out.print("retArr[9]  = '"+retVal.getValue("2.0.9") +"';");   //--�ն�Ʒ��                                      
		out.print("retArr[10] = '"+retVal.getValue("2.0.10")+"';");   //--�ն��ͺ�                                      
		out.print("retArr[11] = '"+retVal.getValue("2.0.11")+"';");   //--IMEI                                          
		out.print("retArr[12] = '"+retVal.getValue("2.0.12")+"';");   //--��Ʊ��                                        
		out.print("retArr[13] = '"+retVal.getValue("2.0.13")+"';");   //--������Ϣ     
		out.print("retArr[14] = '"+retVal.getValue("2.0.14")+"';");   //--����� 
		out.print("retArr[18] = '"+retVal.getValue("2.0.15")+"';");   //--�������
		out.print("retArr[19] = '"+retVal.getValue("2.0.16")+"';");   //--δ���˻���
		out.print("retArr[20] = '"+retVal.getValue("2.0.17")+"';");   //--��ǰ�������    
		out.print("retArr[21] = '"+retVal.getValue("2.0.18")+"';");   //--���ɽ�
		if(opflag.equals("g795")) {
				out.print("retArr[23] = '"+retVal.getValue("2.0.21")+"';");   //--�������
				out.print("retArr[24] = '"+retVal.getValue("2.0.22")+"';");   //--δ���˻���
				out.print("retArr[25] = '"+retVal.getValue("2.0.23")+"';");   //--��ǰ�������
				out.print("retArr[26] = '"+retVal.getValue("2.0.24")+"';");   //--���ɽ�
				out.print("retArr[27] = '"+retVal.getValue("2.0.25")+"';");   //--����ʱ��Ĵ�ӡ��ʶ
		}
		out.print("retArr[15] = '"+retVal.getValue("2.1.0")+"';");   //--˰��     
		out.print("retArr[16] = '"+retVal.getValue("2.1.1")+"';");   //--˰��    
		out.print("retArr[17] = '"+retVal.getValue("2.1.2")+"';");   //--˰��
		
		
		System.out.println("mylog------�ͻ������� -------------------retArr[0]  = '"+   retVal.getValue("2.0.0") +"';");   //--�ͻ�������                                    
		System.out.println("mylog------ҵ������   -------------------retArr[1]  = '"+   retVal.getValue("2.0.1") +"';");   //--ҵ������                                      
		System.out.println("mylog------�ͻ�����   -------------------retArr[2]  = '"+   retVal.getValue("2.0.2") +"';");   //--�ͻ�����                                      
		System.out.println("mylog------�ֻ�����   -------------------retArr[3]  = '"+   retVal.getValue("2.0.3") +"';");   //--�ֻ�����                                      
		System.out.println("mylog------��ӡ��ʶ��0-------------------retArr[4]  = '"+   retVal.getValue("2.0.4") +"';");   //--��ӡ��ʶ��0�ϴ�1�ִ�                        
		System.out.println("mylog------��ӡ��ʶΪ0-------------------retArr[5]  = '"+   retVal.getValue("2.0.5") +"';");   //--��ӡ��ʶΪ0ʱ�Ǻϼƽ�(��д)��Ϊ1ʱ�ǹ�����
		System.out.println("mylog------��ӡ��ʶΪ0-------------------retArr[6]  = '"+   retVal.getValue("2.0.6") +"';");   //--��ӡ��ʶΪ0ʱ��(Сд)��Ϊ1ʱ�ǣ�              
		System.out.println("mylog------��ӡ��ʶΪ1-------------------retArr[7]  = '"+   retVal.getValue("2.0.7") +"';");   //--��ӡ��ʶΪ1ʱ��Ч��ר��(��д)                 
		System.out.println("mylog------��ӡ��ʶΪ1-------------------retArr[8]  = '"+   retVal.getValue("2.0.8") +"';");   //--��ӡ��ʶΪ1ʱ��Ч����(Сд)                   
		System.out.println("mylog------�ն�Ʒ��   -------------------retArr[9]  = '"+   retVal.getValue("2.0.9") +"';");   //--�ն�Ʒ��                                      
		System.out.println("mylog------�ն��ͺ�   -------------------retArr[10] = '"+   retVal.getValue("2.0.10")+"';");   //--�ն��ͺ�                                      
		System.out.println("mylog------IMEI       -------------------retArr[11] = '"+   retVal.getValue("2.0.11")+"';");   //--IMEI                                          
		System.out.println("mylog------��Ʊ��     -------------------retArr[12] = '"+   retVal.getValue("2.0.12")+"';");   //--��Ʊ��                                        
		System.out.println("mylog------������Ϣ   -------------------retArr[13] = '"+   retVal.getValue("2.0.13")+"';");   //--������Ϣ     

			
	}
	
}catch(Exception e){
		 e.printStackTrace();
	    retCode = "444444";
      retMsg  = "ϵͳ��������ϵ����Ա";
}
%>		
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("opCodeBillPrt","<%=opCodeBillPrt%>");
response.data.add("iFlag","<%=iFlag%>");
response.data.add("getbillArr",retArr);
core.ajax.receivePacket(response);