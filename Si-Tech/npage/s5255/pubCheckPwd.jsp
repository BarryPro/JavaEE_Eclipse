<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
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
            String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
            String busy_type = WtcUtil.repStr(request.getParameter("busy_type")," ");
          	
          	String regionCode = (String)session.getAttribute("regCode");
            
			System.out.println("---------------------phone_no-------------------hjw--------------------"+phone_no);
			System.out.println("-------------------------busy_type-----------------hjw-----------------"+busy_type);

            String[][] result1 = new String[][]{};
            
			String retResult = "";
			String sqlStr = "";
			String Pwd0 = "";
			String Pwd1 = "";
		    String Pwd2 = "";
		    String Pwd3 = "";
			System.out.println("-----------busy_type----------------------hjw-----------------"+busy_type);
			sqlStr = "select a.user_passwd,substr(id_iccid,length(b.id_iccid)-3,4) from dCustMsg a,dCustDoc b where a.cust_id=b.cust_id and a.phone_no='" + phone_no + "'";
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%			
			//retArray1 = callView1.sPubSelect("2",sqlStr);
			
			result1 = result_t;
			String cust_passwd = (result1[0][0]).trim();
			String  iccid = (result1[0][1]).trim();
				    
			System.out.println("-------------------cust_passwd---------------hjw-------------------"+cust_passwd);
			System.out.println("---------------iccid------------hjw--------------"+iccid);
					
			Pwd0 = cust_passwd;
			Pwd1 = "000000";
			Pwd2 = "001234";
			Pwd3 = "00"+iccid ;
			System.out.println("-----------------------Pwd2--------------------hjw----------------------"+Pwd2);
		  if((1==Encrypt.checkpwd1(Pwd1,cust_passwd)) || (1==Encrypt.checkpwd1(Pwd2,cust_passwd)) || (1==Encrypt.checkpwd1(Pwd3,cust_passwd)))
		  {
			retResult = "false" ;				
		  }else
		  {
		   retResult = "true" ;
  		  }
				
				System.out.println("---------------------retResult-------------hjw-------------"+retResult); 
				
				

%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);
<%System.out.println("---------------------------OK---------------------------");%>


 