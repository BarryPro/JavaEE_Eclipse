<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
String acc_name = request.getParameter("acc_name");
String acc_pass = request.getParameter("acc_pass");
String user_id=request.getParameter("user_id");
String acc_area=request.getParameter("acc_area");
String choice_type=request.getParameter("choice_type");
String srv_no=request.getParameter("srv_no");
System.out.println("1212-1:"+choice_type);
System.out.println("1212-2:"+srv_no);

//-----------获得密码信息数组-------------
    comImpl co=new comImpl(); 
	StringBuffer sq1=new StringBuffer("select trim(contract_passwd),trim(belong_code) from dconmsg where contract_no=");
	sq1.append(acc_name);
  sq1.append(";select bill_order from dConUserMsg where SERIAL_no =0");
	sq1.append(" and contract_no=");
	sq1.append(acc_name);
	sq1.append(" order by bill_order desc ");
	sq1.append(";select contract_no from dcustmsg where phone_no='");
	sq1.append(srv_no);
	sq1.append("' and substr(run_code,2,1)<'a'"); 
	System.out.println("hejwa sql = "+sq1.toString());
	
	int[] colNums=new int[3];
	colNums[0]=2;
	colNums[1]=1;
	colNums[2]=1;
 	ArrayList passArr=co.multiSql(colNums,sq1.toString()); 
    String pass="";
	String passFlag="n";
 	String bill="";
    String billFlag="y";
	String area="";
	String areaFlag="y";
	String dataFlag="n";
	System.out.println("hejwa----if1---------passArr---"+passArr);
    if(passArr!=null)
	{
	System.out.println("hejwa-----if2--------passArr.size()---"+passArr.size());
      if(passArr.size()==3)
	  {
	  System.out.println("hejwa----if3---------((String[][])passArr.get(0)).length---"+((String[][])passArr.get(0)).length);
	  System.out.println("hejwa----if3---------((String[][])passArr.get(1)).length---"+((String[][])passArr.get(1)).length);
        if(((String[][])passArr.get(0)).length!=0 && ((String[][])passArr.get(1)).length!=0)
		{
		System.out.println("hejwa----if4---------((String[][])passArr.get(0)).length---"+((String[][])passArr.get(0)).length);
	      if(((String[][])passArr.get(0)).length!=0){
	      System.out.println("hejwa----if5---------((String[][])passArr.get(0))[0][0]---"+((String[][])passArr.get(0))[0][0]);
	       pass=((String[][])passArr.get(0))[0][0];
	       }
	       System.out.println("hejwa----if6---------acc_pass---"+acc_pass);
	       System.out.println("hejwa----if6---------pass---"+pass);
	       System.out.println("hejwa----if6---------pass---"+pass);
	      if( 1 ==Encrypt.checkpwd1(acc_pass,pass.trim()))  passFlag="y";   
          System.out.println("hejwa----if7---------passFlag---"+passFlag);
          System.out.println("hejwa----if8---------choice_type---"+choice_type);
        if(!choice_type.equals("d"))
		  {
		  	System.out.println("hejwa----if9---------((String[][])passArr.get(1)).length!=0---"+((String[][])passArr.get(1)).length);
		  	
	        if(((String[][])passArr.get(1)).length!=0) bill=((String[][])passArr.get(1))[0][0];
	        System.out.println("hejwa----if10---------bill---"+bill);
	        if(bill.equals("99999999"))  billFlag="n";
	        System.out.println("hejwa----if11---------billFlag---"+billFlag);
		  }
		  else
		  {
		  		System.out.println("hejwa----else1---------((String[][])passArr.get(2))---"+((String[][])passArr.get(2)));
            if(((String[][])passArr.get(2)).length!=0) 
			{
					System.out.println("hejwa----if12---------acc_name---"+acc_name);
					System.out.println("hejwa----if12---------((String[][])passArr.get(2))[0][0]---"+((String[][])passArr.get(2))[0][0]);
              if(((String[][])passArr.get(2))[0][0].equals(acc_name.trim()))
			  {
			  				
                billFlag="n";
                System.out.println("hejwa----if13---------billFlag---"+billFlag);
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
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("passFlag",passFlag);
response.data.add("billFlag",billFlag);
response.data.add("areaFlag",areaFlag);
response.data.add("dataFlag",dataFlag);
core.ajax.receivePacket(response);
