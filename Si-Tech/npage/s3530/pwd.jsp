   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
            //得到输入参数
            String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo")," ");
						String cus_pass = WtcUtil.repStr(request.getParameter("cus_pass")," ");
            String type = WtcUtil.repStr(request.getParameter("type")," ");
          System.out.println("---------------------phoneNo-----------------------"+phoneNo);
          System.out.println("---------------------type-----------------------"+type);
            String regionCode = (String)session.getAttribute("regCode");
            String[][] result1 = new String[][]{};
            
		      	String retResult = "";
            String sqlStr = "";
            String Pwd0 = "";		
			
			sqlStr = "select cust_passwd from dCustDoc a,dcustmsg b  where a.cust_id=b.cust_id and  phone_no='" + phoneNo + "'";
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%			
            //retArray1 = callView1.sPubSelect("1",sqlStr);
					
            result1 = result_t1;
            String cust_passwd = (result1[0][0]).trim();
           
				    
			System.out.println("----------------cust_passwd-------------------"+cust_passwd);
			
					
			Pwd0 = Encrypt.encrypt(cus_pass);
			
			System.out.println("-------------------Pwd0-------------------------"+Pwd0);
                    
		   if(Encrypt.checkpwd2(cust_passwd,Pwd0) == 1)
		  {
			retResult = "000000" ;				
		  }else
		  {
		   retResult = "000001" ;
  		  }
				System.out.println("----------------------------retResult----------------"+retResult); 
				

%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var type = "<%=type%>";
response.data.add("retResult",retResult);
response.data.add("type",type);
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 