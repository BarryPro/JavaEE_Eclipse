<% 
  /*
   * 功能: 个人彩铃取消
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
   *
   *update:liutong@20080917
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
   /**
    ArrayList retArray = null;
    int error_code = 0;
    String error_msg = "";
    Logger logger = Logger.getLogger("f6711_2.jsp");
    SPubCallSvrImpl callView = new SPubCallSvrImpl();
	  ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
	  String[][] agentInfo = (String[][])arr.get(2);
    String workNo = baseInfo[0][2];
	  String workName = baseInfo[0][3];
	  **/
	String workNo =(String)session.getAttribute("workNo");
	String workName =(String)session.getAttribute("workName");
	String opName= "";

    String sInLoginNo         = request.getParameter("loginNo");          //操作工号        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //工号密码             
    String sInOpCode          = request.getParameter("opCode");                                   //功能代码  
    if(sInOpCode.equals("6711")){
    	opName= "彩铃卡包月取消";
    }else if(sInOpCode.equals("6715")){
    	opName= "彩铃卡包年/包半年/包季取消";
    }else if(sInOpCode.equals("6719")){
    	opName= "彩铃卡取消";
    }
    String sInOpNote          = request.getParameter("opNote");           //用户备注         
    String sInOrgCode         = request.getParameter("orgCode");          //操作工号归属       
    String sInSystemNote      = request.getParameter("sysNote");          //系统备注           
    String sInIpAddr          = request.getParameter("ip_Addr");          //操作IP地址          
    String sInLoginAccept     = request.getParameter("loginAccept");;     //流水                  
    String sInPhoneNo         = request.getParameter("phone_no");         //用户手机号   
    String sInCreateType      = "9";	                                  //业务受理渠道:00:BOSS 
    String sInShowFlag        = "";                                       //取消彩铃，同时取消彩铃秀：""；取消彩铃秀：000
    
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
    paramsIn.add(new String[]{sInCreateType     });
    paramsIn.add(new String[]{sInShowFlag       });

 %>
          <wtc:service name="s6711Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="error_code" retmsg="error_msg"  outnum="3" >
			<wtc:params value="<%=new String[]{sInLoginNo        }%>"/>
			<wtc:params value="<%=new String[]{sInLoginPasswd        }%>"/>
			<wtc:params value="<%=new String[]{sInOpCode        }%>"/>
			<wtc:params value="<%=new String[]{sInOpNote        }%>"/>
			<wtc:params value="<%=new String[]{sInOrgCode        }%>"/>
			<wtc:params value="<%=new String[]{sInSystemNote        }%>"/>
			<wtc:params value="<%=new String[]{sInIpAddr        }%>"/>
			<wtc:params value="<%=new String[]{sInLoginAccept        }%>"/>
			<wtc:params value="<%=new String[]{sInPhoneNo        }%>"/>
			<wtc:params value="<%=new String[]{sInCreateType        }%>"/>
			<wtc:params value="<%=new String[]{sInShowFlag        }%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
 <%   
System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = error_code ;
		String loginAccept =""; 
		
		if(error_code.equals("0")||error_code.equals("000000")){
			if(result.length>0){
				loginAccept=result[0][0];
			}
		}
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+sInOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+error_msg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		

		%>
		<jsp:include page="<%=url%>" flush="true" />
		<%
System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	
    	
    	
    	
    	
    
			if(error_code.equals("0")||error_code.equals("000000")){
			%>
			 <script language="JavaScript">
				rdShowMessageDialog("个人彩铃销户成功");
				location = "f6711_1.jsp?phone_no=<%=sInPhoneNo%>";
			</script>
			
			<%}else{%>
			 <script language="JavaScript">
				rdShowMessageDialog("<%=error_code%>"+"<%=error_msg%>");
				location = "f6711_1.jsp?phone_no=<%=sInPhoneNo%>";
			</script>
	  <%	}	%>
