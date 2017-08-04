<%
/********************
 * version v2.0
 * 开发商: si-tech
 * 作者：weigp 2010-8-25
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
    //得到输入参数
    String phone_no = request.getParameter("phoneNo");
    
    String contentStr = "<div class='title'><div id='title_zi'>关系列表</div></div>"+
							"<table cellspacing='0'><tr><th>手机号码</th><th>办理时间</th></tr>";
 
 
 
    String sql = "SELECT msg.phone_no, m.eff_date"
  				+" FROM group_instance_member m, dcustmsg msg"
 				+" WHERE m.GROUP_ID ="
          		+" (SELECT memb.GROUP_ID"
             	+" FROM group_instance_member memb, dcustmsg msg"
            	+" WHERE memb.member_role_id = ANY (7690, 7691)"
              	+" AND SYSDATE BETWEEN memb.eff_date AND memb.exp_date"
              	+" AND memb.serv_id = msg.id_no"
              	+" AND msg.phone_no = '"+phone_no+"')"
   				+" AND m.serv_id = msg.id_no";
 				
   				System.out.println(phone_no);
   				
   				
   				System.out.println(sql);
    
%>	 
	<wtc:pubselect name="sPubSelect" outnum="2">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%

 	if(retCode.equals("000000")){
 		System.out.println("查询成功 共返回 " + result.length + "行记录");
		for(int i=0;i<result.length;i++){
			contentStr += "<tr><td>"+result[i][0]+"</td><td>"+result[i][1]+"</td></tr>";
		}
	}else{
		System.out.println("查询失败");
	}
	contentStr += "</table>";
	
	System.out.println(contentStr);
%>

<%=contentStr%>

