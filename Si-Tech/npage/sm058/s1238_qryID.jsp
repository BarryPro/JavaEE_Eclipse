<%
    /********************
     version v2.0
     开发商: si-tech
     *作者:linxd@2003-2-9 
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String ret_code  = "";				//错误代码 
    String ret_message  = "SUCCEED";   	//错误消息   
		String region_code=request.getParameter("region_code");
    String new_srv_no=request.getParameter("new_srv_no");
  	String retType = request.getParameter("retType");  
	  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);

		String new_cus_id="";
		String new_id="";
		String main_str1="";
		String fj_str1="";
		String main_note="";
		String mode_code="";
		String detail_code="";

    String sqlStr ="select trim(cust_id),substr(belong_code,1,2),trim(id_no) from dcustmsg where phone_no='"+new_srv_no+"'";
    System.out.println("sqlStr=="+sqlStr);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
    <wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<% 		   
		   if(result==null || result.length==0){			   		   
         ret_code="000001";
	 			 ret_message="服务号错误，请重新操作！";
		   }else{
          if(region_code.equals(result[0][1])){
               new_cus_id=result[0][0];			
               new_id=result[0][2]; 
               ret_code = "000000";
			         ret_message="查询新客户ID成功！";		
			 		}else{
               ret_code = "000003";
		   				 ret_message="此客户为异地客户！";			 
			 		}
		  }
%>

			var response = new AJAXPacket();
			var retType = "<%=retType%>";
			var retCode = "<%=ret_code%>";
			var retMessage = "<%=ret_message%>";
			var new_cus_id = "<%=new_cus_id%>";
			var main_str1="<%=main_str1%>";
			var fj_str1="<%=fj_str1%>";
			var main_note="<%=main_note%>";
			response.data.add("retType",retType);
			response.data.add("retCode",retCode);
			response.data.add("retMessage",retMessage);
			response.data.add("new_cus_id",new_cus_id);
			response.data.add("main_str1",main_str1);
			response.data.add("fj_str1",fj_str1);
			response.data.add("main_note",main_note);
			core.ajax.receivePacket(response);