<%
  /*
   * 功能:查询是否关于E177（关于大庆分公司申请优化预存送有线电视营销活动的请示）
   * 版本: 1.0
   * 日期: 20121022
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	/*===========获取参数============*/
 
  String regionCode = (String)session.getAttribute("regCode");
  //更新流水
  String  upLoginAcc = (String)request.getParameter("upLoginAcc");
  //隐藏域编号
  String  num = (String)request.getParameter("num");
  //手机号码
  String  phoneNo = (String)request.getParameter("phoneNo");	
  String sE177QrySQL= "select c.field_value from wawarddata a, Wmarketcommon b , wmarkettable c , dcustmsg d "+
  " where a.login_accept = b.login_accept and b.login_accept = c.login_accept and a.id_no = b.id_no and c.field_code = '08' "+
  " and a.id_no = d.id_no and b.id_no = d.id_no and d.phone_no = '"+phoneNo+"'"+
  "  and a.login_accept = '"+ upLoginAcc+"' and a.flag = 'N' and b.back_flag = '0' ";
  System.out.println(sE177QrySQL);
  String filedLen="";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg" outnum="1">
		<wtc:sql><%=sE177QrySQL%></wtc:sql>
		</wtc:pubselect>
<wtc:array id="result11" scope="end" />
	
<%
if(result11.length>0)
{
	filedLen=result11[0][0];
}
		
%>
	var response = new AJAXPacket();
	response.data.add("filedLen","<%=filedLen%>");
	response.data.add("sql123","<%=sE177QrySQL%>");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	response.data.add("upLoginAcc","<%=upLoginAcc%>");
	response.data.add("num","<%=num%>");
	core.ajax.receivePacket(response);