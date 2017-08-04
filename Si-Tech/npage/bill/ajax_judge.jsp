<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm @ 2010-8-26
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page import="java.util.*"%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  
<%
	String iPhoneNo = request.getParameter("iPhoneNo");
	String flag = request.getParameter("flag");
	String new_phoneno = request.getParameter("new_phoneno");
	String regionCode=(String)session.getAttribute("regCode");
	String untilName = "";
	String untilId = "";
	String atr = "";
	String[] arr = new_phoneno.split("~");
	for(int i=0;i<arr.length;i++){
	}
	String ret = "";
	String sql =  " select id_no from dcustmsg where phone_no = '"+iPhoneNo+"' ";
%>
  
	<wtc:pubselect name="sPubSelect" outnum="1" retcode="code" retmsg="msg" routerKey="region" routerValue="<%=regionCode%>">
	 <wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
		
<%
    if(result.length == 0 ){   
       ret = "无此号码信息！";
    }else{
    String v1 = result[0][0];
    for(int i=0;i<arr.length;i++){
        String phone = arr[i];
        String sql1 =  " select id_no from dcustmsg where phone_no = '"+phone+"' ";
        %>
           <wtc:pubselect name="sPubSelect" outnum="1" retcode="code1" retmsg="msg1" routerKey="region" routerValue="<%=regionCode%>">
	       <wtc:sql><%=sql1%></wtc:sql>
           </wtc:pubselect>
	       <wtc:array id="result1" scope="end"/>
        <%
        if(result1.length == 0 ){
           ret = ret+ phone +" ";
         }else{
         String v2 = result1[0][0];
         String sql2 = " select count(*) from dcustmsgadd a,dcustmsgadd b where a.id_no='"+v1+"' and b.id_no='"+v2+"' and a.field_code=b.field_code  and a.field_code='20000' and a.field_value=b.field_value ";
         
         %>
            <wtc:pubselect name="sPubSelect" outnum="1" retcode="code2" retmsg="msg2" routerKey="region" routerValue="<%=regionCode%>">
	       <wtc:sql><%=sql2%></wtc:sql>
           </wtc:pubselect>
	       <wtc:array id="result2" scope="end"/>
         <%
         String res = result2[0][0];
          System.out.println("//////////////////////////////////////////////resres"+res);
         if(!"0".equals(res)){
            atr = atr + phone +" ";
            System.out.println("//////////////////////////////////////////////atratratr"+atr);
            String sql3 = " select distinct b.unit_name, c.unit_id " +
				" from dbvipadm.dGrpManagermsg a ,dbvipadm.dGrpCustMsg b ,dbvipadm.dGrpMemberMsg c " +
				" where b.unit_id=c.unit_id  and c.id_no = " + v1 ;
				%>
				 <wtc:pubselect name="sPubSelect" outnum="2" retcode="code3" retmsg="msg3" routerKey="region" routerValue="<%=regionCode%>">
	             <wtc:sql><%=sql3%></wtc:sql>
                 </wtc:pubselect>
	             <wtc:array id="result3" scope="end"/>
				<%
				untilName = result3[0][0];
				untilId = result3[0][1];
				 System.out.println("//////////////////////////////////////////////untilName"+untilName);
         }
         }
    }
    }
%>  
	    
var response = new AJAXPacket();
response.data.add("ret","<%=ret%>");
response.data.add("flag","<%=flag%>");
response.data.add("atr","<%=atr%>");
response.data.add("untilName","<%=untilName%>");
response.data.add("untilId","<%=untilId%>");
core.ajax.receivePacket(response);	