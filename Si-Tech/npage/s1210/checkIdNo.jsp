<%
  /* *********************
   * 功能: 检测客户id是否为集团id，是返回1 不是返回0
   * 版本: 1.0
   * 日期: 2013/03/11
   * 作者: zhouby
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String custId = (String)request.getParameter("custId");
		String sql = "select count(*) from dcustdoc where cust_id = " + custId + " and owner_type = '01'";
		/**
		System.out.println("zhouby opCode " + opCode);
		*/
%>
		<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
			
		var array = [];
<%
		if (true && result.length > 0){
				for(int i = 0; i < result.length; i++){
%>
						var t = [];
<%
						for(int j = 0; j < result[i].length; j++){
						System.out.println("zhouby result [" + i +"][" + j + "] = " + result[i][j]);
%>					
								t[<%=j%>] = "<%=result[i][j]%>";
<%
						}
%>
						array[<%=i%>] = t;
<%
				}
		}
/*
		System.out.println("zhouby retCode  " + retCode);
		System.out.println("zhouby retMsg  " + retMsg);
*/
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		response.data.add("result", array);
		core.ajax.receivePacket(response);