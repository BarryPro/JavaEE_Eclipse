<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.27   nt
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*
      输入参数：凭证序列号     凭证密码
      输出参数：错误代码       错误消息     凭证状态名称     归属省代码名称
                凭证面额       折扣率       有效期           合作厂商
*/   
        //得到输入参数 
       // Logger logger = Logger.getLogger("f1104_8.jsp");
       // ArrayList retArray = new ArrayList();
       // String[][] result = new String[][]{};
 	//	S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String sIn_Cred_id = request.getParameter("Cred_id");
	    String sIn_Cred_pwd = request.getParameter("Cred_pwd");
	 String orgCode = (String)session.getAttribute("orgCode");
        String region_code = orgCode.substring(0,2);
	    
        //String err_code = "";
        //String err_message = "";
/*
       	String sV_Cred_status = "";        		//凭证状态      1    
        String sV_Cred_pwd = "";          		//凭证密码        
        String sV_Org_province = "";       		//归属省代码    1 
        String sV_Cred_price = "";        		//凭证面额      1
        String sV_Cred_fav = "";           		//折扣率        1
        String sV_Cred_date = "";          		//有效期        1
        String sV_Coagent_code = "";       		//合作厂商      1

        String sV_Status_name = "";       		//凭证状态名称   
        String sV_Province_name = "";     		//归属省代码名称 
        String sV_Coagent_name = "";      		//合作厂商名称   
*/
		String credPwd = "";
		String eInfo = "";  
        try
        {
        
 %>
<wtc:service name="s1120Check" routerKey="regionCode" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMsg"  outnum="100" >
        <wtc:param value="<%=sIn_Cred_id%>"/>
        <wtc:param value="<%=sIn_Cred_pwd%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />


 <%
        //   retArray = callView.view_s1120Check(sIn_Cred_id,sIn_Cred_pwd);
          //  result = (String[][])retArray.get(0);
           //  err_code  = result[0][0];
            // err_message  = result[0][1];
             credPwd = result[0][3];
             for(int i=2;i<8;i++)
             {		eInfo +=result[0][i] + "~";		}              
        }catch(Exception e){
            logger.error("Call sunView(s1120Check) is Failed!");
        }
		
		
%>

var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var credPwd = "";
var eInfo = ""; 

retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMsg%>";
credPwd = "<%=credPwd%>";
eInfo = "<%=eInfo%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("credPwd",credPwd);
response.data.add("eInfo",eInfo);

core.ajax.receivePacket(response);

