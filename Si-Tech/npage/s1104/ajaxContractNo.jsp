<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt;"%>
<%
 
		
		
		
		
		String workNo = (String)session.getAttribute("workNo");
		String ipAddr = (String)session.getAttribute("ipAddr");
		String groupId = (String)session.getAttribute("groupId");
		String orgId = groupId;//(String)session.getAttribute("orgCode");
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new Date());
	
		String accountId   = (String)request.getParameter("accountId");  
		String newPwd 		 = (String)request.getParameter("newPwd");
		String new_custPwd = Encrypt.encrypt(newPwd);
		String accountNo   = (String)request.getParameter("accountNo");
		String accountName = (String)request.getParameter("accountName");
		String belongCode  = (String)request.getParameter("belongCode") ;
		String beginDate   = (String)request.getParameter("beginDate")  ;
		String payCode     = (String)request.getParameter("payCode")    ;
		String bankCode    = (String)request.getParameter("bankCode")   ;
		String postCode    = (String)request.getParameter("postCode")   ;
		String accountType = (String)request.getParameter("accountType");
		String unitCode    = (String)request.getParameter("unitCode")   ;
		String endDate     = (String)request.getParameter("endDate")    ;
		String gCustId     = (String)request.getParameter("gCustId")    ;
		String opCode      = "1102";
		
			
		
  System.out.println("-------------------------accountId  ----------------------------"+accountId        );     
  System.out.println("-------------------------gCustId  ------------------------------"+gCustId        );     
	System.out.println("-------------------------new_custPwd----------------------------"+new_custPwd      );     
	System.out.println("-------------------------accountName----------------------------"+accountName      );     
	System.out.println("-------------------------belongCode ----------------------------"+belongCode       );     
	System.out.println("-------------------------beginDate  ----------------------------"+beginDate        );     
	System.out.println("-------------------------payCode    ----------------------------"+payCode          );     
	System.out.println("-------------------------bankCode   ----------------------------"+bankCode         );     
	System.out.println("-------------------------postCode   ----------------------------"+postCode         );     
	System.out.println("-------------------------accountNo  ----------------------------"+accountNo        );     
	System.out.println("-------------------------accountType----------------------------"+accountType      );     
	System.out.println("-------------------------unitCode   ----------------------------"+unitCode         );     
	System.out.println("-------------------------endDate    ----------------------------"+endDate          );     
	System.out.println("-------------------------opCode     ----------------------------"+opCode           );     
	System.out.println("-------------------------workNo     ----------------------------"+workNo           );     
	System.out.println("-------------------------ipAddr     ----------------------------"+ipAddr           );
	System.out.println("-------------------------orgId      ----------------------------"+orgId            );     
	System.out.println("-------------------------groupId    ----------------------------"+groupId          );     
	System.out.println("-------------------------yearMon    ----------------------------"+yearMon          );
	
	
%>		
 <wtc:utype name="sCreateContract" id="retVal" scope="end">
	 <wtc:uparam value="0" type="LONG" />
	 <wtc:uparam name="accountId" type="LONG" />
	 <wtc:uparam name="gCustId" type="LONG" />
	 <wtc:uparam value="<%=new_custPwd%>" type="STRING" />
	 <wtc:uparam name="accountName" type="STRING" />
	 <wtc:uparam name="belongCode" type="STRING" />
	 <wtc:uparam name="beginDate" type="STRING" />
	 <wtc:uparam name="beginDate" type="STRING" />
	 <wtc:uparam value="0" type="INT" />
	 <wtc:uparam value="A" type="STRING" />
	 <wtc:uparam name="payCode" type="STRING" />
	 <wtc:uparam name="bankCode" type="STRING" />
	 <wtc:uparam name="postCode" type="STRING" />
	 <wtc:uparam value="<%=accountNo%>" type="STRING" />
	 <wtc:uparam name="accountType" type="STRING" />
	 <wtc:uparam name="unitCode" type="STRING" />
	 <wtc:uparam value="0" type="STRING" />
	 <wtc:uparam name="beginDate" type="STRING" />
	 <wtc:uparam name="endDate" type="STRING" />
	 <wtc:uparam name="opCode" type="STRING" />
	 <wtc:uparam value="0" type="STRING" />
	 <wtc:uparam value="0" type="DOUBLE" />
	 <wtc:uparam value="ZZ" type="STRING" /> 	
	 <wtc:uparam value="0" type="LONG" /> 	
	 <wtc:uparam value="" type="STRING" />
	 <wtc:uparam name="unitCode" type="STRING" />	
	 <wtc:uparam value="<%=workNo%>" type="STRING" />			 	
   <wtc:uparam value="帐户开户操作" type="STRING" />	
   <wtc:uparam value="<%=ipAddr%>" type="STRING" />	 	
   <wtc:uparam value="<%=orgId%>" type="STRING" />	 	
   <wtc:uparam value=" " type="STRING"/>	
   <wtc:uparam value="<%=groupId%>" type="STRING" />	
   <wtc:uparam value="<%=yearMon%>" type="STRING" />		
</wtc:utype>
<%
	String retrunCode=String.valueOf(retVal.getValue(0));//返回的retCode为LONG类型；
	System.out.println("# returnCode == "+retrunCode);
	System.out.println("# returnMsg == "+String.valueOf(retVal.getValue(1)));
%>

var response = new AJAXPacket();
response.data.add("errorCode","<%=retrunCode%>");
response.data.add("accountId","<%=accountId%>");
core.ajax.receivePacket(response);