<%
/********************
 version v2.0
������: si-tech
********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% 
	//ALT= //�ڴ˴���ȡsession��Ϣ ArrayList arr = 
	//(ArrayList)session.getAttribute("allArr"); 
	//String[][] str1 = (String[][])arr.get(0);//��ȡ��½��Ϣ 
	//String[][] info = (String[][])arr.get(2);//��ȡ��½IP����ɫ���ƣ����ڲ��ţ���ϣ� 
	//String[][] password = (String[][])arr.get(4);//��ȡ��������
	//String work_name = str1[0][2];
	//String work_name = (String)session.getAttribute("workName");
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//paraAray[1] = password[0][0];
	//paraAray[5] = info[0][2];          
		
	String paraAray[] = new String[13];

	paraAray[0] =  (String)session.getAttribute("workNo");                           //0  ��������                iLoginNo                     //1  ��������                iLoginPwd
	paraAray[1] = (String)session.getAttribute("password");
	paraAray[2] = request.getParameter("iOpCode");            //2                          iOpCode
	paraAray[3] = request.getParameter("phoneNo");            //3  �ƶ�����                iPhoneNo
	paraAray[4] = request.getParameter("printAccept");        //4 ��ӡ��ˮ                 printAccept                       //5 ��¼IP                   iIpAddr
	paraAray[5] = (String)session.getAttribute("ipAddr");
	paraAray[6] = request.getParameter("opNote");             //6 ������־                 iOpNote
	paraAray[7] = request.getParameter("saleType");            //7 Ӫ��������              saleType
	paraAray[8] = request.getParameter("pay_phone_fee");       //8 ���ֻ���                pay_phone_fee
	paraAray[9] = request.getParameter("pay_product_fee");     //9 ������Ʒ��              pay_product_fee
	paraAray[10] = request.getParameter("phone_type");         //10 �ֻ�����               phone_type
	paraAray[11] = request.getParameter("product_type");       //11 ��Ʒ����               product_type
	paraAray[12] = request.getParameter("loginAccept");        //12 ԭҵ����ˮ             oldLoginAccept
	String phone_no = paraAray[3];
	String callSerName="";  //huangrong ����callSerName ��ѯ�û��������� 2011-1-12
	//String service_name = "s804601Cfm";
	//String[] ret = impl.callService(service_name,paraAray,"2","phone_no",phone_no);
	//int ret_code = impl.getErrCode();
  //String ret_msg = impl.getErrMsg();
  //begin huangrong �����ж����Ӫ����������ǩԼ�Żݹ�������÷���s804602Cfm��������÷���s804601Cfm 2011-1-12
if(paraAray[7]=="33" || paraAray[7].equals("33")|| paraAray[7].equals("54")||paraAray[7]=="54" || paraAray[7].equals("39")||paraAray[7]=="39")
{
	callSerName="s804602Cfm";
}else
{
	callSerName="s804601Cfm";
}
System.out.println("---------------------------callSerName---------------------"+callSerName);
 //end huangrong �����ж����Ӫ����������ǩԼ�Żݹ�������÷���s804602Cfm��������÷���s804601Cfm 2011-1-12
%>
    <wtc:service name="<%=callSerName%>" outnum="2" routerKey="phone_no" routerValue="<%=phone_no%>">
		 <wtc:param value="<%=paraAray[0]%>" />
		 <wtc:param value="<%=paraAray[1]%>" />
		 <wtc:param value="<%=paraAray[2]%>" />
		 <wtc:param value="<%=paraAray[3]%>" />
		 <wtc:param value="<%=paraAray[4]%>" />
		 <wtc:param value="<%=paraAray[5]%>" />
		 <wtc:param value="<%=paraAray[6]%>" />
		 <wtc:param value="<%=paraAray[7]%>" />
		 <wtc:param value="<%=paraAray[8]%>" />
		 <wtc:param value="<%=paraAray[9]%>" />
		 <wtc:param value="<%=paraAray[10]%>"/>
		 <wtc:param value="<%=paraAray[11]%>"/>
		 <wtc:param value="<%=paraAray[12]%>"/>
		 </wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	System.out.println("----------hejw---------retCode-----------"+retCode);
	if((retCode.equals("000000"))&&(paraAray[2].equals("8046")))
	{
%>
<script language="javascript">
	//begin huangrong �޸�
	rdShowMessageDialog("ȷ�ϳɹ�! ",2);
	window.location="f8046_index.jsp?opCode=8046&opName=Ӫ����ȡ��&activePhone="+<%=phone_no%>;
	//end huangrong �޸�
</script>
<%
	}
	else{
%>
<script language="JavaScript">
	//begin huangrong �޸�
	rdShowMessageDialog("Ԥ�滰���Żݹ���ȡ��ȷ��ʧ��!(<%=retMsg%>",0);
	window.location="f8046_index.jsp?opCode=8046&opName=Ӫ����ȡ��&activePhone="+<%=phone_no%>;
	//end huangrong �޸�
</script>
<%}%>

