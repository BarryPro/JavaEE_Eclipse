<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     	//��½����
	String regionCode=org_code.substring(0,2);
 
	String detail_type = request.getParameter("detail_type");     
	String rpcType = request.getParameter("rpcType");   
	String region_code = request.getParameter("region_code");  
	String sm_code = request.getParameter("sm_code"); 
	String detail_code = request.getParameter("detail_code"); 
	
    SPubCallSvrImpl impl = new SPubCallSvrImpl();
    ArrayList retList = new ArrayList(); 
    String sqlStr="";

  
 /*****����detail_type�����ͣ����������******/
 if( detail_type.equals("0") )//����
 {
	sqlStr = "select count(1) from sBillRateCode where region_code='"+region_code+"' and rate_code='"+detail_code+"'"; 
 } 
 else if(detail_type.equals("1")||detail_type.equals("9"))//����
 {
	sqlStr = "select count(1) from sBillMonthCode where region_code='"+region_code+"' and month_code='" + detail_code+"'";
 }
 else if(detail_type.equals("2")||detail_type.equals("b"))//����
 {
	sqlStr = "select count(1) from sBillTotCode where region_code='"+region_code+"' and total_code='"+detail_code+"'";
 }
 else if(detail_type.equals("3"))//ͨ�������Ż�
 {
	sqlStr = "select count(1) from sBillFavCfg where region_code='"+region_code+"' and favour_code='"+detail_code+"'";
 }
 else if(detail_type.equals("4"))//�ط��Ż�
 {
    sqlStr = "select count(1) from sBillFuncFav where region_code='"+region_code+"' and function_bill='"+detail_code+"'";
 }
 else if(detail_type.equals("a"))//�ط���
 {
    sqlStr = "select count(1) from sBillFuncBind where region_code='"+region_code+"' and function_bind='"+detail_code+"'";
 }

	retList = impl.sPubSelect("1",sqlStr,"region",regionCode);
	String[][] retArr = (String[][])retList.get(0);
	String existNum =retArr[0][0];
	int errCode=0;
	String errMsg="success";
	errCode = impl.getErrCode();
%>

var response = new RPCPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("rpcType","<%=rpcType%>");
response.data.add("existNum","<%=existNum%>");
core.rpc.receivePacket(response);