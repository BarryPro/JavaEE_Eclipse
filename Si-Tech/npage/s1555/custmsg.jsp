 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-17 页面改造,修改样式
	********************/
%> 

<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
           
           String regionCode = (String)session.getAttribute("regCode"); 
            //得到输入参数
            String phoneNo =WtcUtil.repStr(request.getParameter("phoneNo")," ");
            String type = WtcUtil.repStr(request.getParameter("type")," ");
          
            System.out.println("aaaaaaaaaaaaa"+phoneNo);
            System.out.println("bbbbbbbbbbbbb"+type);
	    //ArrayList retArray1 = new ArrayList();
            //String[][] result1 = new String[][]{};
            //SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
            
			
            String sqlStr = "";  
	    sqlStr = "select id_iccid,id_address,cust_name from dCustDoc a,dcustmsg b  where a.cust_id=b.cust_id and  phone_no='" + phoneNo + "'";
	     //retArray1 = callView1.sPubSelect("3",sqlStr);	    
	    %>
	    
	    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	   <wtc:array id="result1" scope="end" />	   	    
	    <%   			
            //result1 = (String[][])retArray1.get(0);
            System.out.println("================result1.length"+result1.length);
            String id_iccid = "";           
	    String id_address = ""; 
	    String cust_name = "";	    
	    if(result1!=null&&result1.length>0){
	    	id_iccid= (result1[0][0]).trim();;
	    	id_address= (result1[0][1]).trim();
	    	cust_name=(result1[0][2]).trim();     ;
	    }    		    

	    ArrayList retArray = new ArrayList();
            //String[][] result = new String[][]{};
            //SPubCallSvrImpl callView = new SPubCallSvrImpl();
            
	    String retResult = "0";
            String sqlStr1 = "";			
	    sqlStr1 = "select count(*) from dcustmsg a, wAwardMsg b  where a.phone_no=b.phone_no and a.id_no=b.id_no and a.phone_no='" + phoneNo + "'";
           // retArray = callView.sPubSelect("1",sqlStr1);            	
           // result = (String[][])retArray.get(0);
            %>
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	   <wtc:array id="result" scope="end" />            
            <%
            	System.out.println("================result.length"+result.length);
            	if(result!=null&&result.length>0){
            		retResult = (result[0][0]).trim();
            	}		
	    %>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var type = "<%=type%>";
var id_iccid = "<%=id_iccid%>";
var id_address = "<%=id_address%>";
var cust_name = "<%=cust_name%>";
response.data.add("id_iccid",id_iccid);
response.data.add("id_address",id_address);
response.data.add("cust_name",cust_name);
response.data.add("type",type);
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 