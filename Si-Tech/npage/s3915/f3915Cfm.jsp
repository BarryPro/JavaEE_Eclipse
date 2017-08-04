<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
 模块: MAS/ADC业务暂停/恢复功能
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%  
   
	String workNo   = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass  = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String opCode = "3915";	
	String opName = "MAS/ADC业务暂停/恢复功能";
%>

<%
	

	String OprCode = request.getParameter("OprCode");//03停机,04恢复
	String id_no = request.getParameter("id_no");//产品id
	String unitId = request.getParameter("unitId");//集团id
	System.out.println("unitId====="+unitId);
	
	if("04".equals(OprCode))
	{
		opCode="3927";
	}
	
	ArrayList paramsIn = new ArrayList();
	
	paramsIn.add(new String[]{opCode    });
	paramsIn.add(new String[]{workNo    });
	paramsIn.add(new String[]{nopass    });
	paramsIn.add(new String[]{org_code  });
	paramsIn.add(new String[]{ip_Addr   });
	paramsIn.add(new String[]{id_no     });
	paramsIn.add(new String[]{OprCode   });
	
	//String[] retStr = null;
	 
	//retStr = impl.callService("s3915CfmE", paramsIn, "2","region", regionCode);
%>
	<wtc:service name="s3915CfmE" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=opCode%>"/>	
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=nopass%>"/>
	<wtc:param value="<%=org_code%>"/>	
	<wtc:param value="<%=ip_Addr%>"/>
	<wtc:param value="<%=id_no%>"/>
	<wtc:param value="<%=OprCode%>"/>
	</wtc:service>	
	<wtc:array id="retStrTemp"  scope="end"/>
<%
	
	String errCode = "";
	String errMsg="";
	String maxAccept="";
	String idNo="";

	errCode		= retCode1;
	errMsg		= retMsg1;
	if(errCode.equals("000000"))
	{
		maxAccept	= retStrTemp[0][0];
		idNo		= retStrTemp[0][1];
	}
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+maxAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";
%>
    <jsp:include page="<%=url%>" flush="true" />

	var response = new AJAXPacket();
	response.data.add("retFlag","queryMod");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);
