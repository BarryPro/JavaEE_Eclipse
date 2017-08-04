<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2000.01.13
 模块：集团合同协议录入
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<% request.setCharacterEncoding("gbk");%>

<%
    //得到输入参数
    String opName = "集团合同协议录入";
    String return_code,return_message,total_date,login_accept;
    String[][] result = new String[][]{};

	String loginAccept = request.getParameter("loginAccept");
    String region_code = request.getParameter("regionCode");
    String org_code = request.getParameter("belongCode");
    String work_no = request.getParameter("workno");					//操作工号
    String ip_addr = request.getParameter("ip_Addr");
    String op_code = "1902";
    String cust_id = request.getParameter("cust_id");                 //客户ID
    String unit_id = request.getParameter("unit_id");                 //集团ID
    String unit_name = request.getParameter("unit_name");             //集团名称
    String contract_id = unit_id;
    String contract_no = unit_id;
    String contract_name = request.getParameter("contract_name");
    String contract_status = request.getParameter("contract_status");
    String deal_time = WtcUtil.repStr(request.getParameter("deal_time")," ");
    String complete_time = WtcUtil.repStr(request.getParameter("complete_time")," ");
    String logout_time = WtcUtil.repStr(request.getParameter("logout_time")," ");
    String deal_address = WtcUtil.repStr(request.getParameter("deal_address")," ");
    String item_manager = WtcUtil.repStr(request.getParameter("item_manager")," ");
    String contract_file = WtcUtil.repStr(request.getParameter("contract_file")," ");
    String contract_desc = WtcUtil.repStr(request.getParameter("contract_desc")," ");
    String opNote = WtcUtil.repStr(request.getParameter("opNote")," ");

    if (deal_time.trim().length() == 8) {
        deal_time = deal_time.substring(0, 4) + "-" + deal_time.substring(4, 6) + "-"
                  + deal_time.substring(6, 8);
	}

    if (complete_time.trim().length() == 8) {
        complete_time = complete_time.substring(0, 4) + "-" + complete_time.substring(4, 6) + "-"
                      + complete_time.substring(6, 8);
	}

    if (logout_time.trim().length() == 8) {
        logout_time = logout_time.substring(0, 4) + "-" + logout_time.substring(4, 6) + "-"
                    + logout_time.substring(6, 8);
	}

    if (opNote.trim().length() > 60) {
        opNote = opNote.substring(0,50);
    }
    	/*
        retArray = callView.view_s1902Cfm(org_code, work_no, op_code,ip_addr,
        cust_id, unit_id, contract_id, contract_no, contract_name,
        contract_status, deal_time, complete_time, logout_time,
        deal_address, item_manager, contract_desc, opNote);
        */
%>
		<wtc:service name="s1902Cfm" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
		<wtc:param value="<%=org_code%>"/>	
		<wtc:param value="<%=work_no%>"/>	
		<wtc:param value="<%=op_code%>"/>	
		<wtc:param value="<%=ip_addr%>"/>	
		<wtc:param value="<%=cust_id%>"/>	
		<wtc:param value="<%=unit_id%>"/>	
		<wtc:param value="<%=contract_id%>"/>	
		<wtc:param value="<%=contract_no%>"/>	
		<wtc:param value="<%=contract_name%>"/>	
		<wtc:param value="<%=contract_status%>"/>	
		<wtc:param value="<%=deal_time%>"/>	
		<wtc:param value="<%=complete_time%>"/>	
		<wtc:param value="<%=logout_time%>"/>	
		<wtc:param value="<%=deal_address%>"/>	
		<wtc:param value="<%=item_manager%>"/>	
		<wtc:param value="<%=contract_desc%>"/>	
		<wtc:param value="<%=opNote%>"/>	
		</wtc:service>	
		<wtc:array id="result1"  scope="end"/>
<%        
        result = result1;
		
        String ret_code = result[0][0];
        String retMessage = result[0][1];
        String retQuence = result[0][2];
		String url = "/npage/contact/onceCnttInfo.jsp?opCode="+op_code+"&retCodeForCntt="+ret_code
			+"&retMsgForCntt="+retMessage+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept
			+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
		System.out.println(url);
%>
		<jsp:include page="<%=url%>" flush="true" />        
<%
        if((ret_code.trim()).compareTo("000000") == 0)
        {
%>
            <script language="javascript">
                rdShowMessageDialog("集团合同录入成功！",2);
				/***因为页面是嵌套在frame中,所以要用两个parent***/                
                location="f1902_main.jsp?opCode='1902'&opName='集团合同协议录入'";
            </script>
<%      }else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]" ,0);
                history.go(-1);
            </script>
<%
        }
%>
