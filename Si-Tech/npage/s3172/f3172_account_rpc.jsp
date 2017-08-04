   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-11
********************/
%>
              
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	System.out.println("111111111111111");
	
	Logger logger = Logger.getLogger("f3171_account_rpc.jsp");
		
	String contract_no = request.getParameter("contract_no");	
	String num="";
	String regionCode = (String)session.getAttribute("regCode");
	String sqlStr = "select to_char(count(*)) from dconmsg a,dconconmsg b where a.contract_no='?' and a.account_type in('A','1') and a.contract_no=b.contract_pay";
	//retArray = impl.sPubSelect("1",sqlStr);
	System.out.println("-----------sqlStr-----------"+sqlStr);
	//xl add for sunqy 判断是否预开未回收
	int i_yk=0;
	String[] sql_yk = new String[2];
	sql_yk[0]="select to_char(count(0)) from grp_pre_invoice where grp_contract_no=:s_contract and s_flag='p' ";
	sql_yk[1]="s_contract="+contract_no;

%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodeyk" retmsg="retMsgyk" outnum="1">
		    <wtc:param value="<%=sql_yk[0]%>"/>
			<wtc:param value="<%=sql_yk[1]%>"/>
		</wtc:service>
		<wtc:array id="result_yk" scope="end" />
	<%
		if(result_yk!=null){
			if (result_yk.length>0) {
			   i_yk = Integer.parseInt(result_yk[0][0]);
			}
		}
		%>
		<wtc:pubselect name="TlsPubSelBoss" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	   <wtc:param value="<%=contract_no%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result" scope="end"/>
	 

<%	
System.out.println("dddddddddddddddddddddddddddddd i_yk is "+i_yk);
	String errCode=code1; 
	String errMsg=msg1;  

			
	if(errCode.equals("000000"))
	{
		num = result[0][0];
	}
		

			System.out.println("-----------errCode-----------"+errCode);
			System.out.println("-----------errMsg-----------"+errMsg);
%>    
	var response = new AJAXPacket();
	response.data.add("retFlag","checkAccount");
	response.data.add("num","<%=num%>");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	response.data.add("i_yk","<%=i_yk%>");
	core.ajax.receivePacket(response);