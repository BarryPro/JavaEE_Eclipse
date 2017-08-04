<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String error_code ="";
    String error_msg = "";
    

    String loginAccept	= request.getParameter("loginAccept");
    
    String opCode     	= request.getParameter("opCode");
    String opName       = request.getParameter("opName");
    System.out.println("opCode==================="+opCode);
    System.out.println("opName==================="+opName);
    
    String loginNo      = request.getParameter("loginNo");
    String loginPwd     = request.getParameter("loginPwd");
    String orgCode      = request.getParameter("orgCode");
    String sysNote      = request.getParameter("sysNote");
    String opNote       = request.getParameter("opNote");
    String ipAddress    = request.getParameter("ipAddress");
    String phoneNo      = request.getParameter("phoneNo");
    String grpIdNo      = request.getParameter("grpIdNo");
    String grpOutNo     = request.getParameter("grpOutNo");
	String mainRate     = request.getParameter("mainRate");
	String newRate      = request.getParameter("newRate");
    String unitId	 	= request.getParameter("unitId");
    String pay_flag	 	= request.getParameter("pay_flag");

    String regionCode = orgCode.substring(0,2);
  	ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{loginAccept  });
            paramsIn.add(new String[]{opCode       });
            paramsIn.add(new String[]{loginNo      });
            paramsIn.add(new String[]{loginPwd     });
            paramsIn.add(new String[]{orgCode      });
            paramsIn.add(new String[]{sysNote      });
            paramsIn.add(new String[]{opNote       });
            paramsIn.add(new String[]{ipAddress    });
            paramsIn.add(new String[]{phoneNo      });
            paramsIn.add(new String[]{grpIdNo      });
            paramsIn.add(new String[]{grpOutNo     });//10
            paramsIn.add(new String[]{mainRate     });
            paramsIn.add(new String[]{newRate      });
            paramsIn.add(new String[]{pay_flag     });

			//传入参数数组
//			retStr = callView.callService("s2903Cfm", paramsIn, "1", "region", regionCode);
//			callView.printRetValue();
%>
	<wtc:service name="s2903Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=sysNote%>"/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=ipAddress%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=grpIdNo%>"/>
		<wtc:param value="<%=grpOutNo%>"/>
		<wtc:param value="<%=mainRate%>"/>
		<wtc:param value="<%=newRate%>"/>
		<wtc:param value="<%=pay_flag%>"/>
	</wtc:service>
	<wtc:array id="retStr" scope="end"/>
<%
	 String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opNote+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo
		+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
            error_code = retCode;
            error_msg= retMsg;

    if(error_code.equals("000000"))
    {
		%>
        <script language='jscript'>
		<%
		if (opCode.equals("2905"))
		{
		%>
            rdShowMessageDialog("IPT成员用户开户操作成功！",2);
		<%
		}
		else if (opCode.equals("2907"))
		{
			%>
            rdShowMessageDialog("IPT成员用户销户操作成功！",2);
			<%
		}
		else if (opCode.equals("2909"))
		{
			%>
            rdShowMessageDialog("IPT成员用户套餐变更操作成功！",2);
			<%
		}
		%>
       	  history.go(-1);
        </script>
		<%
	}
	else
	{
		%>
        <script language='jscript'>
            var path="<%=request.getContextPath()%>/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + "<%=phoneNo%>";
	   		if (rdShowConfirmDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]"+"<br>是否保存错误信息？")==1)	
			{
				path = path + "&returnMsg=" + "<%=error_code%>" + "[" + "<%=error_msg%>" + "]"+ "&unitID=" + "<%=unitId%>";
	  			path = path + "&loginAccept=" + "<%=loginAccept%>"  ;
	  			path = path + "&op_Code=" + "<%=opCode%>";
	  			path = path + "&orgCode=" + "<%=orgCode%>";
          		window.open(path);
			}	
            history.go(-1);
        </script>
		<%
    }
       
%>
	