<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.05
 ģ��: BOSS��VPMN���ſ���
********************/
%>

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
    String error_code="";
    String error_msg="";

    String iIpAddr = (String)session.getAttribute("ipAddr");
    String iWorkNo = (String)session.getAttribute("workNo");
    String iOrgCode = (String)session.getAttribute("orgCode");
    String iLogin_Pass  = (String)session.getAttribute("password");
    String unit_id = request.getParameter("unit_id");  					//����id
    System.out.println("unit_idunit_idunit_id====================="+unit_id);
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    	System.out.println("iLoginAcceptiLoginAcceptiLoginAcceptiLoginAcceptiLoginAccept========="+iLoginAccept);
    String iOpCode         = request.getParameter("op_code");          //��������
    //String iWorkNo         = request.getParameter("WorkNo");           //����Ա����
    // String iLogin_Pass     = request.getParameter("NoPass");           //����Ա����
    // String iOrgCode        = request.getParameter("OrgCode");          //����Ա��������
    String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
    String iOp_Note        = request.getParameter("tonote");           //�û�������ע
    //String iIpAddr         = request.getParameter("ip_Addr");          //����ԱIP��ַ
    String iCust_Id        = request.getParameter("cust_id");          //���ſͻ�ID
    String iGrp_Id         = request.getParameter("grp_id");           //�����û�ID
    String iContract_No    = request.getParameter("account_id");       //�����û��ʺ�
    String iUser_Passwd    = request.getParameter("user_passwd");      //�����û�����
    String iProvince       = request.getParameter("province");         //��������ʡ��
	System.out.println("$$$$$$$$$$$$$$$$iProvince="+iProvince);
	System.out.println("@@@@@@@@@@@@@@"+request.getParameter("belong_code"));
    String iBelong_Code    = request.getParameter("belong_code").substring(0,7);      //�ͻ���������
    String iBill_Type      = request.getParameter("bill_type");        //��������
    String iBill_Date      = request.getParameter("srv_stop");         //ҵ�����ʱ��????
    String iGrp_Name       = request.getParameter("grp_name");         //�����û�����
    String iOrg_Id         = request.getParameter("org_id");           //����Ա��org_id
    String iGroup_Id       = request.getParameter("group_id");         //����Ա��group_id
    String iSm_Code        = request.getParameter("sm_code");          //����Ʒ�ƴ���
    String iProduct_Code   = request.getParameter("product_code");     //��������Ʒ����
    String iProduct_Append = request.getParameter("product_append");   //���Ÿ��Ӳ�Ʒ����
    String iProduct_Prices = request.getParameter("product_prices");   //��Ʒ�۸����
    String iProduct_Attr   = request.getParameter("product_attr");     //��Ʒ���Դ���
    String iProduct_Type   = request.getParameter("product_type");     //��Ʒ����
    String iService_Code   = request.getParameter("service_code");     //�������
    String iService_Attr   = request.getParameter("service_attr");     //��������
	String mainRate   =request.getParameter("mainRate");
	String[] optionalRates   =(String[])request.getParameterValues("optionalRate");
	String url = "";
	String iPay_Type	   = request.getParameter("payType");     //���ʽ
	String iCash_Pay	   = request.getParameter("cashNum");     //֧�����
	String iCheck_No	   = request.getParameter("checkNo");     //֧Ʊ����
	String iBank_Code	   = request.getParameter("bankCode");     //���д���
	String iCheck_Pay	   = request.getParameter("checkPay");     //֧Ʊ����
	String iShouldHandFee  = request.getParameter("should_handfee");   //Ӧ��������
    String iHandFee        = request.getParameter("real_handfee");     //ʵ��������
   //payType ���ѷ�ʽ ~ checkNo ֧Ʊ���� ~ bankCode ���д��� ~ checkPay ֧Ʊ���� ~ cashPay �ֽ𽻿� ~ shouldHandFee ������ ~ handFee ������
	String feeList="";                                                 //������Ϣ
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iShouldHandFee+"~"+iShouldHandFee+"~"+iHandFee+"~";
    //String iContract_List  = "";                                       //��ͬ�б�
    //String iContract_Desc  = "";                                       //��ͬ����
    //String iPayNo          = request.getParameter("pay_no");           //�����ֻ�����
    String iGrp_UserNo     = request.getParameter("grp_userno");       //�����û����
    String iRegion_Code = iOrgCode.substring(0,2);
    iUser_Passwd = Encrypt.encrypt(iUser_Passwd);  //�����û�����

    int i=0,j=0,k=0;
    i = iProduct_Code.indexOf("|"); //�õ�����Ʒ����
    iProduct_Code = iProduct_Code.substring(0, i);
/*
    for (i=0,j=1; i<iProduct_Append.length(); i++) { //ͳ�Ƹ��Ӳ�Ʒ����
        if (iProduct_Append.charAt(i) == ',')
            j++;
    }
*/
    String[] ProdAppend = new String[j+1]; //�����Ӳ�Ʒ����Ʒ�۸񡢲�Ʒ���Էֽ⵽������
    String[] ProdPrice = new String[j+1];
    String[] ProdAttr = new String[j+1];
    ProdAppend[0] = iProduct_Code;
    ProdPrice[0] = " ";
    ProdAttr[0] = " ";
/*
    for(i=1; i<j+1; i++) {
        k = iProduct_Append.indexOf(',');
        if (k > 0)
            ProdAppend[i] = iProduct_Append.substring(0, k);
        else
            ProdAppend[i] = iProduct_Append;
        ProdPrice[i] = "";
        ProdAttr[i] = "";
        iProduct_Append = iProduct_Append.substring(k+1);
    }
*/
    try
    {
            ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });//0
            paramsIn.add(new String[]{iOpCode         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iCust_Id        });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{iContract_No    });//10
            paramsIn.add(new String[]{iUser_Passwd    });
            paramsIn.add(new String[]{iProvince       });
            paramsIn.add(new String[]{iBelong_Code    });
            paramsIn.add(new String[]{iBill_Type      });
            paramsIn.add(new String[]{iBill_Date      });
            paramsIn.add(new String[]{iGrp_Name       });
            paramsIn.add(new String[]{iOrg_Id         });
            paramsIn.add(new String[]{iGroup_Id       });
            paramsIn.add(new String[]{iSm_Code        });
            paramsIn.add(new String[]{iProduct_Code   });//20
            paramsIn.add(ProdAppend                    );
           
            paramsIn.add(ProdPrice                     );
            paramsIn.add(ProdAttr                      );
            paramsIn.add(new String[]{iProduct_Type   });
            paramsIn.add(new String[]{iService_Code   });
            paramsIn.add(new String[]{iService_Attr   });
			paramsIn.add(new String[]{feeList         });
						
						
            //paramsIn.add(new String[]{iContract_List  });
            //paramsIn.add(new String[]{iContract_Desc  });
            //paramsIn.add(new String[]{iShouldHandFee  });
            //paramsIn.add(new String[]{iHandFee        });
            //paramsIn.add(new String[]{iPayNo          });
            paramsIn.add(new String[]{iGrp_UserNo     });//28

			String[] fieldCodes = null;
			String[] rates = null;
			if (optionalRates != null)
			{
				fieldCodes = new String[1+optionalRates.length];
				rates = new String[1+optionalRates.length];
			}
			else
			{
				fieldCodes = new String[1];
				rates = new String[1];
			}
			fieldCodes[0] = "10000";
			rates[0] = mainRate;
			for (i = 1; i < rates.length; i ++)
			{
				fieldCodes[i] = "10001";
				rates[i] = optionalRates[i-1];
			}
			paramsIn.add(fieldCodes);
			paramsIn.add(rates);
			
            //retStr = callView.callService("s3600Cfm", paramsIn, "1", "region", iRegion_Code);
%>
			<wtc:service name="s3600Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
			<wtc:param value="<%=iLoginAccept%>"/>	
			<wtc:param value="<%=iOpCode      %>"/>	
			<wtc:param value="<%=iWorkNo      %>"/>	
			<wtc:param value="<%=iLogin_Pass  %>"/>	
			<wtc:param value="<%=iOrgCode     %>"/>	
			<wtc:param value="<%=iSys_Note    %>"/>	
			<wtc:param value="<%=iOp_Note     %>"/>	
			<wtc:param value="<%=iIpAddr      %>"/>	
			<wtc:param value="<%=iCust_Id     %>"/>	
			<wtc:param value="<%=iGrp_Id      %>"/>	
			<wtc:param value="<%=iContract_No %>"/>	
			<wtc:param value="<%=iUser_Passwd %>"/>	
			<wtc:param value="<%=iProvince    %>"/>	
			<wtc:param value="<%=iBelong_Code %>"/>	
			<wtc:param value="<%=iBill_Type   %>"/>	
			<wtc:param value="<%=iBill_Date   %>"/>	
			<wtc:param value="<%=iGrp_Name    %>"/>	
			<wtc:param value="<%=iOrg_Id      %>"/>	
			<wtc:param value="<%=iGroup_Id    %>"/>	
			<wtc:param value="<%=iSm_Code     %>"/>	
			<wtc:param value="<%=iProduct_Code%>"/>	
				
			<wtc:params value="<%=ProdAppend%>"/>	
			<wtc:params value="<%=ProdPrice%>"/>	
			<wtc:params value="<%=ProdAttr%>"/>	
				
			<wtc:param value="<%=iProduct_Type%>"/>	
			<wtc:param value="<%=iService_Code%>"/>	
			<wtc:param value="<%=iService_Attr%>"/>	
			<wtc:param value="<%=feeList      %>"/>	
			<wtc:param value="<%=iGrp_UserNo%>"/>	
			<wtc:params value="<%=fieldCodes%>"/>	
			<wtc:params value="<%=rates%>"/>	
			
			</wtc:service>	
			<wtc:array id="retStrTemp"  scope="end"/>
<%
     url = "/npage/contact/onceCnttInfo.jsp?opCode="+"3600"+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1
		+"&opName="+"BOSS��VPMN���ſ���"+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+unit_id
		+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
			//callView.printRetValue();
            error_code = retCode1;
            error_msg= retMsg1;
            System.out.println("error_code===="+error_code);
             System.out.println("url===="+url);
    }catch(Exception e){
        System.out.println(e.toString());
        error_code = "9";
    }

    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("ҵ������ɹ���",2);
            removeCurrentTab();
        </script>
<%  } else {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]" ,0);
            history.go(-1);
        </script>
<%
    }
%>
<jsp:include page="<%=url%>" flush="true" />