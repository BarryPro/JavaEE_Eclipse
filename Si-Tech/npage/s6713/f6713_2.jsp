<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * 功能: 个人彩铃申请冲正
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * 修改日期 200-01-08     修改人 leimd     修改目的
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode="6713";
	String opName="个人彩铃申请/变更冲正";
	String phoneNo = (String)request.getParameter("phone_no");
//    SPubCallSvrImpl callView = new SPubCallSvrImpl();
    
    //System.out.println("matureProdCode="+request.getParameter("CRProdCode2")+"=matureProdCode");
    String matureProdCode     = request.getParameter("CRProdCode2"); 
    //System.out.println("matureProdCode="+matureProdCode);
    
//    String[] retStr = null;
    String sInLoginNo         = request.getParameter("loginNo");					//操作工号        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //工号密码             
    String sInOpCode          = request.getParameter("opCode");           //功能代码          
    String sInOpNote          = request.getParameter("opNote");           //用户备注         
    String sInOrgCode         = request.getParameter("orgCode");          //操作工号归属       
    String sInSystemNote      = request.getParameter("sysNote");          //系统备注           
    String sInIpAddr          = request.getParameter("ip_Addr");          //操作IP地址              
    String sInLoginAccept     = request.getParameter("loginAccept");       //流水
    String sInOldLoginAccept  = request.getParameter("loginAcceptOld");    //原操作流水    
    String sInCreateType      = "9";	                                    //业务受理渠道:00:BOSS
    String sInShowFlag        = "001";    //冲正类型:001:只取消彩铃秀
    
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
    paramsIn.add(new String[]{sInOldLoginAccept });
    paramsIn.add(new String[]{sInCreateType     });
    paramsIn.add(new String[]{sInShowFlag       });

//			retStr = callView.callService("s6713Cfm", paramsIn, "3", "region", regionCode);
//			callView.printRetValue();
%>
	<wtc:service name="s6713Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=sInLoginNo%>"/>
		<wtc:param value="<%=sInLoginPasswd%>"/>
		<wtc:param value="<%=sInOpCode%>"/>
		<wtc:param value="<%=sInOpNote%>"/>
		<wtc:param value="<%=sInOrgCode%>"/>
		<wtc:param value="<%=sInSystemNote%>"/>
		<wtc:param value="<%=sInIpAddr%>"/>
		<wtc:param value="<%=sInLoginAccept%>"/>
		<wtc:param value="<%=sInOldLoginAccept%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
		<wtc:param value="<%=sInCreateType%>"/>
		<wtc:param value="<%=sInShowFlag%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String error_code = retCode;
    String  error_msg  = retMsg;
			if(!error_code.equals("000000")){
			%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=error_msg%>",0);
				history.go(-1);
			</script>
			<%}else{%>
			  <script language="JavaScript">
				rdShowMessageDialog('个人彩铃<%if(matureProdCode.equals("")){%>申请<%}else{%>变更<%}%>冲正成功',2);
				location = "f6713_1.jsp?activePhone=<%=phoneNo%>";
			</script>
			<%}	

	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
