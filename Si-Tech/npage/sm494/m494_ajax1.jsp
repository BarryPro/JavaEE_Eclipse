<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String shop        = WtcUtil.repNull(request.getParameter("shop"));                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[2];
	
	paraAray[0] = "  select n.region_name,b.phone_no,c.offer_attr_value,to_char(b.open_time, 'yyyy/mm/dd hh24:mi:ss') open_time,n.region_code "+
			"   from dchngroupinfo      m,   sregioncode   n, dwebopenphonemsg   a,  dcustmsg    b,  product_offer_attr c "+
			"   where m.parent_group_id = n.group_id  "+
			"   and m.group_id = b.group_id  "+
			"   and n.use_flag = 'Y'  "+
			"   and op_code = 'i279'  "+
			"   and b.phone_no = a.phone_no  "+
			"   and a.offer_id = c.offer_id  "+
			"   and c.offer_attr_seq = 50003  "+
			"   and b.run_code = 'pp'  "+
			"   and a.op_code = 'i279'  "+
			"   and b.open_time < sysdate - 30  "+
			"	 and n.region_code =   "+
			"	 case when '00' <> :shop then 	:shop  else 	 n.region_code	 end  " ;
			
			paraAray[1] = "shop="+shop; 
	String serverName = "TlsPubSelCrm";

%>
		<wtc:service name="<%=serverName%>" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----chenlei-------------paraAray["+i+"]------["+serverName+"]------>"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--chenlei--------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	



	System.out.println("--chenlei--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--chenlei--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
