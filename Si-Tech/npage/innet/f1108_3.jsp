<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.08.27
********************/
%>

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
 ���������
      �ֻ�����  
 ��������� 
      �������
      ������Ϣ
      �Ƿ�Ԥ��ͨ��־   Y  Ԥ��ͨ , N  ��Ԥ��ͨ
      SIM������
      SIM������ 
*/

        //�õ�������� 
        //Logger logger = Logger.getLogger("f1108_3.jsp");
        //ArrayList retArray = new ArrayList();
       // String return_code,return_message;
       // String[][] result = new String[][]{};
 		//S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String Phone_no = request.getParameter("Phone_no");
	    String region_code = request.getParameter("region_code"); 
	    
        // String err_code  = "";
        // String err_message  = "";
         String foreFlag = "N";
		 String simNo = "";
		 String simType = "";
		 String simTypeName="";

            // retArray = callView.view_sQryForeSimNo(Phone_no);
%>
   <wtc:service name="spubGetId" routerKey="region" routerValue="<%=region_code%>" retCode="retCode" retMsg="retMessage" outnum="10" >
	<wtc:param value="<%=Phone_no%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
     if(retCode.equals("0")||retCode.equals("000000")){
 			   retCode="000000";
 			foreFlag = result[0][0];
             simNo  = result[0][1];
            simType  = result[0][2];
			simTypeName=result[0][3];
 			}

            
%>

var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var foreFlag = "";
var simNo = "";
var simType = "";
var simTypeName="";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
foreFlag = "<%=foreFlag%>";
simNo = "<%=simNo%>";
simType = "<%=simType%>";
simTypeName="<%=simTypeName%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("foreFlag",foreFlag);
response.data.add("simNo",simNo);
response.data.add("simType",simType);
response.data.add("simTypeName",simTypeName);
core.ajax.receivePacket(response);

