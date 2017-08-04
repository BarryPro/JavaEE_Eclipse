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
 输入参数：
      手机号码
      SIM卡号码
      操作代码
      归属代码
      入网代码
      业务类型
      
 输出参数： 
      错误代码
      错误消息
      选号费
      SIM卡费
      手续费
      手机号码预存
      入网费
      入网预存
*/

        //得到输入参数
        
       // ArrayList retArray = new ArrayList();
       // String return_code,return_message;
       // String[][] result = new String[][]{};
 	//	S1100View callView = new S1100View();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String sIn_Phone_no = request.getParameter("sIn_Phone_no");
	    String sIn_Sim_no = request.getParameter("sIn_Sim_no");
	    String sIn_Op_code = request.getParameter("sIn_Op_code");
	    String sIn_Belong_code = request.getParameter("sIn_Belong_code");
	    String sIn_Inland_Toll = request.getParameter("sIn_Inland_Toll");
	    String sIn_Sm_code = request.getParameter("sIn_Sm_code");
	    String orgCode = (String)session.getAttribute("orgCode");
        String region_code = orgCode.substring(0,2);
	    
         String err_code  = "";
         String err_message  = "";
         String sV_Choice_fee  = "";
         String sV_Sim_fee  = "";
         String sV_Hand_fee  = "";
         String sV_Phone_prepay  = "";
         String sV_Innet_fee  = "";
         String sV_Innet_prepay  = "";

		 String sV_Main_fee="";

      
%>
<wtc:service name="s1104GetFee" routerKey="regionCode" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMsg"  outnum="9" >
			        <wtc:param value="<%=sIn_Phone_no%>"/>
			        <wtc:param value="<%=sIn_Sim_no%>"/>
			        <wtc:param value="<%=sIn_Op_code%>"/>
			        <wtc:param value="<%=sIn_Belong_code%>"/>
			        <wtc:param value="<%=sIn_Inland_Toll%>"/>
			        <wtc:param value="<%=sIn_Sm_code%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />

<%
          //    retArray = callView.view_s1104GetFee(sIn_Phone_no,sIn_Sim_no,sIn_Op_code,sIn_Belong_code,sIn_Inland_Toll,sIn_Sm_code);
 
             //result = (String[][])retArray.get(0);
             //err_code  = result[0][0];
            // err_message  = result[0][1];
            
            if(retCode.equals("0")||retCode.equals("000000")){     //如果服务返回是0的话 变成000000  统一返回结果
            System.out.println("s1104GetFee  in f1104_4.jsp 调用成功！________________________________");
               sV_Choice_fee  = result[0][2];
	             sV_Sim_fee  = result[0][3];
	             sV_Hand_fee  = result[0][4];
	             sV_Phone_prepay  = result[0][5];
	             sV_Innet_fee  = result[0][6];
	             sV_Innet_prepay  = result[0][7];
					 sV_Main_fee=result[0][8];
 			      retCode="000000";
 			
 		}else{
 			 System.out.println("s1104GetFee  in f1104_4.jsp 调用失败！________________________________");
 			}

          
       
 %>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var sV_Choice_fee = "";
var sV_Sim_fee = "";
var sV_Hand_fee = "";
var sV_Phone_prepay = "";
var sV_Innet_fee = "";
var sV_Innet_prepay = ""; 
var sV_Main_fee="";
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMsg%>";
sV_Choice_fee = "<%=sV_Choice_fee%>";
sV_Sim_fee = "<%=sV_Sim_fee%>";
sV_Hand_fee = "<%=sV_Hand_fee%>";
sV_Phone_prepay = "<%=sV_Phone_prepay%>";
sV_Innet_fee = "<%=sV_Innet_fee%>";
sV_Innet_prepay = "<%=sV_Innet_prepay%>"; 
sV_Main_fee='<%=sV_Main_fee%>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sV_Choice_fee",sV_Choice_fee);
response.data.add("sV_Sim_fee",sV_Sim_fee);
response.data.add("sV_Hand_fee",sV_Hand_fee);
response.data.add("sV_Phone_prepay",sV_Phone_prepay);
response.data.add("sV_Innet_fee",sV_Innet_fee);
response.data.add("sV_Innet_prepay",sV_Innet_prepay);
response.data.add("sV_Main_fee",sV_Main_fee);
core.ajax.receivePacket(response);

