
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=Gb2312"%>
 
<HTML>
	
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String reg_code = (String)session.getAttribute("regCode");
  String org_code = (String)session.getAttribute("orgCode");
%>	
<HEAD>
<TITLE>������-��������Ϣ����</TITLE>
</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>
<FORM action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title"><div id="title_zi">���������������� </div></div>
       <TABLE cellspacing=0>
         <TR>
				<TD width="16%" class="blue">�������ͣ�</TD>
				<TD width="34%">
				<select name="work_type" onchange="change()">
				<option value="a" selected>a-->����</option>
				<option value="u">u-->�޸�</option>
				<option value="d">d-->ɾ��</option>
				</select>
				</TD>
				<TD width="16%"  class="blue">�������ƣ�</TD>
					<TD width="34%">
					<select name="region_code" onchange = "chg_region()">
	
					  <%		
					  String sqlStr = "";
					  String sqlStr1 = "";
					  int i=0;
					 if(reg_code.compareTo("01")>=0 && reg_code.compareTo("09") <=0)//��ʡ������Ȩ��
							  {
							 		sqlStr ="select region_code,region_name from sregionCode where region_code='"+org_code.substring(0,2)+"'"; 
              	}
								else
								{
									sqlStr ="select region_code,region_name from sregionCode ";      	
								}
							//retArray_select = callView.spubqry32Process("2","",sqlStr).getList();
							//result_select = (String[][])retArray_select.get(1);
							%>
	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=reg_code%>">
  		<wtc:sql><%=sqlStr%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_select" scope="end"/>
		<%
							for(i=0;i<result_select.length;i++)
								{
									out.println("<option class='button' value='"+result_select[i][0]+"'>" + result_select[i][1] + "</option>");
								}
								if (reg_code.compareTo("01")< 0 || reg_code.compareTo("09") >0)
									{
										out.println("<option class='button' value='ZZ'> ȫ�� </option>");
									}
						%>
				    </select>
					</TD>
				</TR>
				</TABLE>
		<TABLE id=tb1  cellspacing="0"  >
			<TR >
				<TD width="16%"  class="blue">���</TD>
				<TD width=34% > 
								<input class ="button" name ="bullet_code1" maxlength=4 >
					</td>
					<TD width="16%" class="blue">�Ƿ���Ч��</TD>
					<TD width="34%">
					<select name="is_ok1" >
						<option class='button' value='Y'>��Ч</option>
						<option class='button' value='N'>��Ч</option>
				    </select>
					</TD>
			</TR>
				<TR >
					<TD width="16%"  class="blue">��������1��</TD>
					<TD COLSPAN="4" >
						<textarea COLSPAN="3" cols=70 rows=3 name="bullet_content1" maxlength=255 v_must=1 v_type=string  ></textarea>
					</TD>
					</TR>
					<TR >
					<TD width="16%"  class="blue">���浥λ��</TD>
					<TD width="34%">
						<input class="button" name="boot_name1" maxlength=60 v_must=1 v_type=string > 
					</TD>
					<TD width="16%"  class="blue">��Ҫ��־</TD>
					<TD width="34%">
					<select name="anoRank1">
						<option value='0'>һ�㹫��</option>
						<option value='1'>��Ҫ����</option>
				    </select>
				    
					<select name="color3" style="display:none">
						<option class='button' value='FF0000'>��</option>
						<option class='button' value='0000FF'>��</option>
						<option class='button' value='FFFF00'>��</option>
						<option class='button' value='008000'>��</option>
				    </select>
					</TD>
				</TR>

	
		</TABLE>
		<TABLE id=tb2  cellspacing="0"   style="display:none">
			<TR  >
				<TD width="16%"  class="blue">���</TD>
				<TD width=34% >       
					<select name="bullet_code2" onclick=chg_bullet2()>
								  <%		
							sqlStr1 ="select distinct bullet_code from dsysbullet where region_code ='01' order by bullet_code desc ";      	
							%>
							<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=reg_code%>">
  		<wtc:sql><%=sqlStr1%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_select1" scope="end"/>
							<%
								for(i=0;i<result_select1.length;i++)
								{
							out.println("<option class='button' value='"+result_select1[i][0]+"'>" + result_select1[i][0] + "</option>");
								}
						%>
					
					<TD width="16%"  class="blue">�Ƿ���Ч��</TD>
					<TD width="34%">
					<select name="is_ok2" >
						<option class='button' value='Y'>��Ч</option>
						<option class='button' value='N'>��Ч</option>
				    </select>
					</TD>
			</TR>
				<TR >
					<TD width="16%"  class="blue">��������2��</TD>
					<TD COLSPAN="4">
<textarea COLSPAN="3" cols=70 rows=3 name="bullet_content2" maxlength=255 v_must=1 v_type=string  ></textarea>					</TD>
					</TR>
					<TR >
					<TD width="16%"  class="blue">���浥λ��</TD>
					<TD width="34%">
						<input class="button" name="boot_name2" maxlength=60 v_must=1 v_type=string > 
					</TD>
					<TD width="16%"  class="blue">��Ҫ��־</TD>
					<TD width="34%">
					<select name="anoRank2">
						<option value='0'>һ�㹫��</option>
						<option value='1'>��Ҫ����</option>
				    </select>
				    
					<select name="color3" style="display:none">
						<option class='button' value='FF0000'>��</option>
						<option class='button' value='0000FF'>��</option>
						<option class='button' value='FFFF00'>��</option>
						<option class='button' value='008000'>��</option>
				    </select>
					</TD>
				</TR>

			</TABLE>
		<TABLE id=tb3  cellspacing="0" style="display:none">
			<TR >
				<TD width="16%"  class="blue">���</TD>
				<TD width=34% >
							<select name="bullet_code3" onclick=chg_bullet3()>
								  <%		
							sqlStr1 ="select distinct bullet_code from dsysbullet where region_code ='01' order by bullet_code desc ";      	
							%>
							<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=reg_code%>">
						  		<wtc:sql><%=sqlStr1%></wtc:sql>
						 		</wtc:pubselect>
							<wtc:array id="result_select1" scope="end"/>
							<%
								for(i=0;i<result_select1.length;i++)
								{
									out.println("<option class='button' value='"+result_select1[i][0]+"'>" + result_select1[i][0] + "</option>");
								}
						%>
					
					<TD width="16%"  class="blue">�Ƿ���Ч��</TD>
					<TD width="34%">
					<select name="is_ok3" >
						<option class='button' value='Y'>��Ч</option>
						<option class='button' value='N'>��Ч</option>
				    </select>
					</TD>
			</TR>
				<TR  >
					<TD width="16%"  class="blue">��������3��</TD>
					<TD COLSPAN="4">
						<textarea COLSPAN="3" cols=70 rows=3 name="bullet_content3" maxlength=255 v_must=1 v_type=string  ></textarea>
					</TD>
					</TR>
					<TR >
					<TD width="16%"  class="blue">���浥λ��</TD>
					<TD width="34%">
						<input class="button" name="boot_name3" maxlength=60  v_type=string  > 
					</TD>
					<TD width="16%"  class="blue">��Ҫ��־</TD>
					<TD width="34%">
					<select name="anoRank3">
						<option value='0'>һ�㹫��</option>
						<option value='1'>��Ҫ����</option>
				    </select>
				    
					<select name="color3" style="display:none">
						<option class='button' value='FF0000'>��</option>
						<option class='button' value='0000FF'>��</option>
						<option class='button' value='FFFF00'>��</option>
						<option class='button' value='008000'>��</option>
				    </select>
					</TD>
				</TR>
		</TABLE>
	       <TABLE  cellSpacing=0>
          <TBODY>
            <TR  >
              <TD align=center id="footer">
			  <input class="b_foot" name=list type=button value=�б� onclick="pageSubmit('codeManage/f5019_4.jsp');">
			  <input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(checkform()) pageSubmit('codeManage/f5019_2.jsp');" >
			  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
              </TD>
            </TR>
          </TBODY>
        </TABLE>		
 
		<input type="hidden" name=reg_code value="<%=reg_code%>">
		<%@ include file="/npage/include/footer.jsp" %>
 </FORM>
</BODY>
</HTML>
<script language="javascript">
function chg_bullet3()
{
	change_flag = "del1";
		var checkPwd_Packet = new AJAXPacket("f5019_5.jsp","���ڻ���û���Ϣ�����Ժ�......");
		checkPwd_Packet.data.add("retType","getinfo");
		checkPwd_Packet.data.add("region_code",(document.all.region_code.value));
		checkPwd_Packet.data.add("bullet_code",(document.all.bullet_code3.value));
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet = null;
}
function chg_bullet2()
{
		change_flag = "edit1";
		var checkPwd_Packet = new AJAXPacket("f5019_5.jsp","���ڻ���û���Ϣ�����Ժ�......");
		checkPwd_Packet.data.add("retType","getinfo");
		checkPwd_Packet.data.add("region_code",(document.all.region_code.value));
		checkPwd_Packet.data.add("bullet_code",(document.all.bullet_code2.value));
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet = null;
			
}
 	

function chg_region()
{

	if (document.form1.work_type.value=="u") 
	{
				
				change_flag = "edit";
				var sqlStr ="";
				var iregion_code = document.all.region_code[document.all.region_code.selectedIndex].value;
				var reg_code =document.all.reg_code.value;

				 var myPacket = new AJAXPacket("select_ajax.jsp","���ڻ�������Ϣ�����Ժ�......");
				
				myPacket.data.add("reg_code",reg_code);
				myPacket.data.add("iregion_code",iregion_code);
				core.ajax.sendPacket(myPacket);
				myPacket = null;
		
	}
	if (document.form1.work_type.value=="d") 
	{
				
				change_flag = "del";
				var sqlStr = "";
				var reg_code =document.all.reg_code.value;
				var iregion_code = document.all.region_code[document.all.region_code.selectedIndex].value;
				var myPacket = new AJAXPacket("select_ajax.jsp","���ڻ�������Ϣ�����Ժ�......");
				
				myPacket.data.add("reg_code",reg_code);
				myPacket.data.add("iregion_code",iregion_code);
				core.ajax.sendPacket(myPacket);
				myPacket = null;
		
	}
	
}
 

/*-----------------------------------ҳ����ת����-----------------------------------*/
function pageSubmit(page){
	document.form1.action="<%=request.getContextPath()%>/npage/"+page;  
    form1.submit();
    }
/*-----------------------------------��������Ŀ��ƺ���--------------------------*/
function change(){
	   var i = document.form1.work_type.selectedIndex+1;
	   var temp="tb"+i;
	  var j = 1;
	  for(j=1;j<4;j++){
	  	var tem ="tb"+j;
	  	document.all(tem).style.display="none";
	  }
   	    document.all(temp).style.display="";
		if (document.form1.work_type.value=="a")
		{ 
				change_flag = "add";
				var myPacket = new AJAXPacket("f5019_3.jsp","���ڻ�������Ϣ�����Ժ�......");
				core.ajax.sendPacket(myPacket);
				myPacket = null;
		}
		else 
		{
		chg_region()
		}
	
}//��������Ŀ���

 onload=function(){
		change();
	}
 
var change_flag = "";//����ȫ�ֱ�־����


 
 /*----------------------------�������б�Ĵ���-----------------------------------------*/
 function doProcess(packet)
  {
 
   
	if(change_flag == "edit")
		{
	
				 //�޸�
				 var triListData = packet.data.findValueByName("tri_list"); 
  	    		var triList=new Array(triListData.length);
				 triList[0]="bullet_code2";
				 document.all("bullet_code2").length=0;
			
				 document.all("bullet_code2").options.length=triListData.length;//triListData[i].length;
				 //alert("triListData.length"+ triListData.length);
				 for(j=0;j<triListData.length;j++)
				 {
				    //alert(triListData[j][1]);
					document.all("bullet_code2").options[j].text=triListData[j][1];
					document.all("bullet_code2").options[j].value=triListData[j][1];
				 }
				}
	if(change_flag == "edit1")
		{
	
				  var retType = packet.data.findValueByName("retType");
   			  var retCode = packet.data.findValueByName("retCode"); 
    			var retMessage = packet.data.findValueByName("retMessage");	
				  if(retCode=="000000")
          {
            document.all.bullet_content2.value = packet.data.findValueByName("bullet_content"); 
            document.all.boot_name2.value = packet.data.findValueByName("boot_name"); 
            document.all.is_ok2.value = packet.data.findValueByName("valid_flag"); 
            //document.all.color2.value = packet.data.findValueByName("color2"); 
            
            
		       }
		       else
        {
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
        }	
   }
   if(change_flag == "del1")
		{
	
				  var retType = packet.data.findValueByName("retType");
   			  var retCode = packet.data.findValueByName("retCode"); 
    			var retMessage = packet.data.findValueByName("retMessage");	
				  if(retCode=="000000")
          {
            document.all.bullet_content3.value = packet.data.findValueByName("bullet_content"); 
            document.all.boot_name3.value = packet.data.findValueByName("boot_name"); 
            document.all.is_ok3.value = packet.data.findValueByName("valid_flag"); 
            //document.all.color3.value = packet.data.findValueByName("color2"); 
           
            
		       }
		       else
        {
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
        }	
   }
	if(change_flag == "del")
		{
	
				 //ɾ��
				 var triListData = packet.data.findValueByName("tri_list"); 
  	    var triList=new Array(triListData.length);
				 triList[0]="bullet_code3";
				 document.all("bullet_code3").length=0;
			
				 document.all("bullet_code3").options.length=triListData.length;//triListData[i].length;
				 for(j=0;j<triListData.length;j++)
				 {
				
					document.all("bullet_code3").options[j].text=triListData[j][1];
					document.all("bullet_code3").options[j].value=triListData[j][1];
					
				 }
				}				
		if(change_flag=="add")
		  {
				var bullet_code1 = (packet.data.findValueByName("bullet_code"));  
					
				document.all.bullet_code1.value= bullet_code1;
				//alert("in del"+document.all.area_name_del.value);
		  }
		}

 function DoList()
	{
		//if (IList.style.visibility != "hidden")
		if (IList.style.display != "none")
		{
			//IList.style.visibility="hidden";
			IList.style.display = "none";
		}
		else
		{
			//IList.style.visibility="visible";
			IList.style.display = "";
		}
	}
/*-----------------------------���ı���ı���У��---------------------------------------*/
function checkform()
	{
	var do_value = document.all.work_type[document.all.work_type.selectedIndex].value;

	if (do_value == "a")
		{
			if(document.all.bullet_content1.value =="" )
			{
				rdShowMessageDialog(" �������ݲ���Ϊ�գ�",0);
            return false;
			}
       if (document.all.boot_name1.value =="")
       {
     				rdShowMessageDialog(" ���浥λ����Ϊ�գ�",0);
            return false;
  	
       } 
			else
				{
					return true;
				}
		}
	else
		{
			return true;
		}
	
	}


</script>
