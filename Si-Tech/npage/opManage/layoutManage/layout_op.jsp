<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>

<%-- 新增、修改、删除布局模板操作  --%>

<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
  String workNo = (String)session.getAttribute("workNo");
  
	String opType = request.getParameter("opType")==null?"":request.getParameter("opType");
	
	if("add".equals(opType.trim())){
		String mCode = request.getParameter("mCode")==null?"":request.getParameter("mCode");
		String mName = request.getParameter("mName")==null?"":request.getParameter("mName");
		String mShow = request.getParameter("mShow")==null?"":request.getParameter("mShow");
		
		//需要调用后台服务进行增加操作
		%>
		<wtc:service name="sInDlayoutMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=mCode%>" />
			<wtc:param value="<%=mName%>" />
			<wtc:param value="<%=mShow%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e484" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="布局增加" />
		</wtc:service>
				
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	}else if("update".equals(opType.trim())){
		String mCode = request.getParameter("mCode")==null?"":request.getParameter("mCode");
		String mName = request.getParameter("mName")==null?"":request.getParameter("mName");
		String mShow = request.getParameter("mShow")==null?"":request.getParameter("mShow");
		
		//需要调用后台服务进行修改操作
		%>
		
		<wtc:service name="sUpDlayoutMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=mCode%>" />
			<wtc:param value="<%=mName%>" />
			<wtc:param value="<%=mShow%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e484" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="布局修改" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
		<%
	
	}else if("delete".equals(opType.trim())){//删除
		String mCode = request.getParameter("mCode")==null?"":request.getParameter("mCode");
		String mRole = request.getParameter("mRole")==null?"":request.getParameter("mRole");
		//需要调用后台服务进行删除操作
		%>
		<wtc:service name="sDelDlayoutMsg" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=mCode%>" />
			<wtc:param value="<%=mRole%>" />
			<wtc:param value="" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e484" />
      <wtc:param value="<%=ip_Addr%>" />
      <wtc:param value="<%=powerCode%>" />
      <wtc:param value="布局删除" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
	<%

	}else if("check".equals(opType.trim())){//校验mcode是否存在
		String layout_model_id = request.getParameter("mCode")==null?"":request.getParameter("mCode");
		String sql = "select layout_model_id ,layout_model_NAME from DLAYOUTmodel where layout_model_id=:layout_css";
		String param = "layout_css="+layout_model_id;
		String isAdd="1";
		System.out.println(sql);
		%>
		<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=param%>" />
		</wtc:service>
		<wtc:array id="layout" scope="end"/>
		<%			
			
		if("000000".equals(retCode)){ 
			if(layout.length==0){
				isAdd = "0";//不存在
			}
		}
		
	%>
			var response = new AJAXPacket();
			response.data.add("opType","<%=opType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			response.data.add("isAdd","<%=isAdd%>");
			core.ajax.receivePacket(response);	
	
	<%
	}else if("setRole".equals(opType.trim())){//设置角色权限
		String treeValue = request.getParameter("treeValue")==null?"":request.getParameter("treeValue");
		String defaultLayout = request.getParameter("defaultLayout")==null?"":request.getParameter("defaultLayout");
		String selectValue = request.getParameter("selectValue")==null?"":request.getParameter("selectValue");
		String setLayout = request.getParameter("setLayout")==null?"":request.getParameter("setLayout");
		String deTheme   = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
		System.out.println("layout-----treeValue=["+treeValue+"]");
		System.out.println("layout-----defaultLayout=["+defaultLayout+"]");
		System.out.println("layout-----selectValue=["+selectValue+"]");
		System.out.println("layout-----setLayout=["+setLayout+"]");
		System.out.println("layout-----deTheme=["+deTheme+"]");
		%>
		<wtc:service name="sDLayRelSet" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=treeValue%>" />
			<wtc:param value="<%=defaultLayout%>" />
			<wtc:param value="<%=selectValue%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="e484" />
      		<wtc:param value="<%=ip_Addr%>" />
      		<wtc:param value="<%=powerCode%>" />
      		<wtc:param value="布局角色设置" />
      		<wtc:param value="<%=setLayout%>" />
      		<wtc:param value="<%=deTheme%>" />
		</wtc:service>
		
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		core.ajax.receivePacket(response);	
	
	<%
	}else if("query".equals(opType.trim())){//查询
		String mCode = request.getParameter("mCode")==null?"":request.getParameter("mCode");
		String mName = request.getParameter("mName")==null?"":request.getParameter("mName");
		String mShow = request.getParameter("mShow")==null?"":request.getParameter("mShow");
		String sql = "select a.layout_css, a.layout_name, , a.layout_action, a.is_effect, b.is_default from dlayoutmsg a, dlayoutrole_rel b where ";
		if(!"".equals(mCode)){
			sql +=" layout_css="+mCode +" and ";
		}
		if(!"".equals(mName)){
			sql += " layout_name="+mName+" and ";
		}
		if(!"".equals(mShow)){
			sql +=" is_effect="+mShow+" and ";
		}
		sql+=" a.layout_css = b.layout_css and b.op_role=:powerCode";
		String var2 = "powerCode="+powerCode.trim();

		//调用服务查询
		%>
		<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="<%=sql%>" />
			<wtc:param value="<%=var2%>" />
		</wtc:service>
		<wtc:array id="layoutList" scope="end"/>
		
		
		var tempInfos = new Array();
		<%
		//调用服务进行查询
		if("000000".equals(retCode)){ 
			for(int i=0;i<layoutList.length;i++){
				%>
				//生成数组返回				
				var tempInfo_<%=i%> = new Array("<%=layoutList[i][0]%>","<%=layoutList[i][1]%>","<%=layoutList[i][2]%>","<%=layoutList[i][3]%>","<%=layoutList[i][4]%>");
				
				tempInfos[<%=i%>] = tempInfo_<%=i%>;
				<%
			}
		}
	%>		
	
		var response = new AJAXPacket();
		response.data.add("opType","<%=opType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		response.data.add("tempInfos",tempInfos);
		core.ajax.receivePacket(response);	
	
	<%
	}
%>


