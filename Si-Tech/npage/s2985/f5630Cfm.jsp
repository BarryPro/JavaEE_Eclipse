<%
   /******************************************
   * 功能: 参数集明细配置提交
　 * 版本: v1.0
　 * 日期: 2007/03/12
　 * 作者: liubo
　 * 版权: sitech
     * 修改历史
     * 修改日期:2009/05/14      修改人:leimd      修改目的:适应新需求
   *****************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%		
	String regionCode = (String)session.getAttribute("regCode");		 //地市代码
	String  vLogin_NO       =(String)session.getAttribute("workNo");         //操作工号
	String  vPass_Word	  =request.getParameter("loginPass");        //工号密码
	String  vOp_Code		  ="5630" ;                              //操作代码
	String  vOp_Note		  =request.getParameter("opNote");       //操作备注
	String  vIp_Addr		  =request.getParameter("ipAddr");       //IP地址
	String  lLogin_Accept =request.getParameter("loginAccept");      //操作流水 
	
	String  param_set     = request.getParameter("param_set");      //参数集代码
	String  set_name      = request.getParameter("set_name");	     //参数集名称
	
	String [] vparam_code    = request.getParameterValues("param_code");  //参数代码       
	String [] vparam_name   = request.getParameterValues("param_name");  //参数名称
	String [] vparam_order   = request.getParameterValues("param_order");  //参数顺序
	String [] vdefault_value  = request.getParameterValues("default_value"); //缺省值
	String [] vNull_Able           = request.getParameterValues("Null_Able");       //是否可空
	String [] vDes_Able           = request.getParameterValues("Des_Able");       //显示类型
	String [] vRead_Only = request.getParameterValues("Read_Only");            //是否只读
	String [] vMulti_Able   = request.getParameterValues("Multi_Able");              //是否分组
	String [] vParam_Group = request.getParameterValues("Param_Group");   //参数分组
	String [] vopen_param_flag = request.getParameterValues("open_param_flag");   //是否传数组
	String [] vupdate_flag = request.getParameterValues("update_flag");   //是否可修改


	
	String param_code    ="" ;           //参数代码       
	String param_name   ="";            //参数名称
	String param_order   ="" ;           //参数顺序
	String default_value  ="" ;           //缺省值
	String Null_Able         ="" ;           //是否可空
	String Des_Able         ="" ;           //显示类型
	String Read_Only      ="" ;           //是否只读
	String Multi_Able       ="" ;            //是否分组
	String Param_Group="" ;            //参数分组 
	String target_code_arrayList = "";	 //发送平台  
	String open_param_flag = "";	
	String update_flag = "";

	if(vparam_code!=null)
	  {
		for (int i = 0; i < vparam_code.length; i++)
		{		
			param_code  =param_code+vparam_code[i]+"|";  
			param_name =param_name+vparam_name[i]+"|";     
			param_order =param_order+vparam_order[i]+"|";
			default_value=default_value+vdefault_value[i]+"|";
			Null_Able       =Null_Able+vNull_Able[i]+"|"; 
			Des_Able       =Des_Able+vDes_Able[i]+"|"; 
			Read_Only    =Read_Only+vRead_Only[i]+"|"; 
			Multi_Able     =Multi_Able+vMulti_Able[i]+"|"; 
			Param_Group=Param_Group+vParam_Group[i]+"|"; 
			open_param_flag = open_param_flag+vopen_param_flag[i]+"|"; 
			update_flag = update_flag+vupdate_flag[i]+"|"; 
		}
		int num = Integer.parseInt(request.getParameter("num"));	
		System.out.println("num: " + num);
	
		for (int i = 0; i < num; i++)
		{		
			target_code_arrayList =target_code_arrayList+ (String)request.getParameter("target_code_array" +i+"")+",";	//基本产品代码		
		}
	 }
	

	/***
  SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList paraList = new ArrayList();//输入参数
	String[] retStr = null;
	

	paraList.add(new String[]{vLogin_NO    });
	paraList.add(new String[]{vPass_Word    });
	paraList.add(new String[]{vOp_Code    });
	paraList.add(new String[]{vOp_Note    });

	paraList.add(new String[]{vIp_Addr    });
	paraList.add(new String[]{lLogin_Accept    });
	paraList.add(new String[]{param_set    });
	paraList.add(new String[]{set_name    });	
	paraList.add(new String[]{param_code    });
	paraList.add(new String[]{param_name    });
	paraList.add(new String[]{param_order    });
	paraList.add(new String[]{default_value    });
	paraList.add(new String[]{Null_Able    });
	paraList.add(new String[]{Des_Able    });	
	paraList.add(new String[]{Read_Only    });
	paraList.add(new String[]{Multi_Able    });
	paraList.add(new String[]{Param_Group    });
	paraList.add(new String[]{target_code_arrayList    });	
    
	  retStr = impl.callService("s5630Cfm",paraList,"2","region",regionCode);
		impl.printRetValue();
		ret_code = impl.getErrCode();   
    retMessage = impl.getErrMsg();
    
   ***/
%>

 <wtc:service name="s5630Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="ret_code" retmsg="retMessage">
	<wtc:param value="<%=vLogin_NO%>"/>
	<wtc:param value="<%=vPass_Word%>"/>
	<wtc:param value="<%=vOp_Code%>"/>
	<wtc:param value="<%=vOp_Note%>"/>
	<wtc:param value="<%=vIp_Addr%>"/>
	<wtc:param value="<%=lLogin_Accept%>"/>
	<wtc:param value="<%=param_set%>"/>
	<wtc:param value="<%=set_name%>"/>
	<wtc:param value="<%=param_code%>"/>
	<wtc:param value="<%=param_name%>"/>
	<wtc:param value="<%=param_order%>"/>
	<wtc:param value="<%=default_value%>"/>
	<wtc:param value="<%=Null_Able%>"/>
	<wtc:param value="<%=Des_Able%>"/>
	<wtc:param value="<%=Read_Only%>"/>
	<wtc:param value="<%=Multi_Able%>"/>
	<wtc:param value="<%=Param_Group%>"/>
	<wtc:param value="<%=target_code_arrayList%>"/>
	
	<wtc:param value="<%=open_param_flag%>"/>
	<wtc:param value="<%=update_flag%>"/>	

</wtc:service>
	
   
<%

	if(ret_code.equals("000000")){ 
%>
		 <script language="JavaScript">
			rdShowMessageDialog(" 参数集明细配置[<%=param_set%>]配置成功!",2);
			window.location="f2985.jsp";
		 </script>
<%
 	}else{
%>
  	<script language="JavaScript">
		rdShowMessageDialog("<%=ret_code%>" + "[" + "<%=retMessage%>" + "]" ,0);
          history.go(-1);
	</script>
<%
	}
%>   

