<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-19
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>

<%
    String opName = "�����ײͲ�ѯ";
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

	String[] flag1=new String[]{"��","��","��","��","��"};
	String[] flag3=new String[]{"��","��","��","��","��"};

    //�õ��������
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();
 
	String pageTitle = request.getParameter("pageTitle");
    String modeCode = request.getParameter("modeCode");  
    String fieldNum = "";
    String orgCode = request.getParameter("orgCode");
    String regionCode = orgCode.substring(0,2);
    String districtCode = orgCode.substring(2,4);
    String smCode = request.getParameter("smCode");
	String existModeCode = request.getParameter("existModeCode");
	String userType = request.getParameter("userType");

    String sqlStr ="";
    sqlStr=	"SELECT b.MODE_TYPE,c.TYPE_NAME,b.MODE_code,b.MODE_NAME,"
           +"       '0' CHOICED_FLAG,c.MAX_OPEN"
           +"  FROM sBillModeCode b,sBillModeType c"
           +" WHERE b.region_code = c.region_code"
           +"   AND b.mode_type = c.mode_type"
           +"   AND b.mode_type = '" + userType + "'"
           +"   AND b.region_code = '" + regionCode + "'";
/*
	  sqlStr= "select b.MODE_TYPE,c.TYPE_NAME,a.ADD_MODE,b.MODE_NAME," + 
			  " a.CHOICED_FLAG,c.MAX_OPEN from cBillBaDepend a ," + 
			  " sBillModeCode b,sBillModeType c where a.REGION_CODE = b.REGION_CODE" + 
			  " and a.REGION_CODE = '" + regionCode + "' and " + 
			  " a.DISTRICT_CODE = '" + districtCode + "' and " + 
			  " a.MODE_CODE = '" + modeCode + "' and" + 
			  " a.ADD_MODE = b.MODE_CODE and " +
			  " b.REGION_CODE = c.REGION_CODE and " +
			  " b.MODE_TYPE = c.MODE_TYPE " + 
			  " order by b.MODE_TYPE,a.mode_code";
*/
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

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<SCRIPT type=text/javascript>
var js_flag1=new Array("��","��","��","��","��");
var js_flag3=new Array("��","��","��","��","��");

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
	        			         //retCode = retCode + document.all(obj).value + "~";//���ڶ�ѡ
	        			         retCode = retCode + document.all(obj).value;//���ڵ�ѡ
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
	<div id="title_zi">��ѯ���</div>
</div>
  <table cellspacing="0">
    <tr>
<%
    String modeType = "";   //��ѡ������
    int lineSize = 0;       //ÿ�е�����
 
	boolean oneHaveFlag=false;
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      System.out.println(sqlStr);
 		//retArray = callView.view_spubqry32("6",sqlStr);
 		
 		%>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="6">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr1" scope="end" />
    	<%
        if(retCode1.equals("000000")){
            result = retArr1;
        }
 		//result = (String[][])retArray.get(0);
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
					out.print("<TR align=center>");
	                
					out.print("<TH colspan=3>�ʷ�����"+result[i][1]+"��ѡ����"+result[i][5]+"</TH>");						
					out.print("<TH colspan=3>����Ĭ����ѡ���־"+flag1[nowGrp]+"����ѡһ��־"+flag3[nowGrp]+"</TH>");

				    out.print("</TR>");
				     /*if(lineSize > 1)
				     {
	      		    	inputStr = inputStr + "<TD></TD><TD></TD><TD></TD>";
	      		    	inputStr = inputStr + "</TR>";
						out.print(inputStr); 
						inputStr = "";				     
				     }*/
				     out.print("<TR align=center>");
						out.print("<TH width='14%'><div align='center'>�ʷѴ���</div></TH>");
						out.print("<TH width='28%'><div align='center'>�ʷ�����</div>" + "<input type='hidden'" + 
							" name='additiveName" + i + "' value='" + result[i][1] + "'> </TH>");
						out.print("<TH width='8%'><div align='center'>ѡ��ʽ</div></TH>");
						out.print("<TH width='14%'><div align='center'>�ʷѴ���</div></TH>");
						out.print("<TH width='28%'><div align='center'>�ʷ�����</div>" + "<input type='hidden'" +
							" name='additiveNum" + i + "' value='" + result[i][5] + "'" + 
							" tableType='additiveType' addName='" + result[i][1] + "'" +
							" additiveType='" + result[i][0] + "'></TH>");
						out.print("<TH width='8%'><div align='center'>ѡ��ʽ</div></TH>");
				     out.print("</TR>");
				     modeType = result[i][0];
				     lineSize = 1;					      			
	      		}


	      		if(lineSize == 1)
	      		{	out.print("<TR>");	}

                //start write the most important col.===========�ʷѴ���=================
				inputStr = inputStr + "<TD>&nbsp;<input type=radio " +  
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
    <TABLE cellSpacing=0>
    <TBODY>
        <TR id="footer"> 
            <TD>
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>
                <input class="b_foot" name=back onClick="blank()" style="cursor:hand" type=button value=�ر�>
            </TD>
        </TR>
    </TBODY>
    </TABLE>
  
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
