<%
/********************
 * version v2.0
 * ���ܣ���ȡӪ��������
 * ������: si-tech
 * update by huangrong @ 2011-4-20
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String errCode = "";
    String errMsg = "";
		String functionName[]=null;
		String opCode[]=null;
    String work_no = (String)session.getAttribute("workNo");
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
		String phoneNo = request.getParameter("phoneNo");
%>

    <wtc:service name="sSpcDtQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=phoneNo%>"/>
    </wtc:service>
    <wtc:array id="sSpcDtQryArr1" start="0" length="2" scope="end"/>
    <wtc:array id="sSpcDtQryArr2" start="2" length="4" scope="end"/>

<%
	errCode = sSpcDtQryArr1[0][0];
  errMsg = sSpcDtQryArr1[0][1];
 	if(errCode.equals("000000"))
 	{

 	System.out.println("=======================sSpcDtQryArr2.length=============================="+sSpcDtQryArr2.length);
		if(sSpcDtQryArr2.length>0)
		{
	    String resuleStr[][] = sSpcDtQryArr2;
			opCode = new String[resuleStr.length];
			functionName = new String[resuleStr.length];                                
			for(int i=0; i< resuleStr.length; i++)
			{
				opCode[i] = resuleStr[i][2];
				functionName[i] = resuleStr[i][3];
			}
		}else
		{
			errCode = "error";
			errMsg = "���û�û��ר����Ϣ�����ܽ��в�����ò�ѯ";			
		}
	}else
	{
		errCode = "error";
		errMsg = "ȡӪ��������ʧ��";	
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
<%
if("000000".equals(errCode))
{
%>
		var opCodes = Array();
		var names = Array();
<%
		for(int i=0; i< functionName.length ;i++)
		{
%>
			opCodes[<%=i%>] = "<%=opCode[i]%>";
			names[<%=i%>] = "<%=functionName[i]%>";
<%
		}
%>
		response.data.add("opCodes",opCodes);
		response.data.add("names",names);
<%
}	
%>
core.ajax.receivePacket(response);



