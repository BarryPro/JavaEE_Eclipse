<% 
  /*
   * 功能: 个人彩铃申请
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * 修改日期 2008-01-10     修改人leimd      修改目的
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
//    SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String regionCode = (String)session.getAttribute("regCode");			//城市代码
//    String[] retStr = null;
    
    String sInLoginNo         = request.getParameter("loginNo");			//操作工号        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");        	 //工号密码             
    String sInOpCode          = request.getParameter("opCode");          	 //功能代码          
    String sInOpNote          = request.getParameter("opNote");           	//用户备注         
    String sInOrgCode         = request.getParameter("orgCode");          	//操作工号归属       
    String sInSystemNote      = request.getParameter("sysNote");          	//系统备注           
    String sInIpAddr          = request.getParameter("ip_Addr");          	//操作IP地址          
    String sInLoginAccept     = request.getParameter("loginAccept");    	//流水                  
    String sInPhoneNo         = request.getParameter("phoneNo");         	//用户手机号         
    String sInAddMode         = request.getParameter("mebProdCode");		//可选套餐        				  
    String sInEndChgFlag      = request.getParameter("matureFlag")==null?"N":request.getParameter("matureFlag");  //到期转包月标志  
    String sInNextMode        = request.getParameter("matureProdCode")==null?"":request.getParameter("matureProdCode");	      //到期后转包月产品 
    System.out.println("sInPhoneNosInPhoneNosInPhoneNosInPhoneNo"+sInPhoneNo);
    String sInCreateType      = "9";	                                    //业务受理渠道:00:BOSS
    
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
    paramsIn.add(new String[]{sInCreateType       });
    
//		retStr = callView.callService("s6710Cfm", paramsIn, "3", "region", regionCode);
//		callView.printRetValue();
%>
	<wtc:service name="s6710Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
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
   String error_code = retCode;
   String error_msg  = retMsg;
   String url = "/npage/contact/upCnttInfo.jsp?opCode="+sInOpCode+"&retCodeForCntt="+retCode+"&opName="+"个人彩铃产品变更"+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
		if(!error_code.equals("000000")){
		%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=error_msg%>",0);
			history.go(-1);
		</script>
		<%}else{%>
		  <script language="JavaScript">
			rdShowMessageDialog("个人彩铃产品变更成功",2);
			location = "f6712_1.jsp?activePhone=<%=sInPhoneNo%>";
		</script>
		<%	}	%>
		
<jsp:include page="<%=url%>" flush="true" />