<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	//�õ��������
	String id_iccid = "";
	String id_address = "";
	String cust_name = "";
			
	//�õ��������

	String work_no = (String) session.getAttribute("workNo");
	String work_name =(String) session.getAttribute("workName");
	String org_code =(String) session.getAttribute("orgCode");
	String pass = (String) session.getAttribute("password");	
	String strUserPasswd = "";
	String regionCode = org_code.substring(0,2);
	String strPhoneNo =request.getParameter("phone_no");
	String strCustPasswd =request.getParameter("cus_pass");
	System.out.println("strPhoneNo="+strPhoneNo);
	System.out.println("strCustPasswd="+strCustPasswd);

  String return_code="000000";
  String return_msg="У�鴦��ɹ�";//�����ж�ҳ��ս���ʱ����ȷ��

 	String cust_names = "";
 	String bp_name = "";
 	String IccId = "";
 	String cust_address = "";
 	String passwordFromSer = "";
  
 //ȡ�û�������Ϣ
	//SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
	//ArrayList retArray1 = new ArrayList();
	// String[][] result1 = new String[][]{};
	//retArray1 = callView1.sPubSelect("4",sqlStr);
  
  String notestr="����phone_no==["+strPhoneNo+"]���в�ѯ";
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="2849"/>
  <wtc:param value="<%=work_no%>"/>	
  <wtc:param value="<%=pass%>"/>		
  <wtc:param value="<%=strPhoneNo%>"/>	
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result1" start="1" length="40" scope="end"/>
<%					
  if("000000".equals(retCode1)){
    if(result1.length>0){
      if("00".equals(returnFlag[0][0])){
  	   	cust_name = (result1[0][4]).trim();
        id_iccid = (result1[0][12]).trim();
        id_address = (result1[0][13]).trim();
        passwordFromSer = (result1[0][39]).trim();
        
        if (cust_name.equals("")){
      		return_code = "000001";
      	  return_msg = "�û����������ϢΪ�ջ򲻴���!<br>";
       	}
      }
    }
  }
  
 
  String handFee_Favourable = "readonly";        //a230  ������
//begin add by diling for ������Ȩ������ @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = "2849";
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======f2849phoneqry.jsp==== pwrf = " + pwrf);
//end add by diling  
  
  
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
    System.out.println("enter");

	   String passFromPage=Encrypt.encrypt(passTrans);
	    
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	
	   {
	    System.out.println("passFromPage="+passFromPage);
	    System.out.println("passwordFromSer="+passwordFromSer);

       return_code = "1";
       return_msg = "�������!";
	  }
  }
  
if (pwrf){
System.out.println("2password is ture");
}else{
	System.out.println("2password is false");
} 
	
%>

var response = new AJAXPacket();
var id_iccid = "<%=id_iccid%>";
var id_address = "<%=id_address%>";
var cust_name = "<%=cust_name%>";
var cust_passwd = "<%=strUserPasswd%>";
var return_code = "<%=return_code%>";
var return_msg = "<%=return_msg%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page","phoneqry");
response.data.add("id_iccid",id_iccid);
response.data.add("id_address",id_address);
response.data.add("cust_name",cust_name);
response.data.add("cust_passwd",cust_passwd);
response.data.add("return_code",return_code);
response.data.add("return_msg",return_msg);
core.ajax.receivePacket(response);


 