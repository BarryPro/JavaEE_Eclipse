 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-04 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>



<%
	String iRegion_Code = (String)session.getAttribute("regCode");  
	 //�õ��������
   
    	ArrayList retArray = new ArrayList();
    	String return_code,return_message,total_date,login_accept,delay_time;
    	//String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String[] retStr = null;
	String error_code="0";
    	String error_msg="";
 	String account_id  = request.getParameter("accountId");  	//�ʻ�ID  
	String cust_id  = request.getParameter("custId");		    //�ͻ�ID 
	String custPwd =request.getParameter("custPwd");
	String newPwd=request.getParameter("newPwd");
	String account_pwd  = WtcUtil.repStr(newPwd," ");//�ʻ���������
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
  	            
	   /* ArrayList paramsIn = new ArrayList();
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
            paramsIn.add(new String[]{ip_Addr        });*/
            //retStr = callView.callService("s1102Cfm", paramsIn, "3", "region", iRegion_Code);
            %>
            	<wtc:service name="s1102Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode" retmsg="retMsg" outnum="3" >
			<wtc:param value="0"/>
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
		<wtc:array id="result" scope="end"/>
            <%       	   
                error_code=retCode;
             	error_msg=retMsg;           
     
       
        if(result!=null&&result[0][0].equals("000000"))
		{
			if(account_type.equals("a")){
%>
			<script language='jscript'>
				window.opener.document.form1.UserCode.value = "<%=account_id%>";
				window.opener.document.form1.UserPassword.value = "<%=account_pwd%>";
			</script>
<%
			}
%>
            <script language='jscript'>
                rdShowMessageDialog("�ʻ������ɹ���",2);
                window.opener.form1.UserCode.value="<%=account_id%>";
			          window.opener.form1.UserPassword.value="<%=newPwd%>";
			          window.opener.form1.submit1.disabled=false;
			          window.close();
            </script>
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=result[0][0]%>" + "[" + "<%=result[0][1]%>" + "]" ,0);
                history.go(-1);
            </script>
<%        
        }
%>