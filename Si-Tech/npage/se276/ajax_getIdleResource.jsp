<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
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
	String addrCode = request.getParameter("addrCode")==null?"":request.getParameter("addrCode");
	String productTYPE = request.getParameter("productType")==null?"":request.getParameter("productType");
	String enterType = request.getParameter("enterType")==null?"":request.getParameter("enterType");
	String bandWidth = request.getParameter("bandWidth")==null?"":request.getParameter("bandWidth");
	//String flag= request.getParameter("flag")==null?"":request.getParameter("flag");
	String opName="С����Դ��ѯ";
	String areaResourceFlag="0";//�Ƿ��ѯ����Դ�ı�־��0��ʾδ��ѯ����1��ʾ��ѯ�ɹ�
	System.out.println("=========��Դ��ѯ����ĵ���========");
	System.out.println("�������");
	System.out.println("addrCode========"+addrCode);
	System.out.println("productTYPE========"+productTYPE);
	System.out.println("enterType========"+enterType);
	System.out.println("bandWidth========"+bandWidth);
  String iMsg="FIELDCHNAME=С����ַ|��Ʒ����|��������|�û�����,FIELDENNAME=distAddress|productType|inType|userBandwidth,FIELDCONTENT="+addrCode+"|"+productTYPE+"|"+enterType+"|"+bandWidth;
%>
<wtc:service name="sGAreaResource" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="2" >
		<wtc:param value="<%=iMsg%>"/>   	 	
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%
System.out.println("retcode======="+retcode);
System.out.println("retmsg======="+retmsg);
if(retcode.equals("000000")){
	System.out.println("ajax_getIdleResource.jsp  result======="+result[0][0]);
}
 //retcode="000000";
//retmsg="�ɹ�";
//result[0][0]="fieldChName=�豸����%�豸����%�ͺ�%����%IP��ַ%�豸��װ��ַ%�˿ڱ��%�˿�����%���žֱ���#�豸����%�豸����%�ͺ�%����%IP��ַ%�豸��װ��ַ%�˿ڱ��%�˿�����#%���žֱ����豸����%�豸����%�ͺ�%����%IP��ַ%�豸��װ��ַ%�˿ڱ��%�˿�����%���žֱ���#�豸����%�豸����%�ͺ�%����%IP��ַ%�豸��װ��ַ%�˿ڱ��%�˿�����#�豸����%�豸����%�ͺ�%����%IP��ַ%�豸��װ��ַ%�˿ڱ��%�˿�����%���žֱ���,fieldEnName=deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode,fieldContent=ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%��Ϊ%%��������̨�Ӳ����ز�����԰����·��̨���ƶ���˾%NN608A-GPON01-ONU007-HW-HG850-04%���%001#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%��Ϊ%%��������̨�Ӳ����ز�����԰����·��̨���ƶ���˾%NN608A-GPON01-ONU008-HW-HG850-01%���%002#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%��Ϊ%%��������̨�Ӳ����ز�����԰����·��̨���ƶ���˾%NN608A-GPON01-ONU008-HW-HG850-02%���%003#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%��Ϊ%%��������̨�Ӳ����ز�����԰����·��̨���ƶ���˾%NN608A-GPON01-ONU008-HW-HG850-03%���%004#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%��Ϊ%%��������̨�Ӳ����ز�����԰����·��̨���ƶ���˾%NN608A-GPON01-ONU008-HW-HG850-04%���%005";
 
if(retcode.equals("000000")){
%>

var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);
<%
}else{
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);
<%}%>



