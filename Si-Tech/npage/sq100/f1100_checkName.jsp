
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	/**
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//登陆密码
	String regionCode=org_code.substring(0,2);
   **/
   
   
        String workNo =(String)session.getAttribute("workNo");
        String password= (String)session.getAttribute("password");
        String workName =(String)session.getAttribute("workName");
      //  String powerRight =(String)session.getAttribute("powerRight");
      //  String Role =(String)session.getAttribute("Role");
        String orgCode =(String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
      //  String groupId =(String)session.getAttribute("groupId");
        String ip_Addr =(String)session.getAttribute("ip_Addr");
      //  String belongCode =orgCode.substring(0,7);
      //  String districtCode =orgCode.substring(2,4);
        //得到输入参数
       // Logger logger = Logger.getLogger("f1100_checkName.jsp");
        //ArrayList retArray = new ArrayList();
       // String[][] retListString1 = new String[][]{};
 			//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
		    //--------------------------
		    String retType = request.getParameter("retType");
        String custName = request.getParameter("custName");
        String custId=new String();
        String flag="";
     
           
						//获取证件类型
					 	//ArrayList retList1 = new ArrayList();  
						String sqlStr1="";
					 	//sqlStr1 ="select cust_id from dCustDoc where cust_name='"+custName+"'";
					 	String ssss = "根据custName[" + custName + "]进行查询";
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  
  <wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="1100"/>
      <wtc:param value="<%=workNo%>"/>
      <wtc:param value="<%=password%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=custName%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="result_cust">
				  
<%       
	if(retCode.equals("000000")){
  	  if(result_cust.length==0){
          flag="0";
      }else{
      		flag="1";
      		custId=result_cust[0][31];
    	}
  }else{
	    flag="0";
	}		
	
%>
 </wtc:array>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("custId","<%=custId%>");
response.data.add("flag","<%=flag%>");
response.data.add("retCode","000000");
core.ajax.receivePacket(response);
