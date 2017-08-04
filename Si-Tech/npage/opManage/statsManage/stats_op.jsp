<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>


<%
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String statsType = request.getParameter("statsType")==null?"":request.getParameter("statsType");
	String statsDate = request.getParameter("statsDate")==null?"":request.getParameter("statsDate");
	System.out.println();
	if("0".equals(statsType.trim())){
			String dataXml = "";
								
		//调用后台服务进行增加操作
		%>
		<wtc:service name="sRdop003_Opr" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="0" />
			<wtc:param value="<%=statsDate%>" />
		</wtc:service>
		<wtc:array id="list" scope="end"/>
		<%
		System.out.println("sRdop003_Opr----"+retCode);
		if("000000".equals(retCode)){
		System.out.println("list.length---==="+list.length);
			if(list.length>0){
				dataXml = "<graph caption=\"在线人数统计\" subcaption=\""+statsDate+"\" xAxisName=\"角色\" yAxisName=\" \" decimalPrecision=\"0\" formatNumberScale=\"0\">";
			 for(int i=0;i<list.length;i++){
			 		String roleInfo = list[i][1]+"["+list[i][0]+"]";
			 		String num = list[i][2];
			 		
			 		System.out.println("sRdop003_Opr---roleInfo=="+roleInfo);
			 		System.out.println("sRdop003_Opr---num==="+num);
					dataXml = dataXml +" <set name=\""+roleInfo+"\" value=\""+num+"\" />";
			 }
			 dataXml = dataXml +" </graph> ";	
			}				
		}				
		System.out.println("dataXml---==="+dataXml);
		%>
		var response = new AJAXPacket();
		response.data.add("statsType","<%=statsType%>");
		response.data.add("retCode","<%=retCode%>");
		response.data.add("retMsg","<%=retMsg%>");
		response.data.add("dataXml",'<%=dataXml%>');
		core.ajax.receivePacket(response);	
	
		<%
	}else if("1".equals(statsType.trim())){
		
		String dataXml = "";
								
		//调用后台服务进行增加操作
		%>
		<wtc:service name="sRdop003_Opr" outnum="7" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="1" />
			<wtc:param value="<%=statsDate%>" />
		</wtc:service>
		<wtc:array id="list" scope="end"/>
		<%
		System.out.println("sRdop003_Opr----"+retCode);
		if("000000".equals(retCode)){
		System.out.println("list.length---==="+list.length);
			if(list.length>0){
			 dataXml = "<graph caption=\"在线时长(秒)\" subcaption=\""+statsDate+"\" xAxisName=\"角色\" yAxisName=\" \" decimalPrecision=\"0\" formatNumberScale=\"0\">";
			 String categories = "<categories font=\"角色\" fontSize=\"11\" fontColor=\"000000\">";
			 String dataset1 = "<dataset seriesname=\"最大在线时间\">";
			 String dataset2 = "<dataset seriesname=\"最小在线时间\">";
			 String dataset3 = "<dataset seriesname=\"总在线时间\">";
			 String dataset4 = "<dataset seriesname=\"总数量\">";
			 String dataset5 = "<dataset seriesname=\"平均值\">";
			 for(int i=0;i<list.length;i++){
			 		String roleInfo = list[i][1]+"["+list[i][0]+"]";

			 		categories =categories + " <category name=\""+roleInfo+"\" /> ";
					dataset1 = dataset1 +" <set value=\""+list[i][2]+"\" />";
					dataset2 = dataset2 +" <set value=\""+list[i][3]+"\" />";
					dataset3 = dataset3 +" <set value=\""+list[i][4]+"\" />";
					dataset4 = dataset4 +" <set value=\""+list[i][5]+"\" />";
					dataset5 = dataset5 +" <set value=\""+list[i][6]+"\" />";
			 }
			 	categories =categories + " </categories> ";
				dataset1 = dataset1 +" </dataset>";
				dataset2 = dataset2 +" </dataset>";
				dataset3 = dataset3 +" </dataset>";
				dataset4 = dataset4 +" </dataset>";
				dataset5 = dataset5 +" </dataset>";
				dataXml = dataXml + categories +dataset1 + dataset2 + dataset3 + dataset4 + dataset5;
			  dataXml = dataXml +" </graph> ";	
			}				
		}				
		System.out.println("dataXml---==="+dataXml);
		%>
			var response = new AJAXPacket();
			response.data.add("statsType","<%=statsType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			response.data.add("dataXml",'<%=dataXml%>');
			core.ajax.receivePacket(response);	
	
		<%
	
	}else if("2".equals(statsType.trim())){

		String dataXml = "";
		%>
		<wtc:service name="sRdop003_Opr" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
			<wtc:param value="2" />
			<wtc:param value="<%=statsDate%>" />
		</wtc:service>
		<wtc:array id="list" scope="end"/>
		<%
		System.out.println("sRdop003_Opr----"+retCode);
		if("000000".equals(retCode)){
		System.out.println("list.length---==="+list.length);
			if(list.length>0){
				dataXml = "<graph caption=\"工作台使用频率统计\" subcaption=\""+statsDate+"\" xAxisName=\"角色\" yAxisName=\" \" decimalPrecision=\"0\" formatNumberScale=\"0\">";
			 for(int i=0;i<list.length;i++){
			 		String roleInfo = list[i][1]+"["+list[i][0]+"]";
			 		String num = list[i][2];
			 		
					dataXml = dataXml +" <set name=\""+roleInfo+"\" value=\""+num+"\" />";
			 }
			 dataXml = dataXml +" </graph> ";	
			}				
		}				
		System.out.println("dataXml---==="+dataXml);
		%>
		
			var response = new AJAXPacket();
			response.data.add("statsType","<%=statsType%>");
			response.data.add("retCode","<%=retCode%>");
			response.data.add("retMsg","<%=retMsg%>");
			response.data.add("dataXml",'<%=dataXml%>');
			core.ajax.receivePacket(response);	
	
	<%
	}
	%>

