<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.08.29
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*
 输入参数： 
	手机号码
	机构编码
	业务类型
	SIM卡卡号
	SIM卡卡类型
 输出参数： 
      错误代码
      错误消息

*/

        //得到输入参数
	    //Logger logger = Logger.getLogger("f1104_5.jsp");        
        //ArrayList retArray = new ArrayList();
        //String[][] result = new String[][]{};
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String sIn_Phone_no = request.getParameter("sIn_Phone_no");
	    String sIn_OrgCode = request.getParameter("sIn_OrgCode");
	    String region_code = sIn_OrgCode.substring(0,2);
	    String sIn_Sm_code = request.getParameter("sIn_Sm_code");
	    String sIn_Sim_no = request.getParameter("sIn_Sim_no");
	    String sIn_Sim_type = request.getParameter("sIn_Sim_type");
	    String sIn_zph = request.getParameter("zph");
	    String sIn_cardtype=request.getParameter("sIn_cardtype");
	    String sIn_workno=request.getParameter("workno");
	    String sIn_offerId=request.getParameter("offerId");
	    String sIn_simType=request.getParameter("simType");
	    String sltedBossFlag=request.getParameter("sltedBossFlag");
	    
	    String sIn_simTypeOne=request.getParameter("simTypeOne");

	    String innetType=request.getParameter("innetType");
      /*begin diling add for 关于对特殊号码审批专项测试结果进行优化的需求 增加参数：custIccid @2012/5/28 */
      String custIccid=(String)request.getParameter("custIccid")==null?"":(String)request.getParameter("custIccid");
      /*end diling add*/
	    String offerId = "";
	    String mode_dxpay = "";
		//String ret_message = "";
		//int ret_code=9;
		//String[] retStr=null;
		String serviceName="sChekPhoneSimNo";
		String outParaNum="0";
		/*diling update for 关于对特殊号码审批专项测试结果进行优化的需求 增加参数：custIccid @2012/5/28 */
		String[] paraStrIn = new String[]{sIn_Phone_no,sIn_OrgCode,sIn_Sm_code,sIn_Sim_no,sIn_Sim_type,sIn_zph,sIn_cardtype,sIn_workno,custIccid,sIn_offerId,sIn_simType,sIn_simTypeOne,sIn_simTypeOne};
		
		for(int hjw=0;hjw<paraStrIn.length;hjw++){
			System.out.println("-----------gaopengSeeLog1104_5----------------paraStrIn["+hjw+"]--------------------"+paraStrIn[hjw]);
		}
		System.out.println("--------------------sIn_Phone_no------------------"+sIn_Phone_no);
		System.out.println("----------gaopengSeeLog1104_5----------sIn_simTypeOne------------------"+sIn_simTypeOne);
		System.out.println("--------------------sIn_workno--------------------"+sIn_workno);
		String isGoodNo = "0";
		String prepayFee = "0";
%>
	    <wtc:service name="sChekPhoneSimNo" routerKey="region" routerValue="<%=region_code%>"  retcode="ret_code" retmsg="ret_message"  outnum="4" >
        <wtc:params value="<%=paraStrIn%>"/>
		</wtc:service>
		<wtc:array id="retStr" scope="end" />
<%
System.out.println("---zhouby--innetType="+innetType);
if(innetType.equals("04")){
%>			
			<wtc:service name="sGoodNoCheck" routerKey="region" routerValue="<%=region_code%>" retcode="retCode12" retmsg="retMsg12" outnum="10" >
        	<wtc:param value="<%=sIn_Phone_no%>"/>
        	<wtc:param value="<%=sIn_workno%>"/> 
        </wtc:service>
      <wtc:array id="retArr12" scope="end"/>
<%   
		
		
		System.out.println("#zhouby return by sGoodNoCheck - > retCode12 = "+retCode12);
		System.out.println("# return by sGoodNoCheck - > retMsg12 = "+retMsg12);
		if("000000".equals(retCode12) && retArr12.length>0){
		    isGoodNo = retArr12[0][1];
		    prepayFee = retArr12[0][3];
		    offerId = retArr12[0][5] ;
		}
		
		System.out.println("zhouby: isGoodNo =" + isGoodNo);
		System.out.println("zhouby: sIn_Phone_no =" + sIn_Phone_no);
		
		//如果是靓号，判断是否低消大于0元
		if (!"0".equals(isGoodNo)){
				String judgeDxpay = " select mode_dxpay " +
  						 							" from dgoodphoneres a, sGoodBillCfg b " +
 						 								" where a.bill_code = b.mode_code " +
   						 							" and b.region_code = '" + region_code + "'"+
   						 							" and a.phone_no = '" + sIn_Phone_no + "' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
%>
				<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=region_code%>" outnum="1">
					<wtc:sql><%=judgeDxpay%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="resultx" scope="end" />
<%				
				if(resultx != null && resultx.length > 0){
						if(resultx[0][0].equals("")){
								isGoodNo = "0";
						}else{
								isGoodNo = "1";
						}
			  } else {
			  		isGoodNo = "0";
			  }
		}
		
		System.out.println("----------------------retArr12[0][1]----------------"+retArr12[0][1]);
		System.out.println("----------------------retArr12[0][3]----------------"+retArr12[0][3]);
 }
		
			System.out.println("=========================================ret_code    in f1104_5.jsp"+ret_code);
			System.out.println("=========================================ret_message        in f1104_5.jsp"+ret_message);
		String sql = "SELECT mode_dxpay FROM sgoodbillcfg WHERE mode_code = '"+offerId+"' AND region_code='"+region_code+"'";
		System.out.println("=========================================sql    in f1104_5.jsp"+sql);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result9" scope="end" />		
<%
	if(result9.length>0){
		mode_dxpay = result9[0][0];
	}
%>			
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";

retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("isGoodNo","<%=isGoodNo%>");
response.data.add("prepayFee","<%=prepayFee%>");
response.data.add("mode_dxpay","<%=mode_dxpay%>");
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);

