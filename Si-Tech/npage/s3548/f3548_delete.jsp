<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    ArrayList retArray = null;
    String error_code = "";
    String error_msg = "";
    Logger logger = Logger.getLogger("f3548_delete.jsp");

  String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
  String iWorkNo         = request.getParameter("WorkNo");           //����Ա����
  String iLogin_Pass     = request.getParameter("NoPass");           //����Ա����
  String iOrgCode        = request.getParameter("OrgCode");          //����Ա��������
  String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
  String iOp_Note        = request.getParameter("tonote");           //�û�������ע
  String iIpAddr         = request.getParameter("ip_Addr");          //����ԱIP��ַ
  String iGrp_Id         = request.getParameter("id_no");            //�����û�ID	 
	String idcMebNo        = request.getParameter("cust_code");          //IDC�û�����
	//add by baixf 20070606
	String unit_id     =request.getParameter("unit_id");	
	String regionCode = (String)session.getAttribute("regCode");
	//
  String opCode = "3548";
  String opName = "�ǹ�ͨ��Ա����";
	String iPay_Type	   = "0";     //���ʽ
	String iCash_Pay	   = "0";     //֧�����
	String iCheck_No	   = "0";     //֧Ʊ����
	String iBank_Code	   = "0";     //���д���
	String iCheck_Pay	   = "0";     //֧Ʊ����
	String iShouldHandFee  = "0";   //Ӧ��������
  String iHandFee        = "0";     //ʵ��������
	String feeList="";//������Ϣ
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCash_Pay+"~"+iShouldHandFee+"~"+iHandFee+"~";

    String iRegion_Code = iOrgCode.substring(0,2);
    try
    {		
			String paramsIn[] = new String[11];

            paramsIn[0] = iLoginAccept ;
            paramsIn[1] = "3548"      ;
            paramsIn[2] = iWorkNo      ;
            paramsIn[3] = iLogin_Pass  ;
            paramsIn[4] = iOrgCode     ;
            paramsIn[5] = iSys_Note    ;
            paramsIn[6] = iOp_Note     ;
            paramsIn[7] = iIpAddr      ;
            paramsIn[8] = iGrp_Id      ;
            paramsIn[9] = idcMebNo     ;
            paramsIn[10] = feeList      ;

			//�����������
            //String [] paramsIn = new String[] { iLoginAccept, iOpCode, iWorkNo, iLogin_Pass, iOrgCode, iSys_Note, iOp_Note, iIpAddr, iGrp_Id,cust_code,user_type,bill_type,bill_time,"ip28I000",add_mode,feeList,name_list,value_list.toString()};
			//retStr = callView.callService("s3548del", paramsIn, "2", "region", iRegion_Code);
%>

    <wtc:service name="s3548del" outnum="5" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />	
			<wtc:param value="<%=paramsIn[2]%>" />	
			<wtc:param value="<%=paramsIn[3]%>" />	
			<wtc:param value="<%=paramsIn[4]%>" />	
			<wtc:param value="<%=paramsIn[5]%>" />	
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />		
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />			
		</wtc:service>
		<wtc:array id="result_t1" scope="end" />

<%
            error_code = code1;
            error_msg= msg1;
            
            System.out.println("error_code="+error_code+";error_msg="+error_msg);
    }catch(Exception e){
		e.printStackTrace();
        logger.error("Call s3548del is Failed!");
    }
%>

	<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+
								 "&retCodeForCntt="+error_code+
								 "&retMsgForCntt="+error_msg+
	               "&opName="+opName+
     	    			 "&workNo="+iWorkNo+
     	    			 "&loginAccept="+iLoginAccept+
     	    			 "&pageActivePhone="+unit_id+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+unit_id+
     	    			 "&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />


<%
    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_msg%>",2);
            location = "f3548_1.jsp";
        </script>
<%  } else {
%>
        <script language='jscript'>
                     
            var path="<%=request.getContextPath()%>/npage/s3548/f3548_2_printxls.jsp?phoneNo=" + "<%=idcMebNo%>";
            
	   		if (rdShowConfirmDialog("<br>�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>"+"<br>�Ƿ񱣴������Ϣ��",0)==1)	
			{
				path = path + "&returnMsg=" + "<%=error_msg%>"+ "&unitID=" + "<%=unit_id%>";
	  			path = path + "&op_Code="+"8888";
	  			path = path + "&orgCode=" + "<%=iOrgCode%>";
				window.open(path);
			}	
            history.go(-1);
        </script>
<%
    }
    System.out.println("--------------------------f3548_delete.jsp-----------------OK-----------------");
%>

