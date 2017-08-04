<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

var retarr=new Array();
<%


	//得到输入参数
	String loginNo = request.getParameter("loginNo");
	String cust_id = request.getParameter("cust_id");
	String opCode = request.getParameter("opCode");
	String grpIdNo = request.getParameter("grpIdNo");
	String retType = request.getParameter("retType");
	String ECSIType = request.getParameter("ECSIType");
	String black_type = request.getParameter("black_type");
 String regionCode = request.getParameter("regionCode");
	
    ArrayList paramsIn = new ArrayList();
	String[] retStr = null;
	SPubCallSvrImpl callView = new SPubCallSvrImpl();	
	String retCode="000000";
	String retMessage="";
	String sqlStr="";
	String ECSIID="";
  String cust_name="";
	 String[] inParams = new String[2];
	
	if(ECSIType.equals("01"))
	{
		//inParams[0] ="select b.unit_id,b.unit_name  from dbvipadm.dgrpcustmsgadd a,dgrpcustmsg b where a.cust_id = b.cust_id "+
			//"   and a.field_code ='HYWG0'  and b.unit_id =:cust_id";
		inParams[0] = "select to_char(b.unit_id), b.unit_name from dcustdoc a, dgrpcustmsg b where a.cust_id = b.cust_id and b.unit_id =:cust_id and a.owner_type = '04'";	
	}

	if(ECSIType.equals("02"))
	{
		inParams[0] ="select to_char(parter_id),parter_name  from dpartermsg where status='07' and  parter_id=:cust_id";
	}

	inParams[1] = "cust_id="+cust_id;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="code2" retmsg="msg2" outnum="2"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
		</wtc:service> 
	  <wtc:array id="retarr" scope="end"/>
	  
  <%
        if(retarr.length>0 && code2.equals("000000")){                
              for(int i=0;i<2;i++){
                 System.out.println("====|客户信息|===="+retarr[0][i]);
              }
              //catalog_item_id=retarr[0][0];
              ECSIID=retarr[0][0];
              cust_name=retarr[0][1];
          }

%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=msg2%>";
var retCode= "<%=code2%>";
var ECSIID = "<%=ECSIID%>";
var cust_name = "<%=cust_name%>";


response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("ECSIID",ECSIID);
response.data.add("cust_name",cust_name);		

core.ajax.receivePacket(response);
