<%
/********************
version v2.0
开发商: si-tech
模块：用户付费计划变更
日期：2008.12.1
作者：leimd
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

 <%
 // SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
    String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String iccid=WtcUtil.repNull(request.getParameter("iccid"));
	String comm_addr=WtcUtil.repNull(request.getParameter("comm_addr"));
	String cust_name=WtcUtil.repNull(request.getParameter("cust_name"));
	
	String[] retStr = null;
	String error_code="";
    String error_msg="";
	
//  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//  String nopass = ((String[][])arrSession.get(4))[0][0];           
//  System.out.println("+++++nopass==="+nopass);                     

  //String[][] baseInfoSession = (String[][])arrSession.get(0);
  //String work_no = baseInfoSession[0][2];
  //String loginName = baseInfoSession[0][3];
  //String org_code = baseInfoSession[0][16];
  	String nopass = (String)session.getAttribute("password");
    String loginName = (String)session.getAttribute("workName");
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String phoneNo = request.getParameter("srv_no");

    String iRegion_Code = org_code.substring(0,2);
    String op_code = opCode;

	String cus_name=WtcUtil.repNull(request.getParameter("cust_name"));
	
	String paraStr[]=new String[28];
	
	String iloginAccept=WtcUtil.repNull(request.getParameter("sysAccept"));
 	String iopCode=op_code;
 	String iloginNo=work_no;
	String iloginPasswd=nopass;
	String iorgCode=org_code;

	String iopType=WtcUtil.repNull(request.getParameter("r_acc_opType"));
	String iidNo=WtcUtil.repNull(request.getParameter("cust_id"));
	String icontractNo=WtcUtil.repNull(request.getParameter("s_acc_name"));
	String ipriorBillOrder=WtcUtil.repNull(request.getParameter("s_pre_account"));
	String ipayOrder=WtcUtil.repNull(request.getParameter("t_pay_order"));
	String ilimitPay=WtcUtil.repNull(request.getParameter("t_feeLimit"));
	String irateFlag=WtcUtil.repNull(request.getParameter("r_detFlag"));
	String istopFlag=WtcUtil.repNull(request.getParameter("r_stopFlag"));

	String ifeeCode=WtcUtil.repNull(request.getParameter("transFeeCode"));
	String idetailCode=WtcUtil.repNull(request.getParameter("transDetailCode"));
	String ifeeRate=WtcUtil.repNull(request.getParameter("transFeeName"));
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@ifeeCode="+ifeeCode);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@idetailCode="+idetailCode);
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@ifeeRate="+ifeeRate);

	String ipayFee=WtcUtil.repNull(request.getParameter("oriHandFee"));
	String irealFee=WtcUtil.repNull(request.getParameter("t_handFee"));
	String isystemNote=WtcUtil.repNull(request.getParameter("t_sys_remark"));
	String iopNote=WtcUtil.repNull(request.getParameter("t_op_remark"));
	String iipAddr=request.getRemoteAddr();
	
	/****分解字符串****/
	StringTokenizer token1=new StringTokenizer(ifeeCode,"#");
	StringTokenizer token2=new StringTokenizer(idetailCode,"#");
	StringTokenizer token3=new StringTokenizer(ifeeRate,"#");
	/*
	String feeCode []=new String [token1.countTokens()];
	System.out.println("%%%%%%%%%%%token1.countTokens()="+token1.countTokens());
	String detai1Code []=new String [token2.countTokens()];
	String feeRate []=new String [token3.countTokens()];
	*/
	/* 申告 ningtn */
	String feeCode [];
	String detai1Code [];
	String feeRate [];
	if(token1.countTokens() > 0){
		feeCode =new String [token1.countTokens()];
	}else{
		feeCode =new String []{""};
	}
	if(token2.countTokens() > 0){
		detai1Code =new String [token2.countTokens()];
	}else{
		detai1Code =new String []{""};
	}
	if(token3.countTokens() > 0){
		feeRate =new String [token3.countTokens()];
	}else{
		feeRate =new String []{""};
	}
	
	int i=0;
	while(token1.hasMoreElements()){
		feeCode[i]=(String)token1.nextElement();
		detai1Code[i]=(String)token2.nextElement();
		feeRate[i]=(String)token3.nextElement();
		System.out.println("%%%%%%%%%%%"+feeCode[i]);
		System.out.println("%%%%%%%%%%%"+detai1Code[i]);
		System.out.println("%%%%%%%%%%%"+feeRate[i]);
		i++;
	}
	System.out.println("%%%%%%%%%%%feeCode.length()="+feeCode.length);
  //分为增加,修改,删除操作
  if(iopType.equals("a"))
  {
	iopType=WtcUtil.repNull(request.getParameter("r_acc_opType"));
	iidNo=WtcUtil.repNull(request.getParameter("cust_id"));
	icontractNo=WtcUtil.repNull(request.getParameter("t_acc_name"));
	System.out.println("####################icontractNo"+request.getParameter("t_acc_name"));
	ipriorBillOrder=WtcUtil.repNull(request.getParameter("s_pre_account"));
	ipayOrder=WtcUtil.repNull(request.getParameter("t_pay_order"));
	ilimitPay=WtcUtil.repNull(request.getParameter("t_feeLimit"));
	irateFlag=WtcUtil.repNull(request.getParameter("r_detFlag"));
	istopFlag=WtcUtil.repNull(request.getParameter("r_stopFlag"));

	ipayFee=WtcUtil.repNull(request.getParameter("oriHandFee"));
	irealFee=WtcUtil.repNull(request.getParameter("t_handFee"));
	isystemNote=WtcUtil.repNull(request.getParameter("t_sys_remark"));
	iopNote=WtcUtil.repNull(request.getParameter("t_op_remark"));
	iipAddr=request.getRemoteAddr();
  }
  else if(iopType.equals("u"))
  {
    iopType=WtcUtil.repNull(request.getParameter("r_acc_opType"));
	iidNo=WtcUtil.repNull(request.getParameter("cust_id"));
	icontractNo=WtcUtil.repNull(request.getParameter("s_acc_name"));
	ipriorBillOrder=WtcUtil.repNull(request.getParameter("s_pre_account"));
	ipayOrder=WtcUtil.repNull(request.getParameter("t_pay_order"));
	ilimitPay=WtcUtil.repNull(request.getParameter("t_feeLimit"));
	irateFlag=WtcUtil.repNull(request.getParameter("r_detFlag"));
	istopFlag=WtcUtil.repNull(request.getParameter("r_stopFlag"));

	ipayFee=WtcUtil.repNull(request.getParameter("oriHandFee"));
	irealFee=WtcUtil.repNull(request.getParameter("t_handFee"));
	isystemNote=WtcUtil.repNull(request.getParameter("t_sys_remark"));
	iopNote=WtcUtil.repNull(request.getParameter("t_op_remark"));
	iipAddr=request.getRemoteAddr();
  }
  else if (iopType.equals("d"))
  {
	iopType="d";
    iidNo=WtcUtil.repNull(request.getParameter("cust_id"));
    icontractNo=WtcUtil.repNull(request.getParameter("s_acc_name"));
    ipayOrder="1";
	ilimitPay="1";
	irateFlag="1";
	istopFlag="1";
	
	ipayFee=WtcUtil.repNull(request.getParameter("oriHandFee"));
	irealFee=WtcUtil.repNull(request.getParameter("t_handFee"));
	isystemNote=WtcUtil.repNull(request.getParameter("t_sys_remark"));
	iopNote=WtcUtil.repNull(request.getParameter("t_op_remark"));
	iipAddr=request.getRemoteAddr();
  }
  String icust_name=request.getParameter("assuName");
  String icontact_phone=request.getParameter("assuPhone");
  String iid_type=request.getParameter("assuIdType");
  String iid_iccid=request.getParameter("assuId");
  String iid_address=request.getParameter("assuIdAddr");
  String icontact_address=request.getParameter("assuAddr");
  String inotes=request.getParameter("assuNote");
  
  /*paraStr[20]=WtcUtil.repNull(request.getParameter("assuName"));
  paraStr[21]=WtcUtil.repNull(request.getParameter("assuPhone"));
  paraStr[22]=WtcUtil.repNull(request.getParameter("assuIdType"));
  paraStr[23]=WtcUtil.repNull(request.getParameter("assuId"));
  paraStr[24]=WtcUtil.repNull(request.getParameter("assuIdAddr"));
  paraStr[25]=WtcUtil.repNull(request.getParameter("assuAddr"));
  paraStr[26]=WtcUtil.repNull(request.getParameter("assuNote"));

  if(Double.parseDouble(((paraStr[15].trim().equals(""))?("0"):(paraStr[15])))<0.01)    
  { paraStr[27]="0";
  }
  else
  {
     comImpl co=new comImpl();
     String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
     paraStr[27]=(((String[][])co.fillSelect(prtSql))[0][0]).trim();
  }
  */
	 //----------------------------------------------------------

            ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iloginAccept    });
            paramsIn.add(new String[]{iopCode         });
            paramsIn.add(new String[]{iloginNo         });
            paramsIn.add(new String[]{iloginPasswd     });
            paramsIn.add(new String[]{iorgCode        });
            paramsIn.add(new String[]{iopType       });
            paramsIn.add(new String[]{iidNo        });
            paramsIn.add(new String[]{icontractNo         });
            paramsIn.add(new String[]{ipriorBillOrder });
            paramsIn.add(new String[]{ipayOrder       });
            paramsIn.add(new String[]{ilimitPay       });
            paramsIn.add(new String[]{irateFlag       });
            paramsIn.add(new String[]{istopFlag       });

            paramsIn.add(feeCode		  );
            paramsIn.add(detai1Code       );
            paramsIn.add(feeRate		  );

            paramsIn.add(new String[]{ipayFee       });
            paramsIn.add(new String[]{irealFee         });
            paramsIn.add(new String[]{isystemNote       });
            paramsIn.add(new String[]{iopNote        });
            paramsIn.add(new String[]{iipAddr   });

            paramsIn.add(new String[]{icust_name   });
            paramsIn.add(new String[]{icontact_phone   });
            paramsIn.add(new String[]{iid_type   });
            paramsIn.add(new String[]{iid_iccid  });
            paramsIn.add(new String[]{iid_address  });
            paramsIn.add(new String[]{icontact_address  });
            paramsIn.add(new String[]{inotes        });
       //     retStr = callView.callService("s1212Cfm", paramsIn, "1", "region", iRegion_Code);
%>
		<wtc:service name="s1212Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="s1212CfmCode" retmsg="s1212CfmMsg" outnum="2" >
		    <wtc:param value="<%=iloginAccept%>"/>  
            <wtc:param value="<%=iopCode  %>"/>   
            <wtc:param value="<%=iloginNo%>"/>  
            <wtc:param value="<%=iloginPasswd%>"/>  
            <wtc:param value="<%=iorgCode%>"/>    
            <wtc:param value="<%=iopType%>"/>      
            <wtc:param value="<%=iidNo%>"/>       
            <wtc:param value="<%=icontractNo    %>"/>
            <wtc:param value="<%=ipriorBillOrder %>"/>    
            <wtc:param value="<%=ipayOrder       %>"/>    
            <wtc:param value="<%=ilimitPay       %>"/>    
            <wtc:param value="<%=irateFlag       %>"/>   
            <wtc:param value="<%=istopFlag  %>"/>    
                                                             
            <wtc:params value="<%=feeCode		  %>"/>                 
            <wtc:params value="<%=detai1Code       %>"/>                
            <wtc:params value="<%=feeRate		  %>"/>                 
                                                             
            <wtc:param value="<%=ipayFee     %>"/>      
            <wtc:param value="<%=irealFee       %>"/>   
            <wtc:param value="<%=isystemNote     %>"/>  
            <wtc:param value="<%=iopNote     %>"/>     
            <wtc:param value="<%=iipAddr %>"/>          
                                                
            <wtc:param value="<%=icust_name %>"/>       
            <wtc:param value="<%=icontact_phone %>"/>   
            <wtc:param value="<%=iid_type %>"/>         
            <wtc:param value="<%=iid_iccid %>"/>         
            <wtc:param value="<%=iid_address %>"/>       
            <wtc:param value="<%=icontact_address %>"/>  
            <wtc:param value="<%=inotes      %>"/>      
		</wtc:service>			
<%	 
            error_code = s1212CfmCode;
            error_msg= s1212CfmMsg;
//------------------------------------------------------------------------------
   /* S1210Impl im1210=new S1210Impl();
	String[] fg=im1210.s1212Cfm(paraStr,"phone",srv_no);
	System.out.println("@@@@@@@@@@@@@@@@@@@@fg.length()="+fg.length);*/
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&opName="+opName+"&workNo="+iloginNo+"&loginAccept="+iloginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+error_msg+"&opBeginTime="+opBeginTime; 
	System.out.println(url);	
%>
<jsp:include page="<%=url%>" flush="true"/>
<%	
	if(error_code.equals("000000"))
    {
       
	   System.out.println("55555555555555555555555555555555555555555");
%>
        <script>
	      rdShowMessageDialog("客户付费计划已被成功修改！",2);
          location="s1212Login.jsp?activePhone=<%=srv_no%>&opCode=<%=opCode%>&opName=<%=opName%>";
	    </script>
<%
   }
   else
   {
%>
  
	<script>
	  rdShowMessageDialog('错误<%=error_msg%>，请重新操作！',0);
       location="s1212Login.jsp?activePhone=<%=srv_no%>&opCode=<%=opCode%>&opName=<%=opName%>";
	 </script>
<%
   }
%>
