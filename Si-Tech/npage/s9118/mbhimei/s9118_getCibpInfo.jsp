<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String regionCode = (String)session.getAttribute("regCode");
String phoneno=request.getParameter("phoneno");
String despositAct = "";
String imei="";
String yximeicount="";
String sqlStr="select dd.info_code,dd.info_value from ddsmpordermsg d,ddsmpordermsgadd dd where d.phone_no = '"+phoneno+"' and d.order_id = dd.order_id and d.serv_code = 51 and d.opr_code in ('06','05','04','01')";	
int callDataNum = 0;
System.out.println("test001=="+sqlStr);
%>
	<wtc:pubselect  name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array  id="callData" scope="end"/>	
<%

	if(callData!=null&&callData.length>0){
			callDataNum = callData.length;	
			
			for(int i = 0 ; i < callData.length ; i ++){
				if("313".equals(callData[i][0])){
					despositAct=callData[i][1];
				}
				if("311".equals(callData[i][0])){
					imei=callData[i][1];
				}
			}
			if("".equals(despositAct)){
				sqlStr="select maxaccept from oneboss.ob_cibp_deposit where phone_no = '?'  and oprcode = '06'  and (spid, bizcode) in  (select spid, bizcode from DBCUSTADM.ddsmpordermsg d  where phone_no = '?' and d.serv_code = '51' and d.opr_code in ('06', '05', '04', '01'))";
				
				System.out.println("test002=="+sqlStr);
				%>
					<wtc:pubselect  name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:sql><%=sqlStr%></wtc:sql>
						<wtc:param  value="<%=phoneno%>"/>	
						<wtc:param  value="<%=phoneno%>"/>	
					</wtc:pubselect>
					<wtc:array  id="callData4" scope="end"/>	
				<%
				
				if(callData4!=null && callData4.length>0){
					despositAct=callData4[0][0];
				}
			}
			if(!"".equals(imei)){
				sqlStr="select count(1) from dbmarketadm.mk_actrecordres_info  a where a.res_type='1' and a.imei_no='?' and a.phone_no='?'";
				System.out.println("test003=="+sqlStr);
				%>
					<wtc:pubselect  name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:sql><%=sqlStr%></wtc:sql>
						<wtc:param  value="<%=imei%>"/>	
						<wtc:param  value="<%=phoneno%>"/>	
					</wtc:pubselect>
					<wtc:array  id="callData5" scope="end"/>	
				<%
				
				if(callData5!=null && callData5.length>0){
					yximeicount=callData5[0][0];
				}
			}
			
	} 
	
	String stringArray = WtcUtil.createArray("arrMsg",callDataNum);
	
	System.out.println("test001=="+callData.length);

%> 
	<%=stringArray%>
<%
	for(int i = 0 ; i < callData.length ; i ++){
	  for(int j = 0 ; j < callData[i].length ; j ++){
			if(callData[i][j].trim().equals("") || callData[i][j] == null){
			   callData[i][j] = "";
			}
%>
			arrMsg[<%=i%>][<%=j%>] = "<%=callData[i][j].trim()%>";
<%
	  }
	}
%>  
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","cibpInfo");
response.data.add("errorCode","0");
response.data.add("errorMsg","success");
response.data.add("backArrMsg",arrMsg );
response.data.add("despositAct",'<%=despositAct%>' );
response.data.add("yximeicount",'<%=yximeicount%>' );

core.ajax.receivePacket(response);
