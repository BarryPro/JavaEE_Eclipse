 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-04 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>



<%
	String iRegion_Code = (String)session.getAttribute("regCode");  
	 //得到输入参数
   
    	ArrayList retArray = new ArrayList();
    	String return_code,return_message,total_date,login_accept,delay_time;
    	//String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();

	String[] retStr = null;
	String error_code="0";
    	String error_msg="";
 	String account_id  = request.getParameter("accountId");  	//帐户ID  
	String cust_id  = request.getParameter("custId");		    //客户ID 
	String custPwd =request.getParameter("custPwd");
	String newPwd=request.getParameter("newPwd");
	String account_pwd  = WtcUtil.repStr(newPwd," ");//帐户加密密码
	account_pwd = Encrypt.encrypt(account_pwd);  //加密用户密码
	String account_name  = request.getParameter("accountName");	//帐户名称
	String region_id  = request.getParameter("belongCode");		//归属代码
	//String account_limit  = request.getParameter("accountLimit");	//帐户信誉度
	String account_limit  = "A";	//帐户信誉度
	String pay_way  = request.getParameter("payCode");		    //付款方式
	pay_way = pay_way.substring(0,pay_way.indexOf("-"));
	String bank_code  = request.getParameter("bankCode");		//银行代码
	String post_code  = request.getParameter("postCode");		//局方银行代码                 
	String account_no  = request.getParameter("accountNo");		//帐号                         
	String account_type  = request.getParameter("accountType");	//帐户类型                     
	String begin_date  = request.getParameter("beginDate");		//开始日期   YYYY-MM-DD        
	String end_date  = request.getParameter("endDate");		    //结束日期   YYYY-MM-DD        
	String oper_code  = "1102";		//操作代码                                                 
	String agent_id  = request.getParameter("workno");		    //操作工号                     
	String unit_code  = request.getParameter("unitCode");		//机构编码                     
	String oper_remark  = request.getParameter("opNote");		//操作备注  
	String sysNote  = request.getParameter("sysNote");		//机构编码                     
	String ip_Addr  = request.getParameter("ip_Addr");		//操作备注	                   
    	//密码转码
  	            
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
                rdShowMessageDialog("帐户开户成功！",2);
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