<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>

<%
	//��ȡ�û�session��Ϣ
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));               //����
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));               	//��������
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String implRegion = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String regionCode = implRegion;
	
	
	String vBizCodeAdd = request.getParameter("vBizCodeAdd");
	String vProductCode= request.getParameter("vProductCode");
	
	//wuxy add 20090824 ���ҵ�����ƣ���ʹ�ö���ʵ��������������ϵ
	
	String sqlStr="select count(*) from dgrpusermsgadd a,dgrpusermsg b where a.id_no=b.id_no and b.run_code=any('A','F') and a.field_code='YWDM0' and field_value='"+vBizCodeAdd+"' and b.product_code='"+vProductCode+"' ";
	
    int errCode=0;
    String errMsg="";
  	
	String[] acceptList = null;
	
	ArrayList acceptList1 = null;
	String[][] allNumStr = new String[][]{};
	
	String paramsIn[] = new String[4];
	paramsIn[0] = "289401";
	paramsIn[1] = workNo;
	paramsIn[2] = vBizCodeAdd;
	paramsIn[3] = vProductCode;	
	
	
	//acceptList1=impl.sPubSelect("1",sqlStr, "region", implRegion);
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
    
  allNumStr = retArr;
  
  if(allNumStr==null || allNumStr.length==0)
  {
     errCode=1;
     errMsg="��֤���ʷѶ�Ӧ��ϵ�Ƿ��ж���ʵ��ʹ�ô���!";
  }
 else
 {
   if(Integer.parseInt(allNumStr[0][0].trim())>0)
   {
     errCode=2;
     errMsg="���ʷѶ�Ӧ��ϵ�ж���ʵ��ʹ�ã����������!";
   }
  else
  {
		//acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");
    %>
        <wtc:service name="sDynSqlCfm" retcode="retCode" retmsg="retMsg" outnum="0" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=paramsIn[0]%>"/>
        	<wtc:param value="<%=paramsIn[1]%>"/> 
            <wtc:param value="<%=paramsIn[2]%>"/>
            <wtc:param value="<%=paramsIn[3]%>"/>
        </wtc:service>
    <%
		errCode=Integer.parseInt(retCode);
		errMsg=retMsg;
	}
}
System.out.println("# f2894End.jsp -> errCode = " + errCode);
System.out.println("# f2894End.jsp -> errMsg  = " + errMsg );
	%>
	
	
var response = new AJAXPacket();
response.data.add("retFlag","queryMod");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
	