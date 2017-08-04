<%
/********************
 version v2.0
������: si-tech
ģ��:�˻�����
 update zhaohaitao at 2008.12.23
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	String iRegion_Code = (String)session.getAttribute("regCode");
	
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String printAccept = (String)request.getParameter("printAccept");
    //�õ��������
    Logger logger = Logger.getLogger("f1102_2.jsp");
    String return_code,return_message,total_date,login_accept,delay_time;

	String[] retStr = null;
	String error_code="";
    String error_msg="";
 	String account_id  = request.getParameter("accountId");  	//�ʻ�ID  
	String cust_id  = request.getParameter("custId");		    //�ͻ�ID  
	String account_pwd  = WtcUtil.repStr(request.getParameter("newPwd")," ");//�ʻ�����
	account_pwd = Encrypt.encrypt(account_pwd);  //�����û�����
	String account_name  = request.getParameter("accountName");	//�ʻ�����
	String region_id  = request.getParameter("belongCode");		//��������
	//String account_limit  = request.getParameter("accountLimit");	//�ʻ�������
	String account_limit  = "A";	//�ʻ�������
	String pay_way  = request.getParameter("payCode");		    //���ʽ
	pay_way = pay_way.substring(0,pay_way.indexOf("-"));
	String bank_code  = request.getParameter("bankCode");		//���д���
	String post_code  = request.getParameter("postCode");		//�ַ����д���                 
	String account_no  = request.getParameter("accountNo");		//�ʺ�                         
	String account_type  = request.getParameter("accountType");	//�ʻ�����                     
	String begin_date  = request.getParameter("beginDate");		//��ʼ����   YYYY-MM-DD        
	String end_date  = request.getParameter("endDate");		    //��������   YYYY-MM-DD        
	String oper_code  = "1102";		//��������                                                 
	String agent_id  = request.getParameter("workno");		    //��������                     
	String unit_code  = request.getParameter("unitCode");		//��������                     
	String oper_remark  = request.getParameter("opNote");		//������ע  
	String sysNote  = request.getParameter("sysNote");		//��������                     
	String ip_Addr  = request.getParameter("ip_Addr");		//������ע	                   
    //����ת��

  	try              
 	{                
		 ArrayList paramsIn = new ArrayList();

        paramsIn.add(new String[]{"0"});
        paramsIn.add(new String[]{account_id         });
        paramsIn.add(new String[]{cust_id         });
        paramsIn.add(new String[]{account_pwd     });
        paramsIn.add(new String[]{account_name        });
        paramsIn.add(new String[]{region_id       });
        paramsIn.add(new String[]{account_limit        });
        paramsIn.add(new String[]{pay_way         });
        paramsIn.add(new String[]{bank_code        });
        paramsIn.add(new String[]{post_code         });
        paramsIn.add(new String[]{account_no    });
        paramsIn.add(new String[]{account_type    });
        paramsIn.add(new String[]{begin_date       });
        paramsIn.add(new String[]{end_date    });
        paramsIn.add(new String[]{oper_code      });
        paramsIn.add(new String[]{agent_id      });
        paramsIn.add(new String[]{unit_code       });
        paramsIn.add(new String[]{oper_remark         });
        paramsIn.add(new String[]{sysNote       });
        paramsIn.add(new String[]{ip_Addr        });
        //retStr = callView.callService("s1102Cfm", paramsIn, "3", "region", iRegion_Code);
%>
		<wtc:service name="s1102Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
		<wtc:param value="<%=printAccept%>"/>	
		<wtc:param value="<%=account_id%>"/>
		<wtc:param value="<%=cust_id%>"/>	
		<wtc:param value="<%=account_pwd%>"/>
		<wtc:param value="<%=account_name%>"/>	
		<wtc:param value="<%=region_id%>"/>
		<wtc:param value="<%=account_limit%>"/>	
		<wtc:param value="<%=pay_way%>"/>
		<wtc:param value="<%=bank_code%>"/>	
		<wtc:param value="<%=post_code%>"/>	
		<wtc:param value="<%=account_no%>"/>
		<wtc:param value="<%=account_type%>"/>	
		<wtc:param value="<%=begin_date%>"/>
		<wtc:param value="<%=end_date%>"/>	
		<wtc:param value="<%=oper_code%>"/>
		<wtc:param value="<%=agent_id%>"/>	
		<wtc:param value="<%=unit_code%>"/>
		<wtc:param value="<%=oper_remark%>"/>
		<wtc:param value="<%=sysNote%>"/>	
		<wtc:param value="<%=ip_Addr%>"/>
		</wtc:service>	
		<wtc:array id="result1"  scope="end"/>
<%       	
		System.out.println("retCode1======"+retCode1);	
		System.out.println("retMsg1======"+retMsg1);
		String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+agent_id+"&loginAccept="+printAccept+"&opBeginTime="+opBeginTime+"&contactId="+account_id+"&contactType=acc";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
		//callView.printRetValue();
        error_code = retCode1;
        error_msg= retMsg1;
 	}catch(Exception e){
   		logger.error("Call sunView is Failed!");
 	}
   
    
	if(error_code.equals("000000") || error_code.equals("0"))
	{
%>
        <script language='jscript'>
            rdShowMessageDialog("�ʻ������ɹ���",2);
            removeCurrentTab();
        </script>            
<%		}else
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%        
    }
%>