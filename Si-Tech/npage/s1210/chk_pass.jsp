<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String acc_name = request.getParameter("acc_name");
String acc_pass = request.getParameter("acc_pass");
String user_id=request.getParameter("user_id");
String acc_area=request.getParameter("acc_area");
String choice_type=request.getParameter("choice_type");
String srv_no=request.getParameter("srv_no");
String regionCode = (String)session.getAttribute("regCode");
//-----------获得密码信息数组-------------

	String sql1_str = "select trim(contract_passwd),trim(belong_code) from dconmsg where contract_no=:acc_name";
	String sql1_prm = "acc_name="+acc_name;

	String sql2_str = "select bill_order from dConUserMsg where SERIAL_no =0  and contract_no=:acc_name  order by bill_order desc ";
	String sql2_prm = "acc_name="+acc_name;
	
	String sql3_str = "select contract_no from dcustmsg where phone_no=:srv_no  and substr(run_code,2,1)<'a'";
	String sql3_prm = "srv_no="+srv_no;

	System.out.println("-------hejwa---------------sql1_str---------->"+sql1_str);
	System.out.println("-------hejwa---------------sql1_prm---------->"+sql1_prm);	
	
	System.out.println("-------hejwa---------------sql2_str---------->"+sql2_str);
	System.out.println("-------hejwa---------------sql2_prm---------->"+sql2_prm);	
	
	System.out.println("-------hejwa---------------sql3_str---------->"+sql3_str);
	System.out.println("-------hejwa---------------sql3_prm---------->"+sql3_prm);	

  String pass="";
	String passFlag="n";
 	String bill="";
  String billFlag="y";
	String area="";
	String areaFlag="y";
	String dataFlag="n";

	
%>
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql1_str%>" />
		<wtc:param value="<%=sql1_prm%>" />	
	</wtc:service>
	<wtc:array id="result_t0" scope="end"  />

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql2_str%>" />
		<wtc:param value="<%=sql2_prm%>" />	
	</wtc:service>
	<wtc:array id="result_t1" scope="end"  />

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql3_str%>" />
		<wtc:param value="<%=sql3_prm%>" />	
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />		
<%	
 				
 				if(result_t0.length>0){
 					pass = result_t0[0][0];
 					System.out.println("-------hejwa---------------pass---------->"+pass);
 					
 					if( 1 ==Encrypt.checkpwd1(acc_pass,pass.trim())){
 					  passFlag="y";   
	      	}
	       	System.out.println("-------hejwa---------------passFlag---------->"+passFlag);
	       	
	       	area=result_t0[0][1];
	      
	       	System.out.println("-------hejwa---------------area.length()---------->"+area.length());
	      
				  if(area.length()>=2) {
							dataFlag="y";
		          if(!acc_area.substring(0,2).equals(area.substring(0,2))) {
					  			areaFlag="n";
					  	}
					  
					   System.out.println("-------hejwa--5555555-------------dataFlag---------->"+dataFlag);
					   System.out.println("-------hejwa--5555555-------------areaFlag---------->"+areaFlag);
				  }
	       	
 				}
      
	  		
	       
	       System.out.println("-------hejwa---------------choice_type---------->"+choice_type);
          
        if(!choice_type.equals("d")) {
       	 	System.out.println("-------hejwa---------------1111111111---------->");
	        if(result_t1.length>0){
	        	bill = result_t1[0][0];
	        	if(bill.equals("99999999"))  {
	        		billFlag="n";
	         		System.out.println("-------hejwa---------------billFlag---------->"+billFlag);
	         	}
	        }
	        
	        
		  	}else{
		  		
		  			if(result_t2.length>0){
		  				if(result_t2[0][0].equals(acc_name.trim())) {
                billFlag="n";
                 System.out.println("-------hejwa---------------billFlag---------->"+billFlag);
			  			}	
		  			}
		  			
		  		
		  }


	      
	 

 %>
var response = new AJAXPacket();
var passFlag = "<%=passFlag%>";
var billFlag = "<%=billFlag%>";
var areaFlag = "<%=areaFlag%>";
var dataFlag = "<%=dataFlag%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("passFlag",passFlag);
response.data.add("billFlag",billFlag);
response.data.add("areaFlag",areaFlag);
response.data.add("dataFlag",dataFlag);
core.ajax.receivePacket(response);
