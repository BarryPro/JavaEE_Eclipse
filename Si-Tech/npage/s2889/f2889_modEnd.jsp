<%
   /*���ƣ����ſͻ���Ŀ���� - ��ֹ�ύ
�� * �汾: v1.0
�� * ����: 2007/2/7
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%  
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));            //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));         //��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));            //��½����
	String regionCode =WtcUtil.repNull((String)session.getAttribute("regCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));

	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
	String opNote = workNo + "(" + strDate+ ")" + "ҵ����ֹ";
	String opCode = "2889";	
	String opName = "�������ҵ����ֹ";
%>

<%
	String OprCode = request.getParameter("OprCode");//02��ֹ
	String spId = request.getParameter("parterId");//����������
	String bizCode = request.getParameter("operId");//ҵ�����
	
	ArrayList paramsIn = new ArrayList();
	
	paramsIn.add(new String[]{workNo    });	
	paramsIn.add(new String[]{nopass    });	
	paramsIn.add(new String[]{org_code    });	
	paramsIn.add(new String[]{opCode    });	
	paramsIn.add(new String[]{regionCode    });	
	paramsIn.add(new String[]{spId    });	
	paramsIn.add(new String[]{OprCode    });	
	paramsIn.add(new String[]{bizCode    });	
	
    %>
        <wtc:service name="s6300Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=nopass%>"/> 
            <wtc:param value="<%=org_code%>"/> 
            <wtc:param value="<%=opCode%>"/> 
            <wtc:param value="<%=regionCode%>"/> 
            <wtc:param value="<%=spId%>"/> 
            <wtc:param value="<%=OprCode%>"/> 
            <wtc:param value="<%=bizCode%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
	int errCode = Integer.parseInt(retArr[0][0]);
	String errMsg  = retArr[0][1];
	System.out.println("# errCode = "+errCode);
	System.out.println("# errMsg = "+errMsg);
%>

	var response = new AJAXPacket();
	response.data.add("retFlag","queryModEnd");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);
	