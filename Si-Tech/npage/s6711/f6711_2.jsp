<% 
  /*
   * ����: ���˲���ȡ��
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
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

    String sInLoginNo         = request.getParameter("loginNo");          //��������        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //��������             
    String sInOpCode          = request.getParameter("opCode");                                   //���ܴ���  
    if(sInOpCode.equals("6711")){
    	opName= "���忨����ȡ��";
    }else if(sInOpCode.equals("6715")){
    	opName= "���忨����/������/����ȡ��";
    }else if(sInOpCode.equals("6719")){
    	opName= "���忨ȡ��";
    }
    String sInOpNote          = request.getParameter("opNote");           //�û���ע         
    String sInOrgCode         = request.getParameter("orgCode");          //�������Ź���       
    String sInSystemNote      = request.getParameter("sysNote");          //ϵͳ��ע           
    String sInIpAddr          = request.getParameter("ip_Addr");          //����IP��ַ          
    String sInLoginAccept     = request.getParameter("loginAccept");;     //��ˮ                  
    String sInPhoneNo         = request.getParameter("phone_no");         //�û��ֻ���   
    String sInCreateType      = "9";	                                  //ҵ����������:00:BOSS 
    String sInShowFlag        = "";                                       //ȡ�����壬ͬʱȡ�������㣺""��ȡ�������㣺000
    
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
System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
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
System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%"); 	
    	
    	
    	
    	
    
			if(error_code.equals("0")||error_code.equals("000000")){
			%>
			 <script language="JavaScript">
				rdShowMessageDialog("���˲��������ɹ�");
				location = "f6711_1.jsp?phone_no=<%=sInPhoneNo%>";
			</script>
			
			<%}else{%>
			 <script language="JavaScript">
				rdShowMessageDialog("<%=error_code%>"+"<%=error_msg%>");
				location = "f6711_1.jsp?phone_no=<%=sInPhoneNo%>";
			</script>
	  <%	}	%>
