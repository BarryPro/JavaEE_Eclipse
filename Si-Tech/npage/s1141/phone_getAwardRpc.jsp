<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.04
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%/*
* ��ѯ�ֻ����Ͷ�Ӧ��Ʒ�ȼ�����RPC
* @author  sunzx
* @version 1.0
* @since   JDK 1.4.2
*/%>

<%
//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//String[][] baseInfoSession = (String[][])arrSession.get(0);
//String loginNo = baseInfoSession[0][2];
//String orgCode = baseInfoSession[0][16];
//String regionCode = orgCode.substring(0,2);

  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String  loginNo = (String)session.getAttribute("workNo");



String group_id = "";
//String retCode = "000004";
//String retMessage = "δ֪����";
//String retType = ReqUtil.get(request,"retType");
//String style_code = ReqUtil.get(request,"style_code");
//String op_code = ReqUtil.get(request,"op_code");
String retType =request.getParameter("retType");
String style_code =request.getParameter("style_code");
String op_code =request.getParameter("op_code");
//comImpl co=new comImpl();	
//List al = null;
String sql1 = "select group_id from dloginmsg where login_no = '"+loginNo+"'";
//al = co.spubqry32("1",sql1);

%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows1" scope="end" />

<%
          if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("���÷���sPubSelect in phone_getAwardRpc.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	
 	        	if(rows1.length!=0){
 	        	 group_id = rows1[0][0];
 	        	}
 	        	
 	        	
 	     	}else{
 			System.out.println("���÷���sPubSelect in phone_getAwardRpc.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}



/**if(al != null)
{
	//String rows[][] = (String[][])al.get(0);
	
}
**/

String sql = "select count(*) from sphoneawardcfg a,dbgiftrun.schnactivegrade b,dbgiftrun.schnactivegradecfg c"+
",dbgiftrun.RS_CHNGROUP_REL d where b.grade_code = c.grade_code and a.active_code = b.active_code and "+
"a.op_code = '"+op_code+"' and a.region_code='"+regionCode+"' and b.phone_style_code = '"+style_code+"' and c.group_id = d.parent_group_id "+
"and d.group_id = '"+group_id+"'";
System.out.println(sql);

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMessage" outnum="1">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end" />
<%
  		  if(retCode1.equals("0")||retCode1.equals("000000")){
          System.out.println("���÷���sPubSelect in phone_getAwardRpc.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	
 	        	if(rows.length!=0){
 	        	
 	        	    if(Integer.parseInt(rows[0][0]) > 0){
 	        	    	retCode = "000000";
		              retMessage = "�ɹ�";
 	        	    
	 	        	  }else{
	 	        	  	retCode = "000001";
						retMessage = "�û���δ������Ʒ�����������������";
	 	        	  	
	 	        	  	}
 	        	 
 	        	}
 	        	
 	        	
 	     	}else{
 	     			retCode = "000002";
				   retMessage = "��ѯʧ�ܣ�";
 	     		
 			System.out.println("���÷���sPubSelect in phone_getAwardRpc.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}



/**
al = co.spubqry32("1",sql);
if(al != null)
{
	String rows[][] = (String[][])al.get(0);
	if(Integer.parseInt(rows[0][0]) > 0)
	{
		retCode = "000000";
		retMessage = "�ɹ�";
	}
	else
	{
		retCode = "000001";
		retMessage = "�û���δ������Ʒ�����������������";
	}
}
else
{
	retCode = "000002";
	retMessage = "��ѯʧ�ܣ�";
}

**/
%>

var response = new AJAXPacket();

response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMessage","<%=retMessage%>");

core.ajax.receivePacket(response);



