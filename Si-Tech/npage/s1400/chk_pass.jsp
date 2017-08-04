		   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
              
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
String acc_name = request.getParameter("acc_name");
String acc_pass = request.getParameter("acc_pass");
String user_id=request.getParameter("user_id");
String acc_area=request.getParameter("acc_area");
String choice_type=request.getParameter("choice_type");
String srv_no=request.getParameter("srv_no");
System.out.println("1212-1:"+choice_type);
System.out.println("1212-2:"+srv_no);
String regionCode = (String)session.getAttribute("regCode");
//-----------获得密码信息数组-------------
	StringBuffer sq1=new StringBuffer("select trim(contract_passwd),trim(belong_code) from dconmsg where contract_no=");
	sq1.append(acc_name);
  sq1.append(";select bill_order from dConUserMsg where SERIAL_no =0");
	sq1.append(" and contract_no=");
	sq1.append(acc_name);
	sq1.append(" order by bill_order desc ");
	sq1.append(";select contract_no from dcustmsg where phone_no='");
	sq1.append(srv_no);
	sq1.append("' and substr(run_code,2,1)<'a'"); 
	String sql_wtc= sq1.toString();
%>

		<wtc:mutilselect  name="sPubMultiSel"  retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>" id="result_t2" type="list">
  	 <wtc:sql><%=sql_wtc%></wtc:sql>
 	  </wtc:mutilselect>

<%	
 	List passArr=result_t2; 
    String pass="";
	String passFlag="n";
 	String bill="";
    String billFlag="y";
	String area="";
	String areaFlag="y";
	String dataFlag="n";
    if(passArr!=null)
	{
      if(passArr.size()==3)
	  {
        if(((String[][])passArr.get(0)).length!=0 && ((String[][])passArr.get(1)).length!=0)
		{
	      if(((String[][])passArr.get(0)).length!=0) pass=((String[][])passArr.get(0))[0][0];
	      if(1==Encrypt.checkpwd1(acc_pass,pass.trim()))  passFlag="y";

          if(!choice_type.equals("d"))
		  {
	        if(((String[][])passArr.get(1)).length!=0) bill=((String[][])passArr.get(1))[0][0];
	        if(bill.equals("99999999"))  billFlag="n";
		  }
		  else
		  {
            if(((String[][])passArr.get(2)).length!=0) 
			{
              if(((String[][])passArr.get(2))[0][0].equals(acc_name.trim()))
			  {
                billFlag="n";
			  }
			}
		  }


	      if(((String[][])passArr.get(0)).length!=0) area=((String[][])passArr.get(0))[0][1];
		  if(area.length()>=2)
		  {
			dataFlag="y";
            if(!acc_area.substring(0,2).equals(area.substring(0,2))) 
			  areaFlag="n";
		  }
		}
	  }
	}

 %>
var response = new AJAXPacket();
var passFlag = "<%=passFlag%>";
var billFlag = "<%=billFlag%>";
var areaFlag = "<%=areaFlag%>";
var dataFlag = "<%=dataFlag%>";
response.data.add("passFlag",passFlag);
response.data.add("billFlag",billFlag);
response.data.add("areaFlag",areaFlag);
response.data.add("dataFlag",dataFlag);
core.ajax.receivePacket(response);