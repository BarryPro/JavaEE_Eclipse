<% 
  /*
   * 功能: 彩铃秀申请确认
　 * 版本: v1.00
　 * 日期: 2008/03/24
　 * 作者: sunzx
　 * 版权: sitech
   * 修改历史
   * 修改日期 2008-1-3    修改人 leimd     修改目的
   *  
  */
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="../../include/remark.htm" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
   	String opCode ="7961";
    String opName = "彩铃秀申请";
    Logger logger = Logger.getLogger("f7961_2.jsp");
//    SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String mebProdCode = request.getParameter("mebProdCode");				//产品名称       			 
	String phoneNo = request.getParameter("phone_no");
//    String[] retStr = null;

    String matureProdCode = request.getParameter("matureProdCode")==null?"N":request.getParameter("matureProdCode"); 

    String sInLoginNo = (String)session.getAttribute("workNo");				 //操作工号        			 
    String sInLoginPasswd = (String)session.getAttribute("password");        //工号密码             
    String sInOpCode = request.getParameter("opCode");           			 //功能代码          
    String sInOpNote = request.getParameter("opNote");           			 //用户备注         
    String sInOrgCode = (String)session.getAttribute("orgCode");             //操作工号归属       
    String sInSystemNote = request.getParameter("sysNote");                  //系统备注           
    String sInIpAddr = (String)session.getAttribute("ipAddr");               //操作IP地址          
    String sInLoginAccept = request.getParameter("loginAccept");             //流水                  
    String sInPhoneNo = request.getParameter("phone_no");                    //用户手机号         
    String sInAddMode = request.getParameter("mebProdCode");			     //可选套餐        				  
    String sInEndChgFlag = request.getParameter("matureFlag")==null?"N":request.getParameter("matureFlag");  //到期转包月标志  
    String sInNextMode  = "";           
    if(!matureProdCode.equals("N")){
      sInNextMode        = matureProdCode.substring(0,8);	                 //到期后转包月产品 
    }
    String sInCreateType      = "9";	  									 //业务受理渠道:09:BOSS
    String regionCode         = sInOrgCode.substring(0,2);
		  
	ArrayList paramsIn = new ArrayList();
	
    paramsIn.add(new String[]{sInLoginNo        });
    paramsIn.add(new String[]{sInLoginPasswd    });
    paramsIn.add(new String[]{sInOpCode         });
    paramsIn.add(new String[]{sInOpNote         });
    paramsIn.add(new String[]{sInOrgCode        });
    paramsIn.add(new String[]{sInSystemNote     });
    paramsIn.add(new String[]{sInIpAddr         });
    paramsIn.add(new String[]{sInLoginAccept    });
    paramsIn.add(new String[]{sInPhoneNo        });
    paramsIn.add(new String[]{sInAddMode        });
    paramsIn.add(new String[]{sInEndChgFlag     }); 
    paramsIn.add(new String[]{sInNextMode       });
    paramsIn.add(new String[]{sInCreateType     });

//	retStr = callView.callService("s7961Cfm", paramsIn, "3", "region", regionCode);
//	callView.printRetValue();
%>
	<wtc:service name="s7961Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=sInLoginNo%>"/>
		<wtc:param value="<%=sInLoginPasswd%>"/>
		<wtc:param value="<%=sInOpCode%>"/>
		<wtc:param value="<%=sInOpNote%>"/>
		<wtc:param value="<%=sInOrgCode%>"/>
		<wtc:param value="<%=sInSystemNote%>"/>
		<wtc:param value="<%=sInIpAddr%>"/>
		<wtc:param value="<%=sInLoginAccept%>"/>
		<wtc:param value="<%=sInPhoneNo%>"/>
		<wtc:param value="<%=sInAddMode%>"/>
		<wtc:param value="<%=sInEndChgFlag%>"/>
		<wtc:param value="<%=sInNextMode%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    System.out.println("1111111111111111111111="+result.length);
    String error_code = retCode;
    String error_msg  = retMsg ;
    String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+result[0][0]+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
    
	if(!(error_code.equals("000000")||error_code.equals("0"))){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=error_msg%>",0);
			location = "f7961_1.jsp?activePhone=<%=phoneNo%>";
		</script>
<%	}
	else
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("彩铃秀业务申请成功",2);
			location = "f7961_1.jsp?activePhone=<%=phoneNo%>";
		</script>
<%
	}
%>
<jsp:include page="<%=url%>" flush="true" />