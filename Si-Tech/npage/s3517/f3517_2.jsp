 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-15 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.StringTokenizer"%>

<%
	
	String opCode1 = "3517";	
	String opName1 = "�����û����ϱ��";	//header.jsp��Ҫ�Ĳ���  
    //ArrayList retArray = null;
    String error_code = "0";
    String error_msg = "";
   

    String[] retStr = null;
    String unit_id=request.getParameter("unit_idAdd");
    System.out.println("unit_id===="+unit_id);
    String iLoginAccept    = request.getParameter("login_accept");     //������ˮ��
    String iOpCode         = request.getParameter("op_code");          //��������
    String iWorkNo         = request.getParameter("WorkNo");           //����Ա����
    String iLogin_Pass     = request.getParameter("NoPass");           //����Ա����
    String iOrgCode        = request.getParameter("OrgCode");          //����Ա��������
    String iSys_Note       = request.getParameter("sysnote");          //ϵͳ������ע
    String iOp_Note        = request.getParameter("tonote");           //�û�������ע
    String iIpAddr         = request.getParameter("ip_Addr");          //����ԱIP��ַ
    String iGrp_Id         = request.getParameter("grpIdNo");          //�����û�ID	 
	String idcMebNo        = request.getParameter("idcMebNo");         //IDC�û�����
	
	String name_list	   = request.getParameter("nameList");		   //�����ֶδ���
	String grp_list	       = request.getParameter("nameGroupList");	   //�ֶζ�Ӧ���к�
	String name_list_new   = request.getParameter("nameListNew");	   //���������ֶδ���
	String grp_list_new    = request.getParameter("nameGroupListNew"); //�����ֶζ�Ӧ���к�

	String iPay_Type	   = request.getParameter("payType");     //���ʽ
	String iCash_Pay	   = request.getParameter("should_handfee");     //֧�����
	String iCheck_No	   = request.getParameter("checkNo");     //֧Ʊ����
	String iBank_Code	   = request.getParameter("bankCode");     //���д���
	String iCheck_Pay	   = request.getParameter("checkPay");     //֧Ʊ����
	String iShouldHandFee  = request.getParameter("should_handfee");   //Ӧ��������
    	String iHandFee        = request.getParameter("real_handfee");     //ʵ��������
	String feeList="";//������Ϣ
	feeList=iPay_Type+"~"+iCheck_No+"~"+iBank_Code+"~"+iCheck_Pay+"~"+iCash_Pay+"~"+iShouldHandFee+"~"+iHandFee+"~";
    String iRegion_Code = iOrgCode.substring(0,2);
    try
    {		   
			StringTokenizer token=new StringTokenizer(name_list,"|");
			StringTokenizer token_grp=new StringTokenizer(grp_list,"|");
			StringTokenizer token_new=new StringTokenizer(name_list_new,"|");
			StringTokenizer token_grp_new=new StringTokenizer(grp_list_new,"|");
			int length=token.countTokens();
			int newLen=token_new.countTokens();
			//System.out.println(length);
			
			//�������롢��ֵ���к�
			String fieldCodes[] = new String [length];
			String fieldValues[]= new String [length];
			String fieldRowNo[]= new String [length];
			
			ArrayList fieldValueAry = new ArrayList();
			Vector vec = new Vector();

			int i=0;	//���������
			int m=0;
			int j=0;    //�����ʷѸ���
			int k=0;	//��Ÿ��������������ͬ
			int p=0;	//ÿ�����е�һ����ļ�¼����
			//��������ַ���
			while (token_grp.hasMoreElements()){
				fieldRowNo[k]=(String)token_grp.nextElement();
				//System.out.println("###########********fieldRowNo["+k+"]**********##########"+fieldRowNo[k]);
				k++;
			}
			
			//�������ֺ�ֵ�ַ���
			while (token.hasMoreElements()){
				fieldCodes[i]=(String)token.nextElement();
				//System.out.println("###########********fieldCodes["+i+"]**********##########"+fieldCodes[i]);
				//System.out.println("###########********fieldRowNo["+i+"]**********##########"+fieldRowNo[i]);
				
				if(!vec.contains(fieldCodes[i]))
				{
					if(!fieldRowNo[i].equals("0"))	//�кŴ�1��ʼ
					{
						String[] tempValues = (String[])request.getParameterValues("F"+fieldCodes[i]);
						for(p=0;p<tempValues.length;p++)
						{
							fieldValueAry.add(tempValues[p]);
							//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
						}
					}
					else
					{
						fieldValueAry.add(request.getParameter("F"+fieldCodes[i]));
						//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
					}
					vec.add(fieldCodes[i]);
				}
				i++;
			}
			
			fieldValues=(String[])fieldValueAry.toArray(new String[length]);
			//�������롢��ֵ���кŽ���
			
			//�����������롢��ֵ���к�
			String newFieldCodes[] = new String [newLen];
			String newFieldValues[]= new String [newLen];
			String newFieldRowNo[]= new String [newLen];
			
			ArrayList newFieldValueAry = new ArrayList();
			Vector newVec = new Vector();

			i=0;	//���������
			m=0;
			j=0;    //�����ʷѸ���
			k=0;	//��Ÿ��������������ͬ
			p=0;	//ÿ�����е�һ����ļ�¼����
			//��������ַ���
			while (token_grp_new.hasMoreElements()){
				newFieldRowNo[k]=(String)token_grp_new.nextElement();
				//System.out.println("###########********newFieldRowNo["+k+"]**********##########"+newFieldRowNo[k]);
				k++;
			}
			
			//�������ֺ�ֵ�ַ���
			while (token_new.hasMoreElements()){
				newFieldCodes[i]=(String)token_new.nextElement();
				//System.out.println("###########********newFieldCodes["+i+"]**********##########"+newFieldCodes[i]);
				//System.out.println("###########********newFieldRowNo["+i+"]**********##########"+newFieldRowNo[i]);
				
				if(!newVec.contains(newFieldCodes[i]))
				{
					if(!newFieldRowNo[i].equals("0"))	//�кŴ�1��ʼ
					{
						String[] tempValues = (String[])request.getParameterValues("F"+newFieldCodes[i]);
						for(p=0;p<tempValues.length;p++)
						{
							newFieldValueAry.add(tempValues[p]);
							//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
						}
					}
					else
					{
						newFieldValueAry.add(request.getParameter("F"+newFieldCodes[i]));
						//System.out.println("###########********tempValues["+p+"]**********##########"+tempValues[p]);
					}
					newVec.add(newFieldCodes[i]);
				}
				i++;
			}
			
			newFieldValues=(String[])newFieldValueAry.toArray(new String[newLen]);
			//�����������롢��ֵ���кŽ���
			
			String temp_str="";
			
			ArrayList paramsIn = new ArrayList();

            paramsIn.add(new String[]{iLoginAccept    });
            paramsIn.add(new String[]{iOpCode         });
            paramsIn.add(new String[]{iWorkNo         });
            paramsIn.add(new String[]{iLogin_Pass     });
            paramsIn.add(new String[]{iOrgCode        });
            paramsIn.add(new String[]{iSys_Note       });
            paramsIn.add(new String[]{iOp_Note        });
            paramsIn.add(new String[]{iIpAddr         });
            paramsIn.add(new String[]{iGrp_Id         });
            paramsIn.add(new String[]{idcMebNo        });
            //System.out.println("bbbbbbidcMebNo"+idcMebNo);
            paramsIn.add(new String[]{feeList         });
            
            if(length>0)
            {
            paramsIn.add(fieldCodes                    );
            paramsIn.add(fieldValues                   );
            paramsIn.add(fieldRowNo                    );
            }
          else{
          	paramsIn.add(""                    );
            paramsIn.add(""                   );
            paramsIn.add(""                    );
          	}
            if (newLen== 0)
            	 paramsIn.add(temp_str                 );
            else
            	 paramsIn.add(newFieldCodes            );
            if (newLen== 0)
               paramsIn.add(temp_str                   );
            else
               paramsIn.add(newFieldValues             );
            if (newLen== 0)
               paramsIn.add(temp_str                   );
            else
               paramsIn.add(newFieldRowNo              );
            

			//�����������           
			//retStr = callView.callService("s3517Cfm", paramsIn, "1", "region", iRegion_Code);
			%>				
			<wtc:service name="s3517Cfm" routerKey="region" routerValue="<%=iRegion_Code%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
				<wtc:param value="<%=iLoginAccept%>"/>
				<wtc:param value="<%=iOpCode%>"/>
				<wtc:param value="<%=iWorkNo%>"/>
				<wtc:param value="<%=iLogin_Pass%>"/>
				<wtc:param value="<%=iOrgCode%>"/>
				
				<wtc:param value="<%=iSys_Note%>"/>
				<wtc:param value="<%=iOp_Note%>"/>
				<wtc:param value="<%=iIpAddr%>"/>
				<wtc:param value="<%=iGrp_Id%>"/>
				<wtc:param value="<%=idcMebNo%>"/>
				
				<wtc:param value="<%=feeList%>"/>
				
			<%
				 if(length>0){
			%>
				<wtc:params value="<%=fieldCodes%>"/>
				<wtc:params value="<%=fieldValues%>"/>
				<wtc:params value="<%=fieldRowNo%>"/>
			<%	}else{
			%>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
			<%	}%>
			<% if(newLen== 0){%>
				<wtc:param value="<%=temp_str%>"/>
            		<%}else{%>
            			<wtc:params value="<%=newFieldCodes%>"/>
           		<%} if(newLen== 0){%>
           			<wtc:param value="<%=temp_str%>"/>
            		<%}else{%>
            			<wtc:params value="<%=newFieldValues%>"/>
               		<% }if(newLen== 0){%>
           			<wtc:param value="<%=temp_str%>"/>
           		<%}else{%>	
           			<wtc:params value="<%=newFieldRowNo%>"/> 
           		<%}%>   
			</wtc:service>	
	
	
			<%			
            			error_code = retCode1;
            			error_msg= retMsg1;
    }catch(Exception e){
		e.printStackTrace();
       // logger.error("Call s3517Cfm is Failed!");
    }
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode1+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opName1+"&workNo="+iWorkNo+"&loginAccept="+iLoginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
	System.out.println(url);
    if(error_code .equals("000000"))
    {
%>
        <script language='jscript'>
            rdShowMessageDialog("<%=error_msg%>",2);
            history.go(-2);
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

<jsp:include page="<%=url%>" flush="true"/>
</html>