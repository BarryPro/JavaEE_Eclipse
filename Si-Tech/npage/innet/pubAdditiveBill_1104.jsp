<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.02
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>

<%
    HashMap hm=new HashMap();
    hm.put("0","��ͨ");
    hm.put("1","Ĭ��");
    hm.put("2","��");
	hm.put("3","Ӫ����");
	hm.put("4","����ѡһ");

	/*HashMap hm_grp=new HashMap();
    hm_grp.put("0","����");
    hm_grp.put("1","����");
    hm_grp.put("2","GPRS");
	hm_grp.put("3","��������");
	hm_grp.put("4","�������");
	*/

	String[] flag1=new String[]{"��","��","��","��","��","��","��","��","��","��","��","��","��","��","��","��"};
	String[] flag3=new String[]{"��","��","��","��","��","��","��","��","��","��","��","��","��","��","��","��"};

    //�õ��������
    String opCode = "1104";
	String opName = "��ͨ����";
	String pageTitle = request.getParameter("pageTitle");
    String modeCode = request.getParameter("modeCode");  
    String fieldNum = "";
    String orgCode = request.getParameter("orgCode");
    String regionCode = orgCode.substring(0,2);
    String districtCode = orgCode.substring(2,4);
    String smCode = request.getParameter("smCode");
	String machineCode=WtcUtil.repNull(request.getParameter("machineCode"));
    String machineType=request.getParameter("machineType");
	String existModeCode=request.getParameter("existModeCode");

	if(machineType==null) machineType="s";
    String sqlStr ="";
	if(machineType.equals("s"))
	{
	  sqlStr= "select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME," + 
			  " a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ," + 
			  " sBillModeCode b,sBillModeType c where a.REGION_CODE = b.REGION_CODE" + 
			  " and a.REGION_CODE = '" + regionCode + "' and " + 
			  " a.DISTRICT_CODE = any('" + districtCode + "','99') and " + 
			  " a.MODE_CODE = '" + modeCode + "' and" + 
			  " a.ADD_mode = b.MODE_CODE and " +
			  " b.REGION_CODE = c.REGION_CODE and " +
			  " b.MODE_TYPE = c.MODE_TYPE and " + 
			  " sysdate between b.start_time and b.stop_time and " + 
			  " b.sm_code = c.sm_code "+
			  " and b.mode_flag='2' "+
			  " and b.mode_type != 'YnD4' and b.mode_code not in ('fj@@Mdz7','fj@@Mdz8','fj@@Mdz9','fj@@Mdza') " +
			  "  and b.region_code||b.mode_code not in(select region_code||mode_code from sNoDelAddMode where active_flag='Y' and show_flag='Y') "+
			  " and b.mode_type not in(select distinct mode_type from sAddModeType where active_flag='Y') "+
			  " order by b.MODE_TYPE,a.mode_code";
	  //System.out.println("see++++regionCode"+regionCode+"^^^^^^^^^^"+districtCode+"---"+modeCode);
	  //System.out.println("test==================================");
	  System.out.println("see++++^^^^^^^^^^^^^^^^^^^^^^^^"+sqlStr);
	}
	else if(machineType.equals("b"))
	{
         sqlStr="select MODE_TYPE,TYPE_NAME,MODE_code,MODE_NAME,max(CHOICED_FLAG),max_open "+
         " from (select b.MODE_TYPE,c.TYPE_NAME,a.MODE_CODE,b.MODE_NAME,'2' as CHOICED_FLAG,c.max_open "+
         " from sBillPackCode a,sBillModecode b,sBillModeType c where a.region_code=b.region_code "+
         " and a.mode_code=b.mode_code and b.REGION_CODE = c.REGION_CODE and b.MODE_TYPE = c.MODE_TYPE "+
         " and a.mach_code='"+machineCode+"' union select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME,"+
         " a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ,sBillModeCode b,sBillModeType c "+
         " where a.REGION_CODE = b.REGION_CODE and a.REGION_CODE = '"+regionCode+"' and "+
         " a.DISTRICT_CODE =any('" + districtCode + "','99') and a.MODE_CODE = '"+modeCode+"' "+
         " and a.ADD_mode = b.MODE_CODE and b.REGION_CODE = c.REGION_CODE and "+
         " b.MODE_TYPE = c.MODE_TYPE and b.sm_code = c.sm_code and b.region_code||b.mode_code not in(select region_code||mode_code from sNoDelAddMode where active_flag='Y' and show_flag='Y')) group by MODE_TYPE,TYPE_NAME,MODE_code,"+
         " MODE_NAME,max_open order by mode_type,mode_code";
		 System.out.println("see2222``````````````````````"+sqlStr);
	}
	else if(machineType.equals("r"))
	{
	   sqlStr="select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME," + 
			" a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ," + 
			" sBillModeCode b,sBillModeType c where a.REGION_CODE = b.REGION_CODE" + 
			" and a.REGION_CODE = '" + regionCode + "' and " + 
			" a.DISTRICT_CODE = any('" + districtCode + "','99') and " + 
			" a.MODE_CODE = '" + modeCode + "' and" + 
			" a.ADD_mode = b.MODE_CODE and " +
			" b.REGION_CODE = c.REGION_CODE and " +
			" b.MODE_TYPE = c.MODE_TYPE and" +
			" sysdate between b.start_time and b.stop_time and " + 
			" b.sm_code = c.sm_code" +
			"  and b.region_code||b.mode_code not in(select region_code||mode_code from sNoDelAddMode where active_flag='Y' and show_flag='Y') "+
			//" b.mode_type='d'"+
			" order by b.MODE_TYPE,a.add_mode";
			System.out.println("see33333``````````````````````"+sqlStr);
	}
    String selType = "M";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";  

	
%>

<HTML><HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

<SCRIPT type=text/javascript>
var js_flag1=new Array("��","��","��","��","��","��","��","��","��","��","��","��","��","��","��","��");
var js_flag3=new Array("��","��","��","��","��","��","��","��","��","��","��","��","��","��","��","��");

function saveTo()
{
      var rIndex;        //ѡ�������
      var retValue = ""; //����ֵ
      var chPos;         //�ַ�λ��
      var obj;
      var addNum = 0;				//ѡ��ĸ����ʷ�����
      var maxNum = 0;
      var retCode = "";
     
      var retName = "";
      var addType = "";		//�����ʷ�����
      var addName = "";
      var addFlag1=0;      //Ĭ���ʷѵ�ѡ������
	  var addFlag3=0;      //����ʷѵ�ѡ������
	  var grpSerial=-1;     //�����

       //���ص�����¼
          for(i=0;i<document.pubAdditiveBill.elements.length;i++)
          {  //*�����ʷ����ͱ���
    		 if(pubAdditiveBill.elements[i].tableType == "additiveType")
    		 {
    		     addNum = 0;
    		     addType = pubAdditiveBill.elements[i].additiveType;   //�õ������ʷ�����
    		     maxNum = 1*pubAdditiveBill.elements[i].value;     //�õ�����ѡ��������
    		     addName = pubAdditiveBill.elements[i].addName;          //�õ������ʷ���������
				 grpSerial++;
                 //rdShowMessageDialog(addName);
    		     for(j=0;j<document.pubAdditiveBill.elements.length;j++)
    		     {	 //$ͬһ�ʷ�����ѡ��
	    		     if((pubAdditiveBill.elements[j].name=="List")&&	    		     	
	    		     	(pubAdditiveBill.elements[j].additiveType == addType))
	    		      {    //�ж��Ƿ��ǵ�ѡ��ѡ��
	    				   if ((pubAdditiveBill.elements[j].checked==true))
	    				   {     //�ж��Ƿ�ѡ��
	        			         rIndex = pubAdditiveBill.elements[j].RIndex;
	        			         obj = "Rinput" + rIndex + 2;
	        			         retCode = retCode + document.all(obj).value + "~";
	        			         
	        			         obj = "Rinput" + rIndex + 3;
	        			         retName = retName +  "[" + document.all(obj).value + "]";
	        			         addNum = 1*addNum + 1;
								 
								 if(document.all(obj).flag0123=="1")
									 addFlag1++;
								 if(document.all(obj).flag0123=="4")
									 addFlag3++;	 
	                       }
	    		      }
    		    }//end$
    		    //�ж�ѡ��ĸ����ʷ������Ƿ���ڹ涨�Ŀ�ѡ����
                if(js_flag1[grpSerial]=="��")
				{
                  if(addFlag1==0)
				  {
                     rdShowMessageDialog("������Ӧѡ��һ��[" + addName + "]��Ĭ�Ͽ�ѡ�ʷѣ�",0);
					 return false;
				  }
				}
				addFlag1=0;

    		    if(addNum > maxNum)
    		    {	
    		    	rdShowMessageDialog("ѡ���[" + addName + "]��ѡ�ʷ�����(" + addNum + ")�Ѿ�����������ѡ����(" + maxNum + ")��",0);
    		    	return false;
    		    }
    		 }//end*
    	   }
    	   
    	   if(js_flag3[0]=="��" || js_flag3[1]=="��" || js_flag3[2]=="��" || js_flag3[3]=="��" || js_flag3[4]=="��")
			{
              if(addFlag3==0)
			  {
                 rdShowMessageDialog("������Ӧѡ��һ�ֶ���ѡһ�Ŀ�ѡ�ʷѣ�",0);
				 return false;
			  }
			}
					
	   if(retCode =="")
	   {
	        rdShowMessageDialog("������ѡ��һ�ֿ�ѡ�ʷѣ�");
		    return false;
	   }
       retValue = retCode + "|" + retName;
       window.returnValue = retValue;  		   
       window.close(); 		
}

function blank()
{
  window.returnValue="|";
  window.close();
}

</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
         
     
      
<FORM method=post name="pubAdditiveBill">
	
	<%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=pageTitle%></div>
		</div>
	
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
    <tr>
<%
    String modeType = "";   //��ѡ������
    int lineSize = 0;       //ÿ�е�����
 
	boolean oneHaveFlag=false;
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{
 	
 	%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="return_code" retmsg="return_Message" outnum="7">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%
 	
 		if(result!=null)
		{
      		int recordNum = result.length;

            //================================================
			String modeTy="";
			int nowGrp=-1;
			for(int i=0;i<recordNum;i++)
			{
              if(modeTy.compareTo(result[i][0]) != 0)
	      	  {
                  nowGrp++;
				  modeTy = result[i][0];
			  }
			  else
			  {
                if(result[i][4].equals("1"))
				{
                  flag1[nowGrp]="��";
%>
                  <script>
	               js_flag1[<%=nowGrp%>]="��";
	              </script>
<%
				}
				else if(result[i][4].equals("4"))
				{
				  flag3[nowGrp]="��"; 
%>
                  <script>
	               js_flag3[<%=nowGrp%>]="��";
	              </script>
<%
				}
			  }
			}
			//================================================

            nowGrp=-1;
			System.out.println("@@@@@@@@@@@@@@@@@@@"+recordNum);
      		for(int i=0;i<recordNum;i++)
      		{
      		    lineSize = lineSize + 1;
      		    if(modeType.compareTo(result[i][0]) != 0)
	      		{
					//����һ���ײ��ǵ��������
					if(lineSize==3)
                    {						
      		    	  inputStr = inputStr + "<td colspan=3></td>";
					  out.print(inputStr); 
					  inputStr = "";						 
					}
                    nowGrp++;
					oneHaveFlag=false;
				out.print("<TR>");
	                
					out.print("<TD colspan=3>&nbsp;�ʷ����ͣ�"+result[i][1]+"&nbsp;&nbsp;&nbsp;��ѡ������"+result[i][5]+"</TD>");						
					out.print("<TD colspan=3>&nbsp;����Ĭ����ѡ���־��"+flag1[nowGrp]+"&nbsp;&nbsp;&nbsp;����ѡһ��־��"+flag3[nowGrp]+"</TD>");

				    out.print("</TR>");
				     out.print("<TR >");
						out.print("<TH width='14%'><div align='center'>�ʷѴ���</div></TH>");
						out.print("<TH width='28%'><div align='center'>�ʷ�����</div>" + "<input type='hidden'" + 
							" name='additiveName" + i + "' value='" + result[i][1] + "'> </TH>");
						out.print("<TH width='8%' nowrap><div align='center'>ѡ��ʽ</div></TH>");
						out.print("<TH width='14%'><div align='center'>�ʷѴ���</div></TH>");
						out.print("<TH width='28%'><div align='center'>�ʷ�����</div>" + "<input type='hidden'" +
							" name='additiveNum" + i + "' value='" + result[i][5] + "'" + 
							" tableType='additiveType' addName='" + result[i][1] + "'" +
							" additiveType='" + result[i][0] + "'></TD>");
						out.print("<TH width='8%' nowrap><div align='center'>ѡ��ʽ</div></TH>");
				     out.print("</TR>");
				     modeType = result[i][0];
				     lineSize = 1;					      			
	      		}


	      		if(lineSize == 1)
	      		{	out.print("<TR>");	}

                //start write the most important col.===========�ʷѴ���=================
				inputStr = inputStr + "<TD>&nbsp;<input type=checkbox " +  
					"' name='List' style='cursor:hand' RIndex='" + i + "'" + 
					" additiveType='" + result[i][0] + "'" + 
					"onkeydown='if(event.keyCode==13)saveTo();'";
				if(existModeCode.equals(""))
				{
					if((result[i][4]).compareTo("1") == 0)
					{
						if(oneHaveFlag==false)
						{
						  inputStr = inputStr + " checked";	
						  oneHaveFlag=true;
						}
					}
					if((result[i][4]).compareTo("2") == 0)
					{				 
						inputStr = inputStr + " checked disabled";	
					}
				}
				else
				{
   					if((result[i][4]).compareTo("2") == 0)
					{				 
						inputStr = inputStr + " checked disabled";	
					}
                    else
					{
                       	if(existModeCode.indexOf(result[i][2])!=-1)
						  inputStr+=" checked ";
					}
				}
				inputStr = inputStr + ">";
	            inputStr = inputStr + result[i][2] + "<input type='hidden' " +
					" id='Rinput" + i + "2' class='button' value='" + 
					result[i][2] + "' additiveType='" + result[i][0] +"'></TD>";
				//end write the most important col.========�ʷѴ���====================


				//start write the second important col.====�ʷ�����========================
	            inputStr = inputStr + "<TD>" + result[i][3] + "<input type='hidden' " +
					" id='Rinput" + i + "3' class='button' value='" + 
					result[i][3] + "' additiveType='" + result[i][0] + "'  flag0123='"+result[i][4]+ "'></TD>";				
				//end write the second important col.====�ʷ�����========================
				
				inputStr+="<TD><div align=center>"+(String)(hm.get(result[i][4]))+"</div></TD>";
				
				lineSize = lineSize + 1;			 
				if(lineSize == 4)
      		    {	
      		    	lineSize = 0;
      		    	inputStr = inputStr + "</TR>";					
					out.print(inputStr); 
					inputStr = "";	     		    			
      		    }
				
			 }	 //ѭ������

            //�����һ���ǵ����������������佫��ҳ���ϻ������һ��
 		    if(lineSize==2)
			{						
			  inputStr = inputStr + "<td colspan=3></td>";
			  out.print(inputStr); 
			  inputStr = "";						 
			}
 		  }
			           		                     		                  		            
     	}
     	catch(Exception e)
     	{
     	
     	}          
%>
   </tr>
  </table>


<!------------------------------------------------------>
 
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
                <input class="b_foot" name=back onClick="blank()" style="cursor:hand" type=button value=���>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
 
 <%@ include file="/npage/include/footer_pop.jsp" %>    
  <!------------------------>  
</FORM>
</BODY></HTML>    
