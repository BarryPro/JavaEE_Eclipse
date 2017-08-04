<% 
  /*
   * 功能: 彩铃卡申请
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * update by qidp @ 2008-12-17
   *  
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>

<%
    //ArrayList retArray = null;
    Logger logger = Logger.getLogger("f6710_2.jsp");
    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo  = (String[][])arr.get(0);
    //String[][] agentInfo = (String[][])arr.get(2);
    //String workNo   = baseInfo[0][2];
    //String workName = baseInfo[0][3];
    
    //String[] retStr = null;
    
    String sInLoginNo         = request.getParameter("loginNo");					//操作工号        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //工号密码             
    String sInOpCode          = request.getParameter("opCode");           //功能代码          
    String sInOpNote          = request.getParameter("opNote");           //用户备注         
    String sInOrgCode         = request.getParameter("orgCode");          //操作工号归属       
    String sInSystemNote      = request.getParameter("sysNote");          //系统备注           
    String sInIpAddr          = request.getParameter("ip_Addr");          //操作IP地址          
    String sInLoginAccept     = request.getParameter("loginAccept");      //流水                  
    String sInPhoneNo         = request.getParameter("phone_no");         //用户手机号         
    String sInCardNo          = request.getParameter("colorRing_no");			//卡号码        				  
    String sInEndChgFlag      = request.getParameter("matureFlag");       //到期转包月标志  
    String sInNextMode        = request.getParameter("matureProdCode");	  //到期后转包月产品
    String sInCreateType      = "9";	                                    // 业务受理渠道:01:BOSS             
                                                                                        //02:WEB接入          
    String regionCode         = sInOrgCode.substring(0,2);                              //03:12530接入                                     
	//	                                                                                    //04:IVR接入          
	//  ArrayList paramsIn = new ArrayList();                                               //05:彩铃平台网关接入 
	//                                                                                      //06:彩铃平台WAP接入  
    //paramsIn.add(new String[]{sInLoginNo        });
    //paramsIn.add(new String[]{sInLoginPasswd    });
    //paramsIn.add(new String[]{sInOpCode         });
    //paramsIn.add(new String[]{sInOpNote         });
    //paramsIn.add(new String[]{sInOrgCode        });
    //paramsIn.add(new String[]{sInSystemNote     });
    //paramsIn.add(new String[]{sInIpAddr         });
    //paramsIn.add(new String[]{sInLoginAccept    });
    //paramsIn.add(new String[]{sInPhoneNo        });
    //paramsIn.add(new String[]{sInCardNo         });
    //paramsIn.add(new String[]{sInEndChgFlag     }); 
    //paramsIn.add(new String[]{sInNextMode       });
    //paramsIn.add(new String[]{sInCreateType       });
    
		//retStr = callView.callService("s6718Cfm", paramsIn, "3", "region", regionCode);
		//callView.printRetValue();
%>
<wtc:service name="s6718Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s6718CfmCode" retmsg="s6718CfmMsg" outnum="4">
    <wtc:param value="<%=sInLoginNo%>"/>
    <wtc:param value="<%=sInLoginPasswd%>"/>
    <wtc:param value="<%=sInOpCode%>"/>
    <wtc:param value="<%=sInOpNote%>"/>
    <wtc:param value="<%=sInOrgCode%>"/>
    <wtc:param value="<%=sInSystemNote%>"/>
    <wtc:param value="<%=sInIpAddr%>"/>
    <wtc:param value="<%=sInLoginAccept%>"/>
    <wtc:param value="<%=sInPhoneNo%>"/>
    <wtc:param value="<%=sInCardNo%>"/>
    <wtc:param value="<%=sInEndChgFlag%>"/>
    <wtc:param value="<%=sInNextMode%>"/>
    <wtc:param value="<%=sInCreateType%>"/>
</wtc:service>
<wtc:array id="s6718CfmArr" scope="end"/>
<%
System.out.println("loginAccept=>s6718CfmArr[0][0]="+s6718CfmArr[0][0]);
    String error_code = s6718CfmCode;
    String error_msg  = s6718CfmMsg;
    
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"6718"+"&retCodeForCntt="+error_code+"&opName="+"彩铃卡业务申请"+"&workNo="+sInLoginNo+"&loginAccept="+s6718CfmArr[0][0]+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+error_msg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	if(!(error_code.equals("000000"))){
	%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=error_msg%>",0);
		history.go(-1);
	</script>
	<%}else{%>
	  <script language="JavaScript">
		rdShowMessageDialog("彩铃卡业务申请成功",2);
		location = "f6718_1.jsp?activePhone=<%=sInPhoneNo%>";
	</script>
	<%	}	%>
