<%
    /********************
     version v2.0
     开发商: si-tech
     *作者:linxd@2003-2-9 
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_ajax.jsp" %>
	<%@ page import="com.sitech.boss.pub.util.*" %>

<%
    String ret_code  = "";				//错误代码 
    String ret_message  = "SUCCEED";   	//错误消息         

    String region_code=request.getParameter("region_code");
		String new_cus_id=request.getParameter("new_cus_id");
  	String retType = request.getParameter("retType");  
		System.out.println("RetType = " +  retType);  
		String passwd = request.getParameter("passwd");
    String newPass = Encrypt.encrypt(passwd); 
		
		String cust_name="";
		String contact_phone="";
		String contact_address="";
		String ic_iccid="";
		String id_address="";
		String cust_passwd="";


   //String sqlStr ="select cust_id , CUST_NAME, CONTACT_PHONE, CONTACT_ADDRESS, ID_ICCID,ID_ADDRESS, cust_passwd from dcustdoc where cust_id='"+new_cus_id+"'";
   //retArray = co.sPubSelect("7",sqlStr,"region",region_code);
   
    String work_no = (String)session.getAttribute("workNo");
    String loginPwd    = (String)session.getAttribute("password");
    String notestr="根据cust_id==["+new_cus_id+"]进行查询";
%>
  <wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="m058"/>
    <wtc:param value="<%=work_no%>"/>	
    <wtc:param value="<%=loginPwd%>"/>		
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=notestr%>"/>
    <wtc:param value="<%=new_cus_id%>"/>
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value=""/>
  </wtc:service>
  <wtc:array id="returnFlag" start="0" length="1" scope="end"/>
  <wtc:array id="result" start="1" length="28" scope="end"/>
<%
  if("000000".equals(retCode1)){
    if(result.length>0){
      if("01".equals(returnFlag[0][0])){
        cust_passwd = result[0][27];
  	   	if(0==Encrypt.checkpwd2(cust_passwd,newPass))
  	   	{
  	   		ret_code = "000001";
  	   		ret_message = "客户密码错误！";
  	   	}else{
           ret_code = "000000";
  				 ret_message="校验新客户ID成功！";
  				 if(result.length>0){
  						 System.out.println("cust_name = " + result[0][1]);
  						 cust_name=result[0][4];
  						 contact_phone=result[0][16];
  						 contact_address=result[0][17];
  						 ic_iccid=result[0][12];
  						 id_address=result[0][13];
  				 }
  		 	}
      }
    }else{
      ret_code="000001";
			ret_message="没有此客户！";  
    }
  }else{
    ret_code= retCode1;
		ret_message= retMsg1;  
  }
%>

			var response = new AJAXPacket();
			var retType = "<%=retType%>";
			var retCode = "<%=ret_code%>";
			var retMessage = "<%=ret_message%>";
			var cust_name="<%=cust_name%>"
			var contact_phone="<%=contact_phone%>";
			var contact_address="<%=contact_address%>";
			var ic_iccid="<%=ic_iccid%>";
			var id_address="<%=id_address%>";
			
			response.data.add("retType",retType);
			response.data.add("retCode",retCode);
			response.data.add("retMessage",retMessage);
			response.data.add("cust_name",cust_name);
			response.data.add("contact_phone",contact_phone);
			response.data.add("contact_address",contact_address);
			response.data.add("ic_iccid",ic_iccid);
			response.data.add("id_address",id_address);
			core.ajax.receivePacket(response);
