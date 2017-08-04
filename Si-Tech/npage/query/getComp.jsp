<%
/********************
 * version v2.0
 * 功能：验证工号信息
 * 开发商: si-tech
 * update by huangrong @ 2011-4-12
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";
    String errCode1 = "";
    String errMsg1 = "";
    String sameTypeFlag = "";
    String cust_type="";
    String work_no = (String)session.getAttribute("workNo");
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
		String beginLoginNo = request.getParameter("beginLoginNo");
		String endLoginNo = request.getParameter("endLoginNo");
		String loginNoFlag = request.getParameter("loginNoFlag");		//工号标识：2代表客服工号
		String class_flag="class";
		String kfsqlStr="";
		if(!loginNoFlag.equals("2"))
		{
		//判断登录工号级别 大于3 就是厅级和营业员（2是地市 3是区县 4是厅级 5是营业员）
		String sqlStr1="select b.root_distance from dloginmsg a,dchngroupmsg b where a.login_no='"+work_no+"' and  a.group_id=b.group_id ";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode2" retmsg="retMsg2">
   <wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultStr2" scope="end"/>

<%
	errCode = retCode2;
  errMsg = retMsg2;
  if(errCode.equals("000000"))
  {
  	if(resultStr2!=null && resultStr2.length>0)
  	{
			if(Integer.parseInt(resultStr2[0][0])>3)
			{
				String sqlStr3="select count(*) from dloginmsg a,dloginmsg b where a.login_no='"+beginLoginNo+"' and b.login_no='"+work_no+"' and a.group_id=b.group_id";
%>
				<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode3" retmsg="retMsg3">
				   <wtc:sql><%=sqlStr3%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="resultStr3" scope="end"/>

<%
				errCode = retCode3;
				errMsg = retMsg3;
				if(errCode.equals("000000"))
			  {
			  	if(resultStr3!=null && resultStr3.length>0)
			  	{
			  	System.out.println("==========================大于3errCode============================"+resultStr3[0][0]);
						if(resultStr3[0][0].equals("0"))
						{	
						  class_flag="noclass";
							errCode="x";
							errMsg="操作工号和查询工号不在同一营业厅";
						}
					}
				}
			}
		}
	}
	if(class_flag.equals("class"))
	{
	String sqlStr2="select count(*) from dloginmsg a,dloginmsg b where a.login_no='"+beginLoginNo+"' and b.login_no='"+endLoginNo+"' and a.group_id=b.group_id";
%>

	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode" retmsg="retMsg">
	   <wtc:sql><%=sqlStr2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultStr" scope="end"/>

<%
  System.out.println(sqlStr2);
  errCode = retCode;
  errMsg = retMsg;
  if(errCode.equals("000000"))
  {
  	if(resultStr!=null && resultStr.length>0)
  	{
			if(resultStr[0][0].equals("0"))
			{
				errCode="x";
				errMsg="查询的两个工号不在同一营业厅";
			}else
			{
				String sqlStr ="";
				if(loginNoFlag.equals("2"))
				{
  				sqlStr= "select count(*) from dloginmsg a,dloginmsg b where a.login_no='"+work_no+"' and b.login_no='"+endLoginNo+"'  and a.account_type=b.account_type";
			  }else
				{
					sqlStr= "select count(*) from dloginmsg a,dloginmsg b where a.login_no='"+work_no+"' and b.login_no='"+endLoginNo+"' and a.account_type<>2 and b.account_type<>2 and substr(a.ORG_CODE,0,2)=substr(b.ORG_CODE,0,2)";
				}
%>

			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode1" retmsg="retMsg1">
			   <wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultStr1" scope="end"/>
<%
		  errCode = retCode1;
		  errMsg = retMsg1;
				if(errCode.equals("000000"))
				{
					if(resultStr1!=null && resultStr1.length>0)
			  	{
			  	  if(resultStr1[0][0].equals("0"))
			  	  {
			  	  	errCode="x";
		        	errMsg="操作工号和查询工号不是同一类型或者不在同一地市";
			  	  }else
		  	  	{

		  	  	}
          }
				}
			}
	 }
 }
}
}else
	{
		kfsqlStr= "select count(*) from dloginmsg a,dloginmsg b where a.login_no='"+work_no+"' and b.login_no='"+endLoginNo+"'  and a.account_type=b.account_type";
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode4" retmsg="retMsg4">
			   <wtc:sql><%=kfsqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="resultStr4" scope="end"/>			
<%
		  errCode = retCode4;
		  errMsg = retMsg4;
				if(errCode.equals("000000"))
				{
					if(resultStr4!=null && resultStr4.length>0)
			  	{
			  	  if(resultStr4[0][0].equals("0"))
			  	  {
			  	  	errCode="x";
		        	errMsg="操作工号为客服工号，但是查询工号不是客服工号";
			  	  }else
		  	  	{

		  	  	}
          }
				}
			}	
%>					

var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
core.ajax.receivePacket(response);



