<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    ArrayList retArray = null;
    String error_code = "";
    String error_msg = "";
    Logger logger = Logger.getLogger("f3505_delete.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String[] retStr = null;
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
	
	String opCode = (String)request.getParameter("iOpCode");
	String opName = (String)request.getParameter("op_name");
	System.out.println("opNameopNameopNameopNameopName="+opName);
	//luxc add 20080622
	String opType = request.getParameter("opType");
	String new_mode = request.getParameter("addProduct");
	String op_code="";
	if("2".equals(opType))
	{
		op_code="3541";
	}
	else if("1".equals(opType))
	{
		op_code="3506";
	}
	else
	{
		%>
        <script language='jscript'>
            rdShowMessageDialog("���������������!",0);
            history.go(-1);
        </script>
		<%
		return;
	}
	
		
	
	

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
			ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });//0
            paramsIn.add(new String[]{op_code         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });//5
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{idcMebNo        });
            paramsIn.add(new String[]{feeList         });//10
            paramsIn.add(new String[]{new_mode        });

			//�����������
            //String [] paramsIn = new String[] { iLoginAccept, iOpCode, iWorkNo, iLogin_Pass, iOrgCode, iSys_Note, iOp_Note, iIpAddr, iGrp_Id,cust_code,user_type,bill_type,bill_time,"ip28I000",add_mode,feeList,name_list,value_list.toString()};
			//retStr = callView.callService("s3506Cfm", paramsIn, "1", "region", iRegion_Code);
			%>
            <wtc:service name="s3506Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="s3506CfmCode" retmsg="s3506CfmMsg" outnum="4" >
            	<wtc:param value="<%=iLoginAccept%>"/>
                <wtc:param value="<%=op_code%>"/> 
                <wtc:param value="<%=iWorkNo%>"/>
                <wtc:param value="<%=iLogin_Pass%>"/>
                <wtc:param value="<%=iOrgCode%>"/>
                
                <wtc:param value="<%=iSys_Note%>"/>
                <wtc:param value="<%=iOp_Note%>"/>
                <wtc:param value="<%=iIpAddr%>"/>
                <wtc:param value="<%=iGrp_Id%>"/>
                <wtc:param value="<%=idcMebNo%>"/>
                
                <wtc:param value="<%=feeList%>"/>
                <wtc:param value="<%=new_mode%>"/>
            </wtc:service>
            <wtc:array id="s3506CfmArr" scope="end"/>
            <%
			//callView.printRetValue();
            error_code = s3506CfmCode;
            error_msg= s3506CfmMsg;
            
            System.out.println("error_code="+error_code+";error_msg="+error_msg);
            //----------------------------
                System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
                String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
                 System.out.println("%%%%%%%%url%%%%%%%%");
            %>
                <jsp:include page="<%=url%>" flush="true" />
            <%
                System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
            //----------------------------
    }catch(Exception e){
		e.printStackTrace();
        logger.error("Call s3506Cfm is Failed!");
    }

    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_msg%>",2);
            location = "f3505_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        </script>
<%  } else {
%>
        <script language='jscript'>
                     
            var path="<%=request.getContextPath()%>/npage/s3500/f3505_2_printxls.jsp?phoneNo=" + "<%=idcMebNo%>";
            
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
%>
