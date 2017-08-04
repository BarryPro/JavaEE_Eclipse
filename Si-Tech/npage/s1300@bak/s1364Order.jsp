<%
  /*
   * 功能: 用户信誉度修改2308
   * 版本: 1.0
   * 日期: 2009/1/15
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	String orderId = request.getParameter("orderId").trim();//预约ID
	String flag = request.getParameter("flag");//2->dead ;1->正常
	String sql_cust="";
    String phone_no="";
	String phone_no2="";//转账的号码
	String flag_result="";
	String custPhone = "";
	String custPass = "";
	String groupName="";
	String workNo = (String)session.getAttribute("workNo");

	//String sql_order = "select phone_no,phone_no2 from sorderonline where order_id='?' and flag='0' and op_code='1364' and group_id = (select group_id from dloginmsg where login_no='?') and floor(to_date(to_char(sysdate,'YYYYMMDD'),'yyyymmdd') - to_date(total_date,'yyyymmdd'))<=15";
	String sql_order = "select a.phone_no,a.phone_no2,b.group_name from sorderonline a,dchngroupmsg b where a.order_id='?' and a.group_id=b.group_id and a.flag='0' and a.op_code='1364' and a.OP_TIME > sysdate -15";
	 
%>
	<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:sql><%=sql_order%></wtc:sql>
		<wtc:param value="<%=orderId%>"/>
	 
	</wtc:pubselect>
	<wtc:array id="resultOrder" scope="end" />
<%
	String flag_order="";
	String[][] result2  = null ;
	result2=resultOrder;
	if(result2!=null&&result2.length>0)
	{
		phone_no=result2[0][0];
		phone_no2=result2[0][1];
		groupName=result2[0][2];
		if(flag=="1" ||"1".equals(flag))
		{
			sql_cust="select phone_no,user_passwd from dcustmsg where phone_no ='"+phone_no+"'";//dcustmsg
		}
		else
		{
			sql_cust="select phone_no,user_passwd from dcustmsgdead where phone_no ='"+phone_no+"' ";//dcustmsgdead
		}
%>
	
		<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=sql_cust%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultName" scope="end" />
	<%
		String errCode2 = retCode2;
		String errMsg2 = retMsg2;
		
		
		String[][] result1  = null ;
		result1=resultName;
		
		if(result1!=null&&result1.length>0)
		{
			custPhone=result1[0][0];
			custPass=result1[0][1];
			flag_result="0";
		}
		else
		{
			flag_result="1";
		}

	}
	else
	{
		flag_result="2";
	}

%>
		
 
	var response = new AJAXPacket();
	response.data.add("flag1","<%=flag_result%>");
	response.data.add("custPhone","<%=custPhone%>");
	response.data.add("custPass","<%=custPass%>");
	response.data.add("phone_no2","<%=phone_no2%>");
	response.data.add("groupName","<%=groupName%>");
	core.ajax.receivePacket(response);
 