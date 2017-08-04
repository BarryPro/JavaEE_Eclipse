<%
    /********************
     version v2.0
     AUTH: liubo
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String verifyType=request.getParameter("verifyType");
	String groupId =(String)session.getAttribute("groupId");
	String groupId_bak="";
	String prompt_content="";
	
	String opCode=request.getParameter("opCode");
	System.out.println("verifyType="+verifyType);

if(verifyType.equals("prompt")){
	     String sqlStr="select root_distance  from dchngroupmsg where group_id="+groupId;
		 System.out.println("###################root_distance->sqlStr->"+sqlStr);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="baseArr" scope="end"/>
<%			
         //System.out.println("baseArr[0][0] ==="+baseArr[0][0]);
   if(baseArr!=null&&baseArr[0][0].equals("4")){
         //System.out.println("baseArr[0][0] ==="+baseArr[0][0]);
	    String sqlStr1="SELECT b.group_id  from dchngroupinfo a, dchngroupmsg b where a.parent_group_id = b.group_id and b.root_distance=3 and a.GROUP_ID="+groupId;
		System.out.println("###################  group_id sqlStr1="+sqlStr1);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" outnum="1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="baseArr2" scope="end"/>
<%		
      //System.out.println("baseArr2[0][0] ==="+baseArr2[0][0]);
       if(baseArr2!=null){
          groupId_bak=baseArr2[0][0]; 
       }
 
    }else{
   	   groupId_bak=groupId;
   	}		
   
   String sqlStr3= "select prompt_content"
				+" from sFuncPromptRelease a, sFuncPromptType b,sBillPrintFlag c "
				+" where a.is_print = c.print_flag"
				+" and a.prompt_type = b.prompt_type"
				+" and group_id = "+groupId_bak+" "
				+" and bill_type =1 "
				+" and function_code ='"+opCode+"' and valid_flag = 'Y'"
				+" and (is_print = '2' or is_print = '3')"
				+" and sysdate between valid_time and invalid_time"
				+" order by a.prompt_type,b.page_order,c.page_order,a.prompt_seq";

		 System.out.println("###################root_distance->sqlStr3->"+sqlStr3);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" outnum="1">
			<wtc:sql><%=sqlStr3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="baseArr3" scope="end"/>
<%	
     if(baseArr3!=null){
             for(int i=0;i<baseArr3.length;i++){
                    System.out.println("###################  "+baseArr3[i][0]);
               		prompt_content=prompt_content+"~"+baseArr3[i][0];
               }
     }
}
%>  
var response = new AJAXPacket();
response.data.add("verifyType",'<%=verifyType%>');
response.data.add("errorCode","0");
response.data.add("errorMsg","success");
response.data.add("backArrMsg",'<%=prompt_content%>');
core.ajax.receivePacket(response);
