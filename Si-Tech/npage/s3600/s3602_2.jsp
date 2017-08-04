<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
 模块: BOSS侧VPMN集团变更
********************/
%>

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    ArrayList retArray = null;
    String error_code = "";
    String error_msg = "";
    
    String url = "";
    String work_no = (String)session.getAttribute("workNo");

	String unitId    = request.getParameter("unitId");
    String loginAccept    = request.getParameter("loginAccept");
    String opName         = request.getParameter("opName");
    String opCode         = request.getParameter("opCode");
    String loginNo         = request.getParameter("loginNo");
    String loginPwd     = request.getParameter("loginPwd");
    String orgCode        = request.getParameter("orgCode");
    String sysNote       = request.getParameter("sysNote");
    String opNote        = request.getParameter("opNote");
    String ipAddress         = request.getParameter("ipAddress");
    String phoneNo         = request.getParameter("phoneNo");
    String grpIdNo         = request.getParameter("grpIdNo");
    String grpOutNo         = request.getParameter("grpOutNo");
	String oldMainRate       = request.getParameter("oldMainRate").substring(0,8);
	String newRate       = request.getParameter("newRate");
	String[] optionalRates       = request.getParameterValues("optionalRate");

    String regionCode = orgCode.substring(0,2);
    try
    {		
		ArrayList paramsIn = new ArrayList();

        paramsIn.add(new String[]{loginAccept    });
        paramsIn.add(new String[]{opCode         });
        paramsIn.add(new String[]{loginNo         });
        paramsIn.add(new String[]{loginPwd     });
        paramsIn.add(new String[]{orgCode        });
        paramsIn.add(new String[]{sysNote       });
        paramsIn.add(new String[]{opNote        });
        paramsIn.add(new String[]{ipAddress         });
        paramsIn.add(new String[]{grpIdNo         });
        paramsIn.add(new String[]{grpOutNo         });
        paramsIn.add(new String[]{oldMainRate    });
        paramsIn.add(new String[]{newRate    });
        if (optionalRates != null)
        {
            paramsIn.add(optionalRates);
        }
    	else
    	{
        	paramsIn.add(new String[]{" "});
    	}

		//传入参数数组
		//retStr = callView.callService("s3602Cfm", paramsIn, "1", "region", regionCode);
%>
		<wtc:service name="s3602Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=loginAccept%>"/>	
		<wtc:param value="<%=opCode%>"/>	
		<wtc:param value="<%=loginNo%>"/>	
		<wtc:param value="<%=loginPwd%>"/>	
		<wtc:param value="<%=orgCode%>"/>	
		<wtc:param value="<%=sysNote%>"/>	
		<wtc:param value="<%=opNote%>"/>	
		<wtc:param value="<%=ipAddress%>"/>	
		<wtc:param value="<%=grpIdNo%>"/>	
		<wtc:param value="<%=grpOutNo%>"/>	
		<wtc:param value="<%=oldMainRate%>"/>	
		<wtc:param value="<%=newRate%>"/>	
		<wtc:params value="<%=optionalRates%>"/>	
		</wtc:service>	
		<wtc:array id="result1"  scope="end"/>
<%
        error_code = retCode1;
        error_msg= retMsg1;
        url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";
    }
    catch(Exception e)
    {
		System.out.println(e.toString());
    }
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
<%
		if (opCode.equals("3602"))
		{
%>
            rdShowMessageDialog("集团用户套餐变更成功！",2);
<%
		}
		else if (opCode.equals("3604"))
		{
%>
            rdShowMessageDialog("成员用户销户操作成功！",2);
<%
		}
		else if (opCode.equals("3605"))
		{
%>
            rdShowMessageDialog("成员用户套餐变更操作成功！",2);
<%
		}
%>
            window.location="s3602_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        </script>
<%
	}
	else
	{
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%
    }
%>
