<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%/*
*��ҳ�����ڶ�RPC�������÷��񣬲����ؽ����
*/%>
<%
	String regCode = (String)session.getAttribute("regCode");
	
	String ageRange = request.getParameter("ageRange");
	
	String sqlStr ="select code, name from sModeGuideOption where option_type =  '2'  and sub_cond1_value = '"+ageRange+"' ";
	System.out.println("sqlStr======"+sqlStr);
	
	//retArray_select = callView.view_spubqry32("2",sqlStr);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tri_metaData" scope="end" />
<%
	
	System.out.println("retCode1====="+retCode1);
	//String[][] tri_metaData = (String[][])retArray_select.get(0);
	String tri_metaDataStr = WtcUtil.createArray("js_tri_metaDataStr",tri_metaData.length);
%>
<%=tri_metaDataStr%>
<%   
  for(int p=0;p<tri_metaData.length;p++)
  {  
	  for(int q=0;q<tri_metaData[p].length;q++)
	  {
%>
        js_tri_metaDataStr[<%=p%>][<%=q%>]="<%=tri_metaData[p][q]%>";
        
<%
	  }
  }
%>
var response = new AJAXPacket();
response.data.add("tri_list",js_tri_metaDataStr);
core.ajax.receivePacket(response);