<% 
  /*
   * ����: ���˲�������
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
   *update:liutong@20080917
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="../../include/remark.htm" %>


<%
   // ArrayList retArray = null;
   // int error_code = 0;
   // String error_msg = "";
   // Logger logger = Logger.getLogger("f6710_2.jsp");
   // SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//  ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo  = (String[][])arr.get(0);
	//  String[][] agentInfo = (String[][])arr.get(2);
   // String workNo   = baseInfo[0][2];
	 // String workName = baseInfo[0][3];
	 
	 String workno =(String)session.getAttribute("workNo");
    String workname =(String)session.getAttribute("workName");
    String opName ="���˲���ҵ������";
	  
	  String mebProdCode         = request.getParameter("mebProdCode");					//��Ʒ����       			 


  //  String[] retStr = null;
    
    String matureProdCode     = request.getParameter("matureProdCode")==null?"N":request.getParameter("matureProdCode"); 

    String sInLoginNo         = request.getParameter("loginNo");					//��������        			 
    String sInLoginPasswd     = request.getParameter("loginPwd");         //��������             
    String sInOpCode          = request.getParameter("opCode");           //���ܴ���          
    String sInOpNote          = request.getParameter("opNote");           //�û���ע         
    String sInOrgCode         = request.getParameter("orgCode");          //�������Ź���       
    String sInSystemNote      = request.getParameter("sysNote");          //ϵͳ��ע           
    String sInIpAddr          = request.getParameter("ip_Addr");          //����IP��ַ          
    String sInLoginAccept     = request.getParameter("loginAccept");      //��ˮ                  
    String sInPhoneNo         = request.getParameter("phone_no");         //�û��ֻ���         
    String sInAddMode         = request.getParameter("mebProdCode").split("-->")[0];			//��ѡ�ײ�   
    System.out.println("sInAddModesInAddModesInAddMode=="+sInAddMode);     				  
    String sInEndChgFlag      = request.getParameter("matureFlag")==null?"N":request.getParameter("matureFlag");  //����ת���±�־  
    String sInNextMode        = "";
    String sInShowFlag        = request.getParameter("has_show_flag");
    if(!matureProdCode.equals("N")){
      sInNextMode        = matureProdCode.split("-->")[0];	      //���ں�ת���²�Ʒ 
      System.out.println("sInNextModesInNextModesInNextModesInNextMode="+sInNextMode);
    }     
    String sInCreateType      = "9";	  //ҵ����������:00:BOSS    
    String regionCode         = sInOrgCode.substring(0,2);
		  
	//ArrayList paramsIn = new ArrayList();
	
   /**
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
    paramsIn.add(new String[]{sInShowFlag       });
    **/
    
    //	retStr = callView.callService("s6710Cfm", paramsIn, "3", "region", regionCode);
	//callView.printRetValue();
   //  error_code = callView.getErrCode();
   //  error_msg  = callView.getErrMsg();
  
%>
			<wtc:service name="s6710Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="err_code" retmsg="err_message"  outnum="4" >
						<wtc:params value="<%=new String[]{sInLoginNo        }%>"/>
						<wtc:params value="<%=new String[]{sInLoginPasswd    }%>"/>
						<wtc:params value="<%=new String[]{sInOpCode         }%>"/>
						<wtc:params value="<%=new String[]{sInOpNote         }%>"/>
						<wtc:params value="<%=new String[]{sInOrgCode        }%>"/>
						<wtc:params value="<%=new String[]{sInSystemNote     }%>"/>
						<wtc:params value="<%=new String[]{sInIpAddr         }%>"/>
						<wtc:params value="<%=new String[]{sInLoginAccept    }%>"/>
						<wtc:params value="<%=new String[]{sInPhoneNo        }%>"/>
						<wtc:params value="<%=new String[]{sInAddMode        }%>"/>
						<wtc:params value="<%=new String[]{sInEndChgFlag     }%>"/>
						<wtc:params value="<%=new String[]{sInNextMode       }%>"/>
						<wtc:params value="<%=new String[]{sInCreateType     }%>"/>
						<wtc:params value="<%=new String[]{sInShowFlag       }%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />
<%

	
System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
		String retCodeForCntt = err_code ;
		String loginAccept =""; 
		
		if(err_code.equals("0")||err_code.equals("000000")){
			if(result.length>0){
				loginAccept=result[0][0];
			}
		}
		
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+sInOpCode+"&retCodeForCntt="+err_code+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone="+sInPhoneNo+"&retMsgForCntt="+err_message+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		

		%>
		<jsp:include page="<%=url%>" flush="true" />
		<%
System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%"); 	
  
         if(err_code.equals("0")||err_code.equals("000000")){
              System.out.println("���÷���s6710Cfm in f6710_2.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
              String onloadflag = "0";
 	        	%>
					<script language="JavaScript">
						rdShowMessageDialog("���˲���[<%=mebProdCode%>]�����ɹ�");
						 location = "f6710_1.jsp?phone_no=<%=sInPhoneNo%>";
					</script>
				<%
 	        	
 	     	}else{
 	     		String onloadflag = "0";
 	         	System.out.println(err_code+"    err_code");
 	     	 	System.out.println(err_message+"    err_message");
 			   System.out.println("���÷���s6710Cfm in f6710_2.jsp  ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			   %>
					<script language="JavaScript">
						rdShowMessageDialog("<%=err_message%>");
						location = "f6710_1.jsp?action=select&flag=<%=onloadflag%>&phone_no=<%=sInPhoneNo%>";
					</script>
			   <%
 			   
 			}

%>
